package com.gogo.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;

import com.gogo.service.mypageService;
import com.gogo.vo.MemberVO;
import com.gogo.vo.QuestionVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class mypageServiceTest {

	@Autowired
	mypageService service;
	
	@Test
	public void getMember(Model model) {
		List<Map<String, String>> pic = service.reservpic(model);
		log.info("===========");
		log.info("list : " + pic);
		//model.addAttribute("pic", pic);
	}
	
	@Test
	public void reservpic() {
//		List<Map<String, String>> list = (List<Map<String, String>>) service.reservpic();
//		log.info("=========");
//		log.info("list : " + list);
	}
	
	@Test
	public void getOne() {
		QuestionVO one = service.getOne(1);
		log.info("=========");
		log.info("one : " + one);
	}
	
	@Test
	public void chartAge(MemberVO vo) {
		List<MemberVO> list = service.chartAge(vo);
		log.info("=========================");
		log.info("list: " + list);
	}
	

	
}
