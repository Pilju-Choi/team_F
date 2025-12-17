package org.zerock.domain;

import lombok.Data;

@Data
public class StatsDTO {
    private String userId;
    private int totalWords;      // 총 학습(시도) 단어 수
    private int correctWords;    // 총 정답 단어 수
    private int uniqueWords;     // 유니크하게 학습한 단어 수
    private double accuracyRate; // 정확도 (정답률)
}