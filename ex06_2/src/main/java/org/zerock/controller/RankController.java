package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.service.WordService;

import lombok.Setter;

@Controller
@RequestMapping("/rank/*")
public class RankController {

	@Setter(onMethod_ = @Autowired)
	private WordService service;

	@GetMapping("/list")
	public void list(@RequestParam(value="level", defaultValue="1") int level, Model model, java.security.Principal principal) {
		
		model.addAttribute("rankList", service.getRankList(level));
		
		model.addAttribute("currentLevel", level);
		
		if(principal != null) {
			model.addAttribute("myId", principal.getName());
		}
	}
}