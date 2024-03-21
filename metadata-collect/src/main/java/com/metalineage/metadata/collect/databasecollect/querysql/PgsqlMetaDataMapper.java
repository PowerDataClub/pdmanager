package com.metalineage.metadata.collect.databasecollect.querysql;


import com.baomidou.dynamic.datasource.annotation.DS;
import com.metalineage.databus.manager.entity.metadata.MetadataField;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

//PG库的元数据获取还需要梳理一下
public interface PgsqlMetaDataMapper {

    @Select("SELECT table_schema,table_name FROM information_schema.tables WHERE table_schema not in('information_schema','pg_catalog','pg_toast_temp_1','pg_temp_1','pg_toast')")
    List<Map> getAllTables();

    @Select("select comment from (select relname as tabname,\n" +
            "cast(obj_description(relfilenode,'pg_class') as varchar) as comment from pg_class c\n" +
            "where relname = #{tableName} ) a where a.comment is not null limit 1")
    String getTableComment(String tableName);

    @Select("SELECT A.attname AS fieldName, format_type(A.atttypid, A.atttypmod) AS fieldType , col_description(A.attrelid, A.attnum) AS fieldComment FROM pg_class C, pg_attribute A WHERE C.relname = #{tableName} AND A.attrelid = C.oid AND A.attnum > 0")
    List<MetadataField> describeTable(String tableName);

    @Select("select count(1) from ${schemaAndTableName}")
    Long getDbTableCount(String schemaAndTableName);

    @Select("SELECT datname FROM pg_database WHERE datistemplate = false")
    List<Map> getAllDbName();

}
