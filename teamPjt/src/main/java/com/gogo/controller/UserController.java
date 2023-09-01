package com.gogo.controller;



import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gogo.service.MessageService;
import com.gogo.service.ReservedService;
import com.gogo.service.mypageService;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.MemberVO;
import com.gogo.vo.ReservedVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/mypage/*")
public class UserController extends CommonRestController{
	
	@Autowired
	mypageService service;
	
	@Autowired
	ReservedService service_r;
	
	@Autowired
	MessageService service_msg;
	
	
	// 예약 정보
	@GetMapping(value = {"reservation", "travelCnt", "completedList"})
	public void reservation(Model model, HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo) {
		
		
		HttpSession session = request.getSession();  
		String memberId = (String)session.getAttribute("memberId");
		service.reservList(model, memberId, pageNo);  // 예약 
		int res = service.travelCnt(memberId);
		model.addAttribute("travelCnt", res);  // 횟수
		
		service.completedList(model, memberId);
		
	}
	
	
	// 취소 내역
	@GetMapping(value = {"cancel", "travelCnt"})
	public void cancel(Model model, HttpServletRequest request, @RequestParam(defaultValue="1")String pageNo) {
		
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		service.cancelList(model, memberId, pageNo);
		int res = service.travelCnt(memberId);
		model.addAttribute("travelCnt", res);
	}
	
	// 관심 스테이
	@GetMapping(value = {"likestay", "travelCnt"})
	public void likestay(String memberid, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String memberId = (String)session.getAttribute("memberId");
		service.likestay(memberId, model);
		int res = service.travelCnt(memberId);
		model.addAttribute("travelCnt", res);
	}
	
	// 회원 정보 조회
	@GetMapping(value = {"info", "travelCnt", "selectProfile"})
	public void info(Model model, HttpServletRequest request) {
		// 회원 정보
		service.mem(model);
		
		// 회원 id 여행 횟수
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		int res = service.travelCnt(memberId);
		model.addAttribute("travelCnt", res);
		
		// 회원 프로필사진
		FileuploadVO file = service.selectProfile(memberId);
		log.info("file" + file);
		model.addAttribute("file", file);
	}
	
	
	@PostMapping("infoFrm")
	public String infoFrm(RedirectAttributes rttr, MemberVO vo, List<MultipartFile> files) {
		
		try {
			int res = service.update(vo, files);
			System.out.println("Frm files" + files);
			System.out.println("res : " + res);
			
			
			if(res>0) {
				rttr.addFlashAttribute("msg", "회원 정보 수정 성공!");
				return "redirect:/member/mypage/info";
				
			} else {
				rttr.addFlashAttribute("msg", "회원 정보 수정 실패");
				return "redirect:/member/mypage/info";

			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addAttribute("msg", "실패");
		return "redirect:/member/mypage/info";
	}
	
	// 회원 탈퇴
	@PostMapping("memberQuit")
	public String memberQuit(String memberId, RedirectAttributes rttr) {
		
		int res;
		
		String msg = "";
		res = service.memberQuit(memberId);
		
		if(res > 0) {
			msg="회원 탈퇴 되었습니다";
			rttr.addFlashAttribute("msg", msg);  
			return "redirect:/main";
		} else {
			msg="회원 탈퇴 중 오류가 발생하였습니다";
			rttr.addFlashAttribute("msg", msg);  
			return "redirect:/member/mypage/info";
		}
		
		
		
	}
		
	// 메세지 연결
	@GetMapping("message")
	public void message(HttpSession session
						, Model model
						, @RequestParam(required=false, name="pageNo", defaultValue = "1")
													int pageNo) {
		
		
		
		String memberId = (String)session.getAttribute("memberId");
		
		System.err.println("message memberId : "+memberId);
		
		service_msg.messageRoomListUser(memberId, model, pageNo);
		
		
	}
	
	
	// 예약 상세 확인
	@GetMapping("reserved_detail")
	public void reserved_detail(@RequestParam("checkIn") String checkIn
								, @RequestParam("checkOut") String checkOut
								, @RequestParam("price") String price
								, @RequestParam("stayNo") String stayNo
								, @RequestParam("reservationNo") String reservationNo
								, Model model, HttpServletRequest request) {
		
		service.reservation_detail(checkIn, checkOut, price, stayNo, reservationNo, model);
		
		
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		int res = service.travelCnt(memberId);
		model.addAttribute("travelCnt", res);
		
	}
	
	
	@GetMapping("/display")
	// 이미지를 화면에 보여줍니다
	public ResponseEntity<byte[]> display(String fileName) {
		log.info("=====fileName : " + fileName);
		String ATTACHES_DIR = dirPath;
		try {
			// 파일 객체를 생성
			File file = new File(ATTACHES_DIR+fileName);
			HttpHeaders headers = new HttpHeaders();
			
			// 이미지 파일이 존재하면 파일을 이미지를 다운로드
			if(file.exists()) {
				// Mime타입을 설정
				headers.add("Content-Type",Files.probeContentType(file.toPath()));
				return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			}else {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
		} catch (IOException e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}	
}
