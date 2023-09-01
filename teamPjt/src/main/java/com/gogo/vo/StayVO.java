package com.gogo.vo;

import lombok.Data;

@Data
public class StayVO {

	private String stayNo; // 숙소 시퀀스
	private String stayName; // 숙소 이름
	private String memberId; // 호스트 아이디
	private String stayLoc; // 숙소 위치 (지역 명)
	private String stayAdress;
	private String stayInfo; // 숙소 설명
	private String stayType; // 분류
	private String badge; // 뱃지
	private String mainPic1; // 메인사진 1
	private String mainPic2; // 메인사진 2
	
	// 위도, 경도는 카카오맵 api 사용 시 지도에 마커로 표시할 때 사용됨
	private double latitude; 	// 위도
	private double longitude;	// 경도
    
	private String postNum; // 우편번호
	private String detailAds; // 상세주소
	private String refs; 	// 참고항목
	private String registrationYN; // 사업자 등록 여부
	
	private String stdPerson; 	// 기준 인원
	private String overPerson; 	// 최대 인원
	private String minPrice; // 가격
	private String maxPrice; // 가격
	
	private int likeCount; // 좋아요 수
	private String stayView; // 주변 경치
	
	private String roomOption; // 룸옵션 확인 변수
	
	private String findStartDate; // 체크인
	private String findEndDate; // 체크아웃
	
	private String category; // 카테고리 출력 변수
	
	private String sns; // 숙소 sns
	private String tel; // 숙소 번호
	
	private String[] roomOptions; // 룸옵션 배열을 통해 보내기
	private String[] stayTypes; // 분류
	
	
	
}
