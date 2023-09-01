package com.gogo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gogo.vo.AnswerVO;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.MemberVO;
import com.gogo.vo.QuestionVO;
import com.gogo.vo.ReservedVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@Service
public interface mypageService {

	// ▶▶▶  admin ▶▶▶
	// 숙소 조회
	public List<StayVO> getList(Model model);
	
	// 숙소 삭제
	public int deleteStay(String[] idArr);
	
	// 회원 조회
	public List<MemberVO> getMember(Model model);
	
	// 회원 조회 - 검색
	public List<MemberVO> getMemberSearch(MemberVO vo);
	
	// 회원 여러명 삭제
	public int deleteArr(String[] idArr);
	
	// 호스트지원 - 답변하기
	public int answering(AnswerVO vo);
	
	// 답변한 내용 ADMIN에서 확인 
	public AnswerVO answerInfo(int queNo);
	
	// 통계
	public List<MemberVO> chartAge(MemberVO vo);
	
	// 통계
	public List<MemberVO> chartGender(MemberVO vo);
	
	
	// ▶▶▶  host ▶▶▶
	// 숙소 관리
	public List<StayVO> getStay(Model model);
	
	// 숙소 관리 - 객실 조회
	public List<RoomVO> roomInfo(String memberId, Model model);
	
	// 숙소 관리 - 객실 삭제
	public int deleteRoom(String roomNo);
	
	// 예약 관리
	public List<Map<String, String>> reservinfo(@Param("memberId") String memberId, @Param("roomNo") int roomNo, Model model);
	
	// 예약 관리 대표 사진
	public List<Map<String, String>> reservpic(Model model);
	
	// 객실이름
	public List<RoomVO> selectRoomName(String memberId, Model model);
	
	// 수입 현황
	public List<ReservedVO> profit(String memberId);
	
	// 가이드 문의 요청 ->
	public int insert(QuestionVO qa);
	
	// 문의 내역 조회
	public List<QuestionVO> qaList(Model model, QuestionVO vo);
	
	// 문의 내역 한건 조회
	public QuestionVO getOne(int queNo);
	
	
	// ▶▶▶  user ▶▶▶
	// 예약 정보
	public List<Map<String, String>> reservList(Model model, String memberId, String pageNo);
	public int reservListCount(String memberId);
	
	// 이용 완료
	public List<Map<String, String>> completedList(Model model, String memberId);
	
	// 취소 정보
	public List<Map<String, String>> cancelList(Model model, String memberId, String pageNo);
	public int cancleListCount(String memberId);
	
	// 회원 정보 조회
	public List<MemberVO> mem(Model model);
	
	// 회원 정보 수정
	public int update(MemberVO vo, List<MultipartFile> files);
	
	// 회원 사진
	public FileuploadVO selectProfile(String memberId);
	
	// 회원 탈퇴
	public int memberQuit(String memberId);
	
	
	// 예약 상세보기
	public void reservation_detail(@RequestParam("checkIn") String checkIn
			, @RequestParam("checkOut") String checkOut
			, @RequestParam("price") String price
			, @RequestParam("stayNo") String stayNo
			, @RequestParam("reservationNo") String reservationNo
			, Model model);
	
	// 관심 스테이
	public List<Map<String, String>> likestay(String memberId, Model model);
	
	
	// ▶▶▶  함께  * 번의 여행을 했어요 ▶▶▶
	public int travelCnt(String memberId);
	
	//public int updateMember(MemberVO member, MultipartFile file, HttpSession session);

	
}
