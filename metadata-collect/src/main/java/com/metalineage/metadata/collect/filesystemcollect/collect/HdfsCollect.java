package com.metalineage.metadata.collect.filesystemcollect.collect;

import com.metalineage.metadata.collect.filesystemcollect.FilesystemCollect;
import com.metalineage.metadata.collect.databasecollect.entity.TableMetadataEntity;
import lombok.SneakyThrows;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.ContentSummary;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

public class HdfsCollect extends FilesystemCollect {

    private static final String HDFS_USER = "root";

    public FileSystem fileSystem;

    public HdfsCollect(String hdfsUrl){
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
            System.out.println("hdfsUrl配置请配置2个URL，用,分割");
        }
    }

    /**
     * 获取当前目录的占用空间
     */
    public void loadFileSizeAndCount(TableMetadataEntity tableMetadataEntity){
        ContentSummary ca;
        try {
            ca = fileSystem.getContentSummary(new Path(tableMetadataEntity.getFileLocation()));
            tableMetadataEntity.setFileSpace(ca.getLength());
            tableMetadataEntity.setFileCount(ca.getFileCount());
        } catch (java.io.FileNotFoundException e1){
            System.out.println("当前文件夹不存在");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @SneakyThrows
    public String readHDFSFile(String filePath) {
        FSDataInputStream fsDataInputStream = null;
        try {
            Path path = new Path(filePath);
            fsDataInputStream = fileSystem.open(path);
            byte[] bytes = new byte[fsDataInputStream.available()];
            fsDataInputStream.read(bytes);
            return new String(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            fsDataInputStream.close();

        }
        return null;
    }

    @Override
    public void loadFileSize(String filePath) {
        System.out.println("dasw");
    }

    @Override
    public void loadFileCount(String filePath) {

    }


    public static void main(String[] args) {
        HdfsCollect hdfsCollect = new HdfsCollect("hdfs://172.17.0.201:8020/路径");
        String out = hdfsCollect.readHDFSFile("/tmp/logs/test.txt");
        System.out.println(out);

    }

}
