package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;
import com.metalineage.databus.manager.entity.metadata.MetadataTable;

import java.util.List;

@DS("master")
public interface ManagerMetadataTableMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MetadataTable record);

    int insertSelective(MetadataTable record);

    MetadataTable selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MetadataTable record);

    int updateByPrimaryKey(MetadataTable record);

    void insertBatch(List<MetadataTable> batch);

    void deleteAll();

    List<MetadataTable> findTableByTableInfo(@Param("metadata")MetadataTable record, @Param("startOffset") int startOffset, @Param("pageSize") int pageSize);

    List<MetadataTable> findById(@Param("id") int id);

    List<MetadataTable> findTableByTableInfoFuzzy(@Param("metadata")MetadataTable record,@Param("startOffset") int startOffset,@Param("pageSize") int pageSize);

    List<String> findDeleteName();
}