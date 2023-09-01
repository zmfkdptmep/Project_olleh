package com.gogo.service;

import java.io.IOException;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.gogo.vo.PaymentVO;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;



@Service
public interface PaymentService {
	

	public int insertPayment(PaymentVO vo);
	public PaymentVO selectOne(String impUid);
	public String getUid();
	public PaymentVO selectOne_payment_reservationNo(String reservationNo);
	
	public int updateError(PaymentVO vo);
	public int updateCancle(String impUid);
	
	// 결제 모듈
	public String getToken() throws Exception;
	public Map<String, String> paymentInfo(String impUid, String access_token) throws IOException, ParseException;
	public String payMentCancle(String access_token, String imp_uid, String amount,String reason, String checksum);
	public int paymentSave(String impUid, String access_token, String reservationNo, String paymentNo) throws IOException, ParseException;
	public IamportResponse<Payment> verify(Model model
			, Locale locale
			, HttpSession session
			, String imp_uid
			, Map<String, Object> map) throws Exception;
	public String canclePay(@RequestBody Map<String, Object> data
			, @PathVariable String checksum) throws Exception;
	public Map<String, Object> payInfoAction(String imp_uid);
	// 결제 모듈 끝
}
