package com.gogo.mapper;

import com.gogo.vo.PaymentVO;

public interface PaymentMapper {
	
	
	public int insertPayment(PaymentVO vo);
	
	public PaymentVO selectOne(String impUid);
	public PaymentVO selectOne_payment_reservationNo(String reservationNo);
	
	
	public String getUid();
	
	public int updateError(PaymentVO vo);
	
	public int updateCancle(String impUid);
}
