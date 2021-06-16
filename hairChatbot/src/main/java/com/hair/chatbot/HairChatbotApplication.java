package com.hair.chatbot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import ai.project.ChatbotControllerTest;

@SpringBootApplication
@ComponentScan
@ComponentScan(basePackageClasses = ChatbotControllerTest.class)
public class HairChatbotApplication {

	public static void main(String[] args) {
		SpringApplication.run(HairChatbotApplication.class, args);
	}

}
