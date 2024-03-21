package com.metalineage.databus.manager.util;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.databus.manager.config.SqlCollectConfig;
import com.metalineage.databus.manager.entity.lineage.dwnode.*;
import com.metalineage.databus.manager.entity.metadata.*;
import com.metalineage.databus.manager.mapper.lineage.DwRepository;
import com.metalineage.databus.manager.mapper.lineage.LineageRepository;
import com.metalineage.databus.manager.mapper.metadata.ManagerSysMenuHealthMapper;
import com.metalineage.databus.manager.service.YunWendangService;
import com.metalineage.databus.manager.service.lineage.DwRespositoryService;
import com.metalineage.databus.manager.service.lineage.LineageService;
import com.metalineage.databus.manager.service.metadata.MetadataFieldService;
import com.metalineage.databus.manager.service.metadata.MetadataTableService;
import com.metalineage.databus.manager.service.report.ReportService;
import com.metalineage.databus.manager.util.metaCollect.HiveCollect;
import com.metalineage.databus.manager.util.metaCollect.ImpalaCollect;
import com.metalineage.databus.manager.util.metaCollect.PgsqlCollect;
import com.metalineage.databus.manager.util.sqlcollect.DolphinCollect2;
import com.metalineage.databus.manager.util.sqlcollect.DolphinCollect3;
import com.metalineage.databus.manager.util.sqlcollect.LocalFileCollect;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.sql.SQLException;
import java.util.*;

import static com.metalineage.databus.manager.util.GeneralUtil.getTimeString;
import static com.metalineage.databus.manager.util.HttpUtil.getHttpJson;

@Component
@Slf4j
public class DispatchUtil implements Runnable {
    @Autowired
    ReportService reportService;

    @Autowired
    MetadataFieldService metadataFieldService;

    @Autowired
    DwRespositoryService dwRespositoryService;

    @Autowired
    ImpalaCollect impalaCollect;

    @Autowired
    MetadataTableService metadataTableService;

    @Autowired
    DolphinCollect2 dolphinCollect2;

    @Autowired
    YunWendangService yunWendangService;

    @Autowired
    LineageService lineageService;

    @Autowired
    LineageRepository lineageRepository;

    public JSONObject lingageIdJson = new JSONObject();

    Set<String> odsTableSet = new HashSet<>();

    Set<String> dwTableSet = new HashSet<>();

    List<String> deleteTableArray;

    @Autowired
    DwRepository dwRepository;

    JSONObject feishuJson;

    @Autowired
    PgsqlCollect pgsqlParse;

    @Autowired
    HiveCollect hiveCollect;

    @Autowired
    DolphinCollect3 dolphinCollect3;

    @Autowired
    SqlCollectConfig sqlCollectConfig;

    @Value("${lineage.sqlcollect.collectType}")
    private String collectType;

    @Override
    public void run(){
        if(collectType.contains("impala")){
            log.info("*******开启impala血缘导入***********");
            dispatchImpala();
            log.info("*******完成impala血缘导入***********");
        }
        if(collectType.contains("pgsql")){
            log.info("*******开启pgsql血缘导入***********");
            dispatchPgsql();
            log.info("*******完成pgsql血缘导入***********");
        }
        if(collectType.contains("qjmotor")){
            log.info("*******开启qjmotor血缘导入***********");
            dispatchQjmotor();
            log.info("*******完成qjmotor血缘导入***********");
        }
    }

    public void dispatchQjmotor(){
        lineageService.deleteAllData();
        List<MetadataTable> metadataTableList = dolphinCollect3.getAllInfo("lineage");
        List<MetadataTable> dwInfoArray = addDwByDolphin(metadataTableList);

        log.info("成功导入数仓血缘");
        List<ReportInfo> reportInfoArray = addReport();
        log.info("成功导入报表血缘");

        this.deleteTableArray = metadataTableService.findDeleteName();

        metadataFieldService.deleteAll();
        dolphinCollect2.deleteAll();
//         metadataTableService.deleteAll();
        addMetadataAndSchedulerInfo(dwInfoArray);
        reportService.deleteAll();
        addReportInfo(reportInfoArray);

        for (MetadataTable metadataTable:dwInfoArray) {
            String dbTable = metadataTable.getDbTable();
            Set<String> srcTables = metadataTable.getSrcTables();
            odsTableSet.addAll(srcTables);
            dwTableSet.add(dbTable);
        }
        odsTableSet.removeAll(dwTableSet);
        addMetadataRecordList(odsTableSet);
        lingageIdJson.clear();
        log.info("成功更新元数据信息");

        log.info("{}:所有数据更新完成", getTimeString());
    }

    public void dispatchPgsql(){
        lineageService.deleteAllData();

        List<MetadataTable> metadataTableList = addDwByLocal();
        log.info("成功导入数仓血缘");

        List<ReportInfo> reportInfoList = addReport();
        log.info("成功导入报表血缘");

        metadataFieldService.deleteAll();
        dolphinCollect2.deleteAll();
//        metadataTableService.deleteAll();

        reportService.deleteAll();
        addReportInfo(reportInfoList);
        for (String oneTableName:odsTableSet) {
            String comment = pgsqlParse.getTableComment(oneTableName);
            long count = pgsqlParse.getDbTableCount(oneTableName);
            MetadataTable metadataTable = new MetadataTable();
            metadataTable.setDbCount(count);
            metadataTable.setDbTable(oneTableName);
            metadataTable.setComment(comment);
            metadataTableList.add(metadataTable);
        }
        addMetadataAndSchedulerInfoPg(metadataTableList);
        log.info("{}:所有数据更新完成", getTimeString());
    }



    public void dispatchImpala(){
        lineageService.deleteAllData();
        List<MetadataTable> metadataTableList = new ArrayList<>();
        List<MetadataTable> jsonArray3 =  dolphinCollect2.getAllInfo("硬件诊断");
        List<MetadataTable> jsonArray4 =  dolphinCollect2.getAllInfo("财务中心项目");
        List<MetadataTable> jsonArray5 =  dolphinCollect2.getAllInfo("日常调度");
        JSONObject dsResponseJson = getHttpJson("http://10.255.0.5:18089/dolphinscheduler/projects/list-paging?pageSize=300&pageNo=1&searchVal=", "89c2e77cc27f0b0205d2e44b302e4061");
        JSONArray dsArray = dsResponseJson.getJSONObject("data").getJSONArray("totalList");
        for (int i = 0; i < dsArray.size(); i++) {
            JSONObject o =  dsArray.getJSONObject(i);
            List<MetadataTable> jsonArray6 =  dolphinCollect2.getAllInfo(o.getString("name"));
            metadataTableList.addAll(jsonArray6);
        }
        metadataTableList.addAll(jsonArray3);
        metadataTableList.addAll(jsonArray4);
        metadataTableList.addAll(jsonArray5);
        List<MetadataTable> dwInfoArray = addDwByDolphin(metadataTableList);

        log.info("成功导入数仓血缘");   
        List<ReportInfo> reportInfoArray = addReport();
        log.info("成功导入报表血缘");

        this.feishuJson = getFeishuJson();
        this.deleteTableArray = metadataTableService.findDeleteName();

        metadataFieldService.deleteAll();
        dolphinCollect2.deleteAll();
//        metadataTableService.deleteAll();
        addMetadataAndSchedulerInfo(dwInfoArray);
        reportService.deleteAll();
        addReportInfo(reportInfoArray);

        for (MetadataTable metadataTable:dwInfoArray) {
            String dbTable = metadataTable.getDbTable();
            Set<String> srcTables = metadataTable.getSrcTables();
            odsTableSet.addAll(srcTables);
            dwTableSet.add(dbTable);
        }
        odsTableSet.removeAll(dwTableSet);
        addMetadataRecordList(odsTableSet);
        lingageIdJson.clear();
        log.info("成功更新元数据信息");

        menuHealth();
        log.info("成功更新报表健康度");
        log.info("{}:所有数据更新完成", getTimeString());
    }

    JSONObject getFeishuJson(){
        JSONArray jsonArray = yunWendangService.getTableData("wikcnNSvZurz0ssYev2HG2bwKJV","tblZD8j2zxAvQS4f","是");
        JSONObject outJson = new JSONObject();
        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject oneRecord =  jsonArray.getJSONObject(i).getJSONObject("fields");
            JSONObject jsonObject = new JSONObject();
            String dbTable = oneRecord.getString("库名")+"."+oneRecord.getString("表名");
            String owner = oneRecord.getString("使用人");
            String priority = oneRecord.getString("优先级");
            String extractLogic = oneRecord.getString("刷新方式");
            String extractTime = oneRecord.getString("刷新时间");
            jsonObject.put("owner",owner);
            jsonObject.put("priority",priority);
            jsonObject.put("extractLogic",extractLogic);
            jsonObject.put("extractTime",extractTime);
            outJson.put(dbTable,jsonObject);
        }
        return outJson;
    }

    public void addReportInfo(List<ReportInfo> reportInfoList){
        for (ReportInfo oneReport:reportInfoList) {
            oneReport.setLineageId(lingageIdJson.getInteger(oneReport.getReportName()));
            try {
                reportService.insert(oneReport);
            } catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    public int addmetadataRecord(String dbTable) throws SQLException {
        MetadataTable metadataTable = new MetadataTable();
        Integer lineageId = this.lingageIdJson.getInteger(dbTable);
        String dbName = dbTable.split("\\.")[0];
        String dwLevel = getDwLevel(dbName);
        String isDw = getIsDw(dbName);
        metadataTable.setIsDw(isDw);
        String tableName = "";
        JSONObject tableBasicInfo = new JSONObject();
        try {
            tableName = dbTable.split("\\.")[1];
            if(sqlCollectConfig.getDsVersion().equals("1")){
                tableBasicInfo = impalaCollect.getTableBasicInfo(dbName,tableName);
            } else{
                tableBasicInfo = hiveCollect.getTableBasicInfo(dbName,tableName);
            }
        } catch (Exception e){
            metadataTable.setDbTable(dbTable);
            metadataTable.setDbType("delete");
            metadataTable.setLineageId(lineageId);
            metadataTableService.upsert(metadataTable);
            return metadataTable.getId();
        }
        metadataTable.setDbName(dbName);
        metadataTable.setTableName(tableName);
        metadataTable.setDbType(tableBasicInfo.getString("db_type"));
        metadataTable.setDwLevel(dwLevel);
        metadataTable.setLineageId(lineageId);
        metadataTable.setFieldNum(tableBasicInfo.getInteger("field_num"));
        metadataTable.setPartitionType(tableBasicInfo.getInteger("partition_type"));
        metadataTable.setPartitionCount(tableBasicInfo.getInteger("partition_count"));
        metadataTable.setPartitionField(tableBasicInfo.getString("partition_field"));
        metadataTable.setComment(tableBasicInfo.getString("comment"));
        metadataTable.setFilesize(tableBasicInfo.getLongValue("filesize"));
        metadataTable.setFileCompress(tableBasicInfo.getString("file_compress"));
        metadataTable.setFileCount(tableBasicInfo.getLong("file_count"));
        metadataTable.setDbTable(dbTable);
        metadataTable.setFileFormat(tableBasicInfo.getString("file_format"));
        metadataTable.setFileLocation(tableBasicInfo.getString("file_location"));
        if(this.feishuJson!=null){
            JSONObject jsonObject = this.feishuJson.getJSONObject(dbTable);
            if(jsonObject!=null){
                metadataTable.setExtractLogic(jsonObject.getString("extractLogic"));
                metadataTable.setExtractTime(jsonObject.getString("extractTime"));
                metadataTable.setOwner(jsonObject.getString("owner"));
                metadataTable.setPriority(jsonObject.getString("priority"));
            }
        }

        //更新元数据表信息
        metadataTableService.upsert(metadataTable);
        Integer tableId = metadataTable.getId();

        //插入字段信息
        List<MetadataField> fields;
        if(sqlCollectConfig.getDsVersion().equals("1")){
            fields = impalaCollect.getFieldInfo(dbName,tableName,tableId);
        } else{
            fields = hiveCollect.getFieldInfo(dbName,tableName,tableId);
        }
        metadataFieldService.insertBatch(fields);
        return tableId;
    }

    public void addMetadataRecordList(Collection<String> tableArray){
        int i = 1;
        for (String dbTable : tableArray) {
            try {
                if (!this.deleteTableArray.contains(dbTable)) {
                    addmetadataRecord(dbTable);
                }
            } catch (SQLException ignored) {
            }
            log.info("{}-{}-{}", tableArray.size(), i, dbTable);
            i += 1;
        }
    }

    public void addMetadataAndSchedulerInfoPg(List<MetadataTable> metadataTableList){
        for (MetadataTable metadataTable:metadataTableList) {
            String dbTable = metadataTable.getDbTable();
            Integer lineageId = this.lingageIdJson.getInteger(dbTable);
            if(!dbTable.startsWith("public")){
                metadataTable.setDwLevel("ods");
                metadataTable.setIsDw("否");
                metadataTable.setOwner("A&P");
            } else{
                metadataTable.setDwLevel("middle");
                metadataTable.setIsDw("是");
                metadataTable.setOwner("孟更茹");
            }
            metadataTable.setDbName("aps_data");
            metadataTable.setLineageId(lineageId);
            metadataTable.setDbType("postgres");
            metadataTable.setTableName(dbTable.contains(".")?dbTable.split("\\.")[1]:dbTable);
            metadataTable.setCreateTime(new Date());
            metadataTable.setUpdateTime(new Date());
            //更新元数据表信息
            metadataTableService.insert(metadataTable);
            //插入字段信息
            List<MetadataField> fields = pgsqlParse.describeTable(dbTable.contains(".")?dbTable.split("\\.")[1]:dbTable);
            List<MetadataField> resultFields = new ArrayList<>();
            for (MetadataField metadataField : fields) {
                metadataField.setTableId(metadataTable.getId());
                resultFields.add(metadataField);
            }
            metadataFieldService.insertBatch(resultFields);
            SchedulerInfo schedulerInfo = metadataTable.getSchedulerInfo();
            if(schedulerInfo!=null){
                try {
                    schedulerInfo.setTableId(metadataTable.getId());
                    dolphinCollect2.insert(schedulerInfo);
                } catch (Exception e){
                    log.error(e.getMessage());
                }
            }
        }
    }

    /**
     * 添加数仓表的元数据信息
     */
    public void addMetadataAndSchedulerInfo(List<MetadataTable> metadataTableList){
        for (int i = 0; i < metadataTableList.size(); i++) {
            MetadataTable metadataTable = metadataTableList.get(i);
            String dbTable= metadataTable.getDbTable();
            System.out.println(metadataTableList.size()+"-"+i+"-"+dbTable);
            System.out.println();
            int tableId = 0;
            try {
                if(!this.deleteTableArray.contains(dbTable)){
                    tableId = addmetadataRecord(dbTable);
                }
            } catch (SQLException ignored) {
            }

            SchedulerInfo schedulerInfo = metadataTable.getSchedulerInfo();
            try {
                if(schedulerInfo!=null){
                    schedulerInfo.setTableId(tableId);
                    dolphinCollect2.insert(schedulerInfo);
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    public static String getDwLevel(String tableName){
        try {
            if(tableName.startsWith("dic_dw")){
                return tableName.split("\\.")[1].split("_")[0];
            }
            if(tableName.contains("zhizu_dm")||tableName.contains("impala_analyze")||tableName.contains("dic_bi_mid")){
                return "middle";
            }
            return "ods";
        } catch (Exception e){
            return "ods";
        }

    }

    public static String getDataLevel(String tableName){
        if(tableName.equals("是")){
            return "report";
        }
        if(tableName.equals("否")){
            return "tableau";
        }
        if(tableName.startsWith("dic_")){
            return "dic_dw_table";
        }
        return "ods_table";
    }

    public static String getIsDw(String tableName){
        if(tableName.startsWith("dic_dw")){
            return "是";
        }
        return "否";
    }

    @Autowired(required = false)
    ManagerSysMenuHealthMapper sysMenuHealthMapper;

    public void menuHealth(){
        sysMenuHealthMapper.deleteAll();
        int i = 1;
        List<SysMenu> sysMenuList = new ArrayList<>();
        while(true){
            List<SysMenu> sysMenus = reportService.findSysMenuByComponent("tableau/report/index",i,100);
            i+=1;
            sysMenuList.addAll(sysMenus);
            if(sysMenus.size()!=100){
                break;
            }
        }
        for (SysMenu sysMenu : sysMenuList) {
            String name = sysMenu.getMenuName();
            List<String> tableNames = lineageRepository.getSrcTableName(name);
            SysMenuHealth sysMenuHealth = new SysMenuHealth();
            sysMenuHealth.setMenuId(sysMenu.getMenuId());
            sysMenuHealth.setMenuName(sysMenu.getMenuName());
            int guifan = 0;
            for (String s : tableNames) {
                if (s.startsWith("dic")) {
                    guifan = 2;
                } else {
                    guifan = 1;
                    break;
                }
            }
            sysMenuHealth.setIsHealth(guifan);
            sysMenuHealthMapper.insert(sysMenuHealth);
        }
    }

    /**
     * 根据来源节点名称，以及当前节点，添加来源节点血缘
     * @param srcTableName 来源节点名称
     * @param nowNode 当前节点
     */
    public void saveSrcNode(String srcTableName,GraphNodeImpl nowNode){
        String dataLevelSrc = getDataLevel(srcTableName);
        String dwLevelSrc = getDwLevel(srcTableName);
        String isDwSrc = getIsDw(srcTableName);
        //如果来源表节点已存在，则直接取出
        TableNode srcNodesNow;
        srcNodesNow = (TableNode) dwRespositoryService.getNodeByName(srcTableName);
        //如果来源表节点不存在，则新建为ods节点
        if(srcNodesNow==null){
            srcNodesNow = new TableNode(srcTableName,null,dataLevelSrc,dwLevelSrc,isDwSrc);
            dwRespositoryService.save(srcNodesNow);
            this.lingageIdJson.put(srcTableName,srcNodesNow.getId());
        }
        if(srcNodesNow.getId()==null||nowNode.getId()==null||!dwRespositoryService.existOutputRelation(srcNodesNow.getId(),nowNode.getId())){
            nowNode.addDwSourceRelation(srcNodesNow);
        }
    }

    public void saveSrcUserAndRoleNode(GraphNodeImpl srcNode, String nowNodeName, String userNodeName){
        RoleNode roleNode;
        roleNode = (RoleNode) dwRespositoryService.getNodeByName(nowNodeName);
        if(roleNode==null){
            roleNode = new RoleNode(nowNodeName);
            dwRespositoryService.save(roleNode);
        }
        if(srcNode.getId()==null||roleNode.getId()==null||!dwRespositoryService.existOutputRelation(srcNode.getId(),roleNode.getId())){
            roleNode.addDwSourceRelation(srcNode);
            dwRespositoryService.save(roleNode);
        }

        UserNode userNode;
        userNode = (UserNode) dwRespositoryService.getNodeByName(userNodeName);
        if(userNode==null){
            userNode = new UserNode(userNodeName);
            dwRespositoryService.save(userNode);
        }
        if(roleNode.getId()==null||userNode.getId()==null||!dwRespositoryService.existOutputRelation(roleNode.getId(),userNode.getId())){
            userNode.addDwSourceRelation(roleNode);
            dwRespositoryService.save(userNode);
        }
    }

    public List<ReportInfo>  addReport(){
        List<ReportInfo> reportInfoList = reportService.getAllReportLineage();
        for (ReportInfo oneReport:reportInfoList) {
            String reportName = oneReport.getReportName();
            String createBy = oneReport.getCreateUser();
            String workbook = oneReport.getWorkbook();
            String dispatchPath = oneReport.getDispatchPath();
            Set<String> srcTableNames = oneReport.getSrcTables();
            odsTableSet.addAll(srcTableNames);
            String isReport = oneReport.getIsReport();
            String tableauUrl = oneReport.getTableauUrl();
            String dataLevel = getDataLevel(isReport);
            //根据报表名称取出当前节点
            ReportNode nowNode =  (ReportNode) dwRespositoryService.getNodeByName(reportName);
            //如果当前节点为空，则新添加次节点
            if(nowNode==null){
                nowNode = new ReportNode(reportName,workbook,dispatchPath,createBy,dataLevel,tableauUrl);
            }
            for (String srcTableName:srcTableNames) {
                saveSrcNode(srcTableName,nowNode);
                //如果当前两个节点不存在关系，则进行插入
            }
            dwRespositoryService.save(nowNode);
            this.lingageIdJson.put(reportName,nowNode.getId());
            if(oneReport.getMenuId()==null) continue;
            int menuId = oneReport.getMenuId();
            List<Map> userRoleMap = reportService.getUserAndRoleInfo(menuId);
            for (Map map : userRoleMap) {
                String role_name = (String) map.get("role_name");
                String nick_name;
                if(map.get("nick_name") == null){
                    nick_name = "空用户";
                } else{
                    nick_name = (String) map.get("nick_name");
                }
                if(nick_name.equals("超级管理员")||nick_name.equals("管理员")||nick_name.equals("李子钰")){
                    nick_name = nick_name+"用户";
                }
                saveSrcUserAndRoleNode(nowNode, role_name, nick_name);
            }
        }
        return reportInfoList;
    }

    @Autowired
    LocalFileCollect localFileCollect;


    public List<MetadataTable> addDwByLocal(){
        HashMap<String,MetadataTable> resultMap = new HashMap<>();
        List<Map> pgTables = pgsqlParse.getAllTables();
        for (Map map : pgTables) {
            MetadataTable metadataTable = new MetadataTable();
            String table_schema = map.get("table_schema").toString();
            String table_name = map.get("table_name").toString();
            String comment = pgsqlParse.getTableComment(table_name);
            long count = pgsqlParse.getDbTableCount(table_schema+"."+table_name);
            TableNode tableNode = new TableNode(table_schema+"."+table_name,comment,"ods_table","ods","否", null,null,null);
            dwRespositoryService.save(tableNode);
            this.lingageIdJson.put(table_schema+"."+table_name,tableNode.getId());
            metadataTable.setDbCount(count);
            metadataTable.setDbTable(table_schema+"."+table_name);
            metadataTable.setTableName(table_name);
            metadataTable.setComment(comment);
            resultMap.put(table_schema+"."+table_name,metadataTable);
        }
        List<MetadataTable> metadataTableList =  localFileCollect.getAllInfo();
        for(MetadataTable metadataTable:metadataTableList){
            String dbTable= metadataTable.getDbTable();
            Set<String> srcTables= metadataTable.getSrcTables();
            odsTableSet.addAll(srcTables);
            String dataLevel = "dic_dw_table";
            String dwLevel = "middle";
            String isDw = "是";
            TableNode tableNode = (TableNode)dwRespositoryService.getNodeByName(dbTable);
            //如果当前表名已存在节点,直接取出当前节点
            if(tableNode!=null){
                tableNode = dwRespositoryService.updateLabel(tableNode,null,dataLevel,dwLevel,isDw);
            } else{ //如果当前节点不存在，则需要新建节点
                tableNode = new TableNode(dbTable,null,dataLevel,dwLevel,isDw);
            }

            //添加数仓血缘
            for(String srcTableName:srcTables){
                saveSrcNode(srcTableName,tableNode);
                //如果当前两个节点不存在关系，则进行插入
            }
            dwRespositoryService.save(tableNode);
            this.lingageIdJson.put(dbTable,tableNode.getId());

            String table_schema = dbTable.split("\\.")[0];
            String table_name =  dbTable.split("\\.")[1];
            String comment = pgsqlParse.getTableComment(table_name);
            long count = pgsqlParse.getDbTableCount(table_schema+"."+table_name);
            metadataTable.setDbCount(count);
            metadataTable.setComment(comment);
            resultMap.put(dbTable,metadataTable);
        }

        List<MetadataTable> resultList = new ArrayList<>();
        for(String keyString:resultMap.keySet()){
            resultList.add(resultMap.get(keyString));
        }
        return resultList;
    }

    public List<MetadataTable> addDwByDolphin(List<MetadataTable> metadataTableList){
        for(MetadataTable metadataTable :metadataTableList){
            SchedulerInfo schedulerInfo = metadataTable.getSchedulerInfo();
            String dbTable= metadataTable.getDbTable();
            Set<String> srcTables= metadataTable.getSrcTables();
            String taskDescription= schedulerInfo.getTaskDescription();
            String dataLevel = getDataLevel(dbTable);
            String dwLevel = getDwLevel(dbTable);
            String isDw = getIsDw(dbTable);
            TableNode tableNode = (TableNode)dwRespositoryService.getNodeByName(dbTable);
            if(tableNode!=null){
                tableNode = dwRespositoryService.updateLabel(tableNode,taskDescription,dataLevel,dwLevel,isDw);
            } else{ //如果当前节点不存在，则需要新建节点
                tableNode = new TableNode(dbTable,taskDescription,dataLevel,dwLevel,isDw);
            }

            //添加数仓血缘
            for(String srcTableName:srcTables){
                saveSrcNode(srcTableName,tableNode);
                //如果当前两个节点不存在关系，则进行插入
            }
            dwRespositoryService.save(tableNode);
            this.lingageIdJson.put(dbTable,tableNode.getId());
        }
        return metadataTableList;
    }
}
