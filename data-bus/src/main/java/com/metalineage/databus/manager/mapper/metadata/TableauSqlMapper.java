package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;
import com.metalineage.databus.manager.entity.metadata.TableauSql;
import com.metalineage.databus.manager.entity.metadata.TableauSqlKey;

import java.util.List;
@DS("master")
public interface TableauSqlMapper {
    int deleteByPrimaryKey(TableauSqlKey key);

    int insert(TableauSql record);

    int insertSelective(TableauSql record);

    TableauSql selectByPrimaryKey(TableauSqlKey key);

    int updateByPrimaryKeySelective(TableauSql record);

    int updateByPrimaryKeyWithBLOBs(TableauSql record);

    int updateByPrimaryKey(TableauSql record);

    List<TableauSql> findTableauByTableauInfo(@Param("tableau")TableauSql record, @Param("startOffset") int startOffset, @Param("pageSize") int pageSize);

    List<String> findAllWorkbook();
}