package com.metalineage.databus.manager.util;

import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.util.TablesNamesFinder;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

@Slf4j
public class GeneralUtil {
    public static String getTimeString(){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return df.format(new Date());
    }

    public static String getTimeString(Date date){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return df.format(date);
    }

    /**
     * 根据抽取语句获取当前所有来源表名
     *
     * @param sql 抽取语句
     * @return 抽取语句中的所有表名
     */
    public static HashMap<String, Set<String>> selectSrcTable(String sql) {
        sql = sql.toLowerCase();
        Pattern p = Pattern.compile("(?ms)('(?:''|[^'])*')|--.*?$|//.*?$|/\\*.*?\\*/|#.*?$|");
        sql = p.matcher(sql).replaceAll("$1");
        if(sql.startsWith("\n")) sql = sql.replaceFirst("\n","");
        if(sql.startsWith("\n\t")) sql = sql.replaceFirst("\n\t","");
        sql = sql.replace("\t\t","\t");
        sql = sql.replace("partition(pt)","");
        sql = sql.replace("partition ( pt )","");
        sql = sql.replace("insert overwrite","insert into");
        sql = sql.replace("insert into table","insert into");
        sql = sql.replace("upsert into table","upsert into");
        Statement statement;
        HashMap<String,Set<String>> mapSet = new HashMap<>();
        for(String oneSql:sql.split(";")){
            if(oneSql.contains("insert")||oneSql.contains("upsert")||Pattern.compile("create [\\s\\S]*?as").matcher(oneSql).find()){
                try {
                    String splitString = "select";
                    if(oneSql.contains("with") && oneSql.indexOf("with") < oneSql.indexOf(splitString)){
                        splitString = "with";
                    }
                    String selectString = oneSql.replace(oneSql.split(splitString)[0],"");
                    String tableName = oneSql.split(splitString)[0].split("\\.")[0].split(" ")[oneSql.split(splitString)[0].split("\\.")[0].split(" ").length-1]+"."+oneSql.split(splitString)[0].split("\\.")[1].split(" ")[0];
                    tableName = tableName.replace("\n","").replace("\t","").replace("`","").replace("\"","");
                    tableName = tableName.split("\\(")[0];

                    Set<String> resultSet =  mapSet.get(tableName);
                    if (resultSet==null){
                        resultSet = new HashSet<>();
                    }
                    try {
                        statement = CCJSqlParserUtil.parse(selectString);
                    } catch (Exception e){
                        statement = CCJSqlParserUtil.parse(oneSql);
                    }
                    Statement selectStatement = statement;
                    TablesNamesFinder tablesNamesFinder = new TablesNamesFinder();
                    List<String> outs = tablesNamesFinder.getTableList(selectStatement);
                    for (String out : outs) {
                        out = out.replace("`","");
                        resultSet.add(out);
                    }
                    resultSet.remove(tableName);
                    mapSet.put(tableName, resultSet);
                } catch (Exception ignored) {
//                    log.info("{}\n------------------------------------------", oneSql);
                }
            }}
        return mapSet;
    }

    public static Set<String> selectTableauTable(String sql) {
        sql = sql.toLowerCase();
        Pattern p = Pattern.compile("(?ms)('(?:''|[^'])*')|--.*?$|//.*?$|/\\*.*?\\*/|#.*?$|");
        sql = p.matcher(sql).replaceAll("$1");
        Pattern p2 = Pattern.compile("refresh[\\s\\S]*?;");
        sql = p2.matcher(sql).replaceAll("");
        Pattern p4 = Pattern.compile("alter table[\\s\\S]*?;");
        sql = p4.matcher(sql).replaceAll("");
        Pattern p5 = Pattern.compile("drop table[\\s\\S]*?;");
        sql = p5.matcher(sql).replaceAll("");
        Pattern p6 = Pattern.compile("delete from[\\s\\S]*?;");
        sql = p6.matcher(sql).replaceAll("");
        if(sql.startsWith("\n")) sql = sql.replaceFirst("\n","");
        if(sql.startsWith("\n\t")) sql = sql.replaceFirst("\n\t","");
        sql = sql.replace("\t\t","\t");
        Set<String> resultSet =  new HashSet<>();
        Statement statement;
        try {
            sql = sql.replace("partition(pt)","");
            sql = sql.replace("partition ( pt )","");
            sql = sql.replace("insert overwrite","insert into");
            sql = sql.replace("insert into table","insert into");
            sql = sql.replace("upsert into table","upsert into");
            statement = CCJSqlParserUtil.parse(sql);
            Statement selectStatement = statement;
            TablesNamesFinder tablesNamesFinder = new TablesNamesFinder();

            List<String> outs = tablesNamesFinder.getTableList(selectStatement);
            for (String out : outs) {
                out = out.replace("`","");
                resultSet.add(out);
            }
        } catch (JSQLParserException ignored) {
            ignored.printStackTrace();
            log.error(ignored.getMessage());
        }
        return resultSet;
    }
}
