package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import team.hunter.model.dto.Member;
import team.hunter.model.service.MemberService;

@RestController
public class AjaxController {
	@Autowired
	private MemberService memberService;

	@PostMapping("/findId")
	public Member findId(Member member) {
		System.out.println(member.getName() + member.getPhone());
		return memberService.selectByPhone(member);
	}
	
}
