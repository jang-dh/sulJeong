package team.hunter.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import team.hunter.model.dto.Member;
import team.hunter.model.email.Email;
import team.hunter.model.email.EmailSender;
import team.hunter.model.service.MemberService;

@Controller
public class EmailController {
	@Autowired
	private EmailSender emailSender;
	@Autowired
	private MemberService memberService;
	@Autowired
	private Email email;
	@Autowired
	JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성을 주입함.

	// 새로운 비밀번호가 생성된다.
	@RequestMapping("/pwdCheck")
	public String newPassword(Member member, HttpSession session) throws Exception {
		System.out.println("member나오니???" + member.getPhone() + member.getId() + member.getEmail());
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
		email.setContent("새로운 비밀번호 " + member.getPwd() + " 입니다.");
		email.setReceiver(member.getEmail());
		email.setSubject("안녕하세요" + member.getEmail() + "님  재설정된 비밀번호를 확인해주세요");
		emailSender.SendEmail(email);
		System.out.println(email);
		int result = memberService.newPassword(member);
		model.addAttribute("result", result);
		session.invalidate();
		return "forward:searchLoginInfoForm";
	}

	// mailSending 코드
	@RequestMapping("/member/auth")
	@ResponseBody
	public int mailSending(String email, HttpServletResponse response_email) throws Exception {
		System.out.println(email+"이메일 나오냐?");
		Random r = new Random();
		int dice = r.nextInt(4589362) + 49311; // 이메일로 받는 인증코드 부분 (난수)

		String setfrom = "suoung0716@gamil.com";
		String tomail = email; // 받는 사람 이메일
		String title = "회원가입 인증 이메일 입니다."; // 제목
		String content =

				System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

						System.getProperty("line.separator") +

						"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						" 인증번호는 " + dice + " 입니다. "

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						"받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}


		return dice;
	}

//이메일로 받은 인증번호를 입력하고 전송 버튼을 누르면 맵핑되는 메소드.
//내가 입력한 인증번호와 메일로 입력한 인증번호가 맞는지 확인해서 맞으면 회원가입 페이지로 넘어가고,
//틀리면 다시 원래 페이지로 돌아오는 메소드
	@RequestMapping(value = "/member/auth/{dice}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean join_injeung(String childEmailAuth, @PathVariable String dice,
			HttpServletResponse response_equals) throws Exception {

		System.out.println("마지막 : childEmailAuth : " + childEmailAuth);

		System.out.println("마지막 : dice : " + dice);

		if (childEmailAuth.equals(dice)) {
			return true;

		} else if (childEmailAuth != dice) {
			return false;
		}
		return false;
	}
}
