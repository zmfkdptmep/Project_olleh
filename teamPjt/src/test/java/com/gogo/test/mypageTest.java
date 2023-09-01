package com.gogo.test;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gogo.mapper.mypageMapper;
import com.gogo.vo.AnswerVO;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.MemberVO;
import com.gogo.vo.QuestionVO;
import com.gogo.vo.ReservedVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class mypageTest {

	@Autowired
	mypageMapper mapper;
//	
//	@Test
//	public void getMember() {
//		List<MemberVO> member = mapper.getMember();
//		log.info("=========");
//		log.info("member : " + member);
//	}
//	
	@Test
	public void getStay() {
		List<StayVO> list = mapper.getStay();
		log.info("=========");
		log.info("list : " + list);
	}
	
//	@Test
//	public void reserveinfo() {
//		List<Map<String, String>> list = (List<Map<String, String>>) mapper.reservinfo();
//		log.info("list : " + list);
//	}
	
	@Test
	public void reservpic() {
		List<Map<String, String>> list = (List<Map<String, String>>) mapper.reservpic();
		log.info("=========");
		log.info("list : " + list);
	}
	
	@Test
	public void insert() {
		QuestionVO qa = new QuestionVO();
		qa.setQueNo(4);
		qa.setMemberId("user1");
		qa.setTitle("제목");
		qa.setContent("내용");
		//qa.setContentDate(new Date());
		
		mapper.insert(qa);
	}
	
	@Test
	public void qaList() {
		List<QuestionVO> list = mapper.qaList();
		log.info("=========");
		log.info("list : " + list);
	}
	
	@Test
	public void getOne() {
		QuestionVO one = mapper.getOne(1);
		log.info("=========");
		log.info("one : " + one);
	}
	
	@Test
	public void mem() {
		List<MemberVO> mem = mapper.mem();
		log.info("=========");
		log.info("one : " + mem);
	}
	
//	@Test
//	public void reservList() {
//		List<Map<String, String>> list = (List<Map<String, String>>) mapper.reservList("user1");
//		log.info("list : " + list);
//	}
//	
//	@Test
//	public void cancelList() {
//		List<Map<String, String>> list = (List<Map<String, String>>) mapper.cancelList("user1");
//		log.info("list : " + list);
//	}
	
	
	@Test
	public void update() {
		MemberVO vo = new MemberVO();
		vo.setMemberId("user1");
		vo.setMemberEmail("mail");
		vo.setPw("5678");
		mapper.update(vo);
		log.info("=========================");
		log.info("vo: " + vo);
	}
	
//	@Test
//	public void likestay(String memberId) {
//		List<Map<String, String>> list = (List<Map<String, String>>) mapper.likestay(memberId);
//		log.info("list : " + list);
//	}
	
	@Test
	public void answerInfo() {
		AnswerVO answer = mapper.answerInfo(1);
		log.info("=========================");
		log.info("answer: " + answer);
	}
	
	@Test
	public void travelCnt() {
		int res = mapper.travelCnt("user2");
		log.info("=========================");
		log.info("res: " + res);
	}
	
	@Test
	public void memberQuit() {
		int res = mapper.memberQuit("user1");
		log.info("=========================");
		log.info("res: " + res);
	}
	
	@Test
	public void selectProfile() {
		FileuploadVO profile = mapper.selectProfile("user1");
		log.info("=========================");
		log.info("profile: " + profile);
	}
	
	@Test
	public void profit() {
		List<ReservedVO> vo = mapper.profit("host1");
		log.info("=========================");
		log.info("vo: " + vo);
	}
	
	@Test
	public void completedList() {
		List<Map<String, String>> list = mapper.completedList("user1");
		log.info("list : " + list);
		
	}
	
	@Test
	public void roomInfo() {
		List<RoomVO> list = mapper.roomInfo("host1");
		log.info("list : " + list);
	}
	
	@Test
	public void chartGender() {
		MemberVO vo = new MemberVO();
		List<MemberVO> member = mapper.chartGender(vo);
		log.info("member : " + member);
	}
	
	@Test
	public void search() {
		MemberVO vo = new MemberVO();
		vo.setSearchField("memberId");
		vo.setSearchWord("host");
		List<MemberVO> list = mapper.getMemberSearch(vo);
		log.info("list : " + list);
		
	}
	
	@Test
	public void selectRoomName() {
		List<RoomVO> list = mapper.selectRoomName("host1");
		log.info("list : " + list);
	}
}
