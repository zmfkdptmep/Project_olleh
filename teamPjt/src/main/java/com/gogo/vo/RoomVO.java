package com.gogo.vo;

import java.util.List;

import lombok.Data;

@Data
public class RoomVO {

	private String roomNo; 		// room 시퀀스
	private String stayNo; 		// 숙소 시퀀스
	private String roomType;	// 객실 유형
	private String roomName; 	// 객실명
	private String info;		// 객실 소제목
	private String roomInfo; 	// 방 설명
	private String stdPerson; 	// 기준 인원
	private String overPerson; 	// 최대 인원
	private String price;		// 가격
	
	// 인원 추가시 금액 추가 된다면 추가금액 필드를 추가해 주어야 함
	
	private List<String> roomImg; // 이미지 사진
	private String roomPhoto; // 객실 사진
	private String stayName; // 스테이 이름
}
