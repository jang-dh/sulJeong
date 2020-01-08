package team.hunter.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Notice;
import team.hunter.model.dto.PersonalQuestion;
import team.hunter.model.service.NoticeService;
import team.hunter.model.service.PersonalAnswerService;

@Controller
public class AdminController {
	
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private PersonalAnswerService personalAnswerService;
	
	/**
	 * ���񽺼Ұ� ������ ����
	 * */
	@RequestMapping("/introduce")
	public String introduce() {
		return "main/introduce";
	}
	
	/**
	 * ������������
	 * */
	@RequestMapping("/admin/siteManagement")
	public void siteManagement() {}
	
	@RequestMapping("/admin/fundingRequest")
	public String fundingRequest() {
		
		return "admin/fundingRequest";
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
	public ModelAndView personalQuestion() {
		List<PersonalQuestion> list = personalAnswerService.selectAll();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("admin/personalQuestion");
		
		
		return mv;
	}
	
	@RequestMapping("/personalQuestionDetail/{code}")
	public String personalQuestionDetail(@PathVariable Long code) {
		
		return "mypage/personalQuestionDetail";
	}
	
	@RequestMapping("/admin/statistics")
	public String statistics() {
		
		return "admin/statistics";
	}
	

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * ������������ ���� ��Ʈ�ѷ� + �������� ��ü ���
	 * */
	@RequestMapping("/notice")
	public String notice(Model m) {
		List<Notice> list = noticeService.select();
		m.addAttribute("list", list);
		return "notice/noticeList";
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
			String path = session.getServletContext().getRealPath("/WEB-INF/save");

			if (file.getSize() > 0) {
				// ÷�ε� �����̸� ������ ����
				String fileName = file.getOriginalFilename();
				notice.setFilename(fileName);
				file.transferTo(new File(path + "/" + fileName));
			}

			noticeService.insert(notice);
			System.out.println("------------확인---------------");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "redirect:notice";
	}


	
	@RequestMapping("/down")
	public ModelAndView down(String fileName, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String path = session.getServletContext().getRealPath("/WEB-INF/save");
		mv.addObject("fname", new File(path+"/"+fileName));
		mv.setViewName("downLoadView"); //bean의 아이디를 찾을 수 있도록 해야한다...
		return mv;
	}
	
	@RequestMapping("/update")
	public String update(Notice notice, MultipartFile file, HttpSession session) {
		try{
			//���� ������ ������ ����
			String path = session.getServletContext().getRealPath("/WEB-INF/save");
			
			
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
	public String fundInsert(Funding funding, MultipartFile file, HttpSession session) {
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

			
			String path = session.getServletContext().getRealPath("/WEB-INF/funding");
			
			
			if(file.getSize()>0) {
				//÷�ε� �����̸� ������ ����
				String fileName = file.getOriginalFilename();
				funding.setImage(fileName);
				//notice.setFilename(fileName);
				file.transferTo(new File(path+"/"+fileName));
			}

			noticeService.fundInsert(funding);

		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/siteManagement";
	}

}
