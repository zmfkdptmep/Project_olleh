package com.gogo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gogo.service.mypageService;
import com.gogo.vo.MemberVO;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/adminRest/*")
public class MemberRestController {
	
	@Autowired
	mypageService service;
	
	@PostMapping("search")
	public Map<String, Object> search(@RequestBody MemberVO vo){
		Map<String, Object> map = new HashMap<String, Object>();
		List<MemberVO> list = service.getMemberSearch(vo);
		map.put("list", list);
		return map;
		
	}
}
