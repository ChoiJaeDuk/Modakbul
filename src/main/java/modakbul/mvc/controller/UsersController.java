package modakbul.mvc.controller;

import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import lombok.RequiredArgsConstructor;
import modakbul.mvc.service.UsersService;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UsersController {
	private final UsersService usersService;
	
	@RequestMapping("/loginForm")
	public void loginForm() {
		System.out.println("오냐고 !!");
		
	}
	
	@RequestMapping("/login")
	public void login() {
		
	}
	
	

}
