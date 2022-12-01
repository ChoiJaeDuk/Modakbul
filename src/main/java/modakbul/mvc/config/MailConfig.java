package modakbul.mvc.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	
	@Bean
	public JavaMailSender javaMailService() {
		
		JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
		
		javaMailSender.setHost("smtp.naver.com");
		javaMailSender.setUsername("aj5452@naver.com");
		javaMailSender.setPassword("wldms!4869");
		
		javaMailSender.setPort(465);
		
		javaMailSender.setJavaMailProperties(getMailProperties());
		
		return javaMailSender;

	}
	
	private Properties getMailProperties() {
		Properties pro = new Properties();
		pro.setProperty("mail.transport.protocol", "smtp");
		pro.setProperty("mail.smtp.auth", "true");
		pro.setProperty("mail.smtp.starttls.enable", "true");
		pro.setProperty("mail.debug", "true");
		pro.setProperty("mail.smtp.ssl.trust", "smtp.naver.com");
		pro.setProperty("mail.smtp.ssl.enable", "true");
		
		return pro;
	}

}
