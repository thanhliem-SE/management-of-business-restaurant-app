package com.example.easynotes;

import com.example.easynotes.service.NhaCungCapService;
import com.example.easynotes.untils.Helpers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.web.socket.config.annotation.EnableWebSocket;

import javax.annotation.PostConstruct;
import java.util.Date;
import java.util.TimeZone;

@SpringBootApplication
@EnableJpaAuditing
public class FoodOrderManagementApplication {
    @Autowired
    Helpers helpers;

    public static void main(String[] args) {
        SpringApplication.run(FoodOrderManagementApplication.class, args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void init(){
        helpers.initData();
    }

    @PostConstruct
    void started() {
        TimeZone.setDefault(TimeZone.getTimeZone("GMT+7:00"));
        System.out.println("Spring boot application running in UTC timezone :"+ new Date());
    }
}
