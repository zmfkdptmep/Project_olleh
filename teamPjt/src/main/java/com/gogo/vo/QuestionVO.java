package com.gogo.vo;

import java.util.Date;

import lombok.Data;

@Data // 질문
public class QuestionVO {
	
	private int queNo; // 질문 seq
	private String memberId;
	private String title;
	private String content;
	private String contentDate; // 게시일
	
	private String answerYN;
}
