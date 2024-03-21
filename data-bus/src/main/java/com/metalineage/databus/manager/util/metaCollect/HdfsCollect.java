package com.metalineage.databus.manager.util.metaCollect;

import com.alibaba.fastjson2.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;

@Slf4j
@Component
public class HdfsCollect {

    private static final String HDFS_USER = "root";

    public FileSystem fileSystem;

    @Value("${lineage.hdfsUrl}")
    private String hdfsUrl;

    public FileSystem getFileSystem(){
        if(fileSystem==null){
            Configuration configuration = new Configuration();
            try {
                fileSystem = FileSystem.get(new URI(hdfsUrl.split(",")[0]),configuration,HDFS_USER);
                try {
                    fileSystem.listFiles(new Path("/"),false);
                } catch (Exception e){
                    if(e.toString().contains("Operation category READ is not supported in state standby")){
                        fileSystem = FileSystem.get(new URI(hdfsUrl.split(",")[1]),configuration,HDFS_USER);
                    }
                }
            } catch (IOException | InterruptedException | URISyntaxException e) {
                throw new RuntimeException(e);
            } catch (ArrayIndexOutOfBoundsException e2){
                log.error("hdfsUrl配置请配置2个URL，用,分割");
            }
            return fileSystem;
        }
        return fileSystem;
    }

    /**
     * 获取当前目录的占用空间
     * @param pathString 目录地址
     * @return 占用空间
     */
    public JSONObject getFileSizeAndCount(String pathString){

        ContentSummary ca;
        JSONObject fileSizeAndCountJson = new JSONObject();
        try {
            ca = getFileSystem().getContentSummary(new Path(pathString));
            fileSizeAndCountJson.put("filesize",ca.getLength());
            fileSizeAndCountJson.put("file_count",ca.getFileCount());
            return fileSizeAndCountJson;
        } catch (java.io.FileNotFoundException e1){
            System.out.println("当前文件夹不存在");
            return null;
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public String readHDFSFile(String filePath){
        FSDataInputStream fsDataInputStream = null;
        try {
            Path path = new Path(filePath);
            fsDataInputStream = getFileSystem().open(path);
            byte[] bytes = new byte[fsDataInputStream.available()];
            fsDataInputStream.read(bytes);
            String s = new String(bytes);
            fsDataInputStream.close();
            return s;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) throws IOException {
        String out = "test";
        System.out.println(out.split(",")[1]);
//        HdfsCollect hdfsCollect = new HdfsCollect();
//        JSONObject jsonObject = hdfsCollect.getFileSizeAndCount("/data/user/hive/warehouse/zzkj_heartbeat_ods.db/ods_external_iot_cabinet_heartbeat/pt=2022-08-18/part-0-1");
//        System.out.println(jsonObject);
//        JSONObject jsonObject2 = hdfsCollect.getFileSizeAndCount("/data/user/hive/warehouse/zzkj_heartbeat_ods.db/ods_external_iot_cabinet_heartbeat/pt=2022-08-18/part-0-1");
//        System.out.println(jsonObject2);
    }
}