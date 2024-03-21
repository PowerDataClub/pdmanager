package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;
import com.metalineage.databus.manager.entity.metadata.SchedulerInfo;

import java.util.List;
@DS("master")
public interface SchedulerInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SchedulerInfo record);

    int insertSelective(SchedulerInfo record);

    SchedulerInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SchedulerInfo record);

    int updateByPrimaryKeyWithBLOBs(SchedulerInfo record);

    void insertBatch(@Param("schedulerList") List<SchedulerInfo> metadataFieldList);

    int updateByPrimaryKey(SchedulerInfo record);

    List<SchedulerInfo> findSchedulerBySchedulerInfo(@Param("scheduler")SchedulerInfo record, @org.apache.ibatis.annotations.Param("startOffset") int startOffset, @Param("pageSize") int pageSize);

    void deleteAll();
}