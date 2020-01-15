package team.hunter.model.email;

import javax.activation.DataSource;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;


/*
 * 메일 인증 서비스 사용하기
 * 회원가입 시 이메일 인증을 위한 클래스 
 * */

public class MailHandler {
    
    private JavaMailSender mailSender;
    private MimeMessage message;
    private MimeMessageHelper messageHelper;
    
    public MailHandler(JavaMailSender mailSender) throws Exception {
        this.mailSender = mailSender;
        message = this.mailSender.createMimeMessage();
        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    }
    
    public void setSubject(String subject) throws Exception {
        messageHelper.setSubject(subject);
    }
    
    public void setText(String htmlContent) throws Exception {
        messageHelper.setText(htmlContent, true);
    }
    
    public void setFrom(String email, String name) throws Exception {
        messageHelper.setFrom(email, name);
    }
    
    public void setTo(String email) throws Exception {
        messageHelper.setTo(email);
    }
    
    public void addInline(String contentId, DataSource dataSource) throws Exception {
        messageHelper.addInline(contentId, dataSource);
    }
    
    public void send() {
        mailSender.send(message);
    }
}