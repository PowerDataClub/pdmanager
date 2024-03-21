package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;
import com.metalineage.databus.manager.entity.metadata.SysUser;
@DS("master")

public interface ManagerSysUserMapper {
    int deleteByPrimaryKey(Long userId);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    SysUser selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);

    String findNameByPhone(@Param("phonenumber") String phonenumber);
}