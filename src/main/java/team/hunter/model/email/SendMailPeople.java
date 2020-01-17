package team.hunter.model.email;

import java.util.List;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;
import team.hunter.model.service.EmailAlertService;

@Component
public class SendMailPeople {
	
	@Autowired JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성을 주입함.
	@Autowired private EmailAlertService emailAlertService;
	
		/**
		 * 펀딩 성공 시 이메일 보내기
		 * */
		
		public void mailSuccessSending() throws Exception {
			String setfrom = "suoung0716@gamil.com";
			String title = "펀딩 성공 이메일 입니다."; // 제목
			//System.out.println(setfrom+"너는 나오니??");
			List<Funding> fundingSuccessList = emailAlertService.fundingSuccessAlert();
			for( Funding funding : fundingSuccessList) {
				String content =

						System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

								System.getProperty("line.separator") +

								"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"후원하신 "+funding.getRewardName()+" 제품이 펀딩에 성공하였습니다."

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"자동으로 결제가 진행 될 예정입니다."; // 내용

				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
					
					
					messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
					// 받는 사람 이메일주소 세팅
					InternetAddress[] toAddr = new InternetAddress[funding.getMemberList().size()];
					
					int i=0;
					for(Member member : funding.getMemberList()) {
						toAddr[i++] = new InternetAddress(member.getEmail());
						//toAddr[1] = new InternetAddress("메일받는사람 전체주소2");
					}
					
					message.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
					messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
					messageHelper.setText(content); // 메일 내용
					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e);
				}
			}
		}
		
		
		/**
		 * 펀딩 실패 시 이메일
		 * */
		public void mailFailSending() throws Exception {
			String setfrom = "suoung0716@gamil.com";
			String title = "펀딩 실패 이메일 입니다."; // 제목
			
			List<Funding> fundingFailList = emailAlertService.fundingFailAlert();
			for( Funding funding : fundingFailList) {
				
				
				String content =

						System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

								System.getProperty("line.separator") +

								"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"후원하신 "+funding.getRewardName()+" 제품이 펀딩에 실패 하였습니다."

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"다음에도 술정을 찾아주세요~~ 감사합니다 :) "; // 내용

				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
					
					
					messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
					// 받는 사람 이메일주소 세팅
					InternetAddress[] toAddr = new InternetAddress[funding.getMemberList().size()];
					
					int i=0;
					for(Member member : funding.getMemberList()) {
						toAddr[i++] = new InternetAddress(member.getEmail());
						//toAddr[1] = new InternetAddress("메일받는사람 전체주소2");
					}
					
					message.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
					messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
					messageHelper.setText(content); // 메일 내용
					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e);
				}
			}
		}
		
		/**
		 * 마감 하루 전 + 펀딩 한 사람 + 이메일 수신 동의
		 * */
		public void mailBeforeSending() throws Exception {
			String setfrom = "suoung0716@gamil.com";
			String title = "후원 펀딩 마감 하루 전 이메일 입니다."; // 제목
			
			List<Funding> fundingBeforeList = emailAlertService.fundingOneDayBefore();
			for( Funding funding : fundingBeforeList) {
				
				
				String content =

						System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

								System.getProperty("line.separator") +

								"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"후원하신 "+funding.getRewardName()+" 제품이 펀딩마감 하루 전 입니다!!!"

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"다음에도 술정을 찾아주세요~~ 감사합니다 :) "; // 내용

				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
					
					
					messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
					// 받는 사람 이메일주소 세팅
					InternetAddress[] toAddr = new InternetAddress[funding.getMemberList().size()];
					
					int i=0;
					for(Member member : funding.getMemberList()) {
						toAddr[i++] = new InternetAddress(member.getEmail());
						//toAddr[1] = new InternetAddress("메일받는사람 전체주소2");
					}
					
					message.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
					messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
					messageHelper.setText(content); // 메일 내용
					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e);
				}
			}
		}
		
		
		/**
		 * 마감 하루 전 + 좋아요 한 사람 + 이메일 수신 동의
		 * */
		public void mailBeforeSendingLikes() throws Exception {
			String setfrom = "suoung0716@gamil.com";
			String title = "좋아요 하신 펀딩 마감 하루 전 이메일 입니다."; // 제목
			
			List<Funding> fundingBeforeLikesList = emailAlertService.fundingOneDayBeforeLikes();
			for( Funding funding : fundingBeforeLikesList) {
				
				
				String content =

						System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

								System.getProperty("line.separator") +

								"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"좋아요 신청하신  "+funding.getRewardName()+" 제품이 펀딩마감 하루 전 입니다!!! 서둘러 주세요 !!!!"

								+ System.getProperty("line.separator") +

								System.getProperty("line.separator") +

								"다음에도 술정을 찾아주세요~~ 감사합니다 :) "; // 내용

				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
					
					
					messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
					// 받는 사람 이메일주소 세팅
					InternetAddress[] toAddr = new InternetAddress[funding.getMemberList().size()];
					
					int i=0;
					for(Member member : funding.getMemberList()) {
						toAddr[i++] = new InternetAddress(member.getEmail());
						//toAddr[1] = new InternetAddress("메일받는사람 전체주소2");
					}
					
					message.setRecipients(Message.RecipientType.TO, toAddr); // 수신자 셋팅
					messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
					messageHelper.setText(content); // 메일 내용
					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e);
				}
			}
		}
}


