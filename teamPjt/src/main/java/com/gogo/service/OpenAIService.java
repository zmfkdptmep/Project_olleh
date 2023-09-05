package com.gogo.service;


import org.springframework.stereotype.Service;


@Service
public interface OpenAIService {

	public String askGPT(String prompt, String isJson);
 
}
