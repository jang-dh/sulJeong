package team.hunter.controller;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import team.hunter.model.dto.Member;
import team.hunter.model.email.Email;
import team.hunter.model.email.EmailSender;
import team.hunter.model.service.MemberService;

@Controller
public class EmailController {
	@Autowired private EmailSender emailSender;
	@Autowired private MemberService memberService;
	@Autowired private Email email;

	// 새로운 비밀번호가 생성된다.
	@RequestMapping("/pwdCheck")
	public String newPassword(Member member, HttpSession session) throws Exception {
		System.out.println("member나오니???"+member.getPhone()+member.getId()+member.getEmail());
		Random r = new Random();
		int num = r.nextInt(89999) + 10000;
		String npassword = "bapsi" + Integer.toString(num);// 새로운 비밀번호 변경
		member.setPwd(npassword);
		session.setAttribute("member", member);
		return "forward:findPassword";
	}



	// 이메일로 비밀번호가 전송이된다.
	@RequestMapping("/findPassword")
	public String findPasswordOK(Member member, HttpSession session, Model model) throws Exception {
		member = (Member) session.getAttribute("member");
			email.setContent("새로운 비밀번호 " + member.getPwd() + " 입니다." );
			email.setReceiver(member.getEmail());
			email.setSubject("안녕하세요"+member.getEmail() +"님  재설정된 비밀번호를 확인해주세요");
			emailSender.SendEmail(email);
			System.out.println(email);
			int result = memberService.newPassword(member);
			model.addAttribute("result", result);
			session.invalidate();
			return "forward:searchLoginInfoForm";
	}
	
}
