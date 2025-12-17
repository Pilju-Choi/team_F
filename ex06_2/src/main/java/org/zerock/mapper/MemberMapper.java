package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {

	// 회원가입
	public void insertMember(MemberVO member);
	
	// 회원가입
	public void insertAuth(String userId);

	// 로그인: 회원 정보 읽어오기
	public MemberVO read(String userId);
	
	// 아이디 중복 확인
	public int checkId(String userId);
}