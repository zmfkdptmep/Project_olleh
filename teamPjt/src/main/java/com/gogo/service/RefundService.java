package com.gogo.service;

import org.springframework.stereotype.Service;

import com.gogo.vo.RefundVO;

@Service
public interface RefundService {

	public int insertRefund(RefundVO vo);
	
	public RefundVO selectOne(String paymentNo);


}
