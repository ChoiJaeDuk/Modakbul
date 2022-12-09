package modakbul.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import modakbul.mvc.service.GatherReviewService;
import modakbul.mvc.service.UserReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	private UserReviewService userReviewService;
	
	@Autowired
	private GatherReviewService gatherReviewService;
	
	@RequestMapping("/my_page/my_page_review")
	public void review() {
		
	}
}
