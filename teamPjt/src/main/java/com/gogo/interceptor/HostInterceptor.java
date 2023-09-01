package com.gogo.interceptor;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gogo.vo.MemberVO;

@Component
public class HostInterceptor implements HandlerInterceptor{
	
	
	/**
	 * 컨트롤러 실행 전 실행
	 * return true : 요청 컨트롤러 실행
	 *        false : 요청 컨트롤러 실행 하지 않음
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		System.out.println("===========" + session.getAttribute("member"));
		if( session.getAttribute("member") != null) {
			
			MemberVO member = (MemberVO)session.getAttribute("member");
			List<String> roles = member.getRole();
			if(roles != null){
				if(!roles.contains("host")) {
					return true;
				}
			}
		}
		// 로그인 페이지로 이동
		// String msg = URLEncoder.encode("로그인 후 사용 가능한 메뉴 입니다.","utf-8");			
		response.sendRedirect("/member/host/stayhost");
		return false;
	}
		
}
