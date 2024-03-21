package com.metalineage.databus.manager.entity.lineage.dwnode;

/**
 * 节点接口类
 * 用于管理图数据库中的数据节点
 */
public interface GraphNodeImpl {
    String getName();

    Long getId();

    void addDwSourceRelation(GraphNodeImpl endNode);
}
