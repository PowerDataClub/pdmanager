package com.metalineage.metadata.collect.dispatchcollect.queryurl;

import com.alibaba.fastjson2.JSONObject;

import static com.metalineage.databus.manager.util.HttpUtil.getHttpJson;

/**
 * @author liqifeng
 * 获取DolphinScheduler中的接口数据
 */
public class DolphinSchedulerUrl {

    private final String dsUrl;
    private final String token;

    public DolphinSchedulerUrl(String dsUrl, String token){
        if(!dsUrl.endsWith("/")){
            dsUrl = dsUrl+"/";
        }
        this.dsUrl = dsUrl;
        this.token = token;
    }

    //根据项目名称获取所有工作流列表
    static final String PROJECT_INFO_URL = "dolphinscheduler/projects/%s/process-definition?pageSize=50&pageNo=1";

    //工作流UI界面URL
    static final String PAGE_UI_URL= "dolphinscheduler/ui/projects/%s/workflow/definitions/%s";

    //根据项目名称和工作流ID获取所有工作节点列表信息
    static final String WORK_FLOW_DETAIL_URL = "dolphinscheduler/projects/%s/process-definition/%s";

    //根据workFlowId获取调度信息
    static final String  SCHEDULER_TIME_URL = "dolphinscheduler/projects/%s/schedules?processDefinitionCode=%s&searchVal=&pageNo=1&pageSize=10";

    //获取项目信息
    static final String PROJECT_LIST_URL = "dolphinscheduler/projects?pageNo=1&pageSize=100&searchVal=%s";

    //获取状态信息
    static final String STATUS_URL = "dolphinscheduler/projects/%s/instance/list-paging?searchVal=%s&pageSize=100&pageNo=1";

    //获取文件内容
    static final String FILE_CONTENT_URL = "dolphinscheduler/resources/%s/view?skipLineNum=0&limit=20000";

    public JSONObject getProjectInfoUrl(String param){
        return getHttpJson(String.format(dsUrl+ PROJECT_INFO_URL, param), this.token);
    }

    public String getPageUiUrl(Object... params) {
        return String.format(dsUrl+PAGE_UI_URL, params);
    }

    public  JSONObject getSchedulerTimeJson(String param1,String param2) {
        return getHttpJson(String.format(dsUrl+SCHEDULER_TIME_URL, param1,param2), this.token);
    }

    public  JSONObject getWorkFlowDetailJson(String param1,String param2) {
        return getHttpJson(String.format(dsUrl+WORK_FLOW_DETAIL_URL, param1,param2), this.token);
    }

    public  JSONObject getProjectListJson(String param) {
        return getHttpJson(String.format(dsUrl+ PROJECT_LIST_URL, param), this.token);
    }

    public  JSONObject getStatusJSON(String param1,String param2) {
        return getHttpJson(String.format(dsUrl+STATUS_URL, param1,param2), this.token);
    }

    public  JSONObject getFileContentJson(String param) {
        return getHttpJson(String.format(dsUrl+FILE_CONTENT_URL, param), this.token);
    }
}
