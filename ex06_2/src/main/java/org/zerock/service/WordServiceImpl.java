package org.zerock.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.DayStatusDTO;
import org.zerock.domain.QuizVO;
import org.zerock.domain.RankVO;
import org.zerock.domain.ScoreVO;
import org.zerock.domain.WordVO;
import org.zerock.domain.StatsDTO;
import org.zerock.domain.LevelStatsDTO;
import org.zerock.mapper.WordMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class WordServiceImpl implements WordService {

    @Setter(onMethod_ = @Autowired)
    private WordMapper mapper;

    @Override
    public List<Integer> getDayList(int level) {
        return mapper.getDaysByLevel(level);
    }

    @Override
    public List<WordVO> getWordList(int level, int day) {
        return mapper.getWords(level, day);
    }

    @Override
    public List<QuizVO> getQuizList(int level, int day) {
        List<WordVO> words = mapper.getWords(level, day);
        List<QuizVO> quizList = new ArrayList<>();

        for (WordVO word : words) {
            QuizVO quiz = new QuizVO();
            quiz.setWord(word);

            List<String> options = mapper.getRandomMeanings(word.getWordId());
            options.add(word.getWordMean());
            Collections.shuffle(options);

            quiz.setOptions(options);
            quizList.add(quiz);
        }

        return quizList;
    }

    @Override
    public void registerScore(ScoreVO vo) {
        mapper.saveScore(vo);
    }

    @Override
    public List<DayStatusDTO> getStatusList(int level, String userId) {
        return mapper.getStatusList(level, userId);
    }

    @Override
    public List<RankVO> getRankList(int level) {
        return mapper.getRankList(level);
    }

    @Override
    public StatsDTO getOverallStats(String userId) {
        return mapper.getOverallStats(userId);
    }

    @Override
    public List<LevelStatsDTO> getLevelStats(String userId) {
        return mapper.getLevelStats(userId);
    }
    
    
}
