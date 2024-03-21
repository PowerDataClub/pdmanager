package com.metalineage.databus.manager.controller;

import com.alibaba.fastjson2.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.metalineage.databus.manager.service.lineage.DwRespositoryService;
import com.metalineage.databus.manager.service.lineage.LineageService;

/**
 * 血缘相关操作
 */
@RestController
@RequestMapping("/lineage")
public class LineageController {
    @Autowired
    DwRespositoryService dwRespositoryService;

    @Autowired
    LineageService lineageService;

    /**
     * 根据表名获取所有输出的表与报表
     * @param name 表名
     * @return 报表与表的json信息
     */
    @GetMapping("getOutByName")
    public JSONObject getOutByName(@RequestParam(name = "name")String name){
        return lineageService.getOutByName(name);
    }

    /**
     * 根据表名获取所有输出的表与报表
     * @param name 表名
     * @return 报表与表的json信息
     */
    @GetMapping("getSrcByName")
    public JSONObject getSrcByName(@RequestParam(name = "name")String name){
        return lineageService.getSrcByName(name);
    }

}
