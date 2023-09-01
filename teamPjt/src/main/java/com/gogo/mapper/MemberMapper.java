package com.gogo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gogo.vo.MemberVO;


public interface MemberMapper {
	
	public MemberVO loginAction(MemberVO member);
	
	// 멤버의 정보를 불러오기 위한 함수
	public MemberVO selectOne(MemberVO member);
	
	public int updateNaver(MemberVO member);
	
	public String getPw(MemberVO member);
	
	public List<String> getMemberRole(String memberId);

	public int signupAction(MemberVO member);

	public int idCheck(MemberVO member);

	public List<MemberVO> findIdAction(MemberVO member);

	public int findPwAction(MemberVO member);

	public void passwordUpdate(MemberVO member);

	public void insertMemberRole(@Param("memberId") String memberId,@Param("role_id") String role_id);

	public int updateKakao(MemberVO member);

}
