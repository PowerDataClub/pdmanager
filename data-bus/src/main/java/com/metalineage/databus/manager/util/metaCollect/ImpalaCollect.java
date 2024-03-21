package com.metalineage.databus.manager.util.metaCollect;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.databus.manager.entity.metaParseEntity.ImpalaDescribeEntity;
import com.metalineage.databus.manager.entity.metadata.MetadataField;
import com.metalineage.databus.manager.mapper.metaparse.ImpalaMetaDataMapper;
import com.metalineage.databus.manager.service.metadata.MetadataFieldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.*;
import java.util.Date;

/**
 * 改造为线程池方式获取impala连接
 */
@Component
public class ImpalaCollect {

    private static final String JDBC_DRIVER = "com.cloudera.impala.jdbc.Driver";

    private static final String CONNECTION_URL ="jdbc:impala://10.255.0.11:21060/";

    private static final String USER = "liqifeng";

    private static final String PASSWORD = "liqifeng";

    @Autowired
    MetadataFieldService metadataFieldService;

    @Autowired
    ImpalaMetaDataMapper impalaMetaDataMapper;

    @Autowired
    HdfsCollect hdfsCollect;

    private Connection connection;

    public Connection getConnection(){
        try {
            Class.forName(JDBC_DRIVER);
            this.connection = DriverManager.getConnection(CONNECTION_URL,USER,PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return this.connection;
    }
    /**
     * 获取当前库中所有表
     *
     * @param dbName 库名
     * @return 表名称集合
     */
    public JSONArray getAllTables(String dbName){
        List<String> allTables = impalaMetaDataMapper.getAllTables(dbName);
        return JSONArray.parseArray(JSON.toJSONString(allTables));
    }

    /**
     * 获取当前hive表中分区总数
     * @param dbName 数据库名称
     * @param tableName 表名称
     * @return 分区总数
     */
    public int getPartitionCountHive(String dbName,String tableName){
        String dbTableName = dbName+ '.' +tableName;
        List<String> tablePartitions = impalaMetaDataMapper.getTablePartitions(dbTableName);
        return tablePartitions.size();
    }

    /**
     * 获取当前表中数据总量,包括kudu与hive
     * @param dbName 数据库名称
     * @param tableName 表名称
     * @return 数据总量
     */
    public Long getCount(String dbName,String tableName){
        String dbTableName = dbName+ '.' +tableName;
        return impalaMetaDataMapper.getDbTableCount(dbTableName);
    }

    public JSONObject getTableBasicInfo(String dbName, String tableName) throws SQLException {
        JSONObject tableInfoJson = new JSONObject();
        String dbTableName = dbName+ '.' +tableName;
        String dbTableCreate = impalaMetaDataMapper.getDbTableCreate(dbTableName);
        if(dbTableCreate.contains("STORED AS KUDU")){
                tableInfoJson.put("db_type","Kudu");
                JSONObject kuduInfo = getTableBasicInfoKudu(dbTableCreate);
                tableInfoJson.putAll(kuduInfo);

            } else{
                tableInfoJson.put("db_type","Hive");
                JSONObject hiveInfo = getTableBasicInfoHive(dbName,tableName,dbTableCreate);
                tableInfoJson.putAll(hiveInfo);
                JSONObject fileSizeAndCountJson = hdfsCollect.getFileSizeAndCount(tableInfoJson.getString("file_location"));
                tableInfoJson.putAll(fileSizeAndCountJson);
            }
        long dbCount = getCount(dbName,tableName);
        tableInfoJson.put("db_count",dbCount);
        int fieldNum = getFiledNum(dbName,tableName);
        tableInfoJson.put("field_num",fieldNum);
        return tableInfoJson;
    }

    /**
     * 根据建表语句获取kudu表的相关信息
     * @return kudu表信息json
     */
    public JSONObject getTableBasicInfoKudu(String createTable){
        JSONObject tableInfoJson = new JSONObject();
        tableInfoJson.put("partition_type",0);
        for(String one:createTable.split("\n")){
            if(one.contains("PARTITION BY")){
                String[] splitString = one.replace("PARTITION BY ", "").replace(" ", "").split("PARTITIONS");
                String partitionField = splitString[0];
                int partitionCount = Integer.parseInt(splitString[1]);
                tableInfoJson.put("partition_type",1);
                tableInfoJson.put("partition_field",partitionField);
                tableInfoJson.put("partition_count",partitionCount);
            }
            if(one.contains("COMMENT '")&&!one.contains("ENCODING")){
                String commemt = one.replace("COMMENT '","").replace("'","").trim();
                tableInfoJson.put("comment",commemt);
            }
        }
        return tableInfoJson;
    };

    /**
     * 根据建表语句获取hive表的相关信息
     * @param dbName 数据库名称
     * @param tableName 表名称
     * @return hive表信息json
     */
    public JSONObject getTableBasicInfoHive(String dbName, String tableName, String createTable){
        JSONObject tableInfoJson = new JSONObject();
        tableInfoJson.put("partition_type",0);
        String [] createTableSplit = createTable.replace(createTable.split("\\)")[0],"").split("\n");
        for(int i =0;i<createTableSplit.length;i++){
            String one = createTableSplit[i];
            if(one.contains("COMMENT '")){
                String commemt = one.replace("COMMENT '","").replace("'","").trim();
                tableInfoJson.put("comment",commemt);
            }
            if(one.contains("STORED AS")){
                String fileFormat = one.replace("STORED AS ","").trim();
                tableInfoJson.put("file_format",fileFormat);
            }
            if(one.contains("PARTITIONED BY (")){
                tableInfoJson.put("partition_type",1);
                StringBuilder ptStringBuilder =  new StringBuilder();
                //可能存在多个分区，需要分别获取
                while(true){
                   String ptString = createTableSplit[++i];
                   ptStringBuilder.append(ptString.trim().split(" ")[0].replace(",",""));
                   if(ptString.contains(",")){
                       ptStringBuilder.append(",");
                   } else{
                       break;
                    }
                }
                int partitionCount = getPartitionCountHive(dbName,tableName);
                tableInfoJson.put("partition_count",partitionCount);
                tableInfoJson.put("partition_field",ptStringBuilder.toString());
            }
            if(one.contains("LOCATION '")){
                String locationString = one.replace("LOCATION '","").replace("'","").trim().split("//")[1];
                String removeString = locationString.split("/")[0];
                locationString = locationString.replaceFirst(removeString,"");
                tableInfoJson.put("file_location",locationString);
            }
            if(one.contains("parquet.compression")){
                String fileCompress = one.split("'parquet.compression'='")[1].split("'")[0];
                tableInfoJson.put("file_compress",fileCompress);
            }
        }
        return tableInfoJson;
    };

    /**
     * 获取当前表中的所有字段数量
     * @param dbName 库名称
     * @param tableName 表名称
     * @return 字段数量
     */
    public int getFiledNum(String dbName,String tableName){
        String dbTableName = dbName+ '.' +tableName;
        List<ImpalaDescribeEntity> describeEntities = impalaMetaDataMapper.describeTable(dbTableName);
        return describeEntities.size();
    }


    /**
     * 获取当前表中的所有字段信息
     * @param dbName 库名称
     * @param tableName 表名称
     * @param tableId 表的主键ID
     * @return 字段信息的List集合
     */
    public List<MetadataField> getFieldInfo(String dbName, String tableName, int tableId) {
        String dbTableName = dbName+ '.' +tableName;
        ResultSet rs;
        PreparedStatement ps;
        ArrayList<MetadataField> metadataFieldList = new ArrayList<>();
        try {
            ps = getConnection().prepareStatement("describe "+dbTableName);
            rs = ps.executeQuery();
            while (rs.next()) {
                MetadataField metadataField = new MetadataField();
                metadataField.setTableId(tableId);
                metadataField.setFieldName(rs.getString("name"));
                metadataField.setFieldType(rs.getString("type"));
                metadataField.setFieldComment(rs.getString("comment"));
                metadataField.setIsKey(0);
                try {
                    metadataField.setIsKey(rs.getBoolean("primary_key") ? 1 : 0);
                } catch (Exception ignored){};
                metadataField.setCreateTime(new Date());
                metadataField.setUpdateTime(new Date());
                metadataFieldList.add(metadataField);
            }
            ps.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return metadataFieldList;
    }
}
