package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.metalineage.databus.manager.entity.metadata.DimSysWechatUser;
import org.springframework.data.repository.query.Param;

import java.util.List;

@DS("master")
public interface DimSysWechatUserMapper {

    int deleteByPrimaryKey(Integer userId);

    int insert(DimSysWechatUser record);

    int insertSelective(DimSysWechatUser record);

    DimSysWechatUser selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(DimSysWechatUser record);

    int updateByPrimaryKey(DimSysWechatUser record);

    List<DimSysWechatUser> findUserByUserInfo(@Param("wechatUser")DimSysWechatUser wechatUser, @Param("startOffset") int startOffset, @Param("pageSize") int pageSize);

}