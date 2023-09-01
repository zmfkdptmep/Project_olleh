package com.gogo.vo;

import lombok.Data;

@Data
public class MessageVO {
	
	
	
	private String type; // 메세지 타입 (입장, 퇴장, 대화) // ENTER, OUT, TALK
	private String messageNo;
	private String content;
	private String regDate;
	private String memberId;
	private String memberRole;
	private String roomId;
	private String stayNo; // 해당 stay에 대해서만 메세지를 보낼 수 있다 

}
