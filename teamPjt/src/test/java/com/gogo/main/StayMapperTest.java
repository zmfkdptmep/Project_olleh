package com.gogo.main;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gogo.mapper.MainMapper;
import com.gogo.test.MapperTest;
import com.gogo.vo.RoomOptionVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StayMapperTest {

	@Autowired
	MainMapper mainMapper;
	
	@Test
	public void test() {
		assertNotNull(mainMapper);
		
	}
	
	@Test
	public void insertStay() {
		StayVO stayVO = new StayVO();
		stayVO.setBadge("뱃지");
		stayVO.setLatitude(1234);
		stayVO.setLongitude(12345);
		stayVO.setMemberId("user1");
		stayVO.setStayAdress("address");
		stayVO.setStayInfo("info");
		stayVO.setStayLoc("loc");
		stayVO.setStayName("짱");
		stayVO.setStayType("내타입");
		
		int res = mainMapper.insertStay(stayVO);
		
		assertEquals(1, res);
	}
	
	@Test
	public void insertRoom() {
		RoomVO roomVO = new RoomVO();
		roomVO.setStayNo("1");
		roomVO.setInfo("info");
		roomVO.setOverPerson("8");
		roomVO.setPrice("10000");
		roomVO.setRoomInfo("roominfo");
		roomVO.setRoomName("roomname");
		roomVO.setRoomType("roomtype");
		roomVO.setStdPerson("4");
		
		int res = mainMapper.insertRoom(roomVO);
		
		assertEquals(1, res);
	}
	
	@Test
	public void insertRoomOption() {
		RoomOptionVO vo = new RoomOptionVO();
		
		vo.setStayNo("1");
		vo.setRoomNo("1");
		vo.setBabiqu("Y");
		vo.setBathroom("Y");
		vo.setBed("3");
		vo.setKitchen("N");
		vo.setParking("Y");
		vo.setPet("N");
		vo.setPool("Y");
		vo.setTerrace("Y");
		vo.setViewRoom("mountain");
		
		int res = mainMapper.insertRoomOption(vo);
		
		assertEquals(1, res);
	}
	
}
