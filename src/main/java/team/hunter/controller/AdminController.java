package team.hunter.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import team.hunter.model.service.NoticeService;

@Controller
public class AdminController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 서비스소개 페이지 진입
	 * */
	@RequestMapping("/introduce")
	public String introduce() {
		return "main/introduce";
	}
	
	/**
	 * 관리자페이지
	 * */
	@RequestMapping("/admin/siteManagement")
	public void siteManagement() {}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 공지사항으로 들어가는 컨트롤러 + 공지사항 전체 출력
	 * */
	@RequestMapping("/notice")
	public String notice(Model m) {
		List<Notice> list = noticeService.select();
		m.addAttribute("list", list);
		return "notice/noticeList";
	}

	/**
	 * 공지사항 상세보기
	 * */
	@RequestMapping("/noticeDetail/{code}")
	public ModelAndView detail(@PathVariable int code) {

		Notice notice = noticeService.selectByCode(code);
		ModelAndView m = new ModelAndView("notice/noticeDetail", "detail", notice);
		return m;
		
	}
	
	/**
	 * 공지사항 
	 * 수정하기*/
	@PostMapping("/updateForm")
	public ModelAndView updateForm() {
		return null;
	}
	
	/**
	 * 공지사항 등록펌
	 * */
	@RequestMapping("/insertFrom")
	public String insertFrom() {
		
		return "form/noticeForm";

	}
	
	/**
	 * 공지사항 등록
	 * */
//	@RequestMapping("/insert")
//	public ModelAndView insert(String subject, String content, MultipartFile file, HttpSession session) {
//		Notice notice = new Notice();
//		ModelAndView mv = new ModelAndView();
//		try{
//			notice.setSubject(subject);
//			notice.setContent(content);
//			//실제 저장경로 가지고 오기
//			String path = session.getServletContext().getRealPath("/WEB-INF/save");
//			
//			//첨부된 파일이름 가지고 오기
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

			//실제 저장경로 가지고 오기
			String path = session.getServletContext().getRealPath("/WEB-INF/save");
			
			
			
			if(file.getSize()>0) {
				//첨부된 파일이름 가지고 오기
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
	
	@RequestMapping("/down")
	public ModelAndView down(String fname, HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		String path = session.getServletContext().getRealPath("/WEB-INF/save");
		mv.addObject("fname", new File(path+"/"+fname));
		mv.setViewName("downLoadView"); //bean의 아이디를 찾을 수 있도록 해야한다...
		return mv;
	}
	

}
