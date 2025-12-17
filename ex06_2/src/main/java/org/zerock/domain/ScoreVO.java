package org.zerock.domain;

import lombok.Data;

@Data
public class ScoreVO {
	private String userId;
	private int level;
	private int day;
	private int score;
}