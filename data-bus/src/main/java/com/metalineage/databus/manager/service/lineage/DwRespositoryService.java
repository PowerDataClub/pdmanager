package com.metalineage.databus.manager.service.lineage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.metalineage.databus.manager.entity.lineage.dwnode.TableNode;
import com.metalineage.databus.manager.entity.lineage.dwnode.GraphNodeImpl;
import com.metalineage.databus.manager.mapper.lineage.DwRepository;

import java.util.*;


@Service
public class DwRespositoryService {
    @Autowired
    DwRepository dwRepository;

    /**
     * 获取指定节点
     * @param nowNodeName 节点名称
     * @return 指定节点
     */
    public GraphNodeImpl getNodeByName(String nowNodeName){
        List<GraphNodeImpl> dwNodeList = dwRepository.getNodeByName(nowNodeName);
        if(dwNodeList.size()>0){
            return dwNodeList.get(0);
        }
        return null;
    }

    /**
     * 根据节点ID查询当前关系是否存在，如果存在返回true
     * @param srcId 来源节点ID
     * @param targetId 目标节点ID
     * @return 如果存在返回true，否则为false
     */
    public boolean existOutputRelation(long srcId, long targetId){
        List<GraphNodeImpl> dwNodes = dwRepository.getOutputRelationById(srcId,targetId);
        return dwNodes.size() != 0;
    }

    /**
     * 将ods层节点转换为指定dwLevel层级
     * @param dwLevel 数仓层级
     * @param comment 备注
     */
    public TableNode updateLabel(TableNode tableNode, String comment, String dataLevel, String dwLevel, String isDw){
        tableNode.setDwLevel(dwLevel);
        tableNode.setComment(comment);
        tableNode.setDataLevel(dataLevel);
        tableNode.setIsDw(isDw);
        dwRepository.save(tableNode);
        return (TableNode) dwRepository.getNodeById(tableNode.getId());
    }

    public void save(GraphNodeImpl dwNode){
        dwRepository.save(dwNode);
    }

}
