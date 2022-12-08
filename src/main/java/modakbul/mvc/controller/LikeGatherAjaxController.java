package modakbul.mvc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.service.LikeGatherService;

@RestController
@RequiredArgsConstructor
public class LikeGatherAjaxController {
	
	private final LikeGatherService lgService;
	
	@RequestMapping("insert32321")
	public String insertLg(HttpServletRequest request) {
		return "";
	}
	
	
	
	
	
	
}
