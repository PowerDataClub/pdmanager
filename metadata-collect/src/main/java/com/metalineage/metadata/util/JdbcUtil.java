package com.metalineage.metadata.util;

import com.alibaba.fastjson2.JSONArray;
import lombok.Getter;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@Getter
public class JdbcUtil {

    Connection connection;

    public JdbcUtil(String dbTypeString, String url, String userName, String pwssword) {
        try {
            //1. 加载注册驱动
            try {
                switch(dbTypeString){
                    case "mysql":
                    case "doris":
                    case "starrocks":
                        Class.forName(MetadataJdbcConstants.MYSQL_DRIVER);
                        break;
                    case "impala":
                        Class.forName(MetadataJdbcConstants.IMPALA_DRIVER);
                        break;
                    case "postgresql":
                        Class.forName(MetadataJdbcConstants.POSTGRESQL_DRIVER);
                        break;
                    case "sqlserver":
                        Class.forName(MetadataJdbcConstants.SQL_SERVER_DRIVER);
                        break;
                    case "oracle":
                        Class.forName(MetadataJdbcConstants.ORACLE_DRIVER);
                        break;
                    case "tidb":
                        Class.forName(MetadataJdbcConstants.TIDB_DRIVER);
                        break;
                    case "hive":
                        Class.forName(MetadataJdbcConstants.HIVE_DRIVER);
                        break;
                    case "presto":
                        Class.forName(MetadataJdbcConstants.PRESTO_DRIVER);
                        break;
                    case "clickhouse":
                        Class.forName(MetadataJdbcConstants.CLICKHOUSE_DRIVER);
                        break;
                    case "greenplum":
                        Class.forName(MetadataJdbcConstants.GREENPLUM_DRIVER);
                        break;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            this.connection = DriverManager.getConnection(url, userName, pwssword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //释放资源
    public void closeQuery(ResultSet rs, Statement st) {
        try {
            if (rs != null)
                rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null)
                    st.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void closeConn(){
        try {
            if (this.connection != null)
                this.connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 进行SQL语句查询操作
     * @param sql sql语句
     * @param params 参数，不定长
     * @return 返回执行后的jsonarray结果
     */
    public JSONArray query(String sql,Object... params){
        JSONArray jsonArray = new JSONArray();
        PreparedStatement ps=null;
        ResultSet rs = null;
        try {
            ps = this.connection.prepareStatement(sql);
            //注入参数
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i+1, params[i]);
            }
            rs = ps.executeQuery();
            ResultSetMetaData resultSetMetaData = rs.getMetaData();
            int columnCount = resultSetMetaData.getColumnCount();
            while(rs.next()){
                Map<String,Object> map = new HashMap<>();
                for(int i =1;i<=columnCount;i++){
                    map.put(resultSetMetaData.getColumnLabel(i),rs.getObject(i));
                }
                jsonArray.add(map);
            }
            return jsonArray;
            //5. 释放资源
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeQuery(rs,ps);
        }
        return null;
    }

}
