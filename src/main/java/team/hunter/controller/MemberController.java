package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Member;
import team.hunter.model.service.FundingRequestService;
import team.hunter.model.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired FundingRequestService fundingRequestService;

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
	
	@RequestMapping("/searchLoginInfoForm")
	public String searchLoginInfoForm() {
		return "form/searchLoginInfoForm";
	}
	
	@RequestMapping("/fundingOpenRequest")
	public String fundingOpenRequest() {
		
		return "form/fundingRequestForm";
	}
	
	@RequestMapping("/fundingInsert")
	public String fundingInsert(FundingRequest fundingRequest) {
		fundingRequestService.fundingInsert(fundingRequest);
		return "redirect:/";
	}

}
