package com.gogo.vo;

import lombok.Data;

@Data // 환불
public class PaymentVO {

	private String paymentNo;	// 결제 Seq
	private String reservationNo; // 예약 seq
	private String regDate; // 결제 시간
	private String paymentMethod; // 결제 수단
	private String impUid; // 거래 번호
	private String errorCode; // 에러코드
	private String error_Msg; // 에러 메세지
	private String cancleYN;
	private String amount; // 총 결제 가격
}
