package team.hunter.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Likes;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.Notice;
import team.hunter.model.dto.Paging;
import team.hunter.model.dto.PersonalAnswer;
import team.hunter.model.dto.PersonalQuestion;
import team.hunter.model.dto.Statistics;
import team.hunter.model.service.FundingService;
import team.hunter.model.service.NoticeService;
import team.hunter.model.service.PersonalAnswerService;
import team.hunter.model.service.StatisticsService;

@Controller
public class AdminController {
	

	@Autowired
	private NoticeService noticeService;
	@Autowired
	private PersonalAnswerService personalAnswerService;
	@Autowired
	private StatisticsService statisticsService;
	@Autowired
	private FundingService fundingService;
	
	
	/**
	 * ���񽺼Ұ� ������ ����
	 * */
	@RequestMapping("/introduce")
	public String introduce() {
		
		return "main/introduce";
	}
	
	/**
	 * 사이트 통계 
	 * */
	@RequestMapping("/admin/siteManagement")
	public ModelAndView siteManagement() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/siteManagement");
		List<Statistics>list = statisticsService.selectWeekData();
//		String week = "";
//		for(Statistics s : list) {
//			week += s.getRegdate() +",";
//		}
		mv.addObject("weekData", list);
		return mv;
	}
	
	@RequestMapping("/admin/fundingRequest")
	public ModelAndView fundingRequest(@RequestParam(defaultValue = "1") int curPage) {
//		List<FundingRequest> list = noticeService.selectFundingRequest();
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("list", list);
//		mv.setViewName("admin/fundingRequest");
		
		ModelAndView mv = new ModelAndView();
		
		//count로 갯수가지고오기
		 
		int listCnt = noticeService.fundingRequestlistCount();
		System.out.println(listCnt);
		Paging paging = new Paging(listCnt, curPage);

		
		int startIndex = paging.getStartIndex();
		int cntPerPage = paging.getPageSize();
		List<FundingRequest> list = noticeService.fundingRequestList(startIndex, cntPerPage);

		
		mv.addObject("list", list);
		mv.addObject("listCnt", listCnt);
		mv.addObject("paging", paging);
		mv.setViewName("admin/fundingRequest");
	
		return mv;
		

	}
	
	@RequestMapping("/admin/fundingInsert")
	public ModelAndView fundingInsert() {
		List<FundingRequest> list = noticeService.selectFundingRequest();
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("admin/fundingInsert");
		return mv;
	}
	//1:1문의 조회
	@RequestMapping("/admin/personalQuestion")
	public ModelAndView personalQuestion(@RequestParam(defaultValue = "1") int curPage) {
		ModelAndView mv = new ModelAndView();
		int listCnt = personalAnswerService.listCount();
		Paging paging = new Paging(listCnt, curPage);

		
		int startIndex = paging.getStartIndex();
		int cntPerPage = paging.getPageSize();
		List<PersonalQuestion> list = personalAnswerService.selectPersonalQuestionPaging(startIndex, cntPerPage);

		
		mv.addObject("list", list);
		mv.addObject("listCnt", listCnt);
		mv.addObject("paging", paging);
		mv.setViewName("admin/personalQuestion");
		
		return mv;
	}
	
	//1:1 문의 상세보기
	@RequestMapping("/personalQuestionDetail/{code}")
	public String personalQuestionDetail(@PathVariable int code, Model model) {
		
		PersonalQuestion question = personalAnswerService.selectByCodeQuestion(code);
//		System.out.println(question.getMember().getId());
//		System.out.println("question.getPersonalAnswer().getContent()"+question.getPersonalAnswer().getContent());
//		System.out.println("question.getContent()" + question.getContent());
//		
		System.out.println(question.getSubject());
		model.addAttribute("question", question);
		
		return "mypage/personalQuestionDetail";
	}
	
	//1:1 문의 답변
	@RequestMapping("/admin/answerInsert")
	public String answerInsert(PersonalAnswer answer) {
		
		personalAnswerService.insertPersonalAnswer(answer);
		return "redirect:/personalQuestionDetail/"+answer.getQuestionCode();
		
	}
	
	
	@RequestMapping("/admin/statistics")
	public String statistics() {
		
		return "admin/statistics";
	}
	
	
	/**
	 * 펀딩 수정하기 폼으로 넘어가기
	 */
	@RequestMapping("/admin/fundingModify/{code}")
	public ModelAndView fundingModifyBtn(@PathVariable int code) {
		ModelAndView mv = new ModelAndView();
		Funding funding = fundingService.selectByCode(code);
		String[] openDate = funding.getOpenDate().split("/");
		String[] endDate = funding.getEndDate().split("/");
		String changeFormOpenDate = openDate[1]+"/"+openDate[2]+"/"+openDate[0];
		String changeFormEndDate = endDate[1]+"/"+endDate[2]+"/"+endDate[0];
		funding.setOpenDate(changeFormOpenDate);
		funding.setEndDate(changeFormEndDate);
		
		mv.addObject("funding", funding);
		mv.setViewName("admin/fundingInsert");
		return mv;
	}
	
	/**
	 * 펀딩 수정
	 */
	@RequestMapping("/admin/fundUpdate")
	public String fundUpdate(Funding funding, MultipartFile file,MultipartFile file2, HttpSession session) {
		String fileName = null;
		System.out.println(funding.getOpenDate());
		System.out.println(funding.getEndDate());
		SimpleDateFormat originFormat = new SimpleDateFormat("MM/dd/yyyy");
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		try {
			
			Date originOpenDate = originFormat.parse(funding.getOpenDate());
			String newOpenDate = newFormat.format(originOpenDate);
			funding.setOpenDate(newOpenDate);
			
			Date originEndDate = originFormat.parse(funding.getEndDate());
			String newEndDate = newFormat.format(originEndDate);
			funding.setEndDate(newEndDate);
			
			
			
		}catch (ParseException e) {
			e.printStackTrace();
		}
		
		try{

			
			String path = session.getServletContext().getRealPath("/resources/images/funding");
			
			
			if(file.getSize()>0) {
				//÷�ε� �����̸� ������ ����
				
				fileName = file.getOriginalFilename();
				String Thumnail = "Thumnail_"+fileName;
				funding.setImage(fileName);
				//notice.setFilename(fileName);
				file.transferTo(new File(path+"/"+Thumnail));
			}
			
			if(file2.getSize()>0) {
				//÷�ε� �����̸� ������ ����
//				String fileName = file2.getOriginalFilename();
				String Detail = "Detail_"+fileName;
				//notice.setFilename(fileName);
				file2.transferTo(new File(path+"/"+Detail));
			}

			fundingService.fundUpdate(funding);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/funding/" + funding.getCode();
	}
	
	
	
	

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * ������������ ���� ��Ʈ�ѷ� + �������� ��ü ���
	 * */
	@RequestMapping("/notice")
	public ModelAndView notice(@RequestParam(defaultValue = "1") int curPage) {
//		List<Notice> list = noticeService.select();
//		m.addAttribute("list", list);
//		return "notice/noticeList";
		
		
		ModelAndView mv = new ModelAndView();
		
		//count로 갯수가지고오기
		
		int listCnt = noticeService.listCount();
		System.out.println(listCnt);
		Paging paging = new Paging(listCnt, curPage);
		System.out.println(paging.getListCnt());
		System.out.println(paging.getCurPage());
		System.out.println(paging.getStartIndex());
		System.out.println(paging.getPageSize());
		
		int startIndex = paging.getStartIndex();
		int cntPerPage = paging.getPageSize();
		List<Notice> list = noticeService.NoticeList(startIndex, cntPerPage);
		
		System.out.println(list);
		
		mv.addObject("list", list);
		mv.addObject("listCnt", listCnt);
		mv.addObject("paging", paging);
		mv.setViewName("notice/noticeList");
	
		return mv;
	}

	/**
	 * �������� �󼼺���
	 * */
	@RequestMapping("/noticeDetail/{code}")
	public ModelAndView detail(@PathVariable int code) {

		Notice notice = noticeService.selectByCode(code);
		ModelAndView m = new ModelAndView("notice/noticeDetail", "detail", notice);
		return m;
		
	}
	
	/**
	 * �������� 
	 * �����ϱ�*/
	@RequestMapping("/updateForm/{code}")
	public ModelAndView updateForm(@PathVariable int code) {
		Notice notice = noticeService.selectByCode(code);
		ModelAndView m  = new ModelAndView("form/noticeUpdateForm", "detail", notice);
		return m;
	}
	
	/**
	 * �������� �����
	 * */
	@RequestMapping("/insertFrom")
	public String insertFrom() {
		
		return "form/noticeForm";

	}

	@RequestMapping("/insert")
	public String insert(Notice notice, MultipartFile file, HttpSession session) {
		System.out.println(notice.getSubject());
		try {

			// ���� ������ ������ ����
			String path = session.getServletContext().getRealPath("/resources/images/save");

			if (file.getSize() > 0) {
				// ÷�ε� �����̸� ������ ����
				String fileName = file.getOriginalFilename();
				notice.setFilename(fileName);
				file.transferTo(new File(path + "/" + fileName));
			}

			noticeService.insert(notice);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return "redirect:notice";
	}


	
	@RequestMapping("/down")
	public ModelAndView down(String fileName, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String path = session.getServletContext().getRealPath("/resources/images/save");
		mv.addObject("fname", new File(path+"/"+fileName));
		mv.setViewName("downLoadView"); //bean의 아이디를 찾을 수 있도록 해야한다...
		return mv;
	}
	
	@RequestMapping("/update")
	public String update(Notice notice, MultipartFile file, HttpSession session) {
		try{
			//���� ������ ������ ����
			String path = session.getServletContext().getRealPath("/resources/images/save");
			
			
			if(file.getSize()>0) {
				//÷�ε� �����̸� ������ ����
				String fileName = file.getOriginalFilename();
				notice.setFilename(fileName);
				file.transferTo(new File(path+"/"+fileName));
			}

			//noticeService.insert(notice);
			noticeService.update(notice);

		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:notice";
	}
	
	@RequestMapping("delete")
	public String delete(int code) {
		noticeService.delete(code);

		return "redirect:notice";
	}
	
	/**
	 * Funding Insert 
	 * */
	@RequestMapping("/admin/fundInsert")
	public String fundInsert(Funding funding, MultipartFile file,MultipartFile file2, HttpSession session, int code) {
		String fileName = null;
		System.out.println(funding.getOpenDate());
		System.out.println(funding.getEndDate());
		SimpleDateFormat originFormat = new SimpleDateFormat("MM/dd/yyyy");
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		try {
			
			Date originOpenDate = originFormat.parse(funding.getOpenDate());
			String newOpenDate = newFormat.format(originOpenDate);
			funding.setOpenDate(newOpenDate);
			
			Date originEndDate = originFormat.parse(funding.getEndDate());
			String newEndDate = newFormat.format(originEndDate);
			funding.setEndDate(newEndDate);
			
			
			
		}catch (ParseException e) {
			e.printStackTrace();
		}
		
		try{

			
			String path = session.getServletContext().getRealPath("/resources/images/funding");
			
			
			if(file.getSize()>0) {
				//÷�ε� �����̸� ������ ����
				
				fileName = file.getOriginalFilename();
				String Thumnail = "Thumnail_"+fileName;
				funding.setImage(fileName);
				//notice.setFilename(fileName);
				file.transferTo(new File(path+"/"+Thumnail));
			}
			
			if(file2.getSize()>0) {
				//÷�ε� �����̸� ������ ����
//				String fileName = file2.getOriginalFilename();
				String Detail = "Detail_"+fileName;
				//notice.setFilename(fileName);
				file2.transferTo(new File(path+"/"+Detail));
			}

			noticeService.fundInsert(funding, code);

		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/siteManagement";
	}
	
	@RequestMapping("/admin/fundingRequestDetail")
	public ModelAndView fundingRequestDetail(int code) {

		FundingRequest fundingRequest = noticeService.selectFundingRequestByCode(code); 
		ModelAndView m = new ModelAndView("admin/fundingRequestDetail", "detail", fundingRequest);
		return m;
		
	}
	
	/**
	 * 펀딩등록 신청 거절하기
	 * */
	@RequestMapping("/admin/reject")
	public String fundingRequestReject(int code) {
		noticeService.fundingRequestReject(code);
		return "redirect:/admin/fundingRequest";
	}
	
	/**
	 * 펀딩등록 신청 승인하기
	 * */
	@RequestMapping("/admin/approve")
	public String fundingRequestApprove(int code) {
		noticeService.fundingRequestApprove(code);
		return "redirect:/admin/fundingRequest";
	}
	

	

}
