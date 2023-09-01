package com.gogo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gogo.vo.MessageRoomVO;
import com.gogo.vo.MessageVO;

public interface MessageMapper {
	
	
	public int insertMessage(MessageVO vo);
	public List<MessageVO> getList(String roomId);
	
	public String getSysdate();
	
	public int insertMessageRoom(); 
	public int insertMessageRoomCustom(String roomId);
	
	
	public String getRoomId(String roomId);
	
	public String getNewRoomId();
	
	public int joinYN(MessageVO vo); // 입 퇴장 기록이 있는지 체크
	public int joinYN2(MessageVO vo); // 입 퇴장 기록이 있는지 체크
	
	// TALK 가 두개 이상인 roomID 의 모든 정보 (방 개설자도..)
	public List<MessageRoomVO> messageRoomList(@Param("memberId")String memberId, @Param("pageNo") String pageNo);
	
	public int messageRoomListCount(String memberId);
	
	
	public List<MessageRoomVO> messageRoomListUser(@Param("memberId")String memberId, @Param("pageNo") String pageNo);
	
	public int messageRoomListUserCount(String memberId);
	
	// 방 개설자 구하기
	public String getMessageRoomOwner(String roomId);
	
	
	// 해당 메세지 방의 stayNo 구하기
	public String getStayNoMsg(String roomId);
	
	public String getStayNo(String reservationNo);
	
}
