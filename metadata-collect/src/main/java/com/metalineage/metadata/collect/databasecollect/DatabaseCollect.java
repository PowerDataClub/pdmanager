package com.metalineage.metadata.collect.databasecollect;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.metadata.collect.databasecollect.entity.MetadataEntity;
import com.metalineage.metadata.collect.databasecollect.querysql.MysqlQuerySql;
import com.metalineage.metadata.util.JdbcUtil;
import com.metalineage.metadata.collect.databasecollect.entity.TableMetadataEntity;
import lombok.Data;

import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.List;

/**
 * 数据库采集器基础类
 * 一个采集器对应一个整体的数据库连接
 * 通过采集器可以采集到当前数据库的整体元数据信息
 */
@Data
public abstract class DatabaseCollect {
    //JDBC工具类
    public final JdbcUtil jdbcUtil;

    //元数据信息实体类
    public MetadataEntity metadataEntity;

    /**
     * 构造函数
     * @param dbType 数据库类型
     * @param url 数据库连接地址
     * @param username 用户名
     * @param password 密码
     */
    public DatabaseCollect(String dbInstanceName,
                           String dbType,
                           String url,
                           String username,
                           String password,
                           String dbComment){
        metadataEntity = new MetadataEntity();
        metadataEntity.dbInstanceName=dbInstanceName;
        metadataEntity.dbType = dbType;
        metadataEntity.url = url;
        metadataEntity.username = username;
        metadataEntity.password = password;
        metadataEntity.dbComment = dbComment;
        this.jdbcUtil = new JdbcUtil(dbType,url,username,password);
        setDbNamesMetadata();
        setBaseMetadata();
    }
    /**
     * 获取数据库的基础元数据信息并赋值包括
     * 是否只读
     * 是否支持事务
     * 数据库版本
     */
    protected void setBaseMetadata(){
        try {
            DatabaseMetaData databaseMetaData = jdbcUtil.getConnection().getMetaData();
            metadataEntity.setReadOnly(databaseMetaData.isReadOnly());
            metadataEntity.setSupportsTransactions(databaseMetaData.supportsTransactions());
            metadataEntity.setDbVersion(databaseMetaData.getDatabaseProductVersion());

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    };

    /**
     * 获取数据库的所有数据库名信息并返回
     */
    protected void setDbNamesMetadata(){
        String sql = MysqlQuerySql.getDbnamesSql();
        JSONArray jsonArray = jdbcUtil.query(sql);
        for(int i =0;i<jsonArray.size();i++){
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            metadataEntity.dbNames.add(jsonObject.getString("Database"));
        }
    }

    /**
     * 获取每个数据库的表名列表，并赋值到元数据实体类中
     */
    public void setDbTablesMetadata() {
        //循环每个数据库名，添加表元数据实体
        for(String dbName:metadataEntity.dbNames){
            //添加到元数据实体类中，以库名为key，添加当前库的元数据实体列表
            metadataEntity.dbTables.put(dbName,getTableMetadata(dbName));
        }
    }

    /**
     * 获取指定数据库的表名列表，并赋值到元数据实体类中
     */
    public void setSpecificDbTableMetadata(String specificDbName) {
        if (metadataEntity.dbTables.containsKey(specificDbName)) {
            //添加到元数据实体类中，以库名为key，添加当前库的元数据实体列表
            metadataEntity.dbTables.put(specificDbName,getTableMetadata(specificDbName));
        } else {
            System.out.println("The database with name '" + specificDbName + "' does not exist.");
        }
    }

    /**
     * 根据指定的数据库名称获取并构建表元数据实体列表并返回
     * 由于每个数据库的表元数据信息返回逻辑是不一样的，所以这里需要抽象成子类实现
     * @param dbName 数据库名称
     * @return 当前数据库下的所有表元数据实体
     */
    public abstract List<TableMetadataEntity> getTableMetadata(String dbName);



    /**
     * 获取表的记录数
     * @param tableMetadata 表元数据实体
     */
    public void setTableRecordCount(TableMetadataEntity tableMetadata) {
        JSONArray resultSet = jdbcUtil.query(MysqlQuerySql.getCountSql(tableMetadata.getDbName(),tableMetadata.getTableName()));
        for (int i = 0; i < resultSet.size(); i++) {
            JSONObject jsonObject = resultSet.getJSONObject(i);
            tableMetadata.setRecordCount(jsonObject.getLong("recordCount"));
        }
    }

    //获取表的列的元数据信息
    public abstract void setTableColumnsInfo(TableMetadataEntity tableMetadata);

    //设置表的基本元数据信息包括更新时间、引擎、建表语句、备注等等
    public abstract void setTableBaseMetadata(TableMetadataEntity tableMetadata);

    /**
     * 获取元数据信息
     */
    public static void main(String[] args) {

    }

}
