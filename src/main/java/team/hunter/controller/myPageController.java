package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.PersonalQuestion;
import team.hunter.model.service.FundingQuestionService;
import team.hunter.model.service.PersonalQuestionService;

@Controller
@RequestMapping("mypage")
public class myPageController {
	@Autowired
	private PersonalQuestionService personalQs;
	@Autowired
	private FundingQuestionService fundingQs;
	
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
	
	@RequestMapping("fundingQuestionList")
	public void fundingQuestionList() {}
}
