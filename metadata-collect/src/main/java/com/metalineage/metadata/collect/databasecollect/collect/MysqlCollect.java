package com.metalineage.metadata.collect.databasecollect.collect;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.metadata.collect.databasecollect.DatabaseCollect;
import com.metalineage.metadata.collect.databasecollect.querysql.MysqlQuerySql;
import com.metalineage.metadata.collect.databasecollect.entity.FieldMetadataEntity;
import com.metalineage.metadata.collect.databasecollect.entity.MetadataEntity;
import com.metalineage.metadata.collect.databasecollect.entity.TableMetadataEntity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class MysqlCollect extends DatabaseCollect {

    /**
     * 构造函数
     *
     * @param dbInstanceName 数据库实例名称
     * @param dbType         数据库类型
     * @param url            数据库连接地址
     * @param username       用户名
     * @param password       密码
     * @param dbComment      数据库备注
     */
    public MysqlCollect(String dbInstanceName, String dbType, String url, String username, String password, String dbComment) {
        super(dbInstanceName, dbType, url, username, password, dbComment);
    }

    /**
     * 主函数
     * 获取每个数据库的表名列表，构建表元数据实体并返回
     * @param dbName 数据库名称
     * @return 当前数据库下的所有表元数据实体
     */
    @Override
    public List<TableMetadataEntity> getTableMetadata(String dbName) {
        List<TableMetadataEntity> tableMetadatas = new ArrayList<>();
        //获取每个数据库表名的查询语句
        String sql = MysqlQuerySql.getTableNamesSql(dbName);
        JSONArray jsonArray = jdbcUtil.query(sql);
        for(int i = 0; i < jsonArray.size(); i++){
            JSONObject object = jsonArray.getJSONObject(i);
            //为每个表构建元数据实体
            TableMetadataEntity tableMetadata = new TableMetadataEntity();
            //设置库名
            tableMetadata.setDbName(dbName);
            //设置表名
            tableMetadata.setTableName(object.getString("TABLE_NAME"));
            //设置当前记录的获取时间
            tableMetadata.setCreateTime(System.currentTimeMillis());
            //设置表的数据条数
            setTableRecordCount(tableMetadata);
            setTableBaseMetadata(tableMetadata);
            setTableColumnsInfo(tableMetadata);
            //
            //添加到元数据实体列表中
            tableMetadatas.add(tableMetadata);
        }
        return tableMetadatas;
    }

    @Override
    public void setTableColumnsInfo(TableMetadataEntity tableMetadata) {
        JSONArray resultSet = jdbcUtil.query(MysqlQuerySql.getColumnsinfoSql(tableMetadata.getDbName(),tableMetadata.getTableName()));
        List<FieldMetadataEntity> fieldMetadataEntitys = new ArrayList<>();
        for (int i = 0; i < resultSet.size(); i++) {
            JSONObject jsonObject = resultSet.getJSONObject(i);
            FieldMetadataEntity fieldMetadataEntity = new FieldMetadataEntity();
            fieldMetadataEntity.setFieldName(jsonObject.getString("Field"));
            fieldMetadataEntity.setFieldType(jsonObject.getString("Type"));
            fieldMetadataEntity.setFieldComment(jsonObject.getString("Comment"));
            fieldMetadataEntity.setIsKey(jsonObject.getString("Key") != null && !jsonObject.getString("Key").isEmpty());
            fieldMetadataEntity.setIsNullAble(!jsonObject.getString("Null").equals("NO"));
            fieldMetadataEntity.setDefaultValue(jsonObject.getString("Default"));
            fieldMetadataEntitys.add(fieldMetadataEntity);
        }
        tableMetadata.setFields(fieldMetadataEntitys);
    }

    //设置表的基本元数据信息包括更新时间、引擎、建表语句、备注等等
    @Override
    public void setTableBaseMetadata(TableMetadataEntity tableMetadata) {
        JSONArray resultSet = jdbcUtil.query(MysqlQuerySql.getTableStatusSql(tableMetadata.getDbName(),tableMetadata.getTableName()));
        for (int i = 0; i < resultSet.size(); i++) {
            JSONObject jsonObject = resultSet.getJSONObject(i);
            Date updateTime = jsonObject.getDate("Update_time");
            if (updateTime != null) {
                tableMetadata.setUpdateTableTime(updateTime.getTime());
            }
            tableMetadata.setCreateTableTime(jsonObject.getDate("Create_time").getTime());
            tableMetadata.setFileSpace(jsonObject.getLong("Data_length"));
            tableMetadata.setEngine(jsonObject.getString("Engine"));
            tableMetadata.setFileFormat(jsonObject.getString("Row_format"));
            tableMetadata.setComment(jsonObject.getString("Comment"));
        }

        JSONArray resultSet2 = jdbcUtil.query(MysqlQuerySql.getCreateTableSql(tableMetadata.getDbName(),tableMetadata.getTableName()));
        for (int i = 0; i < resultSet2.size(); i++) {
            JSONObject jsonObject = resultSet.getJSONObject(i);
            tableMetadata.setCreateTableSql(jsonObject.getString("Create_Table"));
        }
    }

    public static void main(String[] args) {
        MysqlCollect mysqlCollect = new MysqlCollect("test","mysql","jdbc:mysql://127.0.0.1:3306/sys?useSSL=false","root","000000","test");
        mysqlCollect.setDbTablesMetadata();
        MetadataEntity metadata = mysqlCollect.getMetadataEntity();
        System.out.println(metadata.dbNames);
    }
}
