package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingAnswer;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.Paging;
import team.hunter.model.dto.PersonalQuestion;
import team.hunter.model.service.FundingAnswerService;
import team.hunter.model.service.FundingQuestionService;
import team.hunter.model.service.FundingRequestService;
import team.hunter.model.service.MemberService;
import team.hunter.model.service.PersonalQuestionService;

@Controller
@RequestMapping("mypage")
public class myPageController {
	@Autowired private PersonalQuestionService personalQs;
	@Autowired private FundingQuestionService fundingQs;
	@Autowired private FundingAnswerService fundingAs;
	@Autowired private MemberService memberService;
	@Autowired private FundingRequestService fundingReqService;
	
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
	public ModelAndView fundingQuestion(@RequestParam(defaultValue = "1") int curPage) {
		ModelAndView mv = new ModelAndView();
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int listCnt = fundingQs.listCount(member.getCode());
		Paging paging = new Paging(listCnt, curPage);
		System.out.println(paging.getListCnt());
		System.out.println(paging.getCurPage());
		System.out.println(paging.getStartIndex());
		System.out.println(paging.getPageSize());
		
		member.setStartIndex(paging.getStartIndex());
		member.setCntPerPage(paging.getPageSize());
		List<FundingQuestion> list = fundingQs.fundingQuestionList(member);
		System.out.println(list);
		
		mv.addObject("list", list);
		mv.addObject("listCnt", listCnt);
		mv.addObject("paging", paging);
		mv.setViewName("mypage/fundingQuestionList");
		
		return mv;
	}
	
	@RequestMapping("fundingQuestionDetailPage/{code}")
	public ModelAndView fundingQuestionDetail(@PathVariable int code) {
		FundingQuestion fundingQuestion =fundingQs.selectByCode(code);
		FundingAnswer fundingAnswer = fundingAs.selectByCode(code);
		ModelAndView mv = new ModelAndView();
		mv.addObject("detail", fundingQuestion);
		mv.addObject("answer", fundingAnswer);
		mv.setViewName("mypage/fundingQuestionDetail");
		
		return mv;
	}
	
	@RequestMapping("myInfoMenu")
	public ModelAndView myInfoMenu() {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		member = memberService.selectByPhone(member);
		ModelAndView mv = new ModelAndView();
		mv.addObject("member", member);
		mv.setViewName("mypage/chooseMyInfoMenu");
		return mv;
	}
	
	/**
	 * 내가 오픈한 펀딩 리스트 
	 * */
	@RequestMapping("/myOpenFunding")
	public ModelAndView myOpenFunding() {
		Member member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//System.out.println(member.getCode()+"너 나오니???????????");
		List<Funding> myOpenFundingList = fundingReqService.myFundingOpenList(member.getCode());
		//System.out.println(myOpenFundingList);
		return new ModelAndView("mypage/myOpenFundingList","myOpenFundingList",myOpenFundingList);
	}
	
	@PostMapping("/changeMyInfo")
	public ModelAndView changeMyInfo(Member member) {
		if(member.getEmailAccept()==null) {
			member.setEmailAccept("0");
		}
		member = memberService.changeMyInfo(member);
		ModelAndView mv = new ModelAndView();
		mv.addObject("member", member);
		mv.setViewName("mypage/chooseMyInfoMenu");
		return mv;
	}
	
	/**
	 * 내가 오픈한 펀딩 상세페이지
	 * */
	@RequestMapping("/myOpenFunding/{fundingCode}")
	public String myOpenDetail(@PathVariable int fundingCode, Model model ) {
//		Member member = null;
//		if(!SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser"))
//			member =(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		//펀딩 문의 관리
		model.addAttribute("fundingReqManage", fundingReqService.myFundingOpenDetail(fundingCode));
		
		//펀딩 참가한 사용자
		model.addAttribute("fundingOpenPeople", fundingReqService.myFundingOpenDetailSecond(fundingCode));
		return "mypage/myOpenFundingDetail";
	}
	
	/**
	 * 내가 오픈한 펀딩 상세페이지 - 펀딩 문의자 관리
	 * */
	@RequestMapping("/myOpenFundingReqManage/{questionCode}")
	public String myOpenFundingReqManage(@PathVariable int questionCode, Model model) {
		FundingQuestion fundingQuestion = fundingReqService.myOpenFundingReqManage(questionCode);
		model.addAttribute("fundingQuestion", fundingQuestion);
		return "mypage/myOpenFundingReqManage";
	}
	
	
}
