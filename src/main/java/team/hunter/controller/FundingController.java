package team.hunter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Member;
import team.hunter.model.service.FundingQuestionService;
import team.hunter.model.service.FundingService;

@Controller
public class FundingController {
	@Autowired
	private FundingService service;
	private FundingQuestionService fundingQuestionService;

	//목록 페이지 진입
	@RequestMapping("/funding")
	public String funding() {
		
		return "redirect:/funding/category/";
	}

	//펀딩 상세페이지 이동
	@RequestMapping("/funding/{code}")
	public String fundingDetail(@PathVariable int code, Model model) {
		model.addAttribute("funding", service.selectByCode(code));
		return "funding/fundingDetail";
	}

	//전체 카테고리
	@RequestMapping("/funding/category/")
	public String allCategory(Model model, String order, String where, String val) {
		List<Funding> list = service.selectList(0, order, where, val);
		
		if(list.size() > 8)
			list = list.subList(0, 8);
		
		model.addAttribute("list", list);

		return "funding/fundingList";
	}

	//카테고리별
	@RequestMapping("/funding/category/{categoryCode}")
	public ModelAndView eachCategory(@PathVariable int categoryCode, String order, String where, String val) {
		List<Funding> list = service.selectList(categoryCode, order, where, val);
		if(list.size() > 8)
			list = list.subList(0, 8);
		return new ModelAndView("funding/fundingList", "list", list);
	}
	
	//리스트 추가
	@RequestMapping("/funding/category/fetchList")
	public @ResponseBody List<Funding> fetchList(int categoryCode, String order, String where, String val, int listCnt){
		List<Funding> list = service.selectList(categoryCode, order, where, val);
		System.out.println("list.size : " + list.size());
		
		
		if(list.size() > listCnt + 4)
			list = list.subList(listCnt, listCnt + 4);
		else
			list = list.subList(listCnt, list.size());
		
		for(Funding f : list)
			System.out.println(f.getTitle());
		
		return list;
	}
	
	//펀딩 문의 추가
	@RequestMapping("/funding/fundingQuestionInsert")
	public String fundingQuestionInsert(FundingQuestion fundingQuestion) {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		fundingQuestion.setMemberCode(member.getCode());
		fundingQuestionService.fundingQuestionInsert(fundingQuestion);
		return "redirect:/funding/{code}";
	}
	
}

