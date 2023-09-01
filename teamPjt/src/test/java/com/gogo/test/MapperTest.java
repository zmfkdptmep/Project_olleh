package com.gogo.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gogo.mapper.TestMapper;
import com.gogo.mapper.mypageMapper;
import com.gogo.vo.MemberVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MapperTest {

	@Autowired
	TestMapper testMapper;
	
	
	@Test
	public void test() {
		assertNotNull(testMapper);
	}
	
	@Test
	public void insert() {
		MemberVO member = new MemberVO();
		member.setMemberId("testuser");
		member.setMemberName("testname");
		member.setBirthday("1999/07/04");
		member.setPw("1234");
		
		System.out.println(member.getMemberId());
		
		int res = testMapper.test(member);
		assertEquals(1, res);
		
	}
	
}
