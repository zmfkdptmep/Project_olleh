package com.gogo.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gogo.mapper.FileuploadMapper;
import com.gogo.mapper.mypageMapper;
import com.gogo.vo.AnswerVO;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.MemberVO;
import com.gogo.vo.PaymentVO;
import com.gogo.vo.QuestionVO;
import com.gogo.vo.ReservedVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class mypageServiceImpl extends myPageUploadPath implements mypageService {
	
	private static final String uploadDir = DIR;
	
	@Autowired
	mypageMapper mypageMapper;
	
	@Autowired
	ReservedService service_r;
	
	@Autowired
	PaymentService service_p;
	
	@Autowired
	MemberService service_m;
	
	@Autowired
	FileuploadService fileuploadService;
	
	// ▶▶▶  admin ▶▶▶
	// 숙소 조회
	@Override
		public List<StayVO> getList(Model model) {
			List<StayVO> list = mypageMapper.getList();
			log.info("===========");
			log.info("list : " + list);
			model.addAttribute("list", list);
			return null;
			
		}
	
	
	@Override
	public int deleteStay(String[] idArr) {
		System.out.println(idArr[0]);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("idArr", idArr);
		return mypageMapper.deleteStay(paramMap);
	}
	
	
	// 회원 조회
	@Override
	public List<MemberVO> getMember(Model model) {
		List<MemberVO> member = mypageMapper.getMember();
		log.info("==============");
		log.info("member : " + member);
		model.addAttribute("member", member);
		
		return null;
	}
	
	// 회원 조회
	@Override
	public List<MemberVO> getMemberSearch(MemberVO vo) {
		return mypageMapper.getMemberSearch(vo);
	}
	
	
	@Override
	public int deleteArr(String[] idArr) {
		System.out.println(idArr[0]);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("idArr", idArr);
		return mypageMapper.deleteArr(paramMap);
	}
	
	
	@Override
	public int answering(AnswerVO vo) {
		return mypageMapper.answering(vo);
	}
	
	
	@Override
	public AnswerVO answerInfo(int queNo) {
		AnswerVO answer = mypageMapper.answerInfo(queNo);
		return answer;
	}
	
	
	@Override
	public List<MemberVO> chartAge(MemberVO vo) {
		List<MemberVO> member = mypageMapper.chartAge(vo);
		return member;
	}
	
	@Override
	public List<MemberVO> chartGender(MemberVO vo) {
		List<MemberVO> gender = mypageMapper.chartGender(vo);
		log.info("========= gender : " + gender);
		return gender;
	}
	
	
	
	// ▶▶▶  host ▶▶▶
	// 숙소 관리
	@Override
	public List<StayVO> getStay(Model model) {
		List<StayVO> list = mypageMapper.getStay();
		log.info("===========");
		log.info("list : " + list);
		model.addAttribute("list", list);
		return null;
	}
	
	// 숙소 관리 - 객실 관리
	@Override
	public List<RoomVO> roomInfo(String memberId, Model model) {
		List<RoomVO> room = mypageMapper.getRoomArr(memberId);
		for(RoomVO vo : room) {
			vo.setRoomPhoto(mypageMapper.getRoomFirstPic(vo.getRoomNo()));
			System.out.println(vo.getRoomPhoto());
		}
		model.addAttribute("room", room);
		return null;
	}
	
	@Override
	public int deleteRoom(String roomNo) {
		return mypageMapper.deleteRoom(roomNo);
	}
	
	@Override
	public List<Map<String, String>> reservinfo(@Param("memberId") String memberId, @Param("roomNo") int roomNo, Model model) {
		List<Map<String, String>> list = mypageMapper.reservinfo(memberId, roomNo);
		log.info("===========");
		log.info("list : " + list);
		model.addAttribute("list", list);
		model.addAttribute("paramRoomNo", roomNo);
		return null;
	}
	
	
	@Override
	public List<Map<String, String>> reservpic(Model model) {
		List<Map<String, String>> pic = mypageMapper.reservpic();
		log.info("===========");
		log.info("pic : " + pic);
		model.addAttribute("pic", pic);
		return null;
	}
	
	@Override
	public List<RoomVO> selectRoomName(String memberId, Model model) {
		List<RoomVO> name = mypageMapper.selectRoomName(memberId);
		model.addAttribute("name", name);
		return null;
	}
	
	
	@Override
	public List<ReservedVO> profit(String memberId) {
		List<ReservedVO> profit = mypageMapper.profit(memberId);
		return profit;
	}
	
	@Override
	public int insert(QuestionVO qa) {
		return mypageMapper.insert(qa);
	}
	
	
	@Override
	public List<QuestionVO> qaList(Model model, QuestionVO vo) {
		List<QuestionVO> question = mypageMapper.qaList();
		
		int queNo = 0;
		
		for(QuestionVO que : question) {
			queNo = que.getQueNo();
			AnswerVO answer = answerInfo(queNo);
			
			if(answer != null) {
				que.setAnswerYN("Y");
			}
		}
		
		model.addAttribute("list", question);
		return null;
	}
	
	
	@Override
	public QuestionVO getOne(int queNo) {
		QuestionVO que = mypageMapper.getOne(queNo);
		return que;
	}
	
	
	
	// ▶▶▶  user ▶▶▶
	// 예약 정보
	@Override
	public List<Map<String, String>> reservList(Model model, String memberId, String pageNo) {
		List<Map<String, String>> list = mypageMapper.reservList(memberId, pageNo);
		
		list.forEach(map->{
			String day = service_r.reservedDay2(map.get("CHECKIN"), map.get("CHECKOUT"));
			int dayInteger = Integer.parseInt(day);
			int priceInteger = Integer.parseInt(String.valueOf(map.get("PRICE")));
			int res = dayInteger * priceInteger;
			
			map.put("amount", service_r.comma(res));
		});
		
		int a = reservListCount(memberId);
		int pageEnd = (int)Math.ceil((double)a/(double)5);
		
		log.info("===========");
		log.info("list : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageEnd", pageEnd);
		return null;
	}
	
	@Override
	public int reservListCount(String memberId) {
		return mypageMapper.reservListCount(memberId);
	}
	
	// 이용완료 
	@Override
	public List<Map<String, String>> completedList(Model model, String memberId) {
		List<Map<String, String>> complete = mypageMapper.completedList(memberId);
		model.addAttribute("complete", complete);
		log.info("-=====");
		log.info("complete : " + complete);
		return null;
	}
	
	
	// 취소 정보
	@Override
	public List<Map<String, String>> cancelList(Model model, String memberId, String pageNo) {
		List<Map<String, String>> list = mypageMapper.cancelList(memberId, pageNo);
		
		list.forEach(map->{
			String day = service_r.reservedDay2(map.get("CHECKIN"), map.get("CHECKOUT"));
			int dayInteger = Integer.parseInt(day);
			int priceInteger = Integer.parseInt(String.valueOf(map.get("PRICE")));
			int res = dayInteger * priceInteger;
			
			map.put("amount", service_r.comma(res));
		});

		
		
		int a = cancleListCount(memberId);
		int pageEnd = (int)Math.ceil((double)a/(double)5);
		
		log.info("===========");
		log.info("list : " + list);
		model.addAttribute("list", list);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageEnd", pageEnd);
		return null;

	}
	
	@Override
	public int cancleListCount(String memberId) {
		return mypageMapper.cancleListCount(memberId);
	}
	
	
	// 회원정보 조회
	@Override
	public List<MemberVO> mem(Model model) {
		List<MemberVO> mem = mypageMapper.mem();
		log.info("===========");
		log.info("mem : " + mem);
		model.addAttribute("mem", mem);
		
		return null;
	}
	
	
	// 회원 정보 수정
	@Override
	@Transactional
	public int update(MemberVO vo, List<MultipartFile> files) {
		int res =  mypageMapper.update(vo);
		System.out.println("vo : " + vo);
		System.out.println("update res : " + res);
		
		int deleteRes = mypageMapper.deleteProfile(vo.getMemberId());  // 프로필 삭제
		System.out.println("deleteRes :" + deleteRes);
		
			FileuploadVO fileuploadVO = new FileuploadVO();
			fileuploadVO.setRoomNo("");
			fileuploadVO.setStayNo("");
			fileuploadVO.setMemberId(vo.getMemberId());
			String dir = "profile\\";
			String uploadPath = fileuploadService.fileuploadMainPic(files, dir, fileuploadVO);
			System.out.println("uploadPath : " + uploadPath);
			//res = mypageMapper.insertProfile(uploadPath, vo.getMemberId());
		return res;
	}
	
	
	@Override
	public FileuploadVO selectProfile(String memberId) {
		return mypageMapper.selectProfile(memberId);
	}
	
	// 회원 탈퇴
	@Override
	public int memberQuit(String memberId) {
		return mypageMapper.memberQuit(memberId);
	}
	
	
	// 예약 상세보기
	@Override
	public void reservation_detail(@RequestParam("checkIn") String checkIn
									, @RequestParam("checkOut") String checkOut
									, @RequestParam("price") String price
									, @RequestParam("stayNo") String stayNo
									, @RequestParam("reservationNo") String reservationNo
									, Model model) {
		// 총 몇 일인지 반환
		String day = service_r.reservedDay2(checkIn, checkOut);
		// 가격에 세자리 콤마를 찍어서 반환
		String dayPrice = service_r.comma(price);
		int a = Integer.parseInt(day);
		int b = Integer.parseInt(price);
		String allPrice = service_r.comma(a*b);
		int allPriceInteger = a*b;
		
		
		// stay 정보
		StayVO stay = service_r.selectOne_stay(stayNo);
		// reservation 정보
		ReservedVO reserved = service_r.selectOne_reservation(reservationNo);
		// room 정보
		RoomVO room = service_r.selectOne_room(reserved.getRoomNo());
		// payment 정보
		PaymentVO payment = service_p.selectOne_payment_reservationNo(reserved.getReservationNo());
		
		
		model.addAttribute("talk", reserved.getTalk());
		model.addAttribute("impUid", payment.getImpUid());
		model.addAttribute("stayAddress", stay.getStayAdress());
		model.addAttribute("allPrice", allPrice);
		model.addAttribute("allPriceInteger", allPriceInteger);
		model.addAttribute("dayPrice", dayPrice);
		model.addAttribute("day", day);
		model.addAttribute("roomName", room.getRoomName());
		model.addAttribute("checkIn", reserved.getCheckIn());
		model.addAttribute("checkOut", reserved.getCheckOut());
		model.addAttribute("paymentMethod", payment.getPaymentMethod());
		model.addAttribute("paymentRegDate", payment.getRegDate());
		model.addAttribute("mainImg", stay.getMainPic1());
		model.addAttribute("memberCount", reserved.getMemberCount());
		model.addAttribute("stayName", stay.getStayName());

	}
	
	
	// 관심스테이
	@Override
	public List<Map<String, String>> likestay(String memberId, Model model) {
		List<Map<String, String>> like = mypageMapper.likestay(memberId);
		log.info("===========");
		log.info("like : " + like);
		model.addAttribute("like", like);
		return null;
	}
	
	
	@Override
	public int travelCnt(String memberId) {
		//log.info("memberId : " + memberId);
		return mypageMapper.travelCnt(memberId);
	}
	
//	@Override
//	public int updateMember(MemberVO member, MultipartFile file, HttpSession session) {
//		
//		MemberVO vo = null;
//		
//		// 파일 랜덤 이름 짓기
//		LocalTime how = LocalTime.now();
//		String hour = String.valueOf(how.getHour());
//		String minutes = String.valueOf(how.getMinute());
//		String second = String.valueOf(how.getSecond());
//		String now = hour+minutes+second;
//		
//		
//		String ofile = file.getOriginalFilename();
//		String ext = ofile.substring(ofile.lastIndexOf("."),ofile.length());
//		
//		String saveName = ofile.substring(0,ofile.lastIndexOf("."));
//		String save = saveName+now+ext;
//		// 파일 랜덤 이름 짓기 끝
//		
//		
//		
//		Path copyOfLocation = Paths.get(uploadDir + File.separator + StringUtils.cleanPath(save));
//		
//		
//		try {
//	    Files.copy(file.getInputStream(), copyOfLocation, StandardCopyOption.REPLACE_EXISTING);
//	    
//	    // 바뀐 프사로 세션에 다시 등록
//	    MemberVO original = service_m.selectOne(member);
//	    original.setProfile(save);
//	    session.setAttribute("member", original);
//	    
//	    vo = new MemberVO();
//	    vo.setMemberId(member.getMemberId());
//	    vo.setProfile(save);
//	    vo.setPw(member.getPw());
//	    vo.setMemberEmail(member.getMemberEmail());
//	    
//	    // email, pw, memberId, profile 필요
//	    
//		} catch(IOException e){
//			e.printStackTrace();
//		}
//		// 파일 업로드 끝
//		
//		
//		int res = mypageMapper.update(vo);
//		
//		if(res>0) {
//			return res;
//		} else {
//			return 0;
//		}
//		
//	}


	
	
}

