package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Override
	public void join(MemberVO member) {
		log.info("회원가입 진행 중... : " + member);

		member.setUserPw(pwencoder.encode(member.getUserPw()));
		mapper.insertMember(member);
		mapper.insertAuth(member.getUserId());
		log.info("회원가입 완료!");
	}
	@Override
	public int checkId(String userId) {
	    return mapper.checkId(userId);
	}
}