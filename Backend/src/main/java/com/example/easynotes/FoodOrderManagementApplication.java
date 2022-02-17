package com.example.easynotes;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class FoodOrderManagementApplication {

	public static void main(String[] args) {
		SpringApplication.run(FoodOrderManagementApplication.class, args);
	}
}
