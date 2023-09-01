package com.gogo.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.gogo.vo.AnswerVO;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.MemberVO;
import com.gogo.vo.QuestionVO;
import com.gogo.vo.ReservedVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

public interface mypageMapper {
	
	// ▶▶▶  admin ▶▶▶
	// 숙소 조회
	public List<StayVO> getList();
	
	// 숙소 삭제
	public int deleteStay(HashMap<String, Object> idArr);
	
	// 회원 조회
	public List<MemberVO> getMember();
	
	// 회원 조회 - 검색
	public List<MemberVO> getMemberSearch(MemberVO vo);
	
	// 회원 삭제
	public int deleteArr(HashMap<String, Object> idArr);
	
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
	public List<StayVO> getStay();
	
	// 숙소 관리 - 객실 삭제
	public int deleteRoom(String roomNo);
	
	// 숙소 관리 - 객실 조회
	public List<RoomVO> roomInfo(String memberId);
	
	// 숙소관리 - 객실 조회
	public List<RoomVO> getRoomArr(String memberId);
	public String getRoomFirstPic(String roomNo);
	
	// 예약 관리
	public List<Map<String, String>> reservinfo(@Param("memberId") String memberId, @Param("roomNo") int roomNo);
	
	// 객실이름
	public List<RoomVO> selectRoomName(String memberId);
	
	// 예약 관리 대표 사진
	public List<Map<String, String>> reservpic();
	
	// 수입 현황
	public List<ReservedVO> profit(String memberId);
	
	// 가이드 질문
	public int insert(QuestionVO qa);
	
	// 문의 내역 조회
	public List<QuestionVO> qaList();
	
	// 문의 내역 한건 조회
	public QuestionVO getOne(int queNo);
	
	
	// ▶▶▶  user ▶▶▶
	// 예약 정보
	public List<Map<String, String>> reservList(@Param("memberId")String memberId, @Param("pageNo")String pageNo);
	public int reservListCount(String memberId);
	
	// 이용 완료
	public List<Map<String, String>> completedList(String memberId);
	
	// 취소 정보
	public List<Map<String, String>> cancelList(@Param("memberId")String memberId, @Param("pageNo")String pageNo);
	public int cancleListCount(String memberId);
	
	// 회원 정보 조회
	public List<MemberVO> mem();
	
	// 회원 정보 수정
	public int update(MemberVO vo);
	
	// 회원 사진
	public FileuploadVO selectProfile(String memberId);
	
	// 사진 삭제
	public int deleteProfile(String memberId);
	
	// 사진 추가
	public int insertProfile(@Param("uploadPath")String uploadPath, @Param("memberId") String memberId);
	
	// 회원 탈퇴
	public int memberQuit(String memberId);
	
	// 관심 스테이
	public List<Map<String, String>> likestay(String memberId);

	// ▶▶▶  함께  * 번의 여행을 했어요 ▶▶▶
	public int travelCnt(String memberId);
}
