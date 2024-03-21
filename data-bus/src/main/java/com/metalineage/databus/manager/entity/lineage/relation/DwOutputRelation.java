package com.metalineage.databus.manager.entity.lineage.relation;

import com.metalineage.databus.manager.entity.lineage.dwnode.GraphNodeImpl;
import lombok.Getter;
import lombok.Setter;
import org.neo4j.ogm.annotation.*;

/**
 * 血缘关系
 * @author liqifeng
 */

@RelationshipEntity(type = "output")
@Setter
@Getter
public class DwOutputRelation {
    @Id
    @GeneratedValue
    private Long id;

    // 属性-关系名称
    private String name;

    //当前关系的上游节点
    @StartNode
    private GraphNodeImpl startNode;

    //当前关系的下游节点
    @EndNode
    private GraphNodeImpl endNode;

    //构造函数
    public DwOutputRelation(GraphNodeImpl startNode, GraphNodeImpl endNode){
        this.startNode = startNode;
        this.endNode = endNode;
        this.name = "数据转换";
    }

}
