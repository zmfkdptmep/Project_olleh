package com.gogo.service;

import org.springframework.stereotype.Service;

import com.gogo.vo.Criteria;

@Service
public interface myPagingService {

	// ad / ho / us
	// stay / mem / qa
	
	// ▶▶▶  admin ▶▶▶
	
	
	// ▶▶▶  host ▶▶▶
	// 호스트 - 숙소 관리 페이징
	public int hostayCnt(Criteria cri, String memberId);
	
	
	// ▶▶▶  user ▶▶▶
}
