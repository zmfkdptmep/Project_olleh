package com.gogo.mapper;

import com.gogo.vo.RefundVO;

public interface RefundMapper {
	
	
	public int insertRefund(RefundVO vo);
	
	public RefundVO selectOne(String paymentNo);
}
