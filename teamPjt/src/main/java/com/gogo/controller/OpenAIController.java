package com.gogo.controller;

import com.gogo.service.OpenAIService;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/chat/*")
public class OpenAIController {

    @Autowired
    private OpenAIService openAIService;

    @GetMapping("/OpenAI")
    public ModelAndView OpenAI() {
        return new ModelAndView("chat/OpenAI");
    }

    // JSON을 이용한 API 방식으로 질문을 처리하려는 경우
    @PostMapping("/ask")
    @ResponseBody
    public Map<String, String> askChatbot(@RequestBody String prompt) {
    	
    	Map<String, String> response = new HashMap<>();
    	
    	String result = openAIService.askGPT(prompt,"true");
    	
    	System.out.println("result============ : "+ result);
    	
    	response.put("message", result);
    	
        return response;
    }

    // 폼 제출 방식으로 질문을 처리하려는 경우
    @PostMapping("/formAsk")
    public ModelAndView formAskChatbot(@RequestParam("userMessage") String userMessage) {
        String responseMessage = openAIService.askGPT(userMessage,"");
        ModelAndView mav = new ModelAndView("chat/OpenAI");
        mav.addObject("responseMessage", responseMessage);
        return mav;
    }
    
    @GetMapping("/Chatbot")
    public void Chatbot() {
    	
    }
}
