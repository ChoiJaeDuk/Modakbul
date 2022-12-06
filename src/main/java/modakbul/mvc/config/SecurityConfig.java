package modakbul.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.security.UserRoleProvider;



@Configuration
@EnableWebSecurity 
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	private final UserRoleProvider userRoleProvider;

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http
		.authorizeRequests()  //  security-context  <security:intercept-url
		.antMatchers("/user/login") //     pattern="/member/main" 
		.hasRole("USER")            //      access="isAuthenticated()"
		.antMatchers("/member/**")
		.authenticated()
		.antMatchers("/admin/**")
		.hasRole("USER")
		.and()
		//.csrf().disable() // <security:csrf disabled="true"/>
		.formLogin()
		.loginPage("/user/loginForm")
		.loginProcessingUrl("/user/loginCheck")
		.usernameParameter("id")
		.passwordParameter("pwd")
		.defaultSuccessUrl("/")
		.failureForwardUrl("/user/loginForm?err")
		.and()
		.logout()
		.logoutUrl("/logout")
		.logoutSuccessUrl("/")
		.invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		.and();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
	
		auth.authenticationProvider(userRoleProvider);
		
	}
	
	@Bean
	public static BCryptPasswordEncoder getPassWordEncoder() {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		return passwordEncoder;
		
	}
	
	@Bean
	public AuthenticationManager authenticationManagerBean() throws Exception{
		return super.authenticationManagerBean();
	}
    
}



