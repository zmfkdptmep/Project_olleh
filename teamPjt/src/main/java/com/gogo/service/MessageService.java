package com.gogo.service;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.socket.WebSocketSession;

import com.gogo.vo.MemberVO;
import com.gogo.vo.MessageRoomVO;
import com.gogo.vo.MessageVO;

@Service
public interface MessageService {



	
	public int insertMessage(MessageVO vo);
	public int insertMessageRoom();
	public int insertMessageRoomCustom(String roomId);
	public String getRoomId(String roomId);
	public void chattingGet(String stayNo, String roomId, HttpSession session, Model model) throws Exception;
	public void chattingGet(String roomId, MemberVO member) throws Exception;
	public Map<String, Object> insertChatting(Map<String, Object> map);
	public String getNewRoomId();
	public boolean joinYN(MessageVO vo);
	public boolean joinYN2(MessageVO vo);
	
	public String getSysdate();
	public List<MessageVO> getList(String roomId);
	
	
	public List<MessageRoomVO> messageRoomList(String memberId, int pageNo);
	
	public int messageRoomListCount(String memberId);
	
	
	public List<MessageRoomVO> messageRoomListUser(String memberId, int pageNo);
	
	public int messageRoomListUserCount(String memberId);
	
	public void messageRoomListUser(String memberId, Model model, int pageNo);
	public void chatListGet(Model model, String memberId, int pageNo, HttpSession session);
	public String getMessageRoomOwner(String roomId);
	public String getStayNoMsg(String roomId);
	public String getStayNo(String reservationNo);
}
