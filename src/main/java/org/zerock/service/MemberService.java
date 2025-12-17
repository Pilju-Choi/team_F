package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	// 회원가입 기능 정의
	public void join(MemberVO member);
	
	public int checkId(String userId);
}