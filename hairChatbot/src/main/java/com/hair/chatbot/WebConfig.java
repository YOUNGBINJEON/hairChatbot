package com.hair.chatbot;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //현재 클래스 설정 모든 결과 xml 파일 <bean
//@ComponentScan --<context;component-scan 대신)
//프로젝트 외부 경로 매핑한 것 
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/upload/**")//url 설정
				.addResourceLocations("file:///c:/upload/"); //실제경로
		registry.addResourceHandler("/faceimages/**")//url 설정
		.addResourceLocations("file:///C:/Users/parksoyeon/Desktop/images/");
		registry.addResourceHandler("/file/**")
        .addResourceLocations("file:///tmp/tomcat.8080.***/work/Tomcat/localhost/ROOT/"); 
		//리눅스 root에서 시작하는 폴더 경로
	}

	
}
