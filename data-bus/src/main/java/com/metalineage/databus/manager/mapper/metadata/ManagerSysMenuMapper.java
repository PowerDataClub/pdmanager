package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.metalineage.databus.manager.entity.metadata.SysMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@DS("master")

public interface ManagerSysMenuMapper {
    int deleteByPrimaryKey(Long menuId);

    int insert(SysMenu record);

    int insertSelective(SysMenu record);

    SysMenu selectByPrimaryKey(Long menuId);

    int updateByPrimaryKeySelective(SysMenu record);

    int updateByPrimaryKey(SysMenu record);

    List<SysMenu> findByComponent(@Param("component") String component, @Param("startOffset") int startOffset, @Param("pageSize") int pageSize);
}