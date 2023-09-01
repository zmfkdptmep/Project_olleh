package com.gogo.vo;

import lombok.Data;

@Data	// 답변
public class AnswerVO {

	private int queNo; // 질문 seq
	private String answerInfo; // 답변
	private String answerDate; // 답변일
}
