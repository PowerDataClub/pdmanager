package com.metalineage.databus.manager.entity.metaParseEntity;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ImpalaDescribeEntity {
    private String name;
    private String type;
    private String comment;
}
