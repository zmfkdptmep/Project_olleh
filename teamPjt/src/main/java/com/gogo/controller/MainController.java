package com.gogo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gogo.service.MainService;
import com.gogo.service.StayService;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomOptionVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@Autowired
	StayService stayService;
	
	@GetMapping("/main")
	public void getMain(Model model, HttpSession session) {
		mainService.getMainList(model);
		mainService.getPopStayList(model);
		StayVO vo = new StayVO();
		
		String memberId = (String)session.getAttribute("memberId");
		System.out.println("mainController memberId : " + memberId);
		if(memberId != null && !memberId.equals("")) {
			vo.setMemberId(memberId);
			stayService.likeId(vo, model);
		}
	}
	
	// 임시 매핑용
	@GetMapping("/addstay")
	public String addStay(HttpSession session, Model model, RedirectAttributes rttr) {
		String memberId = (String)(session.getAttribute("memberId"));
		String stayNo = mainService.getStayNo(memberId, model);
		if(stayNo != null && !stayNo.contentEquals("")){
			rttr.addFlashAttribute("msg", "이미 등록된 스테이가 있습니다.<br>한 명의 호스트는<br>하나의 스테만 등록할 수 있습니다.");
			return "redirect:/member/host/guide";
		}
		return "/stay/addstay";
	}

	// 임시
	@PostMapping("/addStayAction")
	public String addStayAction(StayVO vo, List<MultipartFile> files, RedirectAttributes rttr) {
		
		int res = mainService.insertStay(vo, files);
		if(res > 0) {
			rttr.addFlashAttribute("msg", "숙소 등록 완료");
		}else {
			rttr.addFlashAttribute("msg", "숙소 등록 실패");
		}
		
		return "redirect:/member/host/stayhost";
	}
	
	// 임시 매핑용
	@GetMapping("/addroom")
	public String addRoom(HttpSession session, Model model) {
		
		String memberId = (String)(session.getAttribute("memberId"));
		mainService.getStayNo(memberId, model);
		System.out.println("memberId : " + memberId);
		
		return "/stay/addroom";
	}

	@PostMapping("/addRoomAction")
	public String addRoomAction(RoomVO roomVO
						, RoomOptionVO optionVO
						// roomVO에 stayNo가 있음, 수정 TODO
						, String stayNo
						, List<MultipartFile> files
						, RedirectAttributes rttr) {
		
		int res = mainService.insertRoom(roomVO, optionVO, files, stayNo);
		if(res > 0) {
			rttr.addFlashAttribute("msg", "room 등록 완료");
		}else {
			rttr.addFlashAttribute("msg", "room 등록 실패");
		}
		return "redirect:/member/host/stayhost";
	}
	
	// 임시 매핑용
	@GetMapping("/editstay")
	public String editStay(StayVO vo, Model model) {
		
		mainService.getStay(vo, model);
		
		return "stay/editstay";
	}
	
	@PostMapping("/editStayAction")
	public String editStayAction(StayVO vo, List<MultipartFile> files
								,RedirectAttributes rttr, Model model) {

		int res = mainService.updateStay(vo, files);
		
		if(res > 0) {
			rttr.addFlashAttribute("msg", "수정 완료");
		}else {
			rttr.addFlashAttribute("msg", "수정 실패");
		}
		
				// 마이페이지로 포워드
		return "redirect:/member/host/stayhost";
	}

	// 임시 매핑용
	@GetMapping("/editroom")
	public String editRoom(RoomVO vo, Model model) {
		
		mainService.getRoom(vo, model);
		
		return "stay/editroom";
	}

	// 임시 매핑용
	@PostMapping("/editRoomAction")
	public String editRoomAction(RoomVO vo
									, RoomOptionVO optionVO
									, List<MultipartFile> files
									, Model model
									, RedirectAttributes rttr) {
		
		int res = mainService.updateRoom(vo, optionVO, files);
		
		if(res > 0) {
			rttr.addFlashAttribute("msg", "수정 완료");
		}else {
			rttr.addFlashAttribute("msg", "수정 실패");
		}
		
		return "redirect:/member/host/stayhost";
	}
	
	@GetMapping("/joosoSearch")
	public String joosoSearch() {
		return "stay/joosoSearch";
	}
	
	@GetMapping("/fileupload")
	public String fileupload() {
		
		return "/fileupload";
	}
	
	// fileupload test용
//	@PostMapping("/fileuploadAction")
//	public String fileuploadAction(List<MultipartFile> files, FileuploadVO vo) {
//		
//		int res = mainService.roomFileupload(files, vo);
//		System.out.println("maincontroller : " + res);
//		return "/fileupload";
//	}

}
