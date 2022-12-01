package modakbul.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity // WebSecurityConfigurerAdapter 기본클래스를 확장(상속)하고 필요한 메소드를 재정의해서 사용한다.
public class SecurityConfig  {
	

	@Bean
	public static BCryptPasswordEncoder getPassWordEncoder() {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		return passwordEncoder;
		
	}
	
}
