package com.metalineage.databus.manager.entity.metadata;

import java.util.Date;

public class TableauSql {
    private Integer id;

    private String workbook;

    private String workbookId;

    private String workbookPath;

    private Date gmtCreate;

    private Date gmtModified;

    private String md5;

    private String webpageUrl;

    private String name;

    private String bookSql;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getWorkbook() {
        return workbook;
    }

    public void setWorkbook(String workbook) {
        this.workbook = workbook == null ? null : workbook.trim();
    }

    public String getWorkbookId() {
        return workbookId;
    }

    public void setWorkbookId(String workbookId) {
        this.workbookId = workbookId == null ? null : workbookId.trim();
    }

    public String getWorkbookPath() {
        return workbookPath;
    }

    public void setWorkbookPath(String workbookPath) {
        this.workbookPath = workbookPath == null ? null : workbookPath.trim();
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Date getGmtModified() {
        return gmtModified;
    }

    public void setGmtModified(Date gmtModified) {
        this.gmtModified = gmtModified;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5 == null ? null : md5.trim();
    }

    public String getWebpageUrl() {
        return webpageUrl;
    }

    public void setWebpageUrl(String webpageUrl) {
        this.webpageUrl = webpageUrl == null ? null : webpageUrl.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getBookSql() {
        return bookSql;
    }

    public void setBookSql(String bookSql) {
        this.bookSql = bookSql == null ? null : bookSql.trim();
    }
}