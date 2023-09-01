package com.gogo.vo;

import lombok.Data;

@Data  // 예약
public class ReservedVO {

	private String reservationNo; // 예약 seq
	private String roomNo; // room seq
	private String memberId;
	private String regDate; // 예약일
	private String checkIn; // 체크인 날짜
	private String checkOut; // 체크아웃 날짜
	private String memberCount; // 예약 인원
	private String talk; // 요청 사항
	
	// 호스트 수익 - host/income
	private String month; // 월별 집계
	private String total_price; // 수익
}
