package modakbul.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.service.GatherService;

@Controller
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainControllerChoi {
	
	private final GatherService gatherService;
	
	@RequestMapping("/main")
	public void main() {
		
	}
	
	@RequestMapping("{url}")
	public void url() {}
}
