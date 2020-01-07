package team.hunter.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

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
	public String fundingInsert(FundingRequest fundingRequest, HttpSession session) throws IOException {
		MultipartFile file = fundingRequest.getFile();
		
		if(file.getSize() > 0) {
			String path = session.getServletContext().getRealPath("/WEB-INF/save");
			String fileName = file.getOriginalFilename();
			file.transferTo(new File(path+"/"+fileName)); //폴더에 저장완료
			fundingRequest.setFilename(fileName); //dto에 파일이름 저장
		}
		fundingRequestService.fundingInsert(fundingRequest);
		return "redirect:/";
	}

}
