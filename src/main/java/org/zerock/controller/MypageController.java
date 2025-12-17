package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.StatsDTO;
import org.zerock.service.WordService;
import org.zerock.domain.StatsDTO;
import org.zerock.domain.LevelStatsDTO;
import lombok.Setter;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/mypage/*")
public class MypageController {

	@Setter(onMethod_ = @Autowired)
	private WordService service;



    @GetMapping("/dashboard")
    public void dashboard(Principal principal, Model model) {
        if(principal == null) {
            return;
        }
        String userId = principal.getName();
        
        StatsDTO userStats = service.getOverallStats(userId);
        if(userStats == null) {
            userStats = new StatsDTO();
            userStats.setUserId(userId);
        }
        model.addAttribute("stats", userStats);
        
        List<LevelStatsDTO> levelStats = service.getLevelStats(userId);
        model.addAttribute("levelStats", levelStats);
    }
}