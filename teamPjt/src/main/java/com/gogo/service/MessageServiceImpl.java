package com.gogo.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.ConstructorArgs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gogo.mapper.MessageMapper;
import com.gogo.vo.MemberVO;
import com.gogo.vo.MessageRoomVO;
import com.gogo.vo.MessageVO;
import com.gogo.webSocket.EchoHandler;

@Service
public class MessageServiceImpl implements MessageService{

	
	@Autowired
	MessageMapper messageMapper;

	
	@Override
	public int insertMessage(MessageVO vo) {

		return messageMapper.insertMessage(vo);
	}
	@Override
	public boolean joinYN(MessageVO vo) {
		int res = messageMapper.joinYN(vo);
		
		return res==0;
	}
	@Override
	public boolean joinYN2(MessageVO vo) {
		int res = messageMapper.joinYN2(vo);
		
		return res==0;
	}


	@Override
	public int insertMessageRoom() {
		return messageMapper.insertMessageRoom();
	}
	

	@Override
	public String getRoomId(String roomId) {
		return messageMapper.getRoomId(roomId);
	}
	
	@Override
	public String getNewRoomId() {
		return messageMapper.getNewRoomId();
	}
	@Override
	public int insertMessageRoomCustom(String roomId) {
		return messageMapper.insertMessageRoomCustom(roomId);
	}
	@Override
	public List<MessageVO> getList(String roomId){
		return messageMapper.getList(roomId);
	}
	
	@Override
	public String getSysdate() {
		return messageMapper.getSysdate();
	}
	
	@Override
	public String getStayNo(String reservationNo) {
		return messageMapper.getStayNo(reservationNo);
	}
	
	@Override
	public void chattingGet(String stayNoMsg, String roomId, HttpSession session, Model model) throws Exception {
		
		int res = insertMessageRoom();
		
		if(res>0) {
			
			MemberVO member = (MemberVO)session.getAttribute("member");
			
			String memberId = member.getMemberName();
			
			// 파라미터가 null이면 위의 insert문에서 사용한 시퀀스를 가져옴(currVal)
			if(roomId==null || "".equals(roomId)) {
				
				roomId = getNewRoomId();
			}
			
			// 체크해서 없는 roomId면 새로 insert
			String check = getRoomId(roomId);
			
			if(check==null || "".equals(check)) {
				
				insertMessageRoomCustom(roomId);
				
			}
			
			
			System.out.println(memberId+"님 "+roomId+"번 채팅방 입장");
			
			String enter = memberId+"님 "+roomId+"번 채팅방 입장 "
					+ "<span>("+getSysdate()+")</span>";
			
			List<MessageVO> messageHistory = getList(roomId);
			
			model.addAttribute("memberName", memberId);
			model.addAttribute("enter", enter);
			model.addAttribute("roomId", roomId);
			model.addAttribute("stayNoMsg", stayNoMsg);
			model.addAttribute("messageHistory", messageHistory);
			session.setAttribute("roomId", roomId);
			session.setAttribute("stayNoMsg", stayNoMsg);
			
			
		} else {
			
		}
		

	}
	
	
	// chattingGet 오버로딩 
	// EchoHandler에서 WebSocketSession과 겹쳐서  HttpSession을 직접 주입받을 수 없기 때문
	@Override
	public void chattingGet(String roomId, MemberVO member) throws Exception {
		
		int res = insertMessageRoom();
		
		if(res>0) {
			
			String memberId = member.getMemberName();
			
			// 파라미터가 null이면 위의 insert문에서 사용한 시퀀스를 가져옴(currVal)
			if(roomId==null || "".equals(roomId)) {
				
				roomId = getNewRoomId();
			}
			
			// 체크해서 없는 roomId면 새로 insert
			String check = getRoomId(roomId);
			
			if(check==null || "".equals(check)) {
				
				insertMessageRoomCustom(roomId);
				
			}
			
			
			System.out.println(memberId+"님 "+roomId+"번 채팅방 입장");
			
			String enter = memberId+"님 "+roomId+"번 채팅방 입장";
			

		} else {
			
		}
		

	}
	
	@Override
	public Map<String, Object> insertChatting(Map<String, Object> map){
		Map<String, Object> result = new HashMap<String, Object>();
		
		System.out.println("호출 성공 : "+map.get("roomId"));
		System.out.println("호출 성공 : "+map.get("stayNoMsg"));
	
		
		System.out.println(map+"호출 성공");
		MessageVO vo = new MessageVO();
		
		
		
		vo.setContent(String.valueOf(map.get("content")));
		vo.setMemberId(String.valueOf(map.get("writer")));
		vo.setRoomId(String.valueOf(map.get("roomId")));
		vo.setType(String.valueOf(map.get("type")));
		vo.setStayNo(String.valueOf(map.get("stayNoMsg")));
		int res = insertMessage(vo);
		
		if(res>0) {
			System.out.println("메세지 vo 저장 성공");
			result.put("vo", vo);
			result.put("msg", "메세지 저장 성공");
		} else {
			System.out.println("메세지 vo 저장 실패!");
			result.put("msg", "메세지 저장 실패");
		}
		return result;

	}
	
	@Override
	public List<MessageRoomVO> messageRoomList(String memberId, int pageNo) {
		
		System.err.println("messageRoomList : "+ messageMapper.messageRoomList(memberId, String.valueOf(pageNo)));
		System.err.println("서비스 memberId : "+memberId);
		System.err.println("서비스 pageNo : "+pageNo);
		
		
		return messageMapper.messageRoomList(memberId, String.valueOf(pageNo));
	}
	
	@Override
	public int messageRoomListCount(String memberId) {
		return messageMapper.messageRoomListCount(memberId);
	}
	
	
	
	@Override
	public String getMessageRoomOwner(String roomId) {
		return messageMapper.getMessageRoomOwner(roomId);
	}
	
	@Override
	public List<MessageRoomVO> messageRoomListUser(String memberId, int pageNo){
		
		
		return messageMapper.messageRoomListUser(memberId, String.valueOf(pageNo));
	}
	
	@Override
	public void messageRoomListUser(String memberId, Model model, int pageNo) {
		
		
		List<MessageRoomVO> list = messageRoomListUser(memberId, pageNo);
		
		int pageEnd = (int) Math.ceil((double)messageRoomListUserCount(memberId)/(double)10);
		
		System.err.println("page END!!!!!!!! : "+ pageEnd);
		
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("messageRoomList", list);
		model.addAttribute("pageEnd", pageEnd);
	}
	
	@Override
	public void chatListGet(Model model, String memberId, int pageNo, HttpSession session) {
		
		
		List<MessageRoomVO> messageRoomList = messageRoomList(memberId, pageNo);
		
		int pageEnd = (int) Math.ceil((double)messageRoomListCount(memberId)/(double)10);
		
		System.err.println("page END!!!!!!!! : "+ pageEnd);
		
		model.addAttribute("messageRoomList", messageRoomList);
		model.addAttribute("pageEnd", pageEnd);
		model.addAttribute("pageNo", pageNo);
		session.setAttribute("hostMsgPageNo", pageNo);
	}
	
	@Override
	public int messageRoomListUserCount(String memberId) {
		
		return messageMapper.messageRoomListUserCount(memberId);
		
	}
	
	@Override
	public String getStayNoMsg(String roomId) {
		return messageMapper.getStayNoMsg(roomId);
	}







	
}
