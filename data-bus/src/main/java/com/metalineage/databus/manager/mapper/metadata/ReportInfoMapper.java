package com.metalineage.databus.manager.mapper.metadata;

import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;
import com.metalineage.databus.manager.entity.metadata.ReportInfo;

import java.util.List;
import java.util.Map;
@DS("master")
public interface ReportInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ReportInfo record);

    int insertSelective(ReportInfo record);

    ReportInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ReportInfo record);

    int updateByPrimaryKey(ReportInfo record);



    List<ReportInfo> findReportByReportInfo(@Param("report")ReportInfo record, @Param("startOffset") int startOffset, @Param("pageSize") int pageSize);

    List<ReportInfo> findReportByReportInfoFuzzy(@Param("report")ReportInfo record, @Param("startOffset") int startOffset, @Param("pageSize") int pageSize);

    List<Map> getVisitInfo();

    List<Map> getRoleInfo2();

    List<Map> getRoleInfo3();

    void deleteAll();

    List<Map> getUserAndRoleInfo(@Param("menuId") int menuId);


    Map getUserInfoByMenuId(@Param("menuId") int menuId);
}