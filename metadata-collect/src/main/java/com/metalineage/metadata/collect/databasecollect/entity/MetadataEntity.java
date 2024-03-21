package com.metalineage.metadata.collect.databasecollect.entity;

import lombok.Data;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Data
//数据库实体
public class MetadataEntity {

    //数据库连接实例名称，用户自定义。
    public String dbInstanceName;

    //数据库类型
    public String dbType;

    //数据库连接地址
    public String url;

    //数据库用户名
    public String username;

    //数据库密码
    public String password;

    //数据库描述
    public String dbComment;

    //是否只读
    public boolean isReadOnly;

    //产品版本
    public String dbVersion;

    //是否支持事务
    public boolean isSupportsTransactions;

    //数据库列表名称
    public Set<String> dbNames = new HashSet<>();

    //数据库表列表
    public HashMap<String, List<TableMetadataEntity>> dbTables = new HashMap<>();
}
