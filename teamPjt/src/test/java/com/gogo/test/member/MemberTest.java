package com.gogo.test.member;

import static org.junit.Assert.assertNotNull;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gogo.mapper.MemberMapper;
import com.gogo.vo.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MemberTest {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Test
	public void test() {
		MemberVO member = new MemberVO();
		member.setMemberId("admin");
		member.setPw("1234");
		
		member = memberMapper.loginAction(member);
		
		log.info(member);
		assertNotNull(member);
	}
	
	@Test
	public void testInsert() {
		MemberVO member = new MemberVO();
		member.setMemberId("user6");
		member.setMemberName("name1");
		member.setBirthday("1992-08-15");
		member.setPw("1234");
		member.setMemberEmail("yuhhwe@naver.com");;
		member.setGender("F");
		
		
		//int res = memberMapper.signup(member);		
		
		//assertEquals(1, res);
	}
//	
//	@Test
//	public void testIdCheck() {
//		Member member = new Member();
//		member.setId("test");
//		
//		int res = memberMapper.idCheck(member);		
//		
//		assertEquals(1, res);
//	}
//	
//	@Test
//	public void testGetMemberRole() {
//		List<String> list = memberMapper.getMemberRole("admin");
//		System.out.println(list);
//		System.out.println("관리자권한 : " + list.contains("ADMIN_ROLE"));
//	}

}











