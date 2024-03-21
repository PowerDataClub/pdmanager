package com.metalineage.databus.manager.util.metaCollect;

import com.alibaba.fastjson2.JSONObject;
import com.metalineage.databus.manager.entity.metaParseEntity.HiveDescribeEntity;
import com.metalineage.databus.manager.entity.metadata.MetadataField;
import com.metalineage.databus.manager.mapper.metaparse.HiveMetaDataMapper;
import com.metalineage.databus.manager.service.metadata.MetadataFieldService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Hive元数据采集器
 * @author liqifeng
 */
@Component
public class HiveCollect {

    @Autowired
    MetadataFieldService metadataFieldService;

    @Autowired
    HiveMetaDataMapper hiveMetaDataMapper;

    @Autowired
    HdfsCollect hdfsCollect;

    /**
     * 获取当前hive表中分区总数
     * @param dbName 数据库名称
     * @param tableName 表名称
     * @return 分区总数
     */
    public int getPartitionCountHive(String dbName,String tableName){
        String dbTableName = dbName+ '.' +tableName;
        List<String> tablePartitions = hiveMetaDataMapper.getTablePartitions(dbTableName);
        return tablePartitions.size();
    }

    public JSONObject getTableBasicInfo(String dbName, String tableName) {
        JSONObject tableInfoJson = new JSONObject();
        String dbTableName = dbName+ '.' +tableName;
        String dbTableCreate = StringUtils.join(hiveMetaDataMapper.getDbTableCreate(dbTableName),"\n");
        tableInfoJson.put("db_type","Hive");
        JSONObject hiveInfo = getTableBasicInfoHive(dbName,tableName,dbTableCreate);
        tableInfoJson.putAll(hiveInfo);
        JSONObject fileSizeAndCountJson = hdfsCollect.getFileSizeAndCount(tableInfoJson.getString("file_location"));
        tableInfoJson.putAll(fileSizeAndCountJson);
        int fieldNum = getFiledNum(dbName,tableName);
        tableInfoJson.put("field_num",fieldNum);
        return tableInfoJson;
    }

    /**
     * 根据建表语句获取hive表的相关信息
     * @param dbName 数据库名称
     * @param tableName 表名称
     * @return hive表信息json
     */
    public JSONObject getTableBasicInfoHive(String dbName, String tableName, String createTable){
        JSONObject tableInfoJson = new JSONObject();
        tableInfoJson.put("partition_type",0);
        String [] createTableSplit = createTable.split("\n");
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
        List<HiveDescribeEntity> describeEntities = hiveMetaDataMapper.describeTable(dbTableName);
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
        ArrayList<MetadataField> metadataFieldList = new ArrayList<>();
        String dbTableName = dbName+ '.' +tableName;
        List<HiveDescribeEntity> describeEntities = hiveMetaDataMapper.describeTable(dbTableName);
        for (HiveDescribeEntity hiveDescribeEntity : describeEntities) {
            MetadataField metadataField = new MetadataField();
            metadataField.setTableId(tableId);
            metadataField.setFieldName(hiveDescribeEntity.getColName());
            metadataField.setFieldType(hiveDescribeEntity.getDataType());
            metadataField.setFieldComment(hiveDescribeEntity.getComment());
            metadataFieldList.add(metadataField);
        }
        return metadataFieldList;
    }
}
