package modakbul.mvc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.KakaoOAuthToken;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.UsersService;

@Controller
@RequiredArgsConstructor
public class KakaoLoginController {
	private final UsersService usersService;
	

	@RequestMapping("/login/{token}")
	public String login(@PathVariable String token) throws ParseException {
		System.out.println("토큰왔니 ? = " + token);
		String id=usersService.kakaoLogin(token);
		
		if(id==null) {
			return "user/joinForm";
		}
	
		return "redirect:/";
		
	}
	

	
	
	@RequestMapping("/auth/kakao/callback")
	public String getCode(@RequestParam String code) {
		System.out.println("와 ?");
		System.out.println(code);
		KakaoOAuthToken token = usersService.getAccessToken(code);
		
		return "redirect:/login/"+token.getAccess_token();
	}
	
	@RequestMapping("/login/loginUser")
	public void loginUser() {
		
	}
}
