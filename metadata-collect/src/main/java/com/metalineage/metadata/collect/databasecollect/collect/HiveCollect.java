package com.metalineage.metadata.collect.databasecollect.collect;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.metadata.collect.databasecollect.DatabaseCollect;
import com.metalineage.metadata.collect.databasecollect.entity.FieldMetadataEntity;
import com.metalineage.metadata.collect.databasecollect.entity.MetadataEntity;
import com.metalineage.metadata.collect.databasecollect.entity.TableMetadataEntity;
import com.metalineage.metadata.collect.databasecollect.querysql.HiveQuerySql;

import java.util.ArrayList;
import java.util.List;

public class HiveCollect extends DatabaseCollect {

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
    public HiveCollect(String dbInstanceName, String dbType, String url, String username, String password, String dbComment) {
        super(dbInstanceName, dbType, url, username, password, dbComment);
    }

    /**
     * 获取数据库的所有数据库名信息并返回。不包含mysql基础数据库
     */
    @Override
    protected void setDbNamesMetadata(){
        String sql = HiveQuerySql.getDbnamesSql();
        JSONArray jsonArray = jdbcUtil.query(sql);
        for(int i =0;i<jsonArray.size();i++){
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            metadataEntity.dbNames.add(jsonObject.getString("database_name"));
        }
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
        String sql = HiveQuerySql.getTableNamesSql(dbName);
        JSONArray jsonArray = jdbcUtil.query(sql);
        for(int i = 0; i < jsonArray.size(); i++){
            JSONObject object = jsonArray.getJSONObject(i);
            //为每个表构建元数据实体
            TableMetadataEntity tableMetadata = new TableMetadataEntity();
            //设置库名
            tableMetadata.setDbName(dbName);
            //设置表名
            tableMetadata.setTableName(object.getString("tab_name"));
            //设置当前记录的获取时间
            tableMetadata.setCreateTime(System.currentTimeMillis());

            //在获取hive的表元数据之前，刷新当前表的最新的元数据信息。
//            try {
//                jdbcUtil.query(HiveQuerySql.refreshTableMetadata(tableMetadata.getDbName(), tableMetadata.getTableName()));
//            }catch (Exception ignored){
//            }
            //设置表的基本信息
            setTableBaseMetadata(tableMetadata);
            System.out.println(tableMetadata.getDbName()+"."+tableMetadata.getTableName());
            //设置列的基本信息
//            setTableColumnsInfo(tableMetadata);
            //添加到元数据实体列表中
            tableMetadatas.add(tableMetadata);
        }
        return tableMetadatas;
    }

    //获取表的列元数据信息
    @Override
    public void setTableColumnsInfo(TableMetadataEntity tableMetadata) {
        JSONArray resultSet = jdbcUtil.query(HiveQuerySql.getColumnsinfoSql(tableMetadata.getDbName(),tableMetadata.getTableName()));
        List<FieldMetadataEntity> fieldMetadataEntitys = new ArrayList<>();
        for (int i = 0; i < resultSet.size(); i++) {
            JSONObject jsonObject = resultSet.getJSONObject(i);
            if(jsonObject.getString("col_name").isEmpty()){
                break;
            }
            FieldMetadataEntity fieldMetadataEntity = new FieldMetadataEntity();
            fieldMetadataEntity.setFieldName(jsonObject.getString("col_name"));
            fieldMetadataEntity.setFieldType(jsonObject.getString("data_type"));
            fieldMetadataEntity.setFieldComment(jsonObject.getString("comment"));
            fieldMetadataEntitys.add(fieldMetadataEntity);
        }
        for (int i = resultSet.size()-1; i >0; i--) {
            JSONObject jsonObject = resultSet.getJSONObject(i);
            if(jsonObject.getString("col_name").isEmpty()){
                break;
            }
            FieldMetadataEntity fieldMetadataEntity = new FieldMetadataEntity();
            fieldMetadataEntity.setFieldName(jsonObject.getString("col_name"));
            fieldMetadataEntity.setFieldType(jsonObject.getString("data_type"));
            fieldMetadataEntity.setFieldComment(jsonObject.getString("comment"));
            fieldMetadataEntity.setIsPartitionKey(true);
            fieldMetadataEntitys.add(fieldMetadataEntity);
        }
        tableMetadata.setFields(fieldMetadataEntitys);
        tableMetadata.setFieldNum(fieldMetadataEntitys.size());
    }

    //设置表的基本元数据信息包括更新时间、引擎、建表语句、备注等等
    @Override
    public void setTableBaseMetadata(TableMetadataEntity tableMetadata) {
        JSONArray resultSet = jdbcUtil.query(HiveQuerySql.getTableStatusSql(tableMetadata.getDbName(),tableMetadata.getTableName()));
        for (int i = 0; i < resultSet.size(); i++) {
            JSONObject jsonObject = resultSet.getJSONObject(i);
            String col_name = jsonObject.getString("col_name");
            String data_type = jsonObject.getString("data_type");
            String comment = jsonObject.getString("comment");
            if (data_type != null && col_name.isEmpty() && data_type.contains("numFiles")) {
                tableMetadata.setFileCount(Long.parseLong(comment.trim()));
            }
            if (data_type != null && col_name.isEmpty() && data_type.contains("numRows")) {
                tableMetadata.setRecordCount(Long.parseLong(comment.trim()));
            }
            if (data_type != null && col_name.isEmpty() && data_type.contains("totalSize")) {
                tableMetadata.setFileSpace(Long.parseLong(comment.trim()));
            }
            if (data_type != null && col_name.isEmpty() && data_type.contains("numPartitions")) {
                tableMetadata.setPartitionCount(Integer.parseInt(comment.trim()));
                tableMetadata.setIsPartition(true);
            }
            if (data_type != null && col_name.isEmpty() && data_type.contains("compression")) {
                tableMetadata.setFileCompress(comment.trim());
            }
            if (data_type != null && col_name.isEmpty() && data_type.contains("comment")) {
                tableMetadata.setComment(comment.trim());
            }
            if(col_name.contains("Location")){
                if (data_type != null) {
                    tableMetadata.setFileLocation(data_type.trim());
                }
            }
            if(col_name.contains("CreateTime")){
                tableMetadata.setTableCreateTime(jsonObject.getDate("Create_time"));
            }
            if(col_name.contains("InputFormat:")){
                if (data_type != null) {
                    tableMetadata.setFileFormat(data_type.trim());
                }
            }
        }
        //获取建表语句
        JSONArray resultSet2 = jdbcUtil.query(HiveQuerySql.getCreateTableSql(tableMetadata.getDbName(),tableMetadata.getTableName()));
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < resultSet2.size(); i++) {
            JSONObject jsonObject = resultSet2.getJSONObject(i);
            //由于hive建表语句有多行，这里需要做拼接处理
            stringBuilder.append(jsonObject.getString("createtab_stmt")).append("\r\n");
        }
        tableMetadata.setCreateTableSql(stringBuilder.toString());
    }

    public static void main(String[] args) {
        HiveCollect hiveCollect = new HiveCollect("test","hive","jdbc:hive2://172.17.0.102:10000","hdfs","","metadata_test");
        hiveCollect.setDbTablesMetadata();
        MetadataEntity metadata = hiveCollect.getMetadataEntity();
        System.out.println(JSONObject.toJSONString(metadata));
    }
}
