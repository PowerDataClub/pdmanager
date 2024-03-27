package com.metalineage.metadata.collect.databasecollect.querysql;

/**
 * MySQL元数据查询语句
 */
public class MysqlQuerySql {

    //已开发  获取数据库名的SQL语句
    private static final String DB_NAME_SQL = "show databases";

    //已开发 获取所有表名（指定数据库）
    private static final String TABLE_NAMES_SQL = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '%s'";

    //表状态的SQL语句
    private static final String TABLE_STATUS_SQL = "show table status from %s like '%s'";

    //获取表结构的SQL语句
    private static final String CREATE_TABLE_SQL = "show create table %s.%s";

    //获取表列信息的SQL语句
    private static final String COLUMNS_INFO_SQL = "show full columns from %s.%s";

    //获取索引信息的SQL语句
    private static final String INDEX_INFO_SQL = "show index from %s.%s";

    // 获取所有表名（指定数据库）
    public static String getTableNamesSql(String dbName) {
        return String.format(TABLE_NAMES_SQL, dbName);
    }

    // 获取表结构的SQL语句
    public static String getCreateTableSql(String dbName, String tableName) {
        return String.format(CREATE_TABLE_SQL, dbName, tableName);
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
     * 获取表列信息的SQL语句
     *
     * @param dbName 数据库名
     * @param tableName 表名
     * @return SQL语句
     */
    public static String getColumnsinfoSql(String dbName, String tableName) {
        return String.format(COLUMNS_INFO_SQL, dbName, tableName);
    }

    /**
     * 获取索引信息的SQL语句
     *
     * @param dbName 数据库名
     * @param tableName 表名
     * @return SQL语句
     */
    public static String getIndexinfoSql(String dbName, String tableName) {
        return String.format(INDEX_INFO_SQL, dbName, tableName);
    }

}
