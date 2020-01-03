package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.Member;
import team.hunter.model.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("/login")
	public String login() {
		return "form/loginForm";
	}
	
	@RequestMapping("/join")
	public String join() {
		
		return "form/memberJoinForm";
	}
	
	@RequestMapping("/memberJoin")
	public String memberJoin(Member member) {
		memberService.memberJoin(member);
		return "redirect:/";
	}

}
