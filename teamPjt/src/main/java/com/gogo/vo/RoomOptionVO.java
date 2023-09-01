package com.gogo.vo;

import lombok.Data;

@Data
public class RoomOptionVO {
	
	private String roomNo; // 객실 seq
	private String stayNo; // 숙소 seq
	private String bathroom;	// 화장실  (Y,N)
	private String kitchen;		// 부엌 (Y,N)
	private String parking; 	// 주차 (Y,N)
	private String babiqu; 		// 바베큐 (Y,N)
	private String pet;			// 반려동물 (Y,N)
	private String terrace;		// 테라스 (Y,N)
	private String pool;		// 풀장 (Y,N)
	private String viewRoom;		// 뷰 (바다, 산)
	private String bed; 		// 침구 갯수
	private String beamProjector; // 빔프로잭터
}
