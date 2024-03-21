package com.metalineage.databus.manager.entity.lineage.dwnode;

import com.metalineage.databus.manager.entity.lineage.relation.DwOutputRelation;
import lombok.Getter;
import lombok.Setter;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.HashSet;
import java.util.Set;

/**
 * 数据表节点
 */
@NodeEntity("table")
@Setter
@Getter
public class TableNode implements GraphNodeImpl {
    @Id
    @GeneratedValue
    private Long id;

    //节点名称，库表名
    private String name;

    //数据层级，用于前端展示
    private String dataLevel;

    //数仓层级，用于逻辑划分
    private String dwLevel;

    //是否为数仓
    private String isDw;

    //表名注释
    private String comment;

    private String nodeType = "table";

    String projectName;

    String taskName;

    String workflowName;

    public TableNode(String name, String comment, String dataLevel, String dwLevel, String isDw,String projectName,String workflowName,String taskName){
        this.name = name;
        this.comment = comment;
        this.dwLevel = dwLevel;
        this.dataLevel = dataLevel;
        this.isDw = isDw;
        this.projectName = projectName;
        this.taskName = taskName;
        this.workflowName = workflowName;
    }

    public TableNode(String name, String comment, String dataLevel, String dwLevel, String isDw){
        this.name = name;
        this.comment = comment;
        this.dwLevel = dwLevel;
        this.dataLevel = dataLevel;
        this.isDw = isDw;
    }

    public TableNode(){};

    @Relationship(type = "output",direction = "INCOMING")
    private Set<DwOutputRelation> sets = new HashSet<>();

    public void addDwSourceRelation(GraphNodeImpl endNode){
        DwOutputRelation relationEdge = new DwOutputRelation(this,endNode);
        sets.add(relationEdge);
    }

}
