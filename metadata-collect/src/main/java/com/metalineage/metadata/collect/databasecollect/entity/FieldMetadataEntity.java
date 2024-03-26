package com.metalineage.metadata.collect.databasecollect.entity;

import lombok.Data;

@Data
public class FieldMetadataEntity  {

    //字段名称
    private String fieldName;

    //字段类型
    private String fieldType;

    //字段备注
    private String fieldComment;

    //是否主键字段
    private Boolean isKey;

    //是否分区字段
    private Boolean isPartitionKey;

    //主键类型，主键，外键，聚合键，排序键等
    private Integer keyType;

    //是否索引字段
    private Integer isIndex;

    //索引字段类型
    private Integer indexType;

    //可否为空
    private Boolean isNullAble;

    private String defaultValue;

}
