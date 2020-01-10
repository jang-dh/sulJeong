package team.hunter.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
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
	
	//파일 경로 저장
	private String path ="C:\\Edu\\springFileSave\\";

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
		if(member.getEmailAccept()==null) {
			member.setEmailAccept("0");
		}
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
	public String fundingInsert(FundingRequest fundingRequest) throws IOException {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MultipartFile file = fundingRequest.getFile();
    	if(file.getSize() > 0 ) {//파일이 첨부되었다면....
    		String fileName = file.getOriginalFilename();
    		fundingRequest.setFilename(fileName);
    		//파일저장
    		file.transferTo(new File(path+"/" + fileName));
    	}
    	fundingRequest.setMemberCode(member.getCode());
		fundingRequestService.fundingInsert(fundingRequest);
		return "redirect:/";
	}
	
	@RequestMapping("/identityVerificationForm")
	public String Authenticate() {
		return "form/identityVerification/identityVerificationForm";
	}
	

}
