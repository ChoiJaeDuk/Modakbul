package modakbul.mvc.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.KakaoOAuthToken;
import modakbul.mvc.domain.KakaoProfile;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.UsersService;

@Controller
@RequiredArgsConstructor
public class KakaoLoginController {
	private final UsersService usersService;
	

	@RequestMapping("/login/{token}")
	public String login(@PathVariable String token, Model model) throws ParseException {
		System.out.println("토큰왔니 ? = " + token);
		HashMap<String, Object> userInfo = usersService.kakaoLogin(token);
		String id = (String)userInfo.get("id");
		System.out.println("id = " + userInfo.get("gender"));
		System.out.println("id = " + userInfo.get("id"));
		
		if(id==null) {
			model.addAttribute("userInfo", userInfo);
			return "user/joinForm";
		}
	
		return "redirect:/";
		
	}
	

	
	
	@RequestMapping("/auth/kakao/callback")
	public String getCode(@RequestParam String code) {
		System.out.println("와 ?");
		System.out.println(code);
		KakaoOAuthToken token = usersService.getAccessToken(code);
		System.out.println("가져왔어 ? "+token);
		
		return "redirect:/login/"+token.getAccess_token();
	}
	
	@RequestMapping("/login/loginUser")
	public void loginUser() {
		
	}
}
