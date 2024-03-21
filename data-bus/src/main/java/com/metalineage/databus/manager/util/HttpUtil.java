package com.metalineage.databus.manager.util;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;

@Slf4j
public class HttpUtil {
    public static JSONObject getHttpJson(String url){
        return getHttpJson(url,null);
    }

    public static JSONObject getHttpJsonByHeader(String url, JSONObject headerJson) {
        StringBuilder result = new StringBuilder();
        BufferedReader in = null;
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            for(String keyString:headerJson.keySet()){
                connection.setRequestProperty(keyString, headerJson.getString(keyString));
            }
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result.append(line);
            }
        } catch (Exception e) {
            log.error("发送GET请求出现异常！{}", e.getMessage());
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                log.error("关闭输入流出现异常！{}", e2.getMessage());
            }
        }
        return JSON.parseObject(result.toString());
    }

    public static JSONObject getHttpJson(String url, String cookie) {
        StringBuilder result = new StringBuilder();
        BufferedReader in = null;
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("token",cookie);
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result.append(line);
            }
        } catch (Exception e) {
            log.error("发送GET请求出现异常！{}", e);
            e.printStackTrace();
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                log.error(e2.getMessage());
            }
        }
        return JSON.parseObject(result.toString());
    }

    @SneakyThrows
    public static String sendPostByHeader(String urlString, String postString, JSONObject headerJson) {
        String body = "";

        //创建httpclient对象
        CloseableHttpClient client = HttpClients.createDefault();
        //创建post方式请求对象
        URI uri = new URI(urlString);
        HttpPost httpPost = new HttpPost(uri);

        //装填参数
        StringEntity s = new StringEntity(postString, "utf-8");
        s.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE,
                "application/json"));
        //设置参数到请求对象中
        httpPost.setEntity(s);

        //设置header信息
        //指定报文头【Content-type】、【User-Agent】
        httpPost.setHeader("Content-type", "application/json");
        httpPost.setHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
        if(headerJson!=null){
            for(String keyString:headerJson.keySet()){
                httpPost.setHeader(keyString, headerJson.getString(keyString));
            }
        }

        //执行请求操作，并拿到结果（同步阻塞）
        CloseableHttpResponse response = client.execute(httpPost);
        //获取结果实体
        HttpEntity entity = response.getEntity();
        if (entity != null) {
            //按指定编码转换结果实体为String类型
            body = EntityUtils.toString(entity, "utf-8");
        }
        EntityUtils.consume(entity);
        //释放链接
        response.close();
        return body;
    }
    public static void main(String[] args) {
        String url = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=be9c70c9-8da1-4def-967a-f19986d0728c";
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msgtype","text");
        JSONObject textJson = new JSONObject();
        textJson.put("content","血缘告警测试：当前SQL解析异常" +
                "\nSQL来源：Tableau" +
                "\n是否报表：是" +
                "\n报表名称：测试报表" +
                "\nTableau WorkBook：Cabinet_Empty_Daily_Report" +
                "\nTableau 链接：http://192.168.1.83/workbooks/Cabinet_Empty_Daily_Report?rev=1.7");

        textJson.put("content","血缘告警测试：当前SQL解析异常" +
                "\nSQL来源：DolphinScheduler" +
                "\n是否报表：是" +
                "\n报表名称：测试报表" +
                "\nTableau WorkBook：Cabinet_Empty_Daily_Report" +
                "\nTableau 链接：http://192.168.1.83/workbooks/Cabinet_Empty_Daily_Report?rev=1.7");
        jsonObject.put("text",textJson);
        sendPostByHeader(url,jsonObject.toString(),null);

    }
}
