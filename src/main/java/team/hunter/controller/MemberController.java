package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.Member;
import team.hunter.model.service.MemberService;

@Controller
public class MemberController {
	
	@RequestMapping("/login")
	public String login() {
		return "form/loginForm";
	}
	
}
