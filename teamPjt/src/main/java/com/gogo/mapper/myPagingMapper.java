package com.gogo.mapper;

import org.apache.ibatis.annotations.Param;

import com.gogo.vo.Criteria;

public interface myPagingMapper {
	// ad / ho / us
	// stay / mem / qa
	
	// ▶▶▶  admin ▶▶▶
	
	
	// ▶▶▶  host ▶▶▶
	// 호스트 - 숙소 관리 페이징
	public int hostayCnt(@Param("cri") Criteria cri, @Param("memberId") String memberId);
	
	
	// ▶▶▶  user ▶▶▶
}
