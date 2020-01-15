package team.hunter.model.email;

import java.util.Random;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class SendMailPeople {
	
	@Autowired
	JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성을 주입함.

		
		public int mailSending() throws Exception {
			Random r = new Random();
			int dice = r.nextInt(4589362) + 49311; // 이메일로 받는 인증코드 부분 (난수)

			String setfrom = "suoung0716@gamil.com";
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
				// 받는 사람 이메일주소 세팅
				InternetAddress[] toAddr = new InternetAddress[2];
				toAddr[0] = new InternetAddress("메일받는사람 전체주소1");
				toAddr[1] = new InternetAddress("메일받는사람 전체주소2");

				message.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용
				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}


			return dice;
		}
}

		/* PORT = 25:non-ssl, 465:ssl, 587:tls */
//		Properties props = System.getProperties();
//		
//		
//
//		try {
//			String sender = "보내는사람메일주소"; // 보내는사람 메일주소. ex) mailSender@naver.com
//			String subject = "메일 테스트"; // 메일 제목
//			String body = "ㅁ ㅏ 메일 받아라 !!"; // 메일 본문
//
//			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
//				String un = userId;
//				String pw = userPw;
//
//				protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
//					return new javax.mail.PasswordAuthentication(un, pw);
//				}
//			});
//			session.setDebug(false); // Debug 모드 설정.
//
//			Message mimeMessage = new MimeMessage(session);
//			mimeMessage.setFrom(new InternetAddress(sender));
//
//			// 받는 사람 이메일주소 세팅
//			InternetAddress[] toAddr = new InternetAddress[2];
//			toAddr[0] = new InternetAddress("메일받는사람 전체주소1");
//			toAddr[1] = new InternetAddress("메일받는사람 전체주소2");
//
//			mimeMessage.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
//
//			mimeMessage.setSubject(subject); // 제목 세팅
//			mimeMessage.setText(body); // 본문 세팅
//
//			//메일 발송
//			Transport.send(mimeMessage);
//
//			System.out.println("메일 발송 성공!!");
//		} catch (Exception e) {
//			System.out.println("메일보내기 오류 : " + e.getMessage());
//		}
//	}
//
//}
