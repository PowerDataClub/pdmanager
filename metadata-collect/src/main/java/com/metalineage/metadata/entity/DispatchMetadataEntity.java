package com.metalineage.metadata.entity;

import com.metalineage.metadata.collect.databasecollect.entity.MetadataEntity;
import lombok.Data;

import java.util.Date;

@Data
public class DispatchMetadataEntity  {
    //
    private String workflowName;

    private String workflowDescription;

    private String projectName;

    private String schedulerTime;

    private String schedulerStutas;

    private String workflowUrl;

    private String userName;

    private String taskName;

    private String taskDescription;

    private Integer tableId;

    private String fileNames;

    private Date createTime;

    private Date updateTime;

    private String sqlText;
}
