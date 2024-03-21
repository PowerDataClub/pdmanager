package com.metalineage.lineageparser.tableparser;

import com.alibaba.druid.DbType;
import com.alibaba.druid.sql.SQLUtils;
import com.alibaba.druid.sql.ast.SQLStatement;
import com.alibaba.druid.sql.visitor.SchemaStatVisitor;
import com.alibaba.druid.stat.TableStat;

import java.util.*;

public class TableLineageParser {

    /**
     * 验证当前SQL是否正确且能够正常生成AST树
     * @param sqlString sql语句
     * @return 如果不符合要求，则返回false，并将当前SQL验证失败信息进行保存
     */
    boolean basicVerify(String sqlString,DbType dbType){
        try {
            SQLUtils.parseSingleStatement(sqlString, dbType);
        } catch(Exception e){
            System.out.println(e.getMessage());
            return false;
        }
        return true;

    };

    public Map<String, Set<String>> getTableLineage(String sqlString, String dbTypeString){
        DbType dbType;
        if (dbTypeString == null) {
            dbType = DbType.other;
        } else{
            switch (dbTypeString) {
                case "oracle":
                    dbType = DbType.oracle;
                    break;
                case "mysql":
                    dbType = DbType.mysql;
                    break;
                case "postgresql":
                    dbType = DbType.postgresql;
                    break;
                case "sqlserver":
                    dbType = DbType.sqlserver;
                    break;
                case "phoenix":
                    dbType = DbType.phoenix;
                    break;
                case "hive":
                case "impala":
                    dbType = DbType.hive;
                    break;
                case "presto":
                    dbType = DbType.presto;
                    break;
                case "clickhouse":
                    dbType = DbType.clickhouse;
                    break;
                default:
                    dbType = DbType.other;
            }
        }

        //验证当前SQL是否正确且能够正常生成AST树
        if(!basicVerify(sqlString,dbType)){
            return null;
        }

        Map<String,Set<String>> tableLineageMap = new HashMap<>();
        Set<String> sourceTableSet = new HashSet<>();
        Set<String> targetTableSet = new HashSet<>();
        //将SQL解析为语法树对象

        SQLStatement statement = SQLUtils.parseSingleStatement(sqlString, dbType);

        //构建Visitor对象
        SchemaStatVisitor visitor  = SQLUtils.createSchemaStatVisitor(dbType);
        //将visitor对象应用于当前语法树
        statement.accept(visitor);
        //获取当前语法树中所有表
        Map<TableStat.Name, TableStat> tableNodes = visitor.getTables();
        //获取当前语法树中所有字段
//        Collection<TableStat.Column> columnNodes = visitor.getColumns();
        tableNodes.forEach((tableName, tableNode) -> {
            //根据当前table节点类型判断是否为目标节点
            if (tableNode.getCreateCount() > 0 || tableNode.getInsertCount() > 0) {
//                System.out.println("目标表：" + tableName.getName());
                //为了确保库表之间的数据一致性，所有所有库表明均采用小写
                targetTableSet.add(tableName.getName().toLowerCase());
//                //获取当前目标节点的所有字段信息
//                columnNodes.stream().filter(columnNode -> Objects.equals(columnNode.getTable().toLowerCase(), tableName.getName().toLowerCase())).forEach(columnNode -> {
//                    System.out.println("目标表：" + columnNode.getTable().toLowerCase()+"      目标字段："+ columnNode.getName().toLowerCase());
//                });
            }
            //根据当前table节点类型判断是否为来源节点
            else  if (tableNode.getSelectCount() > 0) {
//                System.out.println("来源表："+ tableName.getName().toLowerCase());
                sourceTableSet.add(tableName.getName().toLowerCase());
                //获取当前目标节点的所有字段信息
//                columnNodes.stream().filter(columnNode -> Objects.equals(columnNode.getTable().toLowerCase(), tableName.getName().toLowerCase())).forEach(columnNode -> {
//                    System.out.println("来源表：" + columnNode.getTable().toLowerCase()+"      来源字段："+ columnNode.getName().toLowerCase());
//                });
            }
        });
        targetTableSet.forEach(targetTable->tableLineageMap.put(targetTable,sourceTableSet));
        return tableLineageMap;
    };
}
