package com.metalineage.databus.manager.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "lineage.sqlcollect")
@Setter
@Getter
public class SqlCollectConfig {
    private String dsUrl;
    private String token;
    private String dsVersion;
    private String resourcePath;
    private String localfilePath;
    private String collectType;
}
