package modakbul.mvc.service;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MailSendServiceImpl implements MailSendService {
	
	@Autowired
	private JavaMailSender emailSender;
	
	private String ePw;

	@Override
	public MimeMessage createMessage(String to) throws MessagingException, UnsupportedEncodingException {
		
		MimeMessage message = emailSender.createMimeMessage();
		
		message.addRecipients(RecipientType.TO, to);
		message.setSubject("모닥불 회원가입 이메일 인증");
		
		String content = "";
		content += "<div style='margin:100px;'>";
		content += "<h1> 안녕하세요</h1>";
		content += "<h1> 즐거운 모임을 가지자 모닥불 입니다 </h1>";
		content += "<br>";
		content += "<p>아래 코드를 회원가입 창으로 돌아가 입력해주세요.<p>";
		content += "<br>";
		content += "<div align='center' style='border:1px solid black; font-family:verdada';>";
		content += "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
		content += "<div style='font-size:130%'>";
		content += "CODE : <strong>";
		content += ePw + "</strong><div><br/>";
		content += "</div>";
		message.setText(content, "utf-8", "html");
		message.setFrom(new InternetAddress("aj5452@naver.com", "modakbul_Admin"));
				
		return message;
	}

	@Override
	public String createKey() {
		StringBuffer key = new StringBuffer();
		Random rand = new Random();
		
		for(int i = 0; i < 8; i++) {
			int index = rand.nextInt(3); 
			
			switch (index) {
			case 0:
				key.append((char) ((int) (rand.nextInt(26)) + 97));
				
				break;
				
			case 1:
				key.append((char) ((int) (rand.nextInt(26)) + 65));
				
				break;

			case 2:
				key.append((rand.nextInt(10)));
				
				break;
			}
		}
		
		return key.toString();
	}

	@Override
	public String sendSimpleMessage(String to) throws Exception {
		
		ePw = createKey();
		
		MimeMessage message = createMessage(to);
		try {
			
			emailSender.send(message);
			
		}catch (MailException me) {
			me.printStackTrace();
			throw new IllegalArgumentException();
		}
		
		return ePw;
	}

}
