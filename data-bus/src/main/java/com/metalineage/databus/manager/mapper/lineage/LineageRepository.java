package com.metalineage.databus.manager.mapper.lineage;

import org.neo4j.ogm.model.Result;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * 血缘检索服务
 */
@Repository
public interface LineageRepository  extends Neo4jRepository<Object,Long> {
    @Query(value = "MATCH (n)-[r]->(d) where d.name = $name RETURN n.name as name ,n.dataLevel as label, n.projectName as projectName, n.workflowName as workflowName, n.taskName as taskName;")
    public Result getSrcByName(@Param("name")String name);

    @Query("MATCH (n)-[r]->(d) where n.name = $name RETURN d.name as name ,d.dataLevel as label, d.projectName as projectName, d.workflowName as workflowName, d.taskName as taskName;")
    public Result getOutByName(@Param("name")String name);

    @Query("MATCH (n) where n.name = $name RETURN n.name as name ,n.dataLevel as label, n.projectName as projectName, n.workflowName as workflowName, n.taskName as taskName;")
    public Result getNode(@Param("name") String name);

    @Query("match (n)-[r*1..4]->(d:report) where n.name = $name return d.name as name,d.dispatchPath as dispatchPath;")
    public Result getOutAllReport(@Param("name") String name);

    @Query("match (n)-[r]->(d:report) where n.name = $name return d.name as name,d.dispatchPath as dispatchPath;")
    public Result getOutReport(@Param("name") String name);

    @Query("match (n)-[r]->(d:report) where n.name = $name return count(d);")
    public int getOutReportSize(@Param("name") String name);

    @Query("match (n)-[r*1..4]->(d:report) where n.name = $name return count(d);")
    public int getOutAllReportSize(@Param("name") String name);

    @Query("match(n) where n.name =~ $name return n.name order by n.name limit 10;")
    public List<String> getNameFuzzy(@Param("name") String name);

    @Query("match(n)-[r]->(d) where d.name = $name return n.name as name;")
    public List<String> getSrcTableName(@Param("name") String name);

    @Query("match(nn) detach delete nn")
    public void deleteAllData();
}