package com.metalineage.databus.manager.service;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class AsyncServiceImpl implements AsyncService {

    @Override
    @Async("taskExecutor")
    public void executeAsync(String dispathPath) {
        try{
            System.out.println(dispathPath);
        } catch (Exception  ignored) {
        }
    }
}