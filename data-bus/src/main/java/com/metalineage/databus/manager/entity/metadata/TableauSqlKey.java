package com.metalineage.databus.manager.entity.metadata;

public class TableauSqlKey {
    private Integer id;

    private String md5;

    private String workbook;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5 == null ? null : md5.trim();
    }

    public String getWorkbook() {
        return workbook;
    }

    public void setWorkbook(String workbook) {
        this.workbook = workbook == null ? null : workbook.trim();
    }
}