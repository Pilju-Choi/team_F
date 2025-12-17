package org.zerock.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommonController {

	// 권한 없는 페이지 접근 시 에러 처리
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		model.addAttribute("msg", "Access Denied");
	}

	// 로그인 화면 띄우기 (커스텀 로그인 페이지)
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		// 로그인 실패 시 에러 메시지 전달
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		// 로그아웃 시 메시지 전달
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}

	// 로그아웃 처리
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("로그아웃");
	}
}