package com.metalineage.databus.manager.mapper.metaparse;


import com.baomidou.dynamic.datasource.annotation.DS;
import com.metalineage.databus.manager.entity.metaParseEntity.ImpalaDescribeEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
@DS("impala")
public interface ImpalaMetaDataMapper {

    @Select("show tables in ${dbname}")
    List<String> getAllTables(String dbName);

    @Select("show partitions  ${dbAndTableName}")
    List<String> getTablePartitions(String dbAndTableName);

    @Select("select count(1) from ${dbAndTableName}")
    Long getDbTableCount(String dbAndTableName);

    @Select("show create table  ${dbAndTableName}")
    String getDbTableCreate(String dbAndTableName);

    @Select("describe  ${dbAndTableName}")
    List<ImpalaDescribeEntity> describeTable(String dbAndTableName);

}
