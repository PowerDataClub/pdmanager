package com.metalineage.databus.manager.entity.metaParseEntity;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class HiveDescribeEntity {
    private String colName;
    private String dataType;
    private String comment;
}
