package org.zerock.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.DayStatusDTO;
import org.zerock.service.WordService;

import lombok.Setter;

@Controller
public class HomeController {
	
	@Setter(onMethod_ = @Autowired)
	private WordService wordService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, java.security.Principal principal, 
			@org.springframework.web.bind.annotation.RequestParam(value="level", defaultValue="1") int level) {

		if (principal != null) {
			String userId = principal.getName();
			List<DayStatusDTO> statusList = wordService.getStatusList(level, userId);
			model.addAttribute("days", statusList);
		} 
		else {
		}
		model.addAttribute("currentLevel", level);
		return "home";
	}
}