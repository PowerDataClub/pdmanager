package com.metalineage.databus.manager.mapper.lineage;

import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.repository.query.Param;
import com.metalineage.databus.manager.entity.lineage.dwnode.GraphNodeImpl;

import java.util.List;

/**
 * 图数据存储接口，用于进行血缘数据的存储操作
 */
public interface DwRepository extends Neo4jRepository<GraphNodeImpl,Long> {

    /**
     * 根据节点ID查询当前关系是否存在，如果返回节点数量大于2，则说明关系存在
     * @param srcId 来源节点ID
     * @param targetId 目标节点ID
     * @return 节点数量
     */
    @Query("match(n)-[r:output]->(d) where id(n)=$srcId and id(d) = $targetId return n,d")
    public List<GraphNodeImpl> getOutputRelationById(@Param("srcId") long srcId, @Param("targetId") long targetId);

    /**
     * 根据表名确定节点数量
     * @param tableName 表名
     * @return 节点数量
     */
    @Query("match(nn{name:$tableName}) return nn")
    public List<GraphNodeImpl> getNodeByTableName(@Param("tableName") String tableName);

    /**
     * 根据表名确定节点数量
     * @param tableName 表名
     * @return 节点数量
     */
    @Query("match(nn{name:$tableName}) return nn")
    public List<GraphNodeImpl> getNodeByName(@Param("tableName") String tableName);
    /**
     * 根据ID获取指定节点
     * @param id id
     * @return 指定节点
     */
    @Query("match(nn) where id(nn) = $id return nn")
    public GraphNodeImpl getNodeById(@Param("id") long id);
}