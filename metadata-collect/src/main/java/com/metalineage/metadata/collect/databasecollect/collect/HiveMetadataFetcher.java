package com.metalineage.metadata.collect.databasecollect.collect;

import org.apache.hadoop.hive.conf.HiveConf;
import org.apache.hadoop.hive.metastore.HiveMetaStoreClient;
import org.apache.hadoop.hive.metastore.api.FieldSchema;
import org.apache.hadoop.hive.metastore.api.Table;
import org.apache.thrift.TException;

import java.util.List;

public class HiveMetadataFetcher {

    public static void main(String[] args) throws Exception {
        // 初始化Hive Metastore配置
        HiveConf conf = new HiveConf();
        conf.set("hive.metastore.uris", "thrift://172.17.0.101:9083"); // 使用你自己的Hive Metastore服务地址
        HiveMetaStoreClient client = new HiveMetaStoreClient(conf);

// 获取所有数据库（库）
        System.out.println("获取所有数据库:");
        for (String dbName : client.getAllDatabases()) {
            System.out.println(dbName);
        }

        // 获取特定数据库下的所有表
        String dbName = "metadata_test";
        System.out.println("\n获取数据库 '" + dbName + "' 下的所有表:");
        for (String tableName : client.getTables(dbName, "*")) {
            System.out.println(tableName);
        }

        // 获取特定表的详细信息，包括字段
        String tableName = "test_partition_table";
        Table table = client.getTable(dbName, tableName);

        System.out.println("\n获取表 '" + tableName + "' 的详细信息:");
        System.out.println(table.toString());

        // 输出表的字段信息
        System.out.println("\n表 '" + tableName + "' 的字段信息:");
        List<FieldSchema> fields = table.getSd().getCols();
        for (FieldSchema field : fields) {
            System.out.println(field.getName() + " (" + field.getType() + ")");
        }

        // 关闭客户端
        client.close();

    }
}