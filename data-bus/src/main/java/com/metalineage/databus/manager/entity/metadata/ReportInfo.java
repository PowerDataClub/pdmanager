package com.metalineage.databus.manager.entity.metadata;

import java.util.Date;
import java.util.Set;

public class ReportInfo {
    private Integer id;

    private String reportName;

    private String workbook;

    private String reportUrl;

    private String reportPath;

    private String tableauUrl;

    private String tableauDetailUrl;

    private String dispatchPath;

    private Integer visitNum;

    private Integer roleNum;

    private Integer userNum;

    private String createUser;

    private Integer lineageId;

    private String isReport;

    private Date createTime;

    private Date updateTime;

    private String demander;

    private String reportMaker;

    private Date reportOnlineTime;

    private Set<String> srcTables;

    private Integer menuId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName == null ? null : reportName.trim();
    }

    public String getWorkbook() {
        return workbook;
    }

    public void setWorkbook(String workbook) {
        this.workbook = workbook == null ? null : workbook.trim();
    }

    public String getReportUrl() {
        return reportUrl;
    }

    public void setReportUrl(String reportUrl) {
        this.reportUrl = reportUrl == null ? null : reportUrl.trim();
    }

    public String getReportPath() {
        return reportPath;
    }

    public void setReportPath(String reportPath) {
        this.reportPath = reportPath == null ? null : reportPath.trim();
    }

    public String getTableauUrl() {
        return tableauUrl;
    }

    public void setTableauUrl(String tableauUrl) {
        this.tableauUrl = tableauUrl == null ? null : tableauUrl.trim();
    }

    public String getTableauDetailUrl() {
        return tableauDetailUrl;
    }

    public void setTableauDetailUrl(String tableauDetailUrl) {
        this.tableauDetailUrl = tableauDetailUrl == null ? null : tableauDetailUrl.trim();
    }

    public String getDispatchPath() {
        return dispatchPath;
    }

    public void setDispatchPath(String dispatchPath) {
        this.dispatchPath = dispatchPath == null ? null : dispatchPath.trim();
    }

    public Integer getVisitNum() {
        return visitNum;
    }

    public void setVisitNum(Integer visitNum) {
        this.visitNum = visitNum;
    }

    public Integer getRoleNum() {
        return roleNum;
    }

    public void setRoleNum(Integer roleNum) {
        this.roleNum = roleNum;
    }

    public Integer getUserNum() {
        return userNum;
    }

    public void setUserNum(Integer userNum) {
        this.userNum = userNum;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser == null ? null : createUser.trim();
    }

    public Integer getLineageId() {
        return lineageId;
    }

    public void setLineageId(Integer lineageId) {
        this.lineageId = lineageId;
    }

    public String getIsReport() {
        return isReport;
    }

    public void setIsReport(String isReport) {
        this.isReport = isReport == null ? null : isReport.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getDemander() {
        return demander;
    }

    public void setDemander(String demander) {
        this.demander = demander == null ? null : demander.trim();
    }

    public String getReportMaker() {
        return reportMaker;
    }

    public void setReportMaker(String reportMaker) {
        this.reportMaker = reportMaker == null ? null : reportMaker.trim();
    }

    public Date getReportOnlineTime() {
        return reportOnlineTime;
    }

    public void setReportOnlineTime(Date reportOnlineTime) {
        this.reportOnlineTime = reportOnlineTime;
    }
    public Set<String> getSrcTables() {
        return srcTables;
    }
    public void setSrcTables(Set<String> srcTables) {
        this.srcTables = srcTables;
    }
    public Integer getMenuId() {
        return menuId;
    }
    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }
}