package com.gogo.service;



import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gogo.mapper.MemberMapper;
import com.gogo.mapper.mypageMapper;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.MemberVO;


@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper memberMapper;

	@Autowired
	BCryptPasswordEncoder encoder;
	
	@Autowired
	mypageMapper mypageMapper; 
	
	@Override
	public MemberVO loginAction(MemberVO paramMember) {
		// 사용자 정보 조회
		MemberVO member = memberMapper.loginAction(paramMember);
		
		if(member != null) {
			
			if(member.getPw().contentEquals(paramMember.getPw())) {
				member.setRole(memberMapper.getMemberRole(member.getMemberId()));
				FileuploadVO fileVO = mypageMapper.selectProfile(member.getMemberId());
				if(fileVO != null) {
					System.out.println(fileVO.getProfile());
					member.setProfile(fileVO.getProfile());
				}
				return member;
			}
			
			// 사용자가 입력한 비밀번호가 일치하는지 확인
			// 사용자가 입력한 비밀번호, 데이터베이스에 암호화되어 저장된 비밀번호
			boolean res = 
					encoder.matches(paramMember.getPw(), member.getPw());
			
			// 비밀번호 인증이 성공하면 member객체를 반환
			if(res) {
				// 사용자 권한을 조회
				member.setRole(memberMapper.getMemberRole(member.getMemberId()));
				FileuploadVO fileVO = mypageMapper.selectProfile(member.getMemberId());
				if(fileVO != null) {
					System.out.println(fileVO.getProfile());
					member.setProfile(fileVO.getProfile());
				}
				return member;
			}
//			return memberMapper.loginAction(member);
		}
        // 로그인 실패
        return null;
	}
	@Override
	public int signupAction(MemberVO member) {
		
		// 암호화된 비번을 다시 비번에 넣어줌
		member.setPw(encoder.encode(member.getPw()));
		
		System.out.println("pw : "+ member.getPw());
		// Mapper의 쿼리 호출
		return memberMapper.signupAction(member);
	}

	@Override
	public int idCheck(MemberVO member) {
		return memberMapper.idCheck(member);
	}
	
	@Override
	public void insertMemberRole(String memberId, String role_id) {
	    // 회원 역할 정보 저장 로직
	    memberMapper.insertMemberRole(memberId, role_id);
	}
	
	@Override
	public int updateNaver(MemberVO member) {
		return memberMapper.updateNaver(member);
	}
	@Override
	public String getPw(MemberVO member) {
		return memberMapper.getPw(member);
	}
	@Override
	public MemberVO selectOne(MemberVO member) {
		return memberMapper.selectOne(member);
	}
	@Override
	public List<MemberVO> findIdAction(MemberVO member) {
		return memberMapper.findIdAction(member);
	}
	// 비밀번호 찾기 
	@Override
	public int findPwAction(MemberVO member) {
		return memberMapper.findPwAction(member);
	}
	@Override
	public void passwordUpdate(MemberVO member) {
		memberMapper.passwordUpdate(member);
	}
	@Override
	public List<String> getMemberRole(String memberId) {
		return memberMapper.getMemberRole(memberId);
	}
	
	
	// 이메일 발송
	@SuppressWarnings("deprecation")
	@Override
	public void sendEmail(MemberVO member, String div) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com"; 
		String hostSMTPid = "goddns815@naver.com"; // 보내는 사람 이메일 주소
		String hostSMTPpwd = "5bG-Qy3-X0E-oQp"; // 보내는 사람 이메일 비번

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "goddns815@naver.com"; // 보내는 사람 이메일주소(받는 사람 이메일에 표시됨)
		String fromName = "STAY OLLE GALLE";
		String subject = "";
		String msg = "";

		if(div.equals("findPwAction")) {
			subject = "스테이 올래갈래 임시 비밀번호 입니다.";
			msg += "<div style=\"text-align: center; width: 470px; height: 850px; line-height: 70px;\">";
			msg += "<img src=\"https://i.ibb.co/M7mS3X2/stay2.png\" alt=\"Facebook Logo\" height=\"33\" style='max-width: 100%; height: auto;'>";
			msg += "<p style=\"color:#565a5c;font-size:18px;\">"+member.getMemberName()+"님, 안녕하세요.</p>";
			msg += "<p style=\"color:#565a5c;font-size:18px;\">STAY OLLAE 임시 비밀번호 입니다.</p>";
			msg += "<p style=\"color:#565a5c;font-size:18px;\">임시 비밀번호로 로그인 후 반드시 비밀번호를 수정하시길 바랍니다.</p>";
			msg += "<p style=\"color:#565a5c;font-size:32px;\">"+member.getPw()+"</p>";
			msg += " <p style=\"color:#565a5c;font-size:16px;\">\r\n" + 
					"            로그인 링크나 비밀번호 재설정을 요청하지 않은 경우 이 메시지를 무시하고 ";
			msg += "<a href=\"https://www.google.com/search?q=%EB%8B%88+%EC%95%8C%EC%95%84%EC%84%9C+%ED%95%B4%EB%9D%BC&sxsrf=AB5stBgrmFyK4Y01FqLnq9wBDtGVcOgngQ%3A1691547017698&source=hp&ei=ifXSZLnTKM3m1e8P9_6esA8&iflsig=AD69kcEAAAAAZNMDmX_RLDzcxmiHaOOB3o_gIut_TU8A&ved=0ahUKEwj5u-_Yv86AAxVNc_UHHXe_B_YQ4dUDCAs&uact=5&oq=%EB%8B%88+%EC%95%8C%EC%95%84%EC%84%9C+%ED%95%B4%EB%9D%BC&gs_lp=Egdnd3Mtd2l6IhTri4gg7JWM7JWE7IScIO2VtOudvDIFEAAYgARI3RdQAFiSF3AIeACQAQKYAYUBoAG9EaoBBDEuMTm4AQPIAQD4AQGoAgrCAgcQIxiKBRgnwgIEECMYJ8ICCxAAGIAEGLEDGIMBwgIREC4YgAQYsQMYgwEYxwEY0QPCAgsQLhiABBixAxiDAcICBxAjGOoCGCfCAgQQLhgDwgIIEAAYgAQYsQPCAg4QLhiABBixAxjHARjRA8ICCBAuGIAEGLEDwgIFEC4YgATCAggQLhiABBjUAsICCRAAGA0YExiABMICCBAAGB4YDRgTwgIKEAAYCBgeGA0YE8ICChAAGB4YDRgTGArCAgoQABgFGB4YDRgTwgIHEAAYDRiABMICCBAAGAgYHhgNwgIKEAAYBRgeGA0YD8ICBBAAGB7CAgYQABgFGB7CAggQABgFGB4YD8ICBhAAGAgYHg&sclient=gws-wiz\" style=\"color:#1b74e4;text-decoration:none;\">메시지를 받은 이유에 대해 자세히 알아보세요</a>.";
			msg += "</p>";
			msg += "<img src=\"https://static.xx.fbcdn.net/rsrc.php/v3/y3/r/Bqo9-L659wB.png\" alt=\"Facebook Logo\" height=\"26\" width='52'>";
			msg += " <p style=\"color:#abadae;font-size:11px;\">© STAY OLLAE. Meta Platforms, Inc., 1601 Willow Road, HWA YOU, CA 94025</p>";
			msg += "</div>";
		} 
		if(div.equals("signupAction")) {
			subject = "스테이 올래갈래 회원이 되신걸 환영합니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h4 style='color: green;'>";
			msg += member.getMemberName()+"님 환영합니다.</h4>";
			msg += "스테이 올래갈래와 함께 멋진 순간을 만들어봐요!<br>";
			msg += "<a href='http://localhost:8080/main'>OLLE GALLE 바로가기</a></p></div>";
		} 

		// 받는 사람 E-Mail 주소
		String mail = member.getMemberEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}
	
	// 카카오  Access token 발급
	// 화면에서 파라미터로 넘겨준 code값을 받아오고 POST로 요청을 보내서 토큰을 발급받기 
	@Override
	 public String getAccessToken(String authorize_code) {
	     System.out.println("----------------------------토큰발급---------------------------");
	     String access_Token = "";
	     String refresh_Token = "";
	     String openid = "";
	     //토큰발급 요청을 보낼 주소
	     String reqURL = "https://kauth.kakao.com/oauth/token";
	        
	        try {
	            //URL객체 생성
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            
	            // POST 요청을 위해 기본값이 false인 setDoOutput을 true로 
	            //.setDoOutput(true): URLConnection이 서버에 데이터 출력할 수 있는 지의 여부를 설정
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);
	            
	            // POST 요청에 필요한 파라미터를 스트림 통해 전송
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            
	            sb.append("grant_type=authorization_code");
	            sb.append("&client_id=7801f55d59a73a55013d6f22a1a3e9a1");
	            sb.append("&redirect_uri=http://localhost:8080/login/kakaoAction");
	            sb.append("&code=" + authorize_code);
	            sb.append("&scope=" + openid);
	            
	            bw.write(sb.toString());
	            bw.flush();
	            
	            // 결과코드 200이면 정상
	            int responseCode = conn.getResponseCode();
	            System.out.println("responseCode : " + responseCode);
	 
	            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";
	            
	            // 응답 데이터 반복문 돌려서 line에 담긴 데이터를 result로 만들기
	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            System.out.println("response body : " + result);
	            
				// JSON 데이터를 객체로 변환
				ObjectMapper objectMapper = new ObjectMapper();
				
				// JSON String -> Map
				Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
				});

				access_Token = jsonMap.get("access_token").toString();
				refresh_Token = jsonMap.get("refresh_token").toString();

				System.out.println("access_token : " + access_Token);
				System.out.println("refresh_token : " + refresh_Token);

				br.close();
				bw.close();
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	        } 
	        
	        return access_Token;
	 }
	 
	 // 카카오 Access token 보내 사용자 정보 요청 
	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> getUserInfo(String access_Token) {

	        // 요청하는 클라이언트마다 가진 정보가 다를 수 있으므로 HashMap타입으로 선언
	        HashMap<String, Object> userInfo = new HashMap<String, Object>();
	        String reqURL = "https://kapi.kakao.com/v2/user/me";
	        try {
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("GET");

	            // 요청에 필요한 Header에 포함될 내용
	            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

	            int responseCode = conn.getResponseCode();
	            System.out.println("responseCode : " + responseCode);

	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

	            String line = "";
	            String result = "";

	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            System.out.println("response body : " + result);
	            System.out.println("result type :" + result.getClass().getName());

				// JSON 데이터를 객체로 변환
				ObjectMapper objectMapper = new ObjectMapper();
				// JSON String -> Map
				Map<String, Object> jsonMap = objectMapper.readValue
						(result, new TypeReference<Map<String, Object>>() {
				});

				System.out.println(jsonMap.get("properties"));

				Map<String, Object> properties = (Map<String, Object>) jsonMap.get("properties");
				Map<String, Object> kakao_account = (Map<String, Object>) jsonMap.get("kakao_account");
				long id = (long) jsonMap.get("id");

				 System.out.println(id);
				 System.out.println(properties.get("nickname"));
				 System.out.println(kakao_account.get("email"));
			
				String memberId = Long.toString(id);
				String memberName = properties.get("nickname").toString();
				String profile = properties.get("profile_image").toString();
				String memberEmail = kakao_account.get("email").toString();
				String gender = kakao_account.get("gender").toString();
				String age_group = kakao_account.get("age_range").toString();
				String birthday = kakao_account.get("birthday").toString();


				userInfo.put("id", memberId);
				userInfo.put("nickname", memberName);
				userInfo.put("profile_image", profile);
				userInfo.put("account_email", memberEmail);
				userInfo.put("gender", gender);
				userInfo.put("age_range", age_group);
				userInfo.put("birthday", birthday);

	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        return userInfo;
	    }
	@Override
	public int updateKakao(MemberVO member) {
		return memberMapper.updateKakao(member);		
	}


}
