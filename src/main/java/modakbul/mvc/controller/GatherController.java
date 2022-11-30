package modakbul.mvc.controller;

public class GatherController {
	@RequestMapping("/")
	public String index() {
		System.out.println("HomeController의 index.....");
		return "index";//
	}
}

