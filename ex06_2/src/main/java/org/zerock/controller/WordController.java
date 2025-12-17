package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication; // ★ 이거 없어서 에러 났을 수 있음
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.ScoreVO;
import org.zerock.service.WordService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/word/*")
public class WordController {

	@Setter(onMethod_ = @Autowired)
	private WordService service;

	// 1. 학습 화면
	@GetMapping("/study")
	public void study(@RequestParam("level") int level, @RequestParam("day") int day, Model model) {
		log.info("단어 학습 진입: Level " + level + ", Day " + day);
		
		model.addAttribute("words", service.getWordList(level, day));
		model.addAttribute("currentLevel", level);
		model.addAttribute("currentDay", day);
	}
	
	// 2. 퀴즈 화면
    @GetMapping("/quiz")
    public void quiz(@RequestParam("level") int level, @RequestParam("day") int day, Model model) {
        log.info("퀴즈 풀기 진입: Level " + level + ", Day " + day);
        
        model.addAttribute("quizList", service.getQuizList(level, day));
        model.addAttribute("level", level);
        model.addAttribute("day", day);
    }
    
    // 3. 점수 저장 (AJAX 요청 처리)
    @PostMapping("/saveScore")
    @ResponseBody // 화면 이동 없이 데이터만 주고받음
    public String saveScore(ScoreVO vo, Authentication auth) {
        // 로그인한 사용자 아이디 가져오기
    	if(auth != null) {
            String userId = auth.getName();
            vo.setUserId(userId);
            
            log.info("점수 저장 요청: " + vo);
            service.registerScore(vo);
            
            return "success";
    	} else {
    		return "fail"; // 로그인 안 된 상태
    	}
    }
}