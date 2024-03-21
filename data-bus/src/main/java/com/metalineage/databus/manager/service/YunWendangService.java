package com.metalineage.databus.manager.service;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import org.springframework.stereotype.Service;

import static com.metalineage.databus.manager.util.HttpUtil.*;

@Service
public class YunWendangService {

    public String getTokenString(){
        JSONObject jsonObject = getHttpJson("https://open.feishu.cn/open-apis/auth/v3/app_access_token/internal?app_id=cli_a22f29966839d00b&app_secret=NtDgr1s9e6cdfDsCtTgWNdGksvfrGk0w");
        return jsonObject.getString("app_access_token");
    }

    public void putTableData(String tableId,String pageId,JSONArray dataArray,String typeString){
        JSONObject headerJson = new JSONObject();
        headerJson.put("Authorization","Bearer "+getTokenString());
        String tokenUrl = "https://open.feishu.cn/open-apis/wiki/v2/spaces/get_node?token="+tableId;
        String tokenJson = getHttpJsonByHeader(tokenUrl,headerJson).getJSONObject("data").getJSONObject("node").getString("obj_token");
        String postUrl = "";
        if(typeString.equals("新增")){
            postUrl = "https://open.feishu.cn/open-apis/bitable/v1/apps/"+tokenJson+"/tables/"+pageId+"/records/batch_create";
        } else{
            postUrl = "https://open.feishu.cn/open-apis/bitable/v1/apps/"+tokenJson+"/tables/"+pageId+"/records/batch_update";
        }
        JSONObject jsonObject = new JSONObject();
        JSONArray resultArray = new JSONArray();
        for (Object o : dataArray) {
            resultArray.add(o);
            if(resultArray.size()>98){
                jsonObject.put("records", resultArray);
                String test = sendPostByHeader(postUrl, jsonObject.toString(), headerJson);
                JSONObject resultJson = JSON.parseObject(test);
                if (resultJson.getInteger("code") == 0) {
                    System.out.println(typeString+"成功");
                } else {
                    System.out.println(typeString+"失败：" + resultJson);
                }
                try {
                    Thread.sleep(5000);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                resultArray.clear();
            }
        }
        jsonObject.put("records", resultArray);
        String test = sendPostByHeader(postUrl, jsonObject.toString(), headerJson);
        JSONObject resultJson = JSON.parseObject(test);
        if (resultJson.getInteger("code") == 0) {
            System.out.println(typeString+"成功");
        } else {
            System.out.println(typeString+"失败：" + resultJson);
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            sendPostByHeader(postUrl, jsonObject.toString(), headerJson);
        }
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        resultArray.clear();
    }

    public static void main(String[] args) {
        YunWendangService yunWendangService = new YunWendangService();
        JSONArray jsonArray = yunWendangService.getTableData("wikcnNSvZurz0ssYev2HG2bwKJV","tblZD8j2zxAvQS4f","是");
        JSONObject outJson = new JSONObject();
        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject oneRecord =  jsonArray.getJSONObject(i).getJSONObject("fields");
            JSONObject jsonObject = new JSONObject();
            String dbTable = oneRecord.getString("库名")+"."+oneRecord.getString("表名");
            String owner = oneRecord.getString("负责人");
            String priority = oneRecord.getString("优先级");
            String extractLogic = oneRecord.getString("刷新方式");
            String extractTime = oneRecord.getString("刷新时间");
            jsonObject.put("owner",owner);
            jsonObject.put("priority",priority);
            jsonObject.put("extractLogic",extractLogic);
            jsonObject.put("extractTime",extractTime);
            outJson.put(dbTable,jsonObject);
        }
    }

    /**
     * 根据tableId和pageId获取当前表格页面的所有数据行
     * @param tableId tableId
     * @param pageId pageId
     * @return 所有数据行json
     */
    public JSONArray getTableData(String tableId,String pageId,String isZhishi){
        JSONObject headerJson = new JSONObject();
        headerJson.put("Authorization","Bearer "+getTokenString());
        if(isZhishi.equals("是")){
            String tokenUrl = "https://open.feishu.cn/open-apis/wiki/v2/spaces/get_node?token="+tableId;
            tableId = getHttpJsonByHeader(tokenUrl,headerJson).getJSONObject("data").getJSONObject("node").getString("obj_token");
        }
        String urlOne = "https://open.feishu.cn/open-apis/bitable/v1/apps/"+tableId+"/tables/"+pageId+"/records?page_size=25&page_token=";
        String realUrl = urlOne;
        JSONArray resultArray = new JSONArray();
        while(true){
            JSONObject jsonObject = getHttpJsonByHeader(realUrl,headerJson);
            JSONObject dataJson = jsonObject.getJSONObject("data");
            resultArray.addAll(dataJson.getJSONArray("items"));
            boolean hasMore = dataJson.getBooleanValue("has_more");
            if(hasMore){
                realUrl = urlOne+dataJson.getString("page_token");
            } else{
                break;
            }
        }
        return resultArray;
    }


}
