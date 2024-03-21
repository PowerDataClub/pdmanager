package com.metalineage.databus.manager.entity.lineage.dwnode;

import lombok.Getter;
import lombok.Setter;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;
import com.metalineage.databus.manager.entity.lineage.relation.DwOutputRelation;

import java.util.HashSet;
import java.util.Set;

/**
 * 报表节点
 */
@NodeEntity("report")
@Setter
@Getter
public class ReportNode implements GraphNodeImpl  {
    @Id
    @GeneratedValue
    private Long id;

    //节点名称，报表名或者tableau名称
    private String name;

    //workbook名称
    private String workbook;

    //调度路径参数
    private String dispatchPath;

    //数据层级，用于前端展示
    private String dataLevel;

    //创建人
    private String createBy;

    //tableau页面
    private String tableauUrl;

    private String nodeType = "report";

    public ReportNode(String name, String workbook,String dispatchPath,String createBy, String dataLevel, String tableauUrl){
        this.name = name;
        this.workbook = workbook;
        this.dispatchPath = dispatchPath;
        this.createBy = createBy;
        this.dataLevel = dataLevel;
        this.tableauUrl = tableauUrl;
    }

    @Relationship(type = "output",direction = "INCOMING")
    private Set<DwOutputRelation> sets = new HashSet<>();

    //添加数仓-报表依赖关系
    public void addDwSourceRelation(GraphNodeImpl endNode){
        DwOutputRelation relationEdge = new DwOutputRelation(this,endNode);
        sets.add(relationEdge);
    }
}
