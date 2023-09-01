package com.gogo.vo;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

public class test {
	
	public static Object getBean(String beanName) {
		WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
		return context.getBean(beanName);
	}
	
	public static void main(String[] args) {
		
		getBean("suffix");
		
	}

}
