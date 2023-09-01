package com.gogo.vo;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String memberId;
	private String pw;
	private String memberName;
	private String birthday; // 생년월일 19990101
	private String gender;
	private String memberEmail;
	private String registraionDate; // 가입일
	private String snsCk;	// 소셜계정 로그인 체크
	private String profile;
	
	// 통계
	private String age_group;
	private String count;
	private String gender_group;
	private String gender_Count;
	
	// search
	private String searchField;
	private String searchWord;
	
	
	// 카카오 토큰 발급 정보
	private String access_token;
	private String token_type;
	private String refresh_token;
	private int expires_in;
	private String scope;
	private int refresh_token_expires_in;
	
	// 사용자 권한
	private List<String> role;
	
}
