package org.zerock.domain;

import java.util.Date;
import java.util.List;
import lombok.Data;

@Data
public class MemberVO {
	private String userId;
	private String userPw;
	private String userName;
	private String userEmail;
	private Date regDate;
	private Date updateDate;
	private boolean enabled;
	
	// 권한 목록 (이게 있어야 시큐리티가 안 삐짐)
	private List<AuthVO> authList;
}