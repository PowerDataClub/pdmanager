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
 * 用户节点
 */
@NodeEntity("user")
@Setter
@Getter
public class UserNode implements GraphNodeImpl {
    @Id
    @GeneratedValue
    private Long id;

    //节点名称，库表名
    private String name;

    //数据层级，用于前端展示
    private String dataLevel = "user";

    public UserNode(String name){
        this.name = name;
    }

    @Relationship(type = "output",direction = "INCOMING")
    private Set<DwOutputRelation> sets = new HashSet<>();

    public void addDwSourceRelation(GraphNodeImpl endNode){
        DwOutputRelation relationEdge = new DwOutputRelation(this,endNode);
        sets.add(relationEdge);
    }

}
