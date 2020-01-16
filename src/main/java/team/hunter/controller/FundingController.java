package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Likes;
import team.hunter.model.dto.Member;
import team.hunter.model.service.FundingService;
import team.hunter.model.service.LikesService;
import team.hunter.model.service.MemberService;
import team.hunter.model.service.PurchaseService;

@Controller
public class FundingController {
	@Autowired
	private FundingService service;
	@Autowired
	private LikesService likesService;
	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private MemberService memberService;
	
	int pageCnt = 3;

	//목록 페이지 진입
	@RequestMapping("/funding")
	public String funding() {
		return "redirect:/funding/category/";
	}
	
	//펀딩 상세페이지 이동
	@RequestMapping("/funding/{code}")
	public String fundingDetail(@PathVariable int code, Model model) {
		Member member = null;
		if(!SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser"))
			member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		model.addAttribute("funding", service.selectByCode(code));
		model.addAttribute("fundingSponser", purchaseService.countFundingCode(code));
		model.addAttribute("juso", memberService.selectMemberByCode(service.selectByCode(code).getMdCode()));
		if(member != null)
			model.addAttribute("likes", likesService.select(new Likes(member.getCode(), code)));	
		
		return "funding/fundingDetail";
	}

	//전체 카테고리
	@RequestMapping("/funding/category/")
	public String allCategory(Model model, String order, String where, String val) {
		List<Funding> list = service.selectList("0", order, where, val);
		
		if(list.size() > pageCnt*2)
			list = list.subList(0, pageCnt*2);
		
		model.addAttribute("list", list);
		model.addAttribute("val", val);

		return "funding/fundingList";
	}

	//카테고리별
	@RequestMapping("/funding/category/{categoryCode}")
	public String eachCategory(@PathVariable String categoryCode, String order, String where, String val, Model model) {
		List<Funding> list = service.selectList(categoryCode, order, where, val);
		if(list.size() > pageCnt*2)
			list = list.subList(0, pageCnt*2);
		model.addAttribute("list", list);
		model.addAttribute("val", val);

		return "funding/fundingList";
	}
	
	//리스트 추가
	@RequestMapping("/funding/fetchList")
	public @ResponseBody List<Funding> fetchList(String categoryCode, String order, String where, String val, int listCnt, boolean isComming){
		List<Funding> list = null;
		if(isComming)
			list = service.selectStatePre();
		else	
			list = service.selectList(categoryCode, order, where, val);
		
		if(list.size() > listCnt + pageCnt)
			list = list.subList(listCnt, listCnt + pageCnt);
		else if(list.size() > listCnt)
			list = list.subList(listCnt, list.size());
		
		return list;
	}
  
	@ExceptionHandler({Exception.class})
	public String error() {
		return "error/errorPage";
	}
	@RequestMapping("/funding/commingsoon")
	public ModelAndView commingsoon() {
		List<Funding> list = service.selectStatePre();
		if(list.size() > pageCnt*2)
			list = list.subList(0, pageCnt*2);
		return new ModelAndView("funding/fundingList", "list", list);
	}
}

