package com.gogo.test;

import static org.junit.Assert.assertNotNull;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gogo.mapper.StayMapper;
import com.gogo.mapper.TestMapper;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomPhotoVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class roomTest {

	@Autowired
	StayMapper sm;
	
	
	@Test
	public void stayList() {
		List<StayVO> list = sm.stayList();
		log.info("=========");
		log.info(list);
	}
	
	@Test
	public void roomInfo() {
		Map<String, String> roomInfo = sm.roomInfo("제주스테이 비우다");
		log.info("=========");
		log.info(roomInfo);
	}
	
	@Test
	public void stayRoomInfo() {
		List<Map<String, String>> stayRoomInfo = sm.stayRoomList("제주스테이 비우다");
		log.info("=========");
		log.info(stayRoomInfo);
	}
	
	@Test
	public void roomInfoList() {
		Map<String, String> Info = sm.roomInfoPageList("제주스테이 비우다", "A동");
		log.info("=========");
		log.info(Info);
	}
	
	@Test
	public void roomInfoPicList() {
		List<RoomPhotoVO> picInfo = sm.roomInfoPagePic("제주스테이 비우다", "A동");
		log.info("=========");
		log.info(picInfo);
	}
	
	@Test
	public void styaKeywordList() {
		StayVO vo = new StayVO();
		vo.setStayName("");
		vo.setStayAdress("");
		vo.setStayView("");
		vo.setStdPerson("");
		vo.setMaxPrice("");
		vo.setStayType("");
		vo.setRoomOption("");
		vo.setFindStartDate("2023-08-16");
		vo.setFindEndDate("2023-08-22");
		List<StayVO> keyword = sm.stayKeywordList(vo);
		log.info("=========");
		log.info(keyword);
	}
	
	@Test
	public void insertLike() {
		StayVO vo = new StayVO();
		vo.setStayNo("1");
		vo.setMemberId("user1");
		int res = sm.insertLike(vo);
		log.info("=========");
		log.info(res);
	}
	
	@Test
	public void likeId() {
		StayVO vo = new StayVO();
		vo.setStayNo("1");
		vo.setMemberId("user1");
		List<StayVO> list = sm.likeId(vo);
		log.info("=========");
		log.info(list);
	}
	
	@Test
	public void deleteLike() {
		StayVO vo = new StayVO();
		vo.setStayNo("1");
		vo.setMemberId("user1");
		int res = sm.deleteLike(vo);
		log.info("=========");
		log.info(res);
	}
	
	@Test
	public void stayImg() {
		List<FileuploadVO> res = sm.stayImgList();
		log.info("=========");
		log.info(res);
	}
	
	@Test
	public void stayRoomListDate() {
		List<Map<String,String>> res = sm.stayRoomListDate("제주스테이 비우다", "2023-08-14", "2023-08-21");
		log.info("=========");
		log.info(res);
	}
	
	@Test
	public void stayRoomListImg() {
		List<Map<String,String>> res = sm.stayRoomImgDate("제주스테이 비우다", "2023-08-14", "2023-08-21");
		log.info("=========");
		log.info(res);
	}
}
