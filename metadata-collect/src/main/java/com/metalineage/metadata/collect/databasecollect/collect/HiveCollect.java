package com.metalineage.metadata.collect.databasecollect.collect;

import com.metalineage.metadata.collect.databasecollect.DatabaseCollect;
import com.metalineage.metadata.collect.databasecollect.entity.TableMetadataEntity;

import java.util.List;

public class HiveCollect extends DatabaseCollect {

    public HiveCollect(String dbInstanceName, String dbType, String url, String username, String password, String dbComment) {
        super(dbInstanceName, dbType, url, username, password, dbComment);
    }

    @Override
    public List<TableMetadataEntity> getTableMetadata(String dbName) {
        return null;
    }

    @Override
    public void setTableColumnsInfo(TableMetadataEntity tableMetadata) {

    }

    @Override
    public void setTableBaseMetadata(TableMetadataEntity tableMetadata) {

    }

}
