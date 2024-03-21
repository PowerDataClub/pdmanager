package com.metalineage.metadata.collect.dispatchcollect.collect;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.metadata.collect.dispatchcollect.queryurl.DolphinSchedulerUrl;
import com.metalineage.metadata.entity.DolphinTaskEntity;
import org.apache.commons.lang.StringUtils;

import java.util.*;

public class DolphinSchedulerCollect {

    DolphinSchedulerUrl dolphinSchedulerUrl;

    public DolphinSchedulerCollect(String dsUrl, String token){
        dolphinSchedulerUrl = new DolphinSchedulerUrl(dsUrl,token);
    }

    public static void main(String[] args) {
//        DolphinScheduler3Collect dolphinScheduler3Collect = new DolphinScheduler3Collect("http://172.17.0.203:12345/","e9150ce6ff52d3d88ff2ad0c0b21b82b");
//        List<DolphinTaskEntity> test = dolphinScheduler3Collect.getAllTaskInfo("");
//        JSONArray jsonArray = (JSONArray) JSON.toJSON(test);
//        System.out.println(jsonArray);

        DolphinSchedulerCollect dolphinSchedulerCollect = new DolphinSchedulerCollect("http://172.17.0.202:12345/","c9e0a371508a9546da0ebda72f713a85");
        List<DolphinTaskEntity> test = dolphinSchedulerCollect.getAllTaskInfo("");
        JSONArray jsonArray = (JSONArray) JSON.toJSON(test);
        System.out.println(jsonArray);
    }

    /**
     * step1
     * 根据项目名称获取所有状态为已上线的工作流列表
     * projectName为当前获取项目的名称，如果为""，则表示获取当前token下的所有项目列表
     */
    public JSONArray getWorkFlowArray(String projectName){
        JSONArray resultArry = new JSONArray();
        JSONObject projectsJson = dolphinSchedulerUrl.getProjectListJson(projectName);
        JSONArray projectArray = projectsJson.getJSONObject("data").getJSONArray("totalList");
        for (int i = 0; i < projectArray.size(); i++) {
            JSONObject oneProject =  projectArray.getJSONObject(i);
            String name = oneProject.getString("name");
            String code = oneProject.getString("code");
            if(name.equals(projectName)||projectName.equals("")){
                JSONObject dsResponseJson = dolphinSchedulerUrl.getProjectInfoUrl(code);
                //获取所有workFlow列表
                JSONArray workFlowArray = dsResponseJson.getJSONObject("data").getJSONArray("totalList");
                for (int j = 0; j < workFlowArray.size(); j++) {
                    JSONObject oneWorkFlowJson =  workFlowArray.getJSONObject(j);
                    String state = oneWorkFlowJson.getString("releaseState");
                    if(!state.equals("ONLINE")){
                        continue;
                    }
                    resultArry.add(oneWorkFlowJson);
                }
            }

        }
        return  resultArry;
    }

    /**
     * step2
     * 根据项目名称和工作流ID获取所有工作节点列表信息
     */
    public JSONArray getTaskArray(String projectId,String workFlowId){
        JSONObject oneWorkFlowDetailJson = dolphinSchedulerUrl.getWorkFlowDetailJson(projectId,workFlowId);
        return oneWorkFlowDetailJson.getJSONObject("data").getJSONArray("taskDefinitionList");
    }

    /**
     * step3
     * 根据workFlowId获取调度时间和状态信息
     */
    public JSONObject getWorkFlowSchedulerInfo(String projectId, String workFolwId){
        JSONObject dsResponseJson = dolphinSchedulerUrl.getSchedulerTimeJson(projectId,workFolwId);
        JSONObject resultJson = new JSONObject();
        JSONArray totalList = dsResponseJson.getJSONObject("data").getJSONArray("totalList");
        if(totalList==null||totalList.size()==0){
            return resultJson;
        }
        JSONObject oneInfoJson = totalList.getJSONObject(0);
        resultJson.put("schedulerTime",oneInfoJson.getString("crontab"));
        if(oneInfoJson.getString("releaseState").equals("ONLINE")){
            resultJson.put("schedulerStutas","上线");
        } else{
            resultJson.put("schedulerStutas","下线");
        }
        return resultJson;
    }

    /**
     * 根据文件ID查看当前文件内容
     * @param fileId 文件ID
     * @return 文件内容
     */
    public JSONObject getFileContentById(String fileId){
        JSONObject fileJson = dolphinSchedulerUrl.getFileContentJson(fileId);
        JSONObject oneJson = new JSONObject();
        oneJson.put("fileName",fileJson.getJSONObject("data").getString("alias"));
        oneJson.put("content",fileJson.getJSONObject("data").getString("content"));
        return oneJson;
    }


    /**
     * 获取当前项目下的所有节点信息与SQL文件内容
     * @param projectName 项目名称
     * @return 信息列表
     */
    public List<DolphinTaskEntity> getAllTaskInfo(String projectName){
        JSONArray workFlowArray = getWorkFlowArray(projectName);
        //创建Dolphin任务对象列表，存储采集到Dolphin具体的task信息
        List<DolphinTaskEntity> dolphinTaskEntities = new ArrayList<>();
        for (int i = 0; i < workFlowArray.size(); i++) {
            JSONObject oneWorkFlowJson =  workFlowArray.getJSONObject(i);
            DolphinTaskEntity dolphinTaskEntityTmp = new DolphinTaskEntity();
            dolphinTaskEntityTmp.setWorkFlowName(oneWorkFlowJson.getString("name"));
            dolphinTaskEntityTmp.setWorkflowDescription(oneWorkFlowJson.getString("description"));
            dolphinTaskEntityTmp.setUserName(oneWorkFlowJson.getString("modifyBy"));
            dolphinTaskEntityTmp.setProjectId(oneWorkFlowJson.getString("projectCode"));
            dolphinTaskEntityTmp.setWorkFlowId(oneWorkFlowJson.getString("code"));
            dolphinTaskEntityTmp.setWorkflowUrl(dolphinSchedulerUrl.getPageUiUrl(dolphinTaskEntityTmp.getProjectId(), dolphinTaskEntityTmp.getWorkFlowId()));
            JSONArray taskInfoArray = getTaskArray(dolphinTaskEntityTmp.getProjectId(), dolphinTaskEntityTmp.getWorkFlowId());
            JSONObject workFlowSchedulerInfo = getWorkFlowSchedulerInfo(dolphinTaskEntityTmp.getProjectId(), dolphinTaskEntityTmp.getWorkFlowId());
            dolphinTaskEntityTmp.setSchedulerTime(workFlowSchedulerInfo.getString("schedulerTime"));
            dolphinTaskEntityTmp.setSchedulerStutas(workFlowSchedulerInfo.getString("schedulerStutas"));
            for (int j = 0; j < taskInfoArray.size(); j++) {
                DolphinTaskEntity dolphinTaskEntity = dolphinTaskEntityTmp.deepClone();
                JSONObject oneTaskInfo =  taskInfoArray.getJSONObject(j);
                //如果当前task节点不为shell节点，则跳过
                if (!oneTaskInfo.getString("taskType").equals("SHELL")&&!oneTaskInfo.getString("taskType").equals("SQL")){
                    continue;
                }
                dolphinTaskEntity.setTaskName(oneTaskInfo.getString("name"));
                dolphinTaskEntity.setTaskDescription(oneTaskInfo.getString("description"));
                dolphinTaskEntity.setCreateTime(new Date());
                dolphinTaskEntity.setUpdateTime(new Date());
                JSONObject params = oneTaskInfo.getJSONObject("taskParams");
                ArrayList<String> sqlTexts = new ArrayList<>();
                sqlTexts.add(params.getString("sql"));
                JSONArray resourceList = params.getJSONArray("resourceList")==null?new JSONArray():params.getJSONArray("resourceList");
                ArrayList<String> fileNames = new ArrayList<>();
                for (int k = 0; k < resourceList.size(); k++) {
                    JSONObject o =  resourceList.getJSONObject(k);
                    String fileId = o.getString("id");
                    JSONObject fileJson = getFileContentById(fileId);
                    if(fileJson.getString("fileName").endsWith("sql")){
                        try{
                            sqlTexts.add(fileJson.getString("content"));
                        } catch (Exception ignored){
                            continue;
                        }
                    }
                    fileNames.add(fileJson.getString("fileName"));
                }
                dolphinTaskEntity.setFileNames(StringUtils.join(fileNames, ","));
                dolphinTaskEntity.setSqlTextList(sqlTexts);
                dolphinTaskEntities.add(dolphinTaskEntity);
            }
        }

        return dolphinTaskEntities;
    }

    /**
     * 获取当前任务的运行状态
     * @param taskName 任务名称
     */
//    public String getTaskStatus(String projectName, String workFlowName,String taskName){
//        if((projectName==null||workFlowName==null||taskName==null)||(projectName.equals("")||workFlowName.equals("")||taskName.equals(""))){
//            return "normal";
//        }
//        JSONObject lastInstanceInfo = getLastInstanceInfo(projectName,workFlowName);
//        if(lastInstanceInfo==null){
//            return "normal";
//        }
//        int instanceId = lastInstanceInfo.getInteger("id");
//        String commandType = lastInstanceInfo.getString("commandType");
//        String instanceDetailUrl = String.format("http://10.255.0.5:18089/dolphinscheduler/projects/dic_dw/instance/task-list-by-process-id?processInstanceId=%d&pageSize=100&pageNo=1",instanceId);
//        JSONObject dsResponseJson = getHttpJson(instanceDetailUrl, this.token);
//        JSONArray taskList = dsResponseJson.getJSONObject("data").getJSONArray("taskList");
//        for (int i = 0; i < taskList.size(); i++) {
//            JSONObject oneJson =  taskList.getJSONObject(i);
//            String oneTaskName = oneJson.getString("name");
//            if(taskName.equals(oneTaskName)){
//                String statesString = oneJson.getString("state");
//                if(statesString.equals("SUCCESS")){
//                    return "normal";
//                }
//                if(statesString.equals("FAILURE")){
//                    return "error";
//                }
//            }
//        }
//        if(commandType.equals("START_PROCESS")){
//            return "normal";
//        }else{
//            return "error";
//        }
//    }
//
//    public JSONObject getLastInstanceInfo(String projectName,String workFlowName){
//        JSONObject jsonObject = new JSONObject();
//        JSONObject dsResponseJson = dolphinSchedulerUrl.getStatusJSON(projectName,workFlowName);
//        JSONArray instanceInfoList = dsResponseJson.getJSONObject("data").getJSONArray("totalList");
//        if(instanceInfoList==null||instanceInfoList.size()==0){
//            return null;
//        }
//        for (int i = 0; i < instanceInfoList.size(); i++) {
//            JSONObject instanceInfo =  instanceInfoList.getJSONObject(i);
//            String instanceName = instanceInfo.getString("name").split("-0-")[0];
//            String state = instanceInfo.getString("state");
//            //如果当前状态为正在运行中“RUNNING_EXECUTION”，则跳过
//            if(instanceName.equals(workFlowName)&&!state.equals("RUNNING_EXECUTION")){
//                jsonObject.put("id",instanceInfo.getInteger("id"));
//                jsonObject.put("commandType",instanceInfo.getString("commandType"));
//                return jsonObject;
//            }
//        }
//        return null;
//    }

}
