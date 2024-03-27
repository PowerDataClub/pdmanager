package com.metalineage.metadata.collect.databasecollect.entity;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class TableMetadataEntity {

    //表名称
    private String tableName;

    //库名称
    private String dbName;

    //记录条数
    private Long recordCount;

    //表注释
    private String comment;

    //建表SQL
    private String createTableSql;

    //所用引擎
    private String Engine;

    //字段数量
    private Integer fieldNum;

    //是否为分区表
    private Boolean isPartition;

    //分区数量
    private Integer partitionCount;

    //是否分桶
    private Boolean isBucket;

    //分桶数量
    private Integer bucketCount;

    //表的创建时间
    private Date tableCreateTime;

    //表的最后一次更新时间
    private Date tableLastModifyTime;

    //当前表所在的文件地址
    private String fileLocation;

    //当前表的文件占用空间，单位/byte
    private Long fileSpace;

    //文件类型
    private String fileFormat;

    //压缩类型
    private String fileCompress;

    //文件数量
    private Long fileCount;

    //表的创建时间
    private Long createTableTime;

    //表的最后更新时间
    private Long updateTableTime;

    //当前记录的创建时间
    private Long createTime;

    //字段信息
    public List<FieldMetadataEntity> fields;

}
