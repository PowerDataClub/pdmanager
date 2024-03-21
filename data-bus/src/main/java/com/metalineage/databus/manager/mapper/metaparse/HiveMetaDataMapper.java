package com.metalineage.databus.manager.mapper.metaparse;


import com.baomidou.dynamic.datasource.annotation.DS;
import com.metalineage.databus.manager.entity.metaParseEntity.HiveDescribeEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
@DS("hive")
public interface HiveMetaDataMapper {

    @Select("show partitions  ${dbAndTableName}")
    List<String> getTablePartitions(String dbAndTableName);

    @Select("select count(1) from ${dbAndTableName}")
    Long getDbTableCount(String dbAndTableName);

    @Select("show create table  ${dbAndTableName}")
    List<String> getDbTableCreate(String dbAndTableName);

    @Select("describe  ${dbAndTableName}")
    List<HiveDescribeEntity> describeTable(String dbAndTableName);

}
