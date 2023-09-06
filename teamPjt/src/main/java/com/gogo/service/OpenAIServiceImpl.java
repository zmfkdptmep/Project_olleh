package com.gogo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;
import org.json.JSONObject;
import org.json.JSONArray;

@Service
public class OpenAIServiceImpl implements OpenAIService {
    
    private static final String OPENAI_API_ENDPOINT = "https://api.openai.com/v1/chat/completions";
    @Value("${apiKey}")
    private String YOUR_OPENAI_API_KEY; // 여기에 실제 API 키를 입력하세요

    @Override
    public String askGPT(String prompt, String isJson) {
        RestTemplate restTemplate = new RestTemplate();
        
        
        // 페이로드 생성
        JSONObject payload = new JSONObject();
        JSONObject message = new JSONObject();
        JSONArray messageList = new JSONArray();
        
        message.put("role", "user");
        message.put("content", prompt);
        
        messageList.put(message);
        
        payload.put("model", "gpt-3.5-turbo");
        payload.put("messages", messageList);
        payload.put("temperature", 0.7);
        
        

       

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
            headers.set("Authorization", "Bearer " + YOUR_OPENAI_API_KEY);
            
            HttpEntity<String> entity = new HttpEntity<>(payload.toString(), headers);
            
            System.out.println("entity ========== : "+entity);
            
            ResponseEntity<String> response = restTemplate.exchange(OPENAI_API_ENDPOINT, HttpMethod.POST, entity, String.class);

           
            JSONObject jsonResponse = new JSONObject(response.getBody());
            JSONArray choices = jsonResponse.getJSONArray("choices");
            if (choices.length() > 0) {
                JSONObject firstChoice = choices.getJSONObject(0);
                JSONObject answer = firstChoice.getJSONObject("message");
                String correctString = new String(answer.getString("content").getBytes("ISO-8859-1"), "UTF-8");
                
                // 파싱이 잘 안된 경우 한번 더 파싱 (JSON => String)
                if (correctString.startsWith("{") && correctString.endsWith("}")) {
                    JSONObject contentJson = new JSONObject(correctString);
                    if (contentJson.has("message")) {
                    	correctString = contentJson.getString("message");
                    }
                }
                
                
                System.out.println("correctString ========== "+correctString);
                
                
                return correctString;
            } else {
                return "Sorry, I couldn't understand that.";
            }
            

        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
    


    

    

}

