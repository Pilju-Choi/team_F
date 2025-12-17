package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

    @Setter(onMethod_ = @Autowired)
    private MemberService service;

    // 회원가입 화면
    @GetMapping("/join")
    public void joinGET() {
        log.info("회원가입 페이지 진입");
    }

    // 회원가입 처리
    @PostMapping("/join")
    public String joinPOST(MemberVO member, RedirectAttributes rttr) {
        log.info("회원가입 요청: " + member);

        //아이디 중복 체크
        if (service.checkId(member.getUserId()) > 0) {
            rttr.addFlashAttribute("error", "이미 존재하는 아이디입니다.");
            return "redirect:/member/join";
        }

        //비밀번호 8자리 이상 + 특수문자 포함
        String pw = member.getUserPw();
        if (!pw.matches("^(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]).{8,}$")) {
            rttr.addFlashAttribute("error", "비밀번호는 8자리 이상이며 특수문자를 포함해야 합니다.");
            return "redirect:/member/join";
        }

        //DB 저장
        service.join(member);

        rttr.addFlashAttribute("msg", "JOIN_SUCCESS");

        return "redirect:/customLogin";
    }

    // 아이디 중복 체크
    @GetMapping("/checkId")
    @ResponseBody
    public String checkId(String userId) {

        int count = service.checkId(userId);

        return (count == 0) ? "OK" : "NO";
    }
}

