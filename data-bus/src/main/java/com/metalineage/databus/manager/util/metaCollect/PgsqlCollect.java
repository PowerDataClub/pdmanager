package com.metalineage.databus.manager.util.metaCollect;

import com.metalineage.databus.manager.entity.metadata.MetadataField;
import com.metalineage.databus.manager.mapper.metaparse.PgsqlMetaDataMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class PgsqlCollect {
    @Autowired
    public PgsqlMetaDataMapper pgsqlMetaDataMapper;

    public List<Map> getAllTables(){
        return pgsqlMetaDataMapper.getAllTables();
    }

    public String getTableComment(String tableName){
        return pgsqlMetaDataMapper.getTableComment(tableName);
    };

    public List<MetadataField> describeTable(String tableName){
        return pgsqlMetaDataMapper.describeTable(tableName);
    };

    public Long getDbTableCount(String schemaAndTableName){
        return pgsqlMetaDataMapper.getDbTableCount(schemaAndTableName);
    };

    public List<Map> getAllDbName(){
        return pgsqlMetaDataMapper.getAllDbName();
    };
}
