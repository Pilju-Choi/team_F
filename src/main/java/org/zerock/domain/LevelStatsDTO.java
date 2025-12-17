package org.zerock.domain;

import lombok.Data;

@Data
public class LevelStatsDTO {
    private int lvl;
    private int totalCount;
    private int correctCount;

    public int getLevel() {
        return lvl;
    }
}

