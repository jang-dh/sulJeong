package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Notice;
import team.hunter.model.service.NoticeService;

@Controller
public class AdminController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("/introduce")
	public String introduce() {
		return "main/introduce";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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
		noticeService.selectByCode(code);
	}

}
