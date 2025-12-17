package org.zerock.domain;

import lombok.Data;

@Data
public class RankVO {
	private String userId;
	private String userName;  // 사용자 이름
	private int totalScore;   // 총점
}