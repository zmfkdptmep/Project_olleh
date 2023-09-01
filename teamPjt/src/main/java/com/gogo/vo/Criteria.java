package com.gogo.vo;

import lombok.Data;

@Data
public class Criteria {
	
	private String searchField; // 검색조건
	private String searchWord;	// 검색어
	
	private int pageNo = 1;		// 페이지
	private int amount = 10;	// 한 페이지당 게시물 수

	private int startNo = 1;
	private int endNo = 10;

	private String memberId;
	
	
	public void setPageNo(int pageNo) {
		if(pageNo > 0) {
			this.pageNo = pageNo;
			endNo = pageNo * amount;
			startNo = pageNo * amount - (amount - 1);
		}
		
	}
	
	
}
