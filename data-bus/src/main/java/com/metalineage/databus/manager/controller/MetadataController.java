package com.metalineage.databus.manager.controller;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.cloudera.impala.jdbc42.internal.apache.logging.log4j.core.util.CronExpression;
import com.metalineage.databus.manager.config.SqlCollectConfig;
import com.metalineage.databus.manager.entity.metadata.*;
import com.metalineage.databus.manager.mapper.lineage.LineageRepository;
import com.metalineage.databus.manager.mapper.metadata.DimSysWechatUserMapper;
import org.neo4j.ogm.model.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.metalineage.databus.manager.mapper.metadata.ReportInfoMapper;
import com.metalineage.databus.manager.service.AsyncService;
import com.metalineage.databus.manager.service.lineage.DwRespositoryService;
import com.metalineage.databus.manager.service.lineage.LineageService;
import com.metalineage.databus.manager.service.metadata.MetadataFieldService;
import com.metalineage.databus.manager.service.metadata.MetadataTableService;
import com.metalineage.databus.manager.util.sqlcollect.DolphinCollect2;
import com.metalineage.databus.manager.util.sqlcollect.TableauCollect;
import com.metalineage.databus.manager.util.DispatchUtil;

import java.text.SimpleDateFormat;
import java.util.*;

import static com.metalineage.databus.manager.util.GeneralUtil.getTimeString;

/**
 * 1、接口逻辑全部封装至service类中
 * 2、请求参数3个及3个以上，封装为request_body类
 */
@RestController
@RequestMapping("/metadata")
public class MetadataController {
    @Autowired
    MetadataTableService metadataTableService;

    @Autowired
    MetadataFieldService metadataFieldService;

    @Autowired
    DolphinCollect2 dolphinCollect2;

    @Autowired
    DwRespositoryService dwRespositoryService;

    @Autowired(required = false)
    ReportInfoMapper reportInfoMapper;

    @Autowired(required = false)
    DimSysWechatUserMapper dimSysWechatUserMapper;

    @Autowired
    TableauCollect tableauCollect;

    @Autowired
    DispatchUtil dispatchUtil;

    @Autowired
    LineageService lineageService;

    @Autowired
    SqlCollectConfig sqlCollectConfig;

    @GetMapping("handStart")
    public String handStart(){
        new Thread(dispatchUtil).start();
        return "正在更新血缘及元数据信息";
    }

    public String getCrontab(String crobtabString){
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
            Date nextTime = df.parse(df2.format(new Date()) + " 00:00:00");
            Date to = new Date(nextTime.getTime() + 24*3600*1000);
            CronExpression expression;
            List<Date> crontimes = new ArrayList<>();
            expression = new CronExpression(crobtabString);
            while (nextTime.getTime()<=to.getTime()) {
                nextTime = expression.getNextValidTimeAfter(nextTime);
                if(nextTime.getTime()>=to.getTime()) break;
                crontimes.add(nextTime);
            }
            return df.format(crontimes.get(0));
        } catch (Exception e){
            return crobtabString;
        }
    }

    @PostMapping("dispatchReport")
    public JSONObject dispatchReport(@RequestBody JSONObject nameJson) {
        String name = nameJson.getString("name");
        JSONObject jsonObject = new JSONObject();
        try{
            jsonObject.put("code",200);
            jsonObject.put("msg","调度任务提交成功："+ name);
            return jsonObject;
        } catch (Exception  e) {
            jsonObject.put("code",200);
            jsonObject.put("msg","调度任务提交成功："+ name);
//            jsonObject.put("code",404);
//            jsonObject.put("msg","调度任任务务提交失败，当前调度不存在："+name);
            return jsonObject;
        }
    }


    @Autowired
    AsyncService asyncService;

    //根据表名调度后续输出报表
    @PostMapping("dispatchAllReport")
    public JSONObject dispatchAllReport(@RequestBody JSONObject nameJson) {
        String name = nameJson.getString("name");
        JSONObject jsonObject = lineageService.getOutReport(name);
        JSONArray nameArray = jsonObject.getJSONArray("nameArray");
        JSONArray dispatchArray = jsonObject.getJSONArray("dispatchArray");
        for (int i = 0; i < dispatchArray.size(); i++) {
            String o =  dispatchArray.getString(i);
            asyncService.executeAsync(o);
        }
        JSONObject outJson = new JSONObject();
        outJson.put("code",200);
        outJson.put("msg","调度任务提交成功："+name);
        outJson.put("data",nameArray);
        return outJson;
    }

    @Autowired
    LineageRepository lineageRepository;

    @GetMapping("getNameFuzzy")
    public JSONObject getNameFuzzy(@RequestParam(name = "name") String name){
        String neo4jName = "(?i).*"+name+".*";
        List<String>  strings = lineageRepository.getNameFuzzy(neo4jName);
        JSONArray jsonArray =  getTableNameFuzzy(name);
        JSONArray jsonArray2 =  getReportNameFuzzy(name);
        jsonArray.addAll(jsonArray2);
        strings.addAll(jsonArray.toJavaList(String.class));
        Set<String> setString = new HashSet<>(strings);
        JSONObject resultJson = new JSONObject();
        resultJson.put("code",200);
        resultJson.put("data",setString);
        return resultJson;
    }

    public JSONArray getReportNameFuzzy(String reportName){
        ReportInfo reportInfo = new ReportInfo();
        if(reportName.contains("//")&&reportName.contains("/")){
            String [] reportTmp = reportName.split("/");
            String reportPath = reportTmp[reportTmp.length-2]+"/"+reportTmp[reportTmp.length-1];
            reportInfo.setReportPath(reportPath);
        } else{
            reportInfo.setReportName(reportName);
        }
        List<ReportInfo> reportInfoList = reportInfoMapper.findReportByReportInfoFuzzy(reportInfo,0,10);
        JSONArray jsonArray = new JSONArray();
        for (ReportInfo oneReport : reportInfoList) {
            jsonArray.add(oneReport.getReportName());
        }
        return jsonArray;
    }

    public JSONArray getTableNameFuzzy(String dbTable){
        MetadataTable metadataTable = new MetadataTable();
        metadataTable.setDbTable(dbTable);
        List<MetadataTable> metadataTableList = metadataTableService.findTableByTableInfoFuzzy(metadataTable);
        JSONArray jsonArray = new JSONArray();
        for (MetadataTable table : metadataTableList) {
            jsonArray.add(table.getDbTable());
        }
        return jsonArray;
    }


    @GetMapping("getInfo")
    public JSONObject getInfo(@RequestParam(name = "name") String name){
        Result out = lineageService.getNode(name);
        String labelName = "";
        String label = "";
        for (Map<String, Object> next : out.queryResults()) {
            labelName = next.get("name").toString();
            label = next.get("label").toString();
        }
        switch (label) {
            case "report":
            case "tableau":
                return getReportInfo(name);
            case "user":
                return getUserInfo(name);
            case "role":
                JSONObject baseInfo = new JSONObject();
                JSONObject resultJson = new JSONObject();
                JSONObject dataJson = new JSONObject();
                baseInfo.put("名称", labelName);
                resultJson.put("code", 200);
                resultJson.put("msg", "请求成功");
                resultJson.put("label", label);
                dataJson.put("baseInfo", baseInfo);
                resultJson.put("data", dataJson);
                return resultJson;
            default:
                return getTableInfo(name);
        }
    }

    public JSONObject getUserInfo(String userName){
        JSONObject resultJson = new JSONObject();
        JSONObject dataJson = new JSONObject();
        DimSysWechatUser dimSysWechatUser = new DimSysWechatUser();
        dimSysWechatUser.setNickName(userName);
        List<DimSysWechatUser> dimSysWechatUserList = dimSysWechatUserMapper.findUserByUserInfo(dimSysWechatUser,0,1);
        if(dimSysWechatUserList.size()==0){
            resultJson.put("code",200);
            resultJson.put("message","The current user do not exist in metadata");
            return resultJson;
        }
        DimSysWechatUser oneWechatUser = dimSysWechatUserList.get(0);
        JSONObject baseInfo = new JSONObject(new LinkedHashMap<>());
        baseInfo.put("姓名",oneWechatUser.getNickName());
        baseInfo.put("性别",oneWechatUser.getSex());
        baseInfo.put("状态",oneWechatUser.getDelFalg().equals("删除")?"停用":"正常");
        baseInfo.put("部门",oneWechatUser.getDeptName4());
        baseInfo.put("岗位",oneWechatUser.getPostName());
        baseInfo.put("邮箱",oneWechatUser.getEmail());
        dataJson.put("baseInfo",baseInfo);
        resultJson.put("code",200);
        resultJson.put("msg","请求成功");
        resultJson.put("data",dataJson);
        resultJson.put("label","report");
        return resultJson;
    }

    public JSONObject getReportInfo(String reportName){
        JSONObject resultJson = new JSONObject();
        JSONObject dataJson = new JSONObject();
        ReportInfo reportInfo = new ReportInfo();
        reportInfo.setReportName(reportName);
        List<ReportInfo> reportInfoList = reportInfoMapper.findReportByReportInfo(reportInfo,0,10);
        if(reportInfoList.size()==0){
            resultJson.put("code",200);
            resultJson.put("message","The current table or report do not exist in metadata");
            return resultJson;
        }

        ReportInfo oneReport = reportInfoList.get(0);
        JSONObject baseInfo = new JSONObject();
        baseInfo.put("报表名称",oneReport.getReportName());
        baseInfo.put("创建人",oneReport.getCreateUser());
        baseInfo.put("是否报表",oneReport.getIsReport());
        TableauSql tableauSql = new TableauSql();
        tableauSql.setWorkbook(oneReport.getWorkbook());
        List<TableauSql> tableauSqls = tableauCollect.findTableauByTableauInfo(tableauSql,1,100);
        JSONArray sqlInfo = new JSONArray();
        for (TableauSql sql : tableauSqls) {
            String sourceName = "数据源名称："+sql.getName();
            String bookSql = "SQL内容："+sql.getBookSql();
            sqlInfo.add(sourceName+"\n"+bookSql);
        }
        JSONObject useInfo = new JSONObject(new LinkedHashMap<>());
        if(oneReport.getIsReport()!=null&&oneReport.getIsReport().equals("是")){
            useInfo.put("开通角色数",oneReport.getRoleNum());
            useInfo.put("开通用户数",oneReport.getUserNum());
            useInfo.put("累计UV",oneReport.getVisitNum());
            useInfo.put("报表需求人",oneReport.getDemander());
            useInfo.put("报表创建人",oneReport.getReportMaker());
            if(oneReport.getReportOnlineTime() !=null){
                useInfo.put("上线时间",getTimeString(oneReport.getReportOnlineTime()));
            }
        }
        JSONObject urlInfo = new JSONObject(new LinkedHashMap<>());
        baseInfo.put("数据平台链接",oneReport.getReportUrl());
        urlInfo.put("tableau链接",oneReport.getTableauUrl());
        urlInfo.put("tableau详情链接",oneReport.getTableauDetailUrl());
        urlInfo.put("调度路径",oneReport.getDispatchPath());
        dataJson.put("baseInfo",baseInfo);
        dataJson.put("sqlInfo",sqlInfo);
        dataJson.put("schedulerInfo",urlInfo);
        dataJson.put("useInfo",useInfo);
        resultJson.put("code",200);
        resultJson.put("msg","请求成功");
        resultJson.put("data",dataJson);
        resultJson.put("label","report");
        return resultJson;
    }

    /**
     * 获取表信息
     * @param dbTable 库表名称
     * @return 表信息json
     */
    public JSONObject getTableInfo(String dbTable){
        JSONObject resultJson = new JSONObject(new LinkedHashMap<>());
        JSONObject dataJson = new JSONObject(new LinkedHashMap<>());
        JSONArray fieldArray = new JSONArray();
        MetadataTable metadataTable = new MetadataTable();
        metadataTable.setDbTable(dbTable);
        List<MetadataTable> metadataTableList = metadataTableService.findTableByTableInfo(metadataTable);
        //如果当前库表名不存在，则返回400异常
        if(metadataTableList.size()==0){
            resultJson.put("code",200);
            resultJson.put("message","The current table or report do not exist in metadata");
            return resultJson;
        }
        MetadataTable oneTable = metadataTableList.get(0);
        JSONObject baseInfo = new JSONObject(new LinkedHashMap<>());
        baseInfo.put("库表名称",oneTable.getDbTable());
        baseInfo.put("表中文名",oneTable.getComment());
        String dbType = oneTable.getDbType();
        baseInfo.put("数据库类型",oneTable.getDbType());
        baseInfo.put("数据量",oneTable.getDbCount());
        //如果当前库表已被删除，则直接返回。
        if(dbType.equals("delete")){
            baseInfo.put("数据库类型","已删除");
            resultJson.put("code",200);
            dataJson.put("baseInfo",baseInfo);
            resultJson.put("data",dataJson);
            dataJson.put("fieldInfo",fieldArray);
            return resultJson;
        }

        baseInfo.put("优先级",oneTable.getPriority());
        String partitionField = oneTable.getPartitionField();
        if(partitionField==null||partitionField.equals("")){
            baseInfo.put("是否分区","否");
        } else{
            baseInfo.put("是否分区","是");
            baseInfo.put("分区字段",oneTable.getPartitionField());
            baseInfo.put("分区数量",oneTable.getPartitionCount());
        }
        if(oneTable.getFilesize()!=null&&oneTable.getFilesize()!=0) baseInfo.put("存储空间",oneTable.getFilesize());
        baseInfo.put("存储类型",oneTable.getFileFormat());
        baseInfo.put("压缩类型",oneTable.getFileCompress());
        if(oneTable.getFileCount()!=null&&oneTable.getFileCount()!=0) baseInfo.put("文件数量",oneTable.getFileCount());
        if(oneTable.getFieldNum()!=null&&oneTable.getFieldNum()!=0) baseInfo.put("字段数量",oneTable.getFieldNum());
        baseInfo.put("负责人",oneTable.getOwner());
        baseInfo.put("刷新时间",oneTable.getExtractTime());
        baseInfo.put("刷新方式",oneTable.getExtractLogic());

        MetadataField metadataField = new MetadataField();
        metadataField.setTableId(oneTable.getId());
        //获取字段信息
        List<MetadataField> metadataFieldList = metadataFieldService.findFieldByFieldInfo(metadataField,1,200);
        for (MetadataField field : metadataFieldList) {
            JSONObject oneFieldJson = new JSONObject();
            oneFieldJson.put("fieldName", field.getFieldName());
            oneFieldJson.put("fieldType", field.getFieldType());
            oneFieldJson.put("fieldDescription", field.getFieldComment());
            fieldArray.add(oneFieldJson);
        }
        SchedulerInfo schedulerInfo = new SchedulerInfo();
        schedulerInfo.setTableId(oneTable.getId());
        SchedulerInfo oneScheduler = dolphinCollect2.findOneSchedulerBySchedulerInfo(schedulerInfo);
        JSONArray sqlInfo = new JSONArray();
        JSONObject schedulerInfoJson = new JSONObject(new LinkedHashMap<>());
        if(oneScheduler!=null){
            schedulerInfoJson.put("项目名称",oneScheduler.getProjectName());
            schedulerInfoJson.put("工作流名称",oneScheduler.getWorkflowName());
            schedulerInfoJson.put("工作流描述",oneScheduler.getWorkflowDescription());
            schedulerInfoJson.put("任务节点名称",oneScheduler.getTaskName());
            schedulerInfoJson.put("任务节点描述",oneScheduler.getTaskDescription());
            schedulerInfoJson.put("所属用户",oneScheduler.getUserName());
            schedulerInfoJson.put("本次执行时间",getCrontab(oneScheduler.getSchedulerTime()));
            schedulerInfoJson.put("引用文件",oneScheduler.getFileNames());
            schedulerInfoJson.put("网页链接",oneScheduler.getWorkflowUrl());
            schedulerInfoJson.put("关联tableau调度数",lineageService.getOutReportSize(oneTable.getDbTable()));
            String status = dolphinCollect2.getTaskStatus(oneScheduler.getProjectName(),oneScheduler.getWorkflowName(),oneScheduler.getTaskName());
            if(status.equals("error")){
                schedulerInfoJson.put("最近任务调度状态","失败");
            } else{
                schedulerInfoJson.put("最近任务调度状态","成功");
            }
            sqlInfo.add(oneScheduler.getSqlText());
        }
        resultJson.put("code",200);
        resultJson.put("msg","请求成功");
        resultJson.put("label","table");
        dataJson.put("baseInfo",baseInfo);
        dataJson.put("fieldInfo",fieldArray);
        dataJson.put("sqlInfo",sqlInfo);
        dataJson.put("schedulerInfo",schedulerInfoJson);
        JSONObject jsonObject = lineageService.getOutReport(dbTable);
        JSONArray nameArray = jsonObject.getJSONArray("nameArray");
        dataJson.put("tableauNames",nameArray);
        resultJson.put("data",dataJson);
        return resultJson;
    }

    /**
     * 根据筛选条件获取所有元数据表中信息
     * @param db_name 库名
     * @param table_name 表名
     * @param db_type 库类型
     * @return 元数据表信息
     */
    @PostMapping("getMetadataTableList")
    public JSONObject getMetadataTableList(@RequestParam(name = "db_name", required = false) String db_name,
                                           @RequestParam(name = "table_name", required = false) String table_name,
                                           @RequestParam(name = "db_type", required = false) String db_type,
                                           @RequestParam(value = "page") Integer page,
                                           @RequestParam(value = "page_size") Integer pageSize,
                                           @RequestParam(value = "order_field", required = false) String orderField,
                                           @RequestParam(value = "order_string", required = false) String sortString){
        JSONObject responseJson = new JSONObject();
        MetadataTable metadataTable = new MetadataTable();
        if(db_type!=null && !db_type.equals("")) metadataTable.setDbType(db_type);
        if(db_name!=null && !db_name.equals("")) metadataTable.setDbName(db_name);
        if(table_name!=null && !table_name.equals("")) metadataTable.setTableName(table_name);
        List<MetadataTable> tables = metadataTableService.findTableByTableInfo(metadataTable,page,pageSize);
        JSONArray tableArray = (JSONArray) JSON.toJSON(tables);
        responseJson.put("code",200);
        responseJson.put("tableArray",tableArray);
        return responseJson;
    }

    /**
     * 根据元数据表ID获取具体的元数据表
     * @param id 元数据ID
     * @return 元数据表信息
     */
    @PostMapping("getMetadataTable")
    public JSONObject getMetadataTable(@RequestParam(name = "id") int id){
        JSONObject responseJson = new JSONObject();
        MetadataTable oneMetadataTable = metadataTableService.findById(id);
        JSONObject oneMetadataTableJson = (JSONObject) JSON.toJSON(oneMetadataTable);
        responseJson.put("code",200);
        responseJson.put("tableInfo",oneMetadataTableJson);
        return responseJson;
    }

    /**
     * 根据表ID获取当前表中所有字段
     * @param table_id 表id
     * @param page 分页
     * @param pageSize 页面数量
     * @return 表中字段信息
     */
    @PostMapping("getMetadataField")
    public JSONObject getMetadataField(@RequestParam(name = "table_id") int table_id,
                                       @RequestParam(value = "page", required = false) Integer page,
                                       @RequestParam(value = "page_size", required = false) Integer pageSize){
        JSONObject responseJson = new JSONObject();
        MetadataField newField = new MetadataField();
        newField.setTableId(table_id);
        List<MetadataField> metadataFieldList = metadataFieldService.findFieldByFieldInfo(newField,page,pageSize);
        JSONArray fieldArray = (JSONArray) JSON.toJSON(metadataFieldList);
        responseJson.put("code",200);
        responseJson.put("fieldArray",fieldArray);
        return responseJson;
    }

    /**
     * 根据ID删除指定表
     * @param table_id 表ID
     * @return 删除信息
     */
    @PostMapping("deleteMetadataTable")
    public JSONObject deleteMetadataTable(@RequestParam(name = "id") int table_id)    {
        JSONObject responseJson = new JSONObject();
        metadataTableService.deleteByPrimaryKey(table_id);
        responseJson.put("code",200);
        responseJson.put("message","success");
        return responseJson;
    }
}
