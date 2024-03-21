package com.metalineage.databus.manager.util.sqlcollect;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.metalineage.databus.manager.config.SqlCollectConfig;
import com.metalineage.databus.manager.entity.metadata.MetadataTable;
import com.metalineage.databus.manager.entity.metadata.SchedulerInfo;
import com.metalineage.databus.manager.mapper.metadata.SchedulerInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.metalineage.databus.manager.util.GeneralUtil.selectSrcTable;
import static com.metalineage.databus.manager.util.HttpUtil.getHttpJson;

@Service
public class DolphinCollect3 {

    @Autowired(required = false)
    SchedulerInfoMapper schedulerInfoMapper;

    @Autowired
    SqlCollectConfig sqlCollectConfig;

    //根据项目名称获取所有工作流列表
    String INFO_URL = "/dolphinscheduler/projects/%s/process-definition?pageSize=50&pageNo=1";

    //工作流UI界面URL
    String PAGE_UI_URL= "/dolphinscheduler/ui/#/projects/%s/definition/list/%s";

    //根据项目名称和工作流ID获取所有工作节点列表信息
    String WORK_FLOW_DETAIL_URL = "/dolphinscheduler/projects/%s/process-definition/%s";

    //根据workFlowId获取调度信息
    String  SCHEDULER_TIME_URL = "/dolphinscheduler/projects/%s/schedules?processDefinitionCode=%s&searchVal=&pageNo=1&pageSize=10";

    public int deleteByPrimaryKey(Integer id){return schedulerInfoMapper.deleteByPrimaryKey(id);};

    public int insert(SchedulerInfo record){return schedulerInfoMapper.insert(record);};

    public int insertSelective(SchedulerInfo record){return schedulerInfoMapper.insertSelective(record);};

    public SchedulerInfo selectByPrimaryKey(Integer id){return schedulerInfoMapper.selectByPrimaryKey(id);};

    public int updateByPrimaryKeySelective(SchedulerInfo record){return schedulerInfoMapper.updateByPrimaryKeySelective(record);};

    public int updateByPrimaryKey(SchedulerInfo record){return schedulerInfoMapper.updateByPrimaryKey(record);};

    public void deleteAll(){
        schedulerInfoMapper.deleteAll();
    }

    public int upsert(SchedulerInfo record){
        if(record.getId()!=null){
            record.setUpdateTime(new Date());
            schedulerInfoMapper.updateByPrimaryKeySelective(record);
            return record.getId();
        }
        SchedulerInfo oneRecord = findOneSchedulerBySchedulerInfo(record);
        if(oneRecord!=null){
            record.setId(oneRecord.getId());
            record.setUpdateTime(new Date());
            schedulerInfoMapper.updateByPrimaryKeySelective(record);
            return record.getId();
        } else{
            record.setCreateTime(new Date());
            record.setUpdateTime(new Date());
            schedulerInfoMapper.insertSelective(record);
            return 1;
        }
    }

    public SchedulerInfo findOneSchedulerBySchedulerInfo(SchedulerInfo record){
        List<SchedulerInfo> metadataTableList = findSchedulerBySchedulerInfo(record,1,1);
        if(metadataTableList==null||metadataTableList.size()==0){
            return null;
        } else{
            return metadataTableList.get(0);
        }
    };

    public List<SchedulerInfo> findSchedulerBySchedulerInfo(SchedulerInfo record,int page,int pageSize){
        if(pageSize>100){
            pageSize = 100;
        }
        if(page<=0){
            page=1;
        }
        int startOffset = (page-1)*pageSize;
        return schedulerInfoMapper.findSchedulerBySchedulerInfo(record,startOffset,pageSize);
    };

    /**
     * 根据项目名称获取所有工作流列表
     */
    public JSONArray getWorkFlowArray(String projectName){
        JSONArray resultArry = new JSONArray();
        String projectsUrl = sqlCollectConfig.getDsUrl()+"/dolphinscheduler/projects?pageNo=1&pageSize=10&searchVal="+projectName;
        JSONObject projectsJson = getHttpJson(projectsUrl, sqlCollectConfig.getToken());
        JSONArray projectArray = projectsJson.getJSONObject("data").getJSONArray("totalList");
        for (int i = 0; i < projectArray.size(); i++) {
            JSONObject oneProject =  projectArray.getJSONObject(i);
            String name = oneProject.getString("name");
            String code = oneProject.getString("code");
            if(name.equals(projectName)){
                String projectInfoUrl = String.format(sqlCollectConfig.getDsUrl()+INFO_URL,code);
                JSONObject dsResponseJson = getHttpJson(projectInfoUrl, sqlCollectConfig.getToken());
                System.out.println(dsResponseJson);
                //        获取所有workFlow列表
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
     * 根据文件ID查看当前文件内容
     * @param fileId 文件ID
     * @return 文件内容
     */
    public JSONObject getFileContentById(String fileId){
        String projectsUrl = sqlCollectConfig.getDsUrl()+"/dolphinscheduler/resources/"+fileId+"/view?skipLineNum=0&limit=15000";
        JSONObject fileJson = getHttpJson(projectsUrl, sqlCollectConfig.getToken());
        JSONObject oneJson = new JSONObject();
        oneJson.put("fileName",fileJson.getJSONObject("data").getString("alias"));
        oneJson.put("content",fileJson.getJSONObject("data").getString("content"));
        return oneJson;
    }

    /**
     * 根据项目名称和工作流ID获取所有工作节点列表信息
     */
    public JSONArray getTaskArray(String projectName,String workFlowId){
        String workFlowDetailUrl = String.format(sqlCollectConfig.getDsUrl()+WORK_FLOW_DETAIL_URL,projectName,workFlowId);
        JSONObject oneWorkFlowDetailJson = getHttpJson(workFlowDetailUrl, sqlCollectConfig.getToken());
        return oneWorkFlowDetailJson.getJSONObject("data").getJSONArray("taskDefinitionList");
    }

    /**
     * 获取当前项目下的所有节点信息与SQL文件内容
     * @param projectName 项目名称
     * @return 信息列表
     */
    public List<MetadataTable> getAllInfo(String projectName){
        JSONArray workFlowArray = getWorkFlowArray(projectName);
        List<MetadataTable> metadataTableList = new ArrayList<>();
        for (int i = 0; i < workFlowArray.size(); i++) {
            JSONObject oneWorkFlowJson =  workFlowArray.getJSONObject(i);
            //获取当前workFlow名称
            String workFlowName = oneWorkFlowJson.getString("name");
            String workFlowDescription = oneWorkFlowJson.getString("description");
            String userName = oneWorkFlowJson.getString("modifyBy");
            //获取当前workFlow的ID
            String projectId = oneWorkFlowJson.getString("projectCode");
            String workFlowId = oneWorkFlowJson.getString("code");
            String workFlowUrl = String.format(sqlCollectConfig.getDsUrl()+PAGE_UI_URL,projectId,workFlowId);
            JSONObject workFlowSchedulerInfo = getWorkFlowSchedulerInfo(projectId,workFlowId);
            JSONArray taskInfoArray = getTaskArray(projectId,workFlowId);
            for (int j = 0; j < taskInfoArray.size(); j++) {
                JSONObject oneTaskInfo =  taskInfoArray.getJSONObject(j);
                //如果当前task节点不为shell节点，则跳过
                if (!oneTaskInfo.getString("taskType").equals("SHELL")){
                    continue;
                }
                String taskName = oneTaskInfo.getString("name");
                String taskDescription = oneTaskInfo.getString("description");
                JSONObject params = oneTaskInfo.getJSONObject("taskParams");
                JSONArray resourceList = params.getJSONArray("resourceList");
                String sql = "";
                //用于保存原始sql代码
                String sqlBase = "";
                ArrayList<String> fileNames = new ArrayList<>();
                if(resourceList.size()==0){
                    sqlBase = params.getString("rawScript");
                    sql = params.getString("rawScript").toLowerCase();
                    if(sql.contains("insert")){
                        Pattern p2 = Pattern.compile("insert[\\s\\S]*?;");
                        Matcher matcher = p2.matcher(sql);
                        while (matcher.find()){
                            sql = matcher.group();
                            break;
                        }
                    }
                    if(sql.contains("upsert")){
                        Pattern p2 = Pattern.compile("upsert[\\s\\S]*?;");
                        Matcher matcher = p2.matcher(sql);
                        while (matcher.find()){
                            sql = matcher.group();
                            break;
                        }
                    }

                    try {
                        sql = "insert"+sql.split("insert")[1].replace("\"","");
                    } catch (Exception e){
                        try {
                            sql = "upsert"+sql.split("upsert")[1].replace("\"","");
                        } catch (Exception e1){
                            continue;
                        }
                    }
                }else{
                    for (int k = 0; k < resourceList.size(); k++) {
                        JSONObject o =  resourceList.getJSONObject(k);
                        String fileId = o.getString("id");
                        JSONObject fileJson = getFileContentById(fileId);
                        if(fileJson.getString("fileName").endsWith("sql")){
                            try{
                                sql = fileJson.getString("content").toLowerCase();
                                sqlBase = fileJson.getString("content");
                            } catch (Exception ignored){
                                continue;
                            }
                        }
                        fileNames.add(fileJson.getString("fileName"));
                    }
                }
                try {
                    HashMap<String,Set<String>> mapSet= selectSrcTable(sql);
                    for(String oneKey:mapSet.keySet()){
                        MetadataTable metadataTable = new MetadataTable();
                        SchedulerInfo schedulerInfo = new SchedulerInfo();
                        metadataTable.setDbTable(oneKey);
                        metadataTable.setSrcTables(mapSet.get(oneKey));
                        schedulerInfo.setWorkflowUrl(workFlowUrl);
                        schedulerInfo.setUserName(userName);
                        schedulerInfo.setSqlText(sqlBase);
                        schedulerInfo.setTaskName(taskName);
                        schedulerInfo.setTaskDescription(taskDescription);
                        schedulerInfo.setFileNames(String.join(",",fileNames));
                        schedulerInfo.setSchedulerTime(workFlowSchedulerInfo.getString("schedulerTime"));
                        schedulerInfo.setSchedulerStutas(workFlowSchedulerInfo.getString("schedulerStutas"));
                        schedulerInfo.setWorkflowName(workFlowName);
                        schedulerInfo.setWorkflowDescription(workFlowDescription);
                        schedulerInfo.setProjectName(projectName);
                        metadataTable.setSchedulerInfo(schedulerInfo);
                        metadataTableList.add(metadataTable);
                    }
                } catch (Exception ignored){
                }
            }
        }
        return metadataTableList;
    }


    /**
     * 根据workFlowId获取调度信息
     */
    public JSONObject getWorkFlowSchedulerInfo(String projectId, String workFolwId){
        String timeInfoUrl = String.format(sqlCollectConfig.getDsUrl()+SCHEDULER_TIME_URL,projectId,workFolwId);
        JSONObject dsResponseJson = getHttpJson(timeInfoUrl, sqlCollectConfig.getToken());
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
     * 获取当前任务的运行状态
     * @param taskName 任务名称
     */
    public String getTaskStatus(String projectName, String workFlowName,String taskName){
        if((projectName==null||workFlowName==null||taskName==null)||(projectName.equals("")||workFlowName.equals("")||taskName.equals(""))){
            return "normal";
        }
        JSONObject lastInstanceInfo = getLastInstanceInfo(projectName,workFlowName);
        if(lastInstanceInfo==null){
            return "normal";
        }
        int instanceId = lastInstanceInfo.getInteger("id");
        String commandType = lastInstanceInfo.getString("commandType");
        String instanceDetailUrl = String.format("http://10.255.0.5:18089/dolphinscheduler/projects/dic_dw/instance/task-list-by-process-id?processInstanceId=%d&pageSize=100&pageNo=1",instanceId);
        JSONObject dsResponseJson = getHttpJson(instanceDetailUrl, sqlCollectConfig.getToken());
        JSONArray taskList = dsResponseJson.getJSONObject("data").getJSONArray("taskList");
        for (int i = 0; i < taskList.size(); i++) {
            JSONObject oneJson =  taskList.getJSONObject(i);
            String oneTaskName = oneJson.getString("name");
            if(taskName.equals(oneTaskName)){
                String statesString = oneJson.getString("state");
                if(statesString.equals("SUCCESS")){
                    return "normal";
                }
                if(statesString.equals("FAILURE")){
                    return "error";
                }
            }
        }
        if(commandType.equals("START_PROCESS")){
            return "normal";
        }else{
            return "error";
        }
    }

    public JSONObject getLastInstanceInfo(String projectName,String workFlowName){
        JSONObject jsonObject = new JSONObject();
        String instanceListUrl = String.format(sqlCollectConfig.getDsUrl()+"/dolphinscheduler/projects/%s/instance/list-paging?searchVal=%s&pageSize=100&pageNo=1",projectName,workFlowName);
        JSONObject dsResponseJson = getHttpJson(instanceListUrl, sqlCollectConfig.getToken());
        JSONArray instanceInfoList = dsResponseJson.getJSONObject("data").getJSONArray("totalList");
        if(instanceInfoList==null||instanceInfoList.size()==0){
            return null;
        }
        for (int i = 0; i < instanceInfoList.size(); i++) {
            JSONObject instanceInfo =  instanceInfoList.getJSONObject(i);
            String instanceName = instanceInfo.getString("name").split("-0-")[0];
            String state = instanceInfo.getString("state");
            //如果当前状态为正在运行中“RUNNING_EXECUTION”，则跳过
            if(instanceName.equals(workFlowName)&&!state.equals("RUNNING_EXECUTION")){
                jsonObject.put("id",instanceInfo.getInteger("id"));
                jsonObject.put("commandType",instanceInfo.getString("commandType"));
                return jsonObject;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        DolphinCollect3 dolphinCollect3 = new DolphinCollect3();
        dolphinCollect3.getAllInfo("metalineage");
    }
}
