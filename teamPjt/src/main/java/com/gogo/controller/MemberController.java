package com.gogo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gogo.service.MemberService;
import com.gogo.vo.MemberRoleVO;
import com.gogo.vo.MemberVO;


@Controller
public class MemberController extends CommonRestController {

    @Autowired
    private MemberService memberService;


    // 로그인 페이지 이동
	@GetMapping("/login/login")
	public String login() {
		return "/login/login";
	}
	
	// 로그아웃 페이지 이동
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		// 현재 세션 무효화하여 로그아웃처리
		session.invalidate();
		return "/login/login";
	}
	
	// JSON 형식 데이터 교환
	@PostMapping("/login/loginAction")
	public @ResponseBody Map<String, Object> loginAction(
										@RequestBody MemberVO member
										, Model model
										, HttpSession session) {
		System.out.println("id : " + member.getMemberId());
		System.out.println("pw : " + member.getPw());
		
		MemberVO membervo = memberService.loginAction(member);
		
		if(membervo != null) {
			
			session.setAttribute("member", membervo);
			session.setAttribute("memberId", membervo.getMemberId());
			session.setAttribute("role_id", membervo.getRole());
			
			Map<String, Object> map = responseMap(REST_SUCCESS, "환영합니다.");
			
			// SNS 로그인 체크 로직		
			if("Y".equals(member.getSnsCk())) {
				map.put("msg", "네이버 로그인 성공!");
			}
			// 권한 확인
			if(member.getRole() != null && member.getRole().contains("ADMIN_ROLE")) {
				// 관리자 로그인 -> 관리자 페이지로 이동
				map.put("url", "/admin/stayadmin");
			} else if(member.getRole() != null && member.getRole().contains("HOST_ROLE")){
				map.put("url", "host/stayhost");
			} else {
				map.put("url", "/main");
			}
				return map;
		
		} else {
	        // 로그인 실패 처리  
	        Map<String, Object> map = responseMap(REST_FAIL, "아이디와 비밀번호를 확인해주세요.");
	        return map;
	    }
		
	}


	// 회원가입 페이지 이동
	@GetMapping("/login/signup")
	public String signup(HttpSession session) {
		// 세션에 member라는 이름으로 "signup"을 저장 
		//session.setAttribute("member", "signup");
		return "/login/signup";
	}
	
	// 회원가입 
    @PostMapping("/login/signupAction")
    public String signupAction(@ModelAttribute MemberVO member,
    		@RequestParam("hostyn") String hostyn ,Model model,RedirectAttributes redirectAttributes) {
        try {
            int res = memberService.signupAction(member);

            if (res > 0) {
			   
            	// role_id 설정
	            String role_id = "user";
	            
	            if ("y".equals(hostyn)) {
	            	role_id = "host";
	            }
	            // 회원 역할 정보 저장
	            MemberRoleVO role = new MemberRoleVO();
	            
	            role.setRole_id(role_id);
	            
	            System.out.println("member:"+member);
	            
	            // 매개변수 받기
	            memberService.insertMemberRole(member.getMemberId(), role_id);
	            
	            // 알림창
	            redirectAttributes.addFlashAttribute("msg", "환영합니다. 회원가입되었습니다.");
                
			   // 메일 전송
			   memberService.sendEmail(member,"signupAction");
	            
            } else {
            	redirectAttributes.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "회원가입 중 예외사항이 발생하였습니다.");
        }
        	return "redirect:/login/login"; 
    }

	// 아이디 중복확인 요청
	@PostMapping("/idCheck")
	public @ResponseBody Map<String, Object> idCheck(@RequestBody MemberVO member){
		
		int res = memberService.idCheck(member);
		
		if(res == 0) {
			// count = 1이면 fail(회원가입 불가)
			return responseMap(REST_SUCCESS,"사용 가능한 아이디 입니다.");
		}else {
			return responseMap(REST_FAIL,"이미 사용중인 아이디 입니다.");	
		}
	}
	
	// 아이디 찾기 페이지 이동
	@GetMapping("/login/findId")
	public String findId(HttpServletRequest request, Model model, MemberVO member) {
		return "/login/findId";
	}

	// 아이디 찾기
	@RequestMapping(value = "/login/findIdAction", method = RequestMethod.POST)
	public String findIdAction(HttpServletRequest request, Model model,
			@RequestParam(required = true, value = "memberName") String memberName, 
		    @RequestParam(required = true, value = "memberEmail") String memberEmail,
			@ModelAttribute MemberVO member) {
		try {
			member.setMemberName(memberName);
			member.setMemberEmail(memberEmail);
		    
			// 회원정보 검색
			List<MemberVO> memberId = memberService.findIdAction(member);
			
		    model.addAttribute("memberId", memberId);
		    
		} catch (Exception e) {
		    System.out.println(e.toString());
		    model.addAttribute("msg", "오류가 발생되었습니다.");
		}
	    return "/login/findIdAction";
	}
	
	// 비밀번호 찾기 페이지 이동
	@GetMapping("/login/findPw")
	public String findPw() {
		return "/login/findPw";
	}
	
	// 비밀번호 암호화
	private String encryptPassword(String newPwd) {
	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	    return passwordEncoder.encode(newPwd);
	}
	
	// 비밀번호 찾기
	 @RequestMapping(value = "/login/findPwAction", method = RequestMethod.POST)
	    public String findPwAction(HttpServletRequest request, Model model,
				@RequestParam(required = true, value = "memberId") String memberId, 
			    @RequestParam(required = true, value = "memberName") String memberName,
			    @RequestParam(required = true, value = "memberEmail") String memberEmail,
				@ModelAttribute MemberVO member) {
		 
		 try {
			    
			 member.setMemberId(memberId);
			 member.setMemberName(memberName);
			 member.setMemberEmail(memberEmail);
			 
			    int memberSearch = memberService.findPwAction(member);
			    
			    if(memberSearch == 0) {
			        model.addAttribute("msg", "기입된 정보가 잘못되었습니다. 다시 입력해주세요.");
			        return "/login/findPw";
			    }
			    // randomAlphanumeric : 새로운 패스워드 생성
			    String newPwd = RandomStringUtils.randomAlphanumeric(10);
			    // 암호화
			    String enpassword = encryptPassword(newPwd);
			    
			    // 암호화된 패스워드 생성
			    member.setPw(enpassword);
			    
			    // 비밀번호 업데이트
			    memberService.passwordUpdate(member);
			    
			    // 암호화 전 패스워드 생성
			    member.setPw(newPwd);
			    
			    //메일 전송
			    memberService.sendEmail(member,"findPwAction");
			    
			    model.addAttribute("newPwd", newPwd);
			 
			} catch (Exception e) {
			    System.out.println(e.toString());
			    model.addAttribute("msg", "오류가 발생되었습니다.");
			}
			return "/login/findPwAction";
	    }
	

	//네이버 로그인
	@GetMapping("naverAction")
	public String naverAction() {
		return "/login/naverAction";
	}
	
	@PostMapping("naverSave")
	@Transactional
	public @ResponseBody Map<String, Object> naverSave(MemberVO member
										, HttpSession session
										, Model model
										, RedirectAttributes rttr) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
	    System.out.println("#############################################");
	    System.out.println(member.getMemberId());
	    System.out.println(member.getMemberName());
	    System.out.println(member.getBirthday());
	    System.out.println(member.getProfile());
	    System.out.println(member.getGender());
	    System.out.println(member.getMemberEmail());
	    System.out.println(member.getSnsCk());
	    System.out.println("#############################################");
	    
	    // 네이버는 정확한 연령 데이터를 주지 않는다
	    // 네이버 로그인은 모두 0000년생으로 설정
	    String birthday = member.getBirthday();
	    String month = birthday.substring(0, 2);
	    String days = birthday.substring(3);
	    member.setBirthday("00"+month+days);
	    
	    
	    int idCheck = memberService.idCheck(member);
	    if(idCheck==0) {
	    	
	    	// 네이버 회원가입의 경우 비밀번호 랜덤
	    	String naverPW = UUID.randomUUID().toString();
	    	member.setPw(naverPW);

	    	int res = memberService.signupAction(member);
	    	
	    	if(res>0) {
	    		memberService.insertMemberRole(member.getMemberId(), "user");
	    		memberService.updateNaver(member);
	    		result.put("msg", "네이버 회원가입 성공");
	    		loginAction(member, model, session);
	    	} else {
	    		result.put("msg", "네이버 회원가입 실패");
	    		
	    	}
	    	
	    } else {
	    	// 이미 회원가입 되어 있는 네이버 로그인의 경우 비밀번호를 가져와 세팅
	    	String naverPW = memberService.getPw(member);
	    	member.setPw(naverPW);
	    	Map<String, Object> map = loginAction(member, model, session);	
	    	if("success".equals(map.get("result"))) {
	    		result.put("result", "ok");
	    	} else {
	    		result.put("result", "ok");
	    	}
	    }
	    
	    return result;
	}
	
		
	// 카카오톡 로그인 연동 (인가코드 발급)
	@RequestMapping(value = "/login/kakaoActionUrl")
	public @ResponseBody String kakaoAction(
	        HttpServletRequest request) throws Exception {
	    System.out.println("--------- 카카오연동 들어옴 ---------");
	
	    String reqUrl =
	            "https://kauth.kakao.com/oauth/authorize"
	                    + "?client_id=7801f55d59a73a55013d6f22a1a3e9a1"
	                    + "&redirect_uri=http://localhost:8080/login/kakaoAction"
	                    + "&response_type=code";
	    
	    System.out.println("reqUrl : "+reqUrl);
	
	    return reqUrl;
	}
	
	// 카카오 연동정보 조회 + DB에 회원 정보넣기
	@RequestMapping(value = "/login/kakaoAction")
	public String oauthKakao(
	        @RequestParam(value = "code", required = false) String code
	        , HttpServletRequest req, Model model, HttpSession session, RedirectAttributes redirectAttributes) throws Throwable {
	
		System.out.println("--------- 카카오 정보조회 들어옴 ---------");
	
	    // 발급받은 인가코드(reqUrl)를 통해 토큰 발급받기
	    System.out.println("####code##### :" + code);   
	    String access_Token = memberService.getAccessToken(code);    // 인가코드를 통해 토큰발급
	    System.out.println("###access_Token#### : " + access_Token);    // 확인용 토큰 출력
	
	
	    // 토큰을 이용해 회원 정보 가져오기
	    HashMap<String, Object> userInfo = memberService.getUserInfo(access_Token);
	
	
	     // 가져온 회원 정보 DB에 넣어 회원가입 시키기
	     MemberVO member = new MemberVO();
	        
		 // userInfo에서 필요한 정보를 추출하여 MemberVO에 설정
	     member.setMemberName((String) userInfo.get("nickname"));
	     member.setMemberId((String) userInfo.get("id"));
	     member.setMemberEmail((String) userInfo.get("account_email"));
	     member.setAge_group((String) userInfo.get("age_range"));
	     member.setProfile((String) userInfo.get("profile_image"));
	     
	     // female에서 f만 출력
	     String originalgender = (String) userInfo.get("gender");
	     String gender = originalgender.substring(0, 1);
	     
	     if(gender.equals("f")) {
	    	 gender = "F";
	     }else if(gender.equals("m")){
	    	 gender = "M";
	     } 
	     member.setGender(gender);
	     
	     String birthday = (String)userInfo.get("birthday");
	     String month = birthday.substring(0,2);
	     String days = birthday.substring(2);
	     member.setBirthday("00"+month+days);
		
	    
		System.out.println("----- access_Token ----- : " + access_Token);
		System.out.println("------- id ------- : " + userInfo.get("id"));    
		System.out.println("------- nickname ------- : " + userInfo.get("nickname"));    
		System.out.println("----- account_email ---- : " + userInfo.get("account_email"));    
		System.out.println("-------- gender -------- : " + userInfo.get("gender")); 
		System.out.println("------ age_range ------- : " + userInfo.get("age_range")); 
		System.out.println("------- birthday ------- : " + userInfo.get("birthday")); 
		System.out.println("------- profile_image ------- : " + userInfo.get("profile_image")); 
	
	    
	    // 만약 DB에 해당 회원의 ID가 없다면 회원가입 시키기
	    int idCheck = memberService.idCheck(member);
	    
	    if(idCheck==0) {
	    	
	    	// 비밀번호 랜덤
	    	String kakaoPW = UUID.randomUUID().toString();
	    	member.setPw(kakaoPW);
	
	    	int res = memberService.signupAction(member);
	    	
	    	if(res>0) {
	            // 카카오 로그인 성공 시 snsYN을 "Y"로 설정
	            member.setSnsCk("Y");
	            memberService.insertMemberRole(member.getMemberId(), "user");
	    		memberService.updateKakao(member);
	    		userInfo.put("msg", "카카오 회원가입 성공");
	    		loginAction(member, model, session);
	    		redirectAttributes.addFlashAttribute("msg", "환영합니다.");
	    		
	    	} else {
	    		userInfo.put("msg", "카카오 회원가입 실패");
	    		
	    	}
	    	
	    } else {
	    	// 이미 회원가입 되어 있는 네이버 로그인의 경우 비밀번호를 가져와 세팅
	    	String kakaoPW = memberService.getPw(member);
	    	
	    	member.setPw(kakaoPW);
	    	Map<String, Object> map = loginAction(member, model, session);	
	    	
	    	if("success".equals(map.get("result"))) {
	    		userInfo.put("result", "ok");
	    	} else {
	    		userInfo.put("result", "ok");
	    	}
	    }
	    return "redirect:/main"; 
	
	}
}
