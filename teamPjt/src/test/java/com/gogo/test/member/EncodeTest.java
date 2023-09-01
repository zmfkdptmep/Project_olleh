package com.gogo.test.member;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class EncodeTest {

	/**
	 * 스프링 시큐리티모듈에서 제공하는 비밀번호 암호화및 인증 기능
	 * (Spring Seurity)에서 제공하는 비밀번호를 암호화하는데 사용할 수 있는 메서드를 가진 클래스입니다.
	 * 
	 * pom.xml에 spring security 라이브러리를 추가 
	 */
	BCryptPasswordEncoder encoder 
				= new BCryptPasswordEncoder();
	
	@Test
	public void test() {
		String pw = "1234";
		
		for(int i=0; i<10; i++) {
			
			// 암호화할때마다 새로운 문자열을 반환 하며, 복호화가 불가능
			String encodePw = encoder.encode(pw);
			System.out.println("암호화된 문자열 : " + encodePw);

			// 첫 번째 매개변수는 일치 여부를 확인하고자 하는 인코딩 되지 않은 패스워드
			// 두 번째 매개변수는 인코딩 된 패스워드를 입력합니다.
			
			// 제출된 인코딩 되지 않은 패스워드(일치 여부를 확인하고자 하는 패스워드)와 
			// 인코딩 된 패스워드의 일치 여부를 확인해줍니다.
			boolean matches = encoder.matches(pw, encodePw);
			System.out.println("인증결과 : " + matches);
		}
		
	}
}






















