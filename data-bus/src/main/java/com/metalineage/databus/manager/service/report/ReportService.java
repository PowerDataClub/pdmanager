package com.metalineage.databus.manager.service.report;

import com.alibaba.fastjson2.JSONObject;
import com.metalineage.databus.manager.util.sqlcollect.TableauCollect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.metalineage.databus.manager.entity.metadata.ReportInfo;
import com.metalineage.databus.manager.entity.metadata.SysMenu;
import com.metalineage.databus.manager.entity.metadata.TableauSql;
import com.metalineage.databus.manager.mapper.metadata.ReportInfoMapper;
import com.metalineage.databus.manager.mapper.metadata.ManagerSysMenuMapper;
import com.metalineage.databus.manager.mapper.metadata.ManagerSysUserMapper;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.metalineage.databus.manager.util.GeneralUtil.selectTableauTable;

@Service
public class ReportService {
    @Autowired(required = false)
    ManagerSysMenuMapper sysMenuMapper;

    @Autowired
    TableauCollect tableauCollect;

    @Autowired(required = false)
    ManagerSysUserMapper sysUserMapper;

    @Autowired(required = false)
    ReportInfoMapper reportInfoMapper;

    @Value("${lineage.reportUrl}")
    private String reportUrl;

    public void insert(ReportInfo record){
        reportInfoMapper.insert(record);
    }

    public int upsert(ReportInfo record){
        if(record.getId()!=null){
            record.setUpdateTime(new Date());
            reportInfoMapper.updateByPrimaryKeySelective(record);
            return record.getId();
        }
        ReportInfo oneRecord = findOneReportByReportInfo(record);
        if(oneRecord!=null){
            record.setId(oneRecord.getId());
            record.setUpdateTime(new Date());
            reportInfoMapper.updateByPrimaryKeySelective(record);
            return record.getId();
        } else{
            record.setCreateTime(new Date());
            record.setUpdateTime(new Date());
            reportInfoMapper.insertSelective(record);
            return 1;
        }
    }

    public ReportInfo findOneReportByReportInfo(ReportInfo record){
        List<ReportInfo> metadataTableList = findReportByReportInfo(record,1,1);
        if(metadataTableList==null||metadataTableList.size()==0){
            return null;
        } else{
            return metadataTableList.get(0);
        }
    };

    public List<ReportInfo> findReportByReportInfo(ReportInfo record,int page,int pageSize){
        if(pageSize>100){
            pageSize = 100;
        }
        if(page<=0){
            page=1;
        }
        int startOffset = (page-1)*pageSize;
        return reportInfoMapper.findReportByReportInfo(record,startOffset,pageSize);
    };

    public List<SysMenu> findSysMenuByComponent(String component, int page, int pageSize){
        if(pageSize>100){
            pageSize = 100;
        }
        if(page<=0){
            page=1;
        }
        int startOffset = (page-1)*pageSize;
        return sysMenuMapper.findByComponent(component,startOffset,pageSize);
    };

    public JSONObject getVisitInfo(){
        JSONObject jsonObject = new JSONObject();
        List<Map> maps = reportInfoMapper.getVisitInfo();
        for (Map map : maps) {
            jsonObject.put(map.get("menuId").toString(),map.get("visitNum"));
        }
        return jsonObject;
    }

    public JSONObject getRoleInfo(){
        JSONObject jsonObject = new JSONObject();
        List<Map> map1 = reportInfoMapper.getRoleInfo2();
        List<Map> map2 = reportInfoMapper.getRoleInfo3();
        map1.addAll(map2);
        for (Map map : map1) {
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("path",map.get("path"));
            jsonObject1.put("roleNum",map.get("role_num"));
            jsonObject1.put("userNum",map.get("user_num"));
            jsonObject.put(map.get("menu_id").toString(),jsonObject1);
        }
        return jsonObject;
    }

    public List<Map> getUserAndRoleInfo(int menuId){
        return reportInfoMapper.getUserAndRoleInfo(menuId);
    };

    /**
     * 获取所有报表血缘关系
     */
    public List<ReportInfo> getAllReportLineage(){
        JSONObject reportRoleInfo = getRoleInfo();
        JSONObject reportVisitInfo = getVisitInfo();
        List<ReportInfo> reportInfoList = new ArrayList<>();
        JSONObject tableauJson = tableauCollect.getAllTableauSql();
        int i = 1;
        while(true){
            List<SysMenu> sysMenus = findSysMenuByComponent("tableau/report/index",i,100);
            for (SysMenu sysMenu : sysMenus) {
                String reportName = sysMenu.getMenuName();
                String userPhone = sysMenu.getCreateBy();
                String userName = sysUserMapper.findNameByPhone(userPhone);
                String workbook = sysMenu.getPath().split("/")[0];
                List<TableauSql> tableauSqls;
                try{
                    tableauSqls = tableauJson.getJSONArray(workbook).toJavaList(TableauSql.class);
                } catch (Exception e){
                    continue;
                }
                ReportInfo reportInfo = new ReportInfo();
                Set<String> srcTableSet = new HashSet<>();
                for (TableauSql oneTableSql : tableauSqls) {
                    Set<String> srcTables = selectTableauTable(oneTableSql.getBookSql());
                    for (String s : srcTables) {
                        Pattern p = Pattern.compile("[\\u4E00-\\u9FA5|\\\\！，。（）《》“”？：；【】]");
                        Matcher m = p.matcher(s);
                        if (!m.find()) {
                            srcTableSet.add(s);
                        }
                    }
                    reportInfo.setTableauUrl(oneTableSql.getWebpageUrl());
                    reportInfo.setTableauDetailUrl(oneTableSql.getWebpageUrl().split("workbooks")[0]+"views/"+sysMenu.getPath());
                    reportInfo.setDispatchPath(oneTableSql.getWorkbookPath());
                }
                reportInfo.setReportName(reportName);
                reportInfo.setCreateUser(userName);
                reportInfo.setSrcTables(srcTableSet);
                reportInfo.setWorkbook(workbook);
                reportInfo.setReportPath(sysMenu.getPath());
                reportInfo.setMenuId(sysMenu.getMenuId().intValue());
                reportInfo.setIsReport("是");
                Map userInfoMap = reportInfoMapper.getUserInfoByMenuId(reportInfo.getMenuId());
                if(userInfoMap!=null&&!userInfoMap.isEmpty()){
                    reportInfo.setDemander((String) userInfoMap.get("demander"));
                    reportInfo.setReportMaker((String) userInfoMap.get("report_maker"));
                    reportInfo.setReportOnlineTime((Date) userInfoMap.get("report_online_time"));
                }
                reportInfo.setVisitNum(reportVisitInfo.getInteger(sysMenu.getMenuId().toString()));
                JSONObject oneRoleInfo = reportRoleInfo.getJSONObject(sysMenu.getMenuId().toString());
                if(oneRoleInfo!=null){
                    reportInfo.setReportUrl(reportUrl+oneRoleInfo.getString("path"));
                    reportInfo.setRoleNum(oneRoleInfo.getInteger("roleNum"));
                    reportInfo.setUserNum(oneRoleInfo.getInteger("userNum"));
                }
                reportInfoList.add(reportInfo);
                tableauJson.remove(workbook);
            }
            if(sysMenus.size()!=100){
                break;
            }
            i+=1;
        }
        for(String keyString : tableauJson.keySet()){
            List<TableauSql> tableauSqls = tableauJson.getJSONArray(keyString).toJavaList(TableauSql.class);
            ReportInfo reportInfo = new ReportInfo();
            Set<String> srcTableSet = new HashSet<>();
            for (TableauSql oneTableSql : tableauSqls) {
                Set<String> srcTables = selectTableauTable(oneTableSql.getBookSql());
                for (String s : srcTables) {
                    Pattern p = Pattern.compile("[\\u4E00-\\u9FA5|\\\\！，。（）《》“”？：；【】]");
                    Matcher m = p.matcher(s);
                    if (!m.find()) {
                        srcTableSet.add(s);
                    }
                }
                reportInfo.setReportUrl(oneTableSql.getWebpageUrl());
                reportInfo.setDispatchPath(oneTableSql.getWorkbookPath());
                reportInfo.setReportName(oneTableSql.getWorkbook());
                reportInfo.setWorkbook(oneTableSql.getWorkbook());
            }
            reportInfo.setCreateUser("tableau");
            reportInfo.setSrcTables(srcTableSet);
            reportInfo.setIsReport("否");
            reportInfoList.add(reportInfo);
        }
        return reportInfoList;
    }

    public void deleteAll(){
        reportInfoMapper.deleteAll();
    }
}
