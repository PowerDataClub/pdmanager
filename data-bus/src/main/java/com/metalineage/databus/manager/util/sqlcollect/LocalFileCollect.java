package com.metalineage.databus.manager.util.sqlcollect;

import com.metalineage.databus.manager.config.SqlCollectConfig;
import com.metalineage.databus.manager.entity.metadata.MetadataTable;
import com.metalineage.databus.manager.entity.metadata.SchedulerInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.metalineage.databus.manager.util.GeneralUtil.selectSrcTable;

@Component
@Slf4j
public class LocalFileCollect {

    @Autowired
    SqlCollectConfig sqlCollectConfig;

    /**
     * 递归获取当前目录下所有的sql文件
     *
     */
    private List<Path> getAllFileName(String pathString){
        log.info("execute file: {}", pathString);
        try (Stream<Path> paths = Files.walk(Paths.get(pathString))){
            return paths
                    .filter(Files::isRegularFile).filter(x->x.toString().endsWith("sql"))
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private String readFileContent(String filePath){
        String content = "";
        StringBuilder builder = new StringBuilder();
        InputStreamReader streamReader = null;
        try {
            streamReader = new InputStreamReader(Files.newInputStream(Paths.get(filePath)), StandardCharsets.UTF_8);
            BufferedReader bufferedReader = new BufferedReader(streamReader);
            while ((content = bufferedReader.readLine()) != null){
                builder.append(content);
                builder.append("\n");
            }
        return builder.toString();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public List<MetadataTable> getAllInfo(){
        List<Path> filePaths = getAllFileName(sqlCollectConfig.getLocalfilePath());
        List<MetadataTable> metadataTableList = new ArrayList<>();
        assert filePaths != null;
        for (Path path : filePaths) {
            String pathString = path.toString();
            String content = readFileContent(pathString);
            HashMap<String, Set<String>> mapSet =  selectSrcTable(content);
            for(String oneKey:mapSet.keySet()){
                MetadataTable metadataTable = new MetadataTable();
                SchedulerInfo schedulerInfo = new SchedulerInfo();
                metadataTable.setDbTable(oneKey);
                schedulerInfo.setSqlText(content);
                schedulerInfo.setFileNames(pathString);
                metadataTable.setSrcTables(mapSet.get(oneKey));
                metadataTable.setSchedulerInfo(schedulerInfo);
                metadataTableList.add(metadataTable);
            }
        }
        return metadataTableList;
    }

}