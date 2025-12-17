package org.zerock.domain;

import lombok.Data;

@Data
public class DayStatusDTO {
	private int day;   // 몇 일차?
	private int score; // 몇 점? (안 풀었으면 0)
}