package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.PersonalQuestion;
import team.hunter.model.service.FundingQuestionService;
import team.hunter.model.service.FundingRequestService;
import team.hunter.model.service.PersonalQuestionService;

@Controller
@RequestMapping("mypage")
public class myPageController {
	@Autowired private PersonalQuestionService personalQs;
	@Autowired private FundingQuestionService fundingQs;
	@Autowired FundingRequestService fundingReqService;
	
	@RequestMapping("myQuestion")
	public ModelAndView personalQuestionList() {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<PersonalQuestion> list = personalQs.personalQuestionList(member.getCode());
		return new ModelAndView("mypage/personalQuestionList", "list", list);
	}
	
	@RequestMapping("personalQuestionForm")
	public String personalQuestionForm() {
		return "form/personalQuestionForm";
	}
	
	@RequestMapping("personalQuestionInsert")
	public String personalQuestionInsert(PersonalQuestion personalQuestion) {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		personalQuestion.setMemberCode(member.getCode());
		personalQs.personalQuestionInsert(personalQuestion);
		return "redirect:/mypage/myQuestion";
	}

	
	@RequestMapping("fundingQuestion")
	public ModelAndView fundingQuestion() {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<FundingQuestion> list = fundingQs.fundingQuestionList(member.getCode());
		return new ModelAndView("mypage/fundingQuestionList", "list", list);
	}
	
	@RequestMapping("fundingQuestionDetailPage/{code}")
	public ModelAndView fundingQuestionDetail(@PathVariable int code) {
		FundingQuestion fundingQuestion =fundingQs.selectByCode(code);
		
		return new ModelAndView("mypage/fundingQuestionDetail", "detail", fundingQuestion);
	}
	
	@RequestMapping("/myOpenFunding")
	public ModelAndView myOpenFunding() {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//System.out.println(member.getCode()+"너 나오니???????????");
		List<Funding> myOpenFundingList = fundingReqService.myFundingOpenList(member.getCode());
		//System.out.println(myOpenFundingList);
		return new ModelAndView("mypage/myOpenFundingList","myOpenFundingList",myOpenFundingList);
	}
	
}
