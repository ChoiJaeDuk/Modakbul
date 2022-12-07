package modakbul.mvc.service;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailTest {

	public static String MailSend(String userEmail) {
		//smtop 서버 정보를 설정
		Properties p = System.getProperties();
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.host", "smtp.naver.com");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.ssl.enable", "true");

		Authenticator auth = new MyAuthentication();

		Session session = Session.getDefaultInstance(p, auth);
		MimeMessage msg = new MimeMessage(session);
		
		//email전송
		try {

			msg.setSentDate(new Date());
			InternetAddress from = new InternetAddress();
			from = new InternetAddress("aj5452@naver.com"); // 수신자

			msg.setFrom(from);

			InternetAddress to = new InternetAddress(userEmail); // 발신자
			msg.setRecipient(Message.RecipientType.TO, to);

			msg.setSubject("회원가입 이메일 인증", "UTF-8");

			//msg.setText(text, "UTF-8");

			msg.setHeader("content-Type", "text/html");

			javax.mail.Transport.send(msg, msg.getAllRecipients());

		} catch (AddressException addr_e) {
			addr_e.printStackTrace();
		} catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		} catch (Exception msg_e) {
			msg_e.printStackTrace();
		}
		
		return null;
	}
	
	

}

class MyAuthentication extends Authenticator {

	PasswordAuthentication pa;

	public MyAuthentication() {

		String id = "aj5452@naver.com";
		String pw = "wldms!4869";

		pa = new PasswordAuthentication(id, pw);
	}

	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}
