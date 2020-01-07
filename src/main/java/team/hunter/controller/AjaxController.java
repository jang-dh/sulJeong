package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Likes;
import team.hunter.model.dto.Member;
import team.hunter.model.service.FundingQuestionService;
import team.hunter.model.service.LikesService;
import team.hunter.model.service.MemberService;

@RestController
public class AjaxController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private LikesService likesService;
	
	@Autowired
	private FundingQuestionService fundingQuestionService;

	@PostMapping("/findId")
	public Member findId(Member member) {
		System.out.println(member.getName() + member.getPhone());
		return memberService.selectByPhone(member);
	}

	@RequestMapping(value = "/funding/insertLikes", method = RequestMethod.POST)
	public int insertLikes(String fundingCode) {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Likes likes = new Likes(member.getCode(), Integer.parseInt(fundingCode));
		return likesService.insert(likes);
	}
	
	//펀딩 문의 추가
	@RequestMapping(value = "/funding/fundingQuestionInsert", method = RequestMethod.POST)
	public int fundingQuestionInsert(String fundingCode, String content, String subject) {
		System.out.println("fcd :" + fundingCode);
		System.out.println("content :" + content);
		System.out.println("subject : " + subject);
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		FundingQuestion fundigQuestion =new FundingQuestion(0, Integer.parseInt(fundingCode), member.getCode(), content, subject, null, null);
		return fundingQuestionService.insert(fundigQuestion);
	}
	
}
