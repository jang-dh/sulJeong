package team.hunter.controller;

import java.io.File;
import java.io.IOException;
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
		
		return "admin/iframe/fundingRequest";
	}
	
	@RequestMapping("/admin/fundingInsert")
	public String fundingInsert() {
		
		return "admin/iframe/fundingInsert";
	}
	//1:1문의 조회
	@RequestMapping("/admin/personalQuestion")
	public ModelAndView personalQuestion() {
		List<PersonalQuestion> list = personalAnswerService.selectAll();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("admin/iframe/personalQuestion");
		
		
		return mv;
	}
	
	@RequestMapping("/personalQuestionDetail/{code}")
	public String personalQuestionDetail(@PathVariable Long code) {
		
		return "mypage/personalQuestionDetail";
	}
	
	@RequestMapping("/admin/statistics")
	public String statistics() {
		
		return "admin/iframe/statistics";
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
	
	/**
	 * �������� ���
	 * */
//	@RequestMapping("/insert")
//	public ModelAndView insert(String subject, String content, MultipartFile file, HttpSession session) {
//		Notice notice = new Notice();
//		ModelAndView mv = new ModelAndView();
//		try{
//			notice.setSubject(subject);
//			notice.setContent(content);
//			//���� ������ ������ ����
//			String path = session.getServletContext().getRealPath("/WEB-INF/save");
//			
//			//÷�ε� �����̸� ������ ����
//			String fileName = file.getOriginalFilename();
//			notice.setFilename(fileName);
//			file.transferTo(new File(path+"/"+fileName));
//
//			noticeService.insert(notice);
//			mv.setViewName("notice/noticeList");
//		}catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		return mv;
//	}
	@RequestMapping("/insert")
	public String insert(Notice notice, MultipartFile file, HttpSession session) {

	try{

			//���� ������ ������ ����
			String path = session.getServletContext().getRealPath("/WEB-INF/save");
			
			
			if(file.getSize()>0) {
				//÷�ε� �����̸� ������ ����
				String fileName = file.getOriginalFilename();
				notice.setFilename(fileName);
				file.transferTo(new File(path+"/"+fileName));
			}

			noticeService.insert(notice);

		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:notice";
	}
	
	@RequestMapping("/down/{code}")
	public ModelAndView down(@PathVariable int code, HttpSession session) {
		Notice notice = noticeService.selectByCode(code);
		ModelAndView mv = new ModelAndView();
		String path = session.getServletContext().getRealPath("/WEB-INF/save");
		mv.addObject("fname", new File(path+"/"+notice.getFilename()));
		mv.setViewName("downLoadView"); //bean�� ���̵� ã�� �� �ֵ��� �ؾ��Ѵ�...
		//AJAX로 구현해야할거 같음
		return mv;
	}
	
//	@RequestMapping("/update")
//	public String update(Notice notice, MultipartFile file, HttpSession session) {
//		
//	}

}
