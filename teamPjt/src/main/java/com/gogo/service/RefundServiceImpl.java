package com.gogo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gogo.mapper.RefundMapper;
import com.gogo.vo.RefundVO;

@Service
public class RefundServiceImpl implements RefundService {
	
	@Autowired
	RefundMapper refundMapper;
	
	@Override
	public int insertRefund(RefundVO vo) {
		return refundMapper.insertRefund(vo);
	}

	@Override
	public RefundVO selectOne(String paymentNo) {
		return refundMapper.selectOne(paymentNo);
	}

}
