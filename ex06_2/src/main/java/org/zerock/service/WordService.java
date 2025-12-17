package org.zerock.service;

import java.util.List;

import org.zerock.domain.DayStatusDTO;
import org.zerock.domain.QuizVO;
import org.zerock.domain.RankVO;
import org.zerock.domain.ScoreVO;
import org.zerock.domain.WordVO;
import org.zerock.domain.StatsDTO;
import org.zerock.domain.LevelStatsDTO;

public interface WordService {

    List<Integer> getDayList(int level);

    List<WordVO> getWordList(int level, int day);

    List<QuizVO> getQuizList(int level, int day);

    void registerScore(ScoreVO vo);

    List<DayStatusDTO> getStatusList(int level, String userId);

    List<RankVO> getRankList(int level);

    StatsDTO getOverallStats(String userId);

    List<LevelStatsDTO> getLevelStats(String userId);

}
