package org.zerock.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.DayStatusDTO;
import org.zerock.domain.LevelStatsDTO;
import org.zerock.domain.RankVO;
import org.zerock.domain.ScoreVO; // ★ ScoreVO 임포트 필수!
import org.zerock.domain.StatsDTO;
import org.zerock.domain.WordVO;

public interface WordMapper {
	
	// 레벨별 Day 목록 가져오기
	public List<Integer> getDaysByLevel(int level);
	
	// 특정 Day의 단어장 가져오기
	public List<WordVO> getWords(@Param("level") int level, @Param("day") int day);

	// 퀴즈용 랜덤 오답 3개 가져오기
	public List<String> getRandomMeanings(@Param("wordId") int wordId);
	
	// 점수 저장하기
	public int saveScore(ScoreVO vo);
	
	public List<DayStatusDTO> getStatusList(@Param("level") int level, @Param("userId") String userId);
	
	public List<RankVO> getRankList(int level);
	
	public StatsDTO getOverallStats(String userId);

	public List<LevelStatsDTO> getLevelStats(String userId);
}