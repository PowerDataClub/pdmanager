package com.metalineage.databus.manager.service.lineage;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.databus.manager.util.sqlcollect.DolphinCollect2;
import org.neo4j.ogm.model.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.metalineage.databus.manager.mapper.lineage.LineageRepository;

import java.util.LinkedHashMap;
import java.util.Map;

import static com.metalineage.databus.manager.util.GeneralUtil.getTimeString;

@Service
public class LineageService {
    @Autowired
    LineageRepository lineageRepository;

    @Autowired
    DolphinCollect2 dolphinCollect2;

    public Result getNode(String nodeName){
        return lineageRepository.getNode(nodeName);
    }

    //删除血缘数据
    public void deleteAllData(){
        System.out.println(getTimeString()+" 删除所有血缘数据");
        lineageRepository.deleteAllData();
    };

    public JSONObject getOutReport(String name){
        Result out = lineageRepository.getOutReport(name);
        JSONObject outJson = new JSONObject();
        JSONArray nameArray = new JSONArray();
        JSONArray dispatchArray = new JSONArray();
        for (Map<String, Object> next : out.queryResults()) {
            String reportName = next.get("name").toString();
            String dispatchPath = next.get("dispatchPath").toString();
            nameArray.add(reportName);
            dispatchArray.add(dispatchPath);
        }
        outJson.put("nameArray",nameArray);
        outJson.put("dispatchArray",dispatchArray);
        return outJson;
    }

    public int getOutReportSize(String name){
        return lineageRepository.getOutReportSize(name);
    }

    public int getOutAllReportSize(String name){
        return lineageRepository.getOutAllReportSize(name);
    }

    public JSONObject getOutAllReport(String name){
        Result out = lineageRepository.getOutAllReport(name);
        JSONObject outJson = new JSONObject();
        JSONArray nameArray = new JSONArray();
        JSONArray dispatchArray = new JSONArray();
        for (Map<String, Object> next : out.queryResults()) {
            String reportName = next.get("name").toString();
            String dispatchPath = next.get("dispatchPath").toString();
            nameArray.add(reportName);
            dispatchArray.add(dispatchPath);
        }
        outJson.put("nameArray",nameArray);
        outJson.put("dispatchArray",dispatchArray);
        return outJson;
    }

    /**
     * 根据表名获取所有输出的表与报表
     * @param name 表名
     * @return 报表与表的json信息
     */
    public JSONObject getOutByName(String name){
        Result out = lineageRepository.getOutByName(name);
        Result oneNode = lineageRepository.getNode(name);
        JSONArray oneNodeInfo =  getResultAraray(oneNode);
        String status = "normal";
        try {
            status = oneNodeInfo.getJSONObject(0).getString("status");
        } catch (Exception ignored){
        }
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = getResultAraray(out);
        jsonObject.put("msg","请求成功");
        jsonObject.put("code",200);
        jsonObject.put("name",name);
        jsonObject.put("status",status);
        jsonObject.put("data",jsonArray);
        return jsonObject;
    }

    JSONArray getResultAraray(Result out){
        JSONArray jsonArray = new JSONArray();
        for (Map<String, Object> next : out.queryResults()) {
            JSONObject oneJson = new JSONObject();
            String nodeName = next.get("name")!=null?next.get("name").toString():null;
            String label = next.get("label")!=null?next.get("label").toString():null;
            String projectName =  next.get("projectName")!=null?next.get("projectName").toString():null;
            String workflowName =  next.get("workflowName")!=null?next.get("workflowName").toString():null;
            String taskName =  next.get("taskName")!=null?next.get("taskName").toString():null;
//            String status = dolphinCollect.getTaskStatus(projectName,workflowName,taskName);
//            oneJson.put("status",status);
            oneJson.put("status","normal");
            oneJson.put("name",nodeName);
            oneJson.put("label",label);
            jsonArray.add(oneJson);
        }
        return jsonArray;
    }

    /**
     * 根据名称获取所有来源的表与报表
     * @param name 表名
     * @return 报表与表的json信息
     */
    public JSONObject getSrcByName(String name){
        Result out = lineageRepository.getSrcByName(name);
        Result oneNode = lineageRepository.getNode(name);
        JSONArray oneNodeInfo =  getResultAraray(oneNode);
        String status = "normal";
        if(oneNodeInfo.size()>0){
            status = oneNodeInfo.getJSONObject(0).getString("status");
        }
        JSONObject jsonObject = new JSONObject(new LinkedHashMap<>());

        JSONArray jsonArray = getResultAraray(out);
        jsonObject.put("msg","请求成功");
        jsonObject.put("code",200);
        jsonObject.put("name",name);
        jsonObject.put("status",status);
        jsonObject.put("data",jsonArray);
        return jsonObject;
    }
}