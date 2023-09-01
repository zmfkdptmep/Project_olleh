package com.gogo.vo;

import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.WebSocketSession;

import com.gogo.service.MessageService;

import lombok.Data;

@Data
public class MessageRoomVO {
	
	private String roomId;
	private String roomName;
	private String memberId; // 방 개설자
	private String stayNo; // 자신이 등록한 stay 중 어느 stay의 메세지인지 구분
	
	private Set<WebSocketSession> sessions = new HashSet<>();
	
	
}
