package team.hunter.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import team.hunter.model.dto.FundingAnswer;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Likes;
import team.hunter.model.dto.Member;
import team.hunter.model.service.FundingAnswerService;
import team.hunter.model.service.FundingQuestionService;
import team.hunter.model.service.LikesService;
import team.hunter.model.service.MemberService;
import team.hunter.util.Constants;

@RestController
public class AjaxController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private LikesService likesService;
	
	@Autowired
	private FundingQuestionService fundingQuestionService;
	
	@Autowired
	private FundingAnswerService fundingAs;

	@PostMapping("/findId")
	public List<Member> findId(Member member) {
		List<Member> list = memberService.selectByPhone(member);
		return list;
	}

	@RequestMapping(value = "/likes/insert", method = RequestMethod.POST)
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
		
		FundingQuestion fundigQuestion =new FundingQuestion(0, Integer.parseInt(fundingCode), member.getCode(), content, subject, null, Constants.BEFORE_ANSWER,null,null,null);
		return fundingQuestionService.insert(fundigQuestion);
	}
	
//	@PostMapping("/findPWD")
//	public Member findPWD(Member member) {
//		System.out.println(member.getName() + member.getPhone());
//		return memberService.selectByPhone(member);
//	}
	
	@PostMapping("/contentInsert")
	public FundingAnswer contentInsert(int code, String contentBox){
		FundingAnswer fundingAnswer = new FundingAnswer(code, contentBox, null);
		fundingAs.contentInsert(fundingAnswer);
		fundingAnswer = fundingAs.selectByCode(code);
		return fundingAnswer;
	}
	
	@PostMapping("/membershipWithdrawal")
	public int membershipWithdrawal(Member member, HttpSession session) {
		int result = memberService.membershipWithdrawal(member);
		session.invalidate();
		
		return result;
	}

	@PostMapping("/fundingAnswer")
	public FundingAnswer fundingAnswer(String content, String questionCode) {
		fundingAs.fundingAnswerinsert(new FundingAnswer(Integer.parseInt(questionCode), content, null));
		FundingAnswer fundingAnswer2 = fundingAs.selectByCode(Integer.parseInt(questionCode));
		return fundingAnswer2;
	}
	
	@PostMapping("/idDuplicateCheck")
	public Member idDuplicateCheck(String id) {
		Member result = memberService.idDuplicateCheck(id);
		return result;
	};
	

}
