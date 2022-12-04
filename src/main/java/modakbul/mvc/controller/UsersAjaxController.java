package modakbul.mvc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
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
		return userId;
	}
	
}
