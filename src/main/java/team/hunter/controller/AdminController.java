package team.hunter.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.NotContextException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.Notice;
import team.hunter.model.dto.Paging;
import team.hunter.model.dto.PersonalAnswer;
import team.hunter.model.dto.PersonalQuestion;
import team.hunter.model.dto.Statistics;
import team.hunter.model.service.EmailAlertService;
import team.hunter.model.service.FundingService;
import team.hunter.model.service.NoticeService;
import team.hunter.model.service.PersonalAnswerService;
import team.hunter.model.service.StatisticsService;
import team.hunter.util.Constants;

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
	
	@Autowired JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성을 주입함.
	@Autowired private EmailAlertService emailAlertService; //이메일 수신 동의 체크한 사람 알기 위해 필요
	
	
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
		SimpleDateFormat originFormat = new SimpleDateFormat("MM/dd/yyyy");
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		try {
			
			Date originOpenDate = originFormat.parse(funding.getOpenDate());
			String newOpenDate = newFormat.format(originOpenDate);
			funding.setOpenDate(newOpenDate);
			
			Date originEndDate = originFormat.parse(funding.getEndDate());
			String newEndDate = newFormat.format(originEndDate);
			funding.setEndDate(newEndDate);
			
			Date currentDate = new Date();
			
			if(originOpenDate.getTime() > currentDate.getTime()) {
				funding.setFundingState(Constants.FUNDING_PRE);
			}else {
				funding.setFundingState(Constants.FUNDING_ING);
			}
			
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
			
			//메일보내기 기능 시작!! - 수녕 - 
			//이메일 수신체크 한 사람에게 펀딩 등록 될 때 마다 메일 보내줘야 하므로 추가
			List<Member> emailAcceptList = emailAlertService.emailAcceptMember();
			
			//메일 보내기 기능
				String setfrom = "suoung0716@gamil.com";
				String title = "펀딩 공지사항 등록 메일입니다 :) "; // 제목
				String content =

							System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

									System.getProperty("line.separator") +

									"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

									+ System.getProperty("line.separator") +

									System.getProperty("line.separator") +

									"새로운 공지사항이 등록되었으니 홈페이지에 와서 확인 해주세요 ~ ♡"
									
									+ System.getProperty("line.separator") +
									

									 System.getProperty("line.separator") +

									System.getProperty("line.separator") +

									"술정에 놀러오세요~~~~"; // 내용

					try {
						MimeMessage message = mailSender.createMimeMessage();
						MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
						
						
						messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
						// 받는 사람 이메일주소 세팅
						InternetAddress[] toAddr = new InternetAddress[emailAcceptList.size()];
						
						int i=0;
						for(Member member : emailAcceptList) {
							toAddr[i++] = new InternetAddress(member.getEmail());
						}
						
						message.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
						messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
						messageHelper.setText(content); // 메일 내용
						mailSender.send(message);
					} catch (Exception e) {
						System.out.println(e);
					}
			//메일 보내기 기능 끝!!!!! - 수녕 - 

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
	
	@RequestMapping("/down2")
	public ModelAndView down2(String fileName, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String path = "C:\\Edu\\springFileSave";
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
		String hwak1 = null;
		String onlyName1 =null;
		String hwak2 = null;
		String onlyName2 =null;
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
				
				//파일 이름만 구하기
				int pos = fileName.lastIndexOf( "." );
				onlyName1 = fileName.substring(0, pos);
				//확장자 명 구하기
				hwak1 = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
				String Thumnail = "Thumnail_"+fileName;
				funding.setImage(fileName);
				//notice.setFilename(fileName);
				file.transferTo(new File(path+"/"+Thumnail));
			}
			
			if(file2.getSize()>0) {
				//÷�ε� �����̸� ������ ����
				String secondfileName = file2.getOriginalFilename();
				//확장자 명 구하기
				hwak2 = secondfileName.substring(secondfileName.lastIndexOf(".")+1,secondfileName.length());

				
				String Detail = "Detail_"+onlyName1+"."+hwak1;
				//notice.setFilename(fileName);
				file2.transferTo(new File(path+"/"+Detail));
			}
			

			noticeService.fundInsert(funding, code);
			
			//메일보내기 기능 시작!! - 수녕 - 
			//이메일 수신체크 한 사람에게 펀딩 등록 될 때 마다 메일 보내줘야 하므로 추가
			List<Member> emailAcceptList = emailAlertService.emailAcceptMember();
			
			//메일 보내기 기능
				String setfrom = "suoung0716@gamil.com";
				String title = "펀딩 신규 등록 메일입니다 :) "; // 제목
				String content =

							System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

									System.getProperty("line.separator") +

									"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

									+ System.getProperty("line.separator") +

									System.getProperty("line.separator") +

									"새로운 펀딩이 등록되었으니 홈페이지에 와서 구경하고 가세요 ~ ♡"
									
									+ System.getProperty("line.separator") +
									
									"새로 등록된 펀딩 : "+ funding.getRewardName()

									+ System.getProperty("line.separator") +

									System.getProperty("line.separator") +

									"술정에 놀러오세요~~~~"; // 내용

					try {
						MimeMessage message = mailSender.createMimeMessage();
						MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
						
						
						messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
						// 받는 사람 이메일주소 세팅
						InternetAddress[] toAddr = new InternetAddress[emailAcceptList.size()];
						
						int i=0;
						for(Member member : emailAcceptList) {
							toAddr[i++] = new InternetAddress(member.getEmail());
						}
						
						message.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
						messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
						messageHelper.setText(content); // 메일 내용
						mailSender.send(message);
					} catch (Exception e) {
						System.out.println(e);
					}
			//메일 보내기 기능 끝!!!!! - 수녕 - 
			

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
	
	@ExceptionHandler({Exception.class})
	public String error() {
		return "error/errorPage";
	}
	
	/**
	 * 403에러
	 * */
	@RequestMapping("/error/errorPage")
	public String error403() {
		return "error/errorPage";
	}

}
