package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Member;
import team.hunter.model.dto.PersonalQuestion;
import team.hunter.model.service.PersonalQuestionService;

@Controller
@RequestMapping("mypage")
public class myPageController {
	@Autowired
	private PersonalQuestionService personalQs;
	
	@RequestMapping("myQuestion")
	public ModelAndView personalQuestionList() {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<PersonalQuestion> list = personalQs.personalQuestionList(member.getCode());
		System.out.println(list);
		
		return new ModelAndView("mypage/personalQuestionList", "list", list);
	}
}
