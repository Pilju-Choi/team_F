package org.zerock.domain;

import java.util.List;
import lombok.Data;

@Data
public class QuizVO {
	private WordVO word;          // 문제 (정답 포함)
	private List<String> options; // 보기 4개 (정답 + 오답 3개 섞인 것)
}