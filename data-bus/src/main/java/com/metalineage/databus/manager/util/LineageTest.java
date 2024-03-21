package com.metalineage.databus.manager.util;

import com.alibaba.druid.sql.SQLUtils;
import com.alibaba.druid.sql.ast.SQLStatement;
import com.alibaba.druid.sql.ast.statement.*;
import com.alibaba.druid.sql.visitor.SchemaStatVisitor;
import com.alibaba.druid.stat.TableStat;
import com.alibaba.druid.util.JdbcConstants;
import com.metalineage.lineageparser.tableparser.TableLineageParser;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.insert.Insert;
import net.sf.jsqlparser.util.TablesNamesFinder;

import java.util.*;

public class LineageTest {
    public static void main(String[] args) {
        String complexSql = " INSERT INTO dic_dw.dwd_biz_breach_order (breach_order_id, trading_order_number, rent_record_id, rent_record_detail, customer_id\n" +
                "    , customer_name, customer_phone, status, status_bak, timeout_money\n" +
                "    , berach_money, break_money, total_money, actual_money, pay_type\n" +
                "    , pay_type_bak, pay_time, pay_date, coupon_id, question_type\n" +
                "    , question_memo, update_user, update_time, update_date, create_time\n" +
                "    , create_date, breach_day, breach_detail, breach_rule, bad_debt\n" +
                "    , bad_debt_bak, trade_no, zm_status, zm_status_bak, refund_money\n" +
                "    , create_type, create_user,create_type_str,create_user_name,create_user_phone)\n" +
                "WITH tmp_customer AS (\n" +
                "        SELECT customer_id, real_name, mobile\n" +
                "        FROM dic_dw.dim_bas_customer\n" +
                "        WHERE pt = to_date(date_sub(now(), 1))\n" +
                "    )\n" +
                "SELECT a.id, a.trading_order_number, a.rent_record_id, a.rent_record_detail, a.customer_id\n" +
                "    , b.real_name, b.mobile as 城市\n" +
                "    , status, a.status, CAST(a.timeout_money AS decimal(10, 2)), CAST(a.berach_money AS decimal(10, 2)), CAST(a.break_money AS decimal(10, 2))\n" +
                "    , CAST(a.total_money AS decimal(10, 2)), CAST(a.actual_money AS decimal(10, 2))\n" +
                "    , a.pay_type, a.pay_time, to_date(pay_time)\n" +
                "    , a.coupon_id, a.question_type, a.question_memo, a.update_user, a.update_date\n" +
                "    , to_date(a.update_date), a.create_date\n" +
                "    , to_date(a.create_date), a.breach_day, a.breach_detail\n" +
                "    , a.breach_rule\n" +
                "    , CASE a.bad_debt\n" +
                "        WHEN 0 THEN '否'\n" +
                "        WHEN 1 THEN '是'\n" +
                "        ELSE CAST(a.bad_debt AS string)\n" +
                "    END AS bad_debt, a.bad_debt, a.trade_no\n" +
                "    , CASE a.zm_status\n" +
                "        WHEN 0 THEN '未同步'\n" +
                "        WHEN 1 THEN '已同步'\n" +
                "        ELSE CAST(a.zm_status AS string)\n" +
                "    END AS zm_status, a.zm_status, CAST(a.refund_money AS decimal(10, 2)), a.create_type, a.create_user,\n" +
                "    c.name,c.mobile\n" +
                "    , to_date(date_sub(now(), 1))\n" +
                "FROM zzkj.biz_breach_order a\n" +
                "    LEFT JOIN tmp_customer b ON a.customer_id = b.customer_id\n" +
                "    LEFT JOIN zzkj.bas_user c on a.create_user = c.id ";

        String simpleSql = "insert into a(name,age,sex) select b.name+c.test,b.age,b.sex from b left join c where b.id = c.id ";

        String moreTableSql = "\n" +
                "INSERT ALL\n" +
                "WHEN ottl < 100000 THEN\n" +
                "INTO small_orders\n" +
                "VALUES(oid, ottl, sid, cid)\n" +
                "WHEN ottl > 100000 and ottl < 200000 THEN\n" +
                "INTO medium_orders\n" +
                "VALUES(oid, ottl, sid, cid)\n" +
                "WHEN ottl > 200000 THEN\n" +
                "into large_orders\n" +
                "VALUES(oid, ottl, sid, cid)\n" +
                "WHEN ottl > 290000 THEN\n" +
                "INTO special_orders\n" +
                "SELECT o.order_id oid, o.customer_id cid, o.order_total ottl,\n" +
                "o.sales_rep_id sid, c.credit_limit cl, c.cust_email cem\n" +
                "FROM orders o, customers c\n" +
                "WHERE o.customer_id = c.customer_id;";
//
        TableLineageParser tableLineageParser = new TableLineageParser();
        Map<String,Set<String>> mapString = tableLineageParser.getTableLineage(complexSql,"hive");
        System.out.println(mapString);

//        getSqlLineageByDruid(moreTableSql);
//        getSqlLineageByJSqlParser(complexSql);


    }


    /**
     * 根据Druid组件构建血缘解析
     * @param sql sql语句
     */
    public static void getSqlLineageByDruid(String sql){
        //将SQL解析为语法树对象
        SQLStatement statement = SQLUtils.parseSingleStatement(sql,JdbcConstants.ORACLE);

        //构建Visitor对象
        SchemaStatVisitor visitor  = SQLUtils.createSchemaStatVisitor(JdbcConstants.ORACLE);
        //将visitor对象应用于当前语法树
        statement.accept(visitor);
        //获取当前语法树中所有表
        Map<TableStat.Name, TableStat> tableNodes = visitor.getTables();
        //获取当前语法树中所有字段
        Collection<TableStat.Column> columnNodes = visitor.getColumns();
        tableNodes.forEach((tableName, tableNode) -> {
            //根据当前table节点类型判断是否为目标节点
            if (tableNode.getCreateCount() > 0 || tableNode.getInsertCount() > 0) {
                System.out.println("目标表：" + tableName.getName());
                //获取当前目标节点的所有字段信息
                columnNodes.stream().filter(columnNode -> Objects.equals(columnNode.getTable().toLowerCase(), tableName.getName().toLowerCase())).forEach(columnNode -> {
                    System.out.println("目标表：" + columnNode.getTable().toLowerCase()+"      目标字段："+ columnNode.getName().toLowerCase());
                });
            }
            //根据当前table节点类型判断是否为来源节点
            else  if (tableNode.getSelectCount() > 0) {
                System.out.println("来源表："+ tableName.getName().toLowerCase());
                //获取当前目标节点的所有字段信息
                columnNodes.stream().filter(columnNode -> Objects.equals(columnNode.getTable().toLowerCase(), tableName.getName().toLowerCase())).forEach(columnNode -> {
                    System.out.println("来源表：" + columnNode.getTable().toLowerCase()+"      来源字段："+ columnNode.getName().toLowerCase());
                });
            }
        });
    }

    /**
     * 根据JSqlParser构建血缘解析
     * @param sql sql语句
     */
    public static void getSqlLineageByJSqlParser(String sql) {
        Statement statement;
        try {
            //构建AST语法树
            statement = CCJSqlParserUtil.parse(sql);
            //将语法树转换为Insert类型
            Insert insertStatement = (Insert) statement;
            //获取目标表名
            String targetTable = insertStatement.getTable().getFullyQualifiedName();
            System.out.println("目标表："+targetTable);
            TablesNamesFinder tablesNamesFinder = new TablesNamesFinder();
            //获取语法树中所有表名
            List<String> sourceTables = tablesNamesFinder.getTableList(insertStatement);
            //去除目标表名
            sourceTables.remove(targetTable);
            sourceTables.forEach(sourceTable -> System.out.println("来源表："+sourceTable));
        } catch (JSQLParserException e) {
            e.printStackTrace();
        }
    }
}

