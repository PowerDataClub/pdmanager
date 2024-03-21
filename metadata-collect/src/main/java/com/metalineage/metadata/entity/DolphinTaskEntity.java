package com.metalineage.metadata.entity;

import lombok.Data;
import lombok.SneakyThrows;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;

@Data
public class DolphinTaskEntity implements Serializable {
    private String workFlowName;

    private String workflowDescription;

    private String projectName;

    private String projectId;

    private String workFlowId;

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

    private ArrayList<String> sqlTextList;

    @SneakyThrows
    public DolphinTaskEntity deepClone()  {
        // 将对象写到流里
        OutputStream bo = new ByteArrayOutputStream();
        //OutputStream op = new ObjectOutputStream();
        ObjectOutputStream oo = new ObjectOutputStream(bo);
        oo.writeObject(this);

        // 从流里读出来
        InputStream bi = new ByteArrayInputStream(((ByteArrayOutputStream) bo).toByteArray());
        ObjectInputStream oi = new ObjectInputStream(bi);
        return (DolphinTaskEntity) oi.readObject();
    }
}
