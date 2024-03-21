package com.metalineage.metadata.util;

//数据库驱动工具类
public interface MetadataJdbcConstants {

    String POSTGRESQL_DRIVER = "org.postgresql.Driver";

    String SQL_SERVER_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    String ORACLE_DRIVER = "oracle.jdbc.driver.OracleDriver";

    String MYSQL_DRIVER = "com.mysql.jdbc.Driver";

    String TIDB_DRIVER = "io.tidb.bigdata.jdbc.TiDBDriver";

    String HIVE_DRIVER = "org.apache.hive.jdbc.HiveDriver";

    String PRESTO_DRIVER = "com.facebook.presto.jdbc.PrestoDriver";

    String CLICKHOUSE_DRIVER = "ru.yandex.clickhouse.ClickHouseDriver";

    String GREENPLUM_DRIVER = "com.pivotal.jdbc.GreenplumDriver";

    String IMPALA_DRIVER = "com.cloudera.impala.jdbc41.Driver";
}
