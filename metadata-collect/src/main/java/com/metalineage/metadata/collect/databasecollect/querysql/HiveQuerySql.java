package com.metalineage.metadata.collect.databasecollect.querysql;

/**
 * MySQL元数据查询语句
 */
public class HiveQuerySql {

    //获取数据库名的SQL语句
    private static final String DB_NAME_SQL = "show databases";

    //获取所有表名（指定数据库）
    private static final String TABLE_NAMES_SQL = "SHOW TABLES IN `%s`";

    //表状态的SQL语句
    private static final String TABLE_STATUS_SQL = "DESCRIBE FORMATTED `%s`.`%s`";

    //获取表结构的SQL语句
    private static final String CREATE_TABLE_SQL = "show create table `%s`.`%s`";

    //获取表列信息的SQL语句
    private static final String COLUMNS_INFO_SQL = "describe `%s`.`%s`";

    //刷新元数据信息，在每张表获取元数据之前，必须先执行这个命令。
    private static final String REFRESH_METADATA = "ANALYZE TABLE `%s`.`%s` COMPUTE STATISTICS";

    // 获取所有表名（指定数据库）
    public static String getTableNamesSql(String dbName) {
        return String.format(TABLE_NAMES_SQL, dbName);
    }

    // 刷新元数据信息
    public static String refreshTableMetadata(String dbName,String tableName) {
        return String.format(REFRESH_METADATA, dbName, tableName);
    }
    

    // 获取表结构的SQL语句
    public static String getCreateTableSql(String dbName, String tableName) {
        return String.format(CREATE_TABLE_SQL, dbName, tableName);
    }

    /**
     * 获取表状态的SQL语句
     *
     * @param dbName 数据库名
     * @param tableName 表名
     * @return SQL语句
     */
    public static String getTableStatusSql(String dbName, String tableName) {
        return String.format(TABLE_STATUS_SQL, dbName, tableName);
    }

    /**
     * 获取数据库名的SQL语句
     *
     * @return SQL语句
     */
    public static String getDbnamesSql() {
        return DB_NAME_SQL;
    }

    /**
     * 获取表列信息的SQL语句
     *
     * @param dbName 数据库名
     * @param tableName 表名
     * @return SQL语句
     */
    public static String getColumnsinfoSql(String dbName, String tableName) {
        return String.format(COLUMNS_INFO_SQL, dbName, tableName);
    }

}
