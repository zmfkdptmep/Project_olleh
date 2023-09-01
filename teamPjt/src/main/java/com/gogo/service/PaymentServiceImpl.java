package com.gogo.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;



import com.gogo.mapper.PaymentMapper;
import com.gogo.vo.PaymentVO;
import com.gogo.vo.RefundVO;
import com.gogo.vo.ReservedVO;

@Service

public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	PaymentMapper paymentMapper;
	
	@Autowired
	ReservedService service_r;
	
	@Autowired
	RefundService service_re;
	
	
	@Override
	public int insertPayment(PaymentVO vo) {
		return paymentMapper.insertPayment(vo);
	}
	
	
	@Override
	// 결제 정보 select로 PaymentVo 객체 불러오기
	public PaymentVO selectOne(String impUid) {
		
		PaymentVO vo = paymentMapper.selectOne(impUid);
		return vo;
	}

	@Override
	public String getUid() {
		return paymentMapper.getUid();
	}
	
	@Override
	public int updateError(PaymentVO vo) {
		return paymentMapper.updateError(vo);
	}
	@Override
	public int updateCancle(String impUid) {
		return paymentMapper.updateCancle(impUid);
	}
	
	@Override
	public PaymentVO selectOne_payment_reservationNo(String reservationNo) {
		return paymentMapper.selectOne_payment_reservationNo(reservationNo);
	}
	
	
	
	// Payment 공통 모듈
	
	
	// iamPort 필수 정보 정의
	private String impKey = "1500511887437481";
	private String impSecret = "qPqnrNzBkKnVFPKnVh9f2vzz5zvz1Xb1YVm0W7iyMbXAlGLmkyTnzc0Gg2qxLQF4nJkyyokH8kO47qMq";
	
	@Override
	// 토큰 생성 메소드
	public String getToken() throws Exception {

		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/users/getToken");

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", impKey);
		json.addProperty("imp_secret", impSecret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		bw.write(json.toString());
		bw.flush();
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();


		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
	}

	@Override
    //결제 정보 JSON으로 불러오기, paySave를 위해 사용한다.
	public Map<String, String> paymentInfo(String impUid, String access_token) throws IOException, ParseException {
		
		Map<String, String> map = new HashMap<String, String>();
		HttpsURLConnection conn = null;

		URL url = new URL("https://api.iamport.kr/payments/" + impUid);

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", access_token);
		conn.setDoOutput(true);

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		JSONParser parser = new JSONParser();

		JSONObject p = (JSONObject) parser.parse(br.readLine());
		
		String response = p.get("response").toString();
		System.out.println("paymentInfo response : "+response);
		
		p = (JSONObject) parser.parse(response);
		
		String amount = p.get("amount").toString();
		
		map.put("productName", p.get("name").toString());
		map.put("amount", p.get("amount").toString());
		map.put("merchant_uid", p.get("merchant_uid").toString());
		map.put("imp_uid", p.get("imp_uid").toString());
		map.put("pg_provider", p.get("pg_provider").toString());
		map.put("buyer_name", p.get("buyer_name").toString());
		
		if(p.get("card_name")!=null) {
			
			map.put("card_name", p.get("card_name").toString());
		}
		
		return map;
	}
	
	@Override
	public String payMentCancle(String access_token, String imp_uid, String amount,String reason, String checksum) {
		try {
		System.out.println(imp_uid+"에 대한 환불을 진행합니다.");
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");

		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);

		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();

		json.addProperty("reason", reason);
		json.addProperty("imp_uid", imp_uid);
		json.addProperty("amount", amount);
		// 환불 금액 조작을 위해 검증 생략
		System.out.println("checksum : "+ checksum);
		json.addProperty("checksum", checksum);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));			
		return "success";
		} catch(Exception e) {
			e.printStackTrace();
			return "failed";
		}
	}
	
	@Override
	// 결제 정보 저장
	public int paymentSave(String impUid, String access_token, String reservationNo, String paymentNo) throws IOException, ParseException {
		
		Map<String, String> map = paymentInfo(impUid, access_token);
		
		System.out.println("map.get(\"merchant_uid\") : "+ map.get("merchant_uid"));
		System.out.println("map.get(\"amount\") : "+ map.get("amount"));
		System.out.println("map.get(\"imp_uid\") : "+map.get("imp_uid"));
		System.out.println("map.get(\"pg_provider\") : "+map.get("pg_provider"));
		
		
		
		PaymentVO vo = new PaymentVO();
		
		vo.setImpUid(map.get("imp_uid"));
		
		if(map.get("card_name")!=null && !"".equals(map.get("card_name"))) {
			
			vo.setPaymentMethod(map.get("card_name"));
		} else {
			
			vo.setPaymentMethod(map.get("pg_provider"));
		}
		
		
		vo.setReservationNo(reservationNo);
		vo.setPaymentNo(paymentNo);
		vo.setAmount(map.get("amount"));
		
		
		return paymentMapper.insertPayment(vo);
		
	}
	
	
	// 결제 검증 메소드, 예약 insert, paymentSave, error_msg update 등을 관리한다.
	private IamportClient api;
	@Override
	public IamportResponse<Payment> verify(Model model
										, Locale locale
										, HttpSession session
										, String imp_uid
										, Map<String, Object> map) throws Exception{
		String token = getToken();
		
		api = new IamportClient(impKey, impSecret);
		
		System.out.println("imp_uid : "+map.get("imp_uid"));
		System.out.println("success : "+map.get("success"));
		System.out.println("reservationNo : "+map.get("reservationNo"));
		System.out.println("merchant_uid : "+map.get("merchant_uid"));
		System.out.println("memberCount : "+map.get("memberCount"));
		System.out.println("roomNo : "+map.get("roomNo"));
		System.out.println("checkIn : "+map.get("checkIn"));
		System.out.println("checkOut : "+map.get("checkOut"));
		System.out.println("talkSome : "+map.get("talkSome"));
		
		System.err.println("검증 시작");
		
		
		String impUid = String.valueOf(map.get("imp_uid"));
		String paymentNo = String.valueOf(map.get("merchant_uid"));
		String memberId = String.valueOf(map.get("memberId"));
		String checkIn = String.valueOf(map.get("checkIn"));
		String checkOut = String.valueOf(map.get("checkOut"));
		String roomNo = String.valueOf(map.get("roomNo"));
		String reservationNo = String.valueOf(map.get("reservationNo"));
		String memberCount = String.valueOf(map.get("memberCount"));
		String talkSome = String.valueOf(map.get("talkSome"));
		
		int res = 0;
		
		// success 가 false일시 error 메세지 저장
		String success = String.valueOf(map.get("success"));
		if("false".equals(success)) {
			
			PaymentVO error = new PaymentVO();
			String errorCode = String.valueOf(map.get("error_code"));
			String error_Msg = String.valueOf(map.get("error_msg"));
			
			error.setImpUid(impUid);
			error.setErrorCode(errorCode);
			error.setError_Msg(error_Msg);
			
			int res2 = updateError(error);
			
			if(res2>0) {
				System.out.println("결제 취소 정보 업데이트 성공");
			} else {
				System.out.println("결제 취소 정보 업데이트 실패!");
			}
		} else {
			
			// 예약 insert
			ReservedVO reserved = new ReservedVO();
			reserved.setReservationNo(reservationNo);
			reserved.setRoomNo(roomNo);
			reserved.setMemberId(memberId);
			reserved.setCheckIn(checkIn);
			reserved.setCheckOut(checkOut);
			reserved.setMemberCount(memberCount);
			reserved.setTalk(talkSome);
			
			int reservedRes = service_r.insertReserved(reserved);
			
			if(reservedRes>0) {
				System.out.println("예약 정보 저장 성공");
			} else {
				System.out.println("예약 정보 저장 실패");
			}
			
			// 결제 정보 저장
			res = paymentSave(impUid,token, reserved.getReservationNo(), paymentNo);
		}
		
		
		
		if(res>0) {
			System.out.println("결제 정보 저장 성공!");
			return api.paymentByImpUid(impUid);
		} else {
			System.out.println("결제 정보 저장 실패...");
			return null;
		}
		
	}
	
	@Override
	public String canclePay(@RequestBody Map<String, Object> data
			, @PathVariable String checksum) throws Exception {
		
		String res = "";
		
		if(data!=null) {
			String token = getToken();
			String imp_uid = (String)data.get("imp_uid");
			Object price = data.get("cancel_request_amount");
			
			
			
			System.out.println("canclepay : "+checksum);
			
			// 환불 금액 걍 조작 가능ㅋ
			String refundPrice = String.valueOf(price);
			res = payMentCancle(token, imp_uid, refundPrice, "환불이다!", checksum);
			
			if("success".equals(res)) {
				
				System.out.println("cancleYN 수정 완료");
				updateCancle(imp_uid);
				
				
				PaymentVO pay = selectOne(imp_uid);
				RefundVO check = service_re.selectOne(pay.getPaymentNo());
				
				if(check==null) {
					
					RefundVO vo = new RefundVO();
					
					vo.setPaymentNo(pay.getPaymentNo());
					vo.setAmount(pay.getAmount());
					vo.setFee("0");
					
					service_re.insertRefund(vo);
				} else {
					
					res = "dup";
				}
				
				
				
			} else {
				System.out.println("cancleYN 수정 실패..");
			}
		}
		
		return res;

	}
	
	@Override
	public Map<String, Object> payInfoAction(String imp_uid){
		
		System.out.println(imp_uid);
		
		Map<String, Object> map = new HashMap<String, Object>();
		PaymentVO vo = selectOne(imp_uid);
		
		if(vo==null) {
			System.out.println("해당 결제 정보를 찾을 수 없습니다.");
			map.put("message", "해당 결제 정보를 찾을 수 없습니다.");
			return map;
		}
		
		
		System.out.println(vo.getPaymentNo());
		System.out.println(vo.getPaymentMethod());
		System.out.println(vo.getImpUid());
		System.out.println(vo.getReservationNo());
		System.out.println(vo.getCancleYN());
		
		map.put("vo", vo);
		
		return map;

	}



	
	


}
