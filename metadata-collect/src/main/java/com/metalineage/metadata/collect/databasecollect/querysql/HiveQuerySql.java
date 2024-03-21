package com.metalineage.metadata.collect.databasecollect.querysql;

//Hive和Impala兼用
public class HiveQuerySql {

    // 获取数据库名的SQL语句
    public static final String DB_NAMES_SQL = "show databases";
    // 获取表名的SQL语句
    public static final String TABLE_NAMES_SQL = "show tables in `%s`";
    // 获取表分区信息的SQL语句
    private static final String TABLE_PARTITIONS_SQL = "show partitions  `%s.%s`";
    // 获取表行数的SQL语句
    private static final String TABLE_COUNT_SQL = "select count(1) from `%s.%s`";
    // 获取创建表的SQL语句
    private static final String TABLE_CREATE_SQL = "show create table  `%s.%s`";
    // 描述表的SQL语句
    private static final String TABLE_DESCRIBE_SQL = "describe `%s.%s`";

    /**
     * 获取数据库名的SQL语句
     * @param dbName 数据库名
     * @return SQL语句
     */
    public static String getDbNamesSql(String dbName){
        return DB_NAMES_SQL;
    }

    /**
     * 获取表名的SQL语句
     * @param dbName 数据库名
     * @return SQL语句
     */
    public static String getTableNamesSql(String dbName){
        return String.format(TABLE_NAMES_SQL,dbName);
    }

    /**
     * 根据给定的数据库名和表名生成获取表分区的SQL语句。
     *
     * @param dbName 数据库名
     * @param tableName 表名
     * @return 生成的SQL语句
     */
    public static String getTablePartitionsSql(String dbName, String tableName) {
        return String.format(TABLE_PARTITIONS_SQL, dbName,tableName);
    }

    /**
     * 获取表行数的SQL语句
     *
     * @param dbName 数据库名
     * @param tableName 表名
     * @return SQL语句
     */
    public static String getTableCountSql(String dbName, String tableName) {
        return String.format(TABLE_COUNT_SQL, dbName, tableName);
    }

    /**
     * 获取创建表的SQL语句
     * @param dbName 数据库名
     * @param tableName 表名
     * @return SQL语句
     */
    public static String getTableCreateSql(String dbName, String tableName) {
        return String.format(TABLE_CREATE_SQL,  dbName,tableName);
    }

    /**
     * 描述表的SQL语句
     * @param dbName 数据库名
     * @param tableName 表名
     * @return SQL语句
     */
    public static String describeTableSql(String dbName, String tableName) {
        return String.format(TABLE_DESCRIBE_SQL, dbName,tableName);
    }
}