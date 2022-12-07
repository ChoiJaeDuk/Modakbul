package modakbul.mvc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.UsersService;

@RestController
@RequiredArgsConstructor
public class UsersAjaxController {
	
	private final UsersService usersService;
	
	@RequestMapping("selectUserId")
	public String selectUserId(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		System.out.println("email = " + email );
		String userId = usersService.selectUserId(email);
		System.out.println(userId);
		if(userId == null) {
			return "이메일에 해당하는 정보가 없습니다.";
		}
		return userId;
		
	}
	
	@RequestMapping("selectUserPwd")
	public String selectUserPwd(HttpServletRequest request) throws Exception{
		
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		System.out.println(email + "," + id);
		boolean result = usersService.selectUserPwd(id, email);
		System.out.println("result = " + result);
		if(result==true) {
			return "해당 이메일로 임시비밀번호가 전송되었습니다.";
		}
		return "해당 정보에 해당하는 회원이 없습니다.";
		
	}
	
	@RequestMapping("sendCode")
	public String emailCheck(HttpServletRequest request) throws Exception {
		String email = request.getParameter("email");
		System.out.println("email = " + email);
		return usersService.sendCode(email);
	}
	
	@RequestMapping("checkId")
	public String checkId(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		
		Users user = usersService.selectById(id);
	
		if(user==null) {
			return "가능";
		}else {
			return "사용";
		}
		
		
	}
	
	@RequestMapping("checkNick")
	public String checkNick(HttpServletRequest request) {
		
		String nick = request.getParameter("nick");
		
		boolean result = usersService.nickCheck(nick);
		System.out.println("nick = " + nick + ", result = " + result);
	
		if(result==true) {
			return "사용가능한 닉네임";
		}else {
			return "이미 사용중인 닉네임";
		}

	}
	

	
	
}
