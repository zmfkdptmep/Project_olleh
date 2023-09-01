package com.gogo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.WebSocketSession;

import com.gogo.service.MessageService;
import com.gogo.webSocket.EchoHandler;


@Controller
@RequestMapping("/chat/*")
public class MessageController {
	
	@Autowired
	MessageService service;

	@Autowired
    private EchoHandler echoHandler;
	
	
	
	@GetMapping("chat")
	public void chatGet(@RequestParam(required = false, value="stayNoMsg") String stayNoMsg
						, @RequestParam(required = false) String roomId
						, @RequestParam(required = false, value="reservationNo") String reservationNo
						, HttpSession session
						, Model model) throws Exception {
		
		if(roomId==null || "".equals(roomId)) {
			
			service.insertMessageRoom();
			roomId = service.getNewRoomId();
			
		}
		if(stayNoMsg==null || "".equals(stayNoMsg) || "undefined".equals(stayNoMsg)) {
			
			stayNoMsg = service.getStayNo(reservationNo);
		}
		
			
		
		
		session.setAttribute("stayNoMsg", stayNoMsg);
		System.err.println("stayNoMsg : "+stayNoMsg);
		System.err.println("roomId : "+roomId);
		
		
		service.chattingGet(stayNoMsg, roomId, session, model);
		
	}
	

	

	
	@PostMapping("insertChat")
	@ResponseBody
	public Map<String, Object> insertChat(@RequestBody Map<String, Object> map) {
		
		
		return service.insertChatting(map);
		
		
	}
	
	@GetMapping("invite")
	public void invite() {
		
	}
	
	@PostMapping(value = "inviteAction", consumes = "application/json")
    @ResponseBody
    public Map<String, Object> inviteMember(@RequestBody Map<String, String> params
    										, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            String senderId = params.get("myMemberId"); // 초대를 보내는 사람의 ID
            String targetMemberId = params.get("targetMemberId"); // 초대를 받는 사람의 ID
            String roomId = (String)session.getAttribute("roomId");

            // 초대 메시지 생성
            String inviteMessage = senderId + "님이 " + roomId + "번 방에 초대하였습니다.";

            // 초대 메시지 전송
            echoHandler.sendInviteNotification(senderId, targetMemberId, roomId);  // senderId 는 전송하지 않습니다.

            response.put("status", "success");
            response.put("msg", inviteMessage);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("msg", "Failed to send invitation!");
            e.printStackTrace();
        }

        return response;
    }
}
