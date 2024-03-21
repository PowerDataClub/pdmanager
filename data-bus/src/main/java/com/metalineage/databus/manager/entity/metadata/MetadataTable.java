package com.metalineage.databus.manager.entity.metadata;

import java.util.Date;
import java.util.Set;

public class MetadataTable {
    private Integer id;

    private String dbName;

    private String tableName;

    private String dbTable;

    private String dbType;

    private String owner;

    private String priority;

    private String isDw;

    private String dwLevel;

    private Integer lineageId;

    private Integer fieldNum;

    private Integer partitionType;

    private Integer partitionCount;

    private String partitionField;

    private Date createTime;

    private Date updateTime;

    private String note;

    private String comment;

    private String extractLogic;

    private String extractTime;

    private String businesDesc;

    private Long dbCount;

    private String fileLocation;

    private Long filesize;

    private String fileFormat;

    private String fileCompress;

    private Long fileCount;

    private SchedulerInfo schedulerInfo;

    private Set<String> srcTables;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName == null ? null : dbName.trim();
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName == null ? null : tableName.trim();
    }

    public String getDbTable() {
        return dbTable;
    }

    public void setDbTable(String dbTable) {
        this.dbTable = dbTable == null ? null : dbTable.trim();
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType == null ? null : dbType.trim();
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner == null ? null : owner.trim();
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority == null ? null : priority.trim();
    }

    public String getIsDw() {
        return isDw;
    }

    public void setIsDw(String isDw) {
        this.isDw = isDw == null ? null : isDw.trim();
    }

    public String getDwLevel() {
        return dwLevel;
    }

    public void setDwLevel(String dwLevel) {
        this.dwLevel = dwLevel == null ? null : dwLevel.trim();
    }

    public Integer getLineageId() {
        return lineageId;
    }

    public void setLineageId(Integer lineageId) {
        this.lineageId = lineageId;
    }

    public Integer getFieldNum() {
        return fieldNum;
    }

    public void setFieldNum(Integer fieldNum) {
        this.fieldNum = fieldNum;
    }

    public Integer getPartitionType() {
        return partitionType;
    }

    public void setPartitionType(Integer partitionType) {
        this.partitionType = partitionType;
    }

    public Integer getPartitionCount() {
        return partitionCount;
    }

    public void setPartitionCount(Integer partitionCount) {
        this.partitionCount = partitionCount;
    }

    public String getPartitionField() {
        return partitionField;
    }

    public void setPartitionField(String partitionField) {
        this.partitionField = partitionField == null ? null : partitionField.trim();
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

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }

    public String getExtractLogic() {
        return extractLogic;
    }

    public void setExtractLogic(String extractLogic) {
        this.extractLogic = extractLogic == null ? null : extractLogic.trim();
    }

    public String getExtractTime() {
        return extractTime;
    }

    public void setExtractTime(String extractTime) {
        this.extractTime = extractTime == null ? null : extractTime.trim();
    }

    public String getBusinesDesc() {
        return businesDesc;
    }

    public void setBusinesDesc(String businesDesc) {
        this.businesDesc = businesDesc == null ? null : businesDesc.trim();
    }

    public Long getDbCount() {
        return dbCount;
    }

    public void setDbCount(Long dbCount) {
        this.dbCount = dbCount;
    }

    public String getFileLocation() {
        return fileLocation;
    }

    public void setFileLocation(String fileLocation) {
        this.fileLocation = fileLocation == null ? null : fileLocation.trim();
    }

    public Long getFilesize() {
        return filesize;
    }

    public void setFilesize(Long filesize) {
        this.filesize = filesize;
    }

    public String getFileFormat() {
        return fileFormat;
    }

    public void setFileFormat(String fileFormat) {
        this.fileFormat = fileFormat == null ? null : fileFormat.trim();
    }

    public String getFileCompress() {
        return fileCompress;
    }

    public void setFileCompress(String fileCompress) {
        this.fileCompress = fileCompress == null ? null : fileCompress.trim();
    }

    public Long getFileCount() {
        return fileCount;
    }

    public void setFileCount(Long fileCount) {
        this.fileCount = fileCount;
    }
    public SchedulerInfo getSchedulerInfo() {
        return schedulerInfo;
    }
    public void setSchedulerInfo(SchedulerInfo schedulerInfo) {
        this.schedulerInfo = schedulerInfo;
    }
    public Set<String> getSrcTables() {
        return srcTables;
    }
    public void setSrcTables(Set<String> srcTables) {
        this.srcTables = srcTables;
    }
}