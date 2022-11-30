package modakbul.mvc.controller;

import org.springframework.web.bind.annotation.RequestMapping;

public class GatherController {
	@RequestMapping("/")
	public String index() {
		System.out.println("HomeController의 index.....");
		return "index";//
	}
}
