package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.metalineage.databus.manager.entity.metadata.SysMenuHealth;
@DS("master")

public interface ManagerSysMenuHealthMapper {
    int deleteByPrimaryKey(Long menuId);

    int insert(SysMenuHealth record);

    int insertSelective(SysMenuHealth record);

    SysMenuHealth selectByPrimaryKey(Long menuId);

    int updateByPrimaryKeySelective(SysMenuHealth record);

    int updateByPrimaryKey(SysMenuHealth record);

    void deleteAll();
}