package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;
import com.metalineage.databus.manager.entity.metadata.MetadataField;

import java.util.List;

@DS("master")

public interface ManagerMetadataFieldMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MetadataField record);

    int insertSelective(MetadataField record);

    MetadataField selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MetadataField record);

    int updateByPrimaryKey(MetadataField record);

    void insertBatch(@Param("metadataFieldList") List<MetadataField> metadataFieldList);

    List<MetadataField> findFieldByFieldInfo(@Param("metafield")MetadataField record, @Param("startOffset") int startOffset, @Param("pageSize") int pageSize);

    void deleteAll();
}