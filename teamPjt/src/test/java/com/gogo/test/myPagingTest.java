package com.gogo.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gogo.mapper.myPagingMapper;
import com.gogo.vo.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class myPagingTest {
	
	@Autowired
	myPagingMapper paging;
	
	@Test
	public void hostayCnt() {
		Criteria cri = new Criteria();
		int res = paging.hostayCnt(cri, "host1");
		log.info("res : " + res);
	}

}
