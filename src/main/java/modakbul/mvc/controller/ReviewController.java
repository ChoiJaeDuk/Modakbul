package modakbul.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.service.GatherReviewService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.UserReviewService;

@Controller
public class ReviewController {
	private final static int PAGE_COUNT=3;
	private final static int BLOCK_COUNT=4;	
	
	@Autowired
	private UserReviewService userReviewService;
	
	@Autowired
	private GatherReviewService gatherReviewService;
	
	@Autowired
	private GatherService gatherService;
	
	@RequestMapping("/my_page/my_page_review")
	public ModelAndView reviewStatus(Long userNo,@RequestParam(defaultValue = "1") int nowPage) {
		ModelAndView mv= new ModelAndView();
		 
		  Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		  Page<Gather> page = gatherService.selectByReviewState(userNo, false,pageable);
		 
		  
		  int temp= (nowPage -1)%BLOCK_COUNT; 
		  int startPage= nowPage-temp;
		  
		  mv.setViewName("/my_page/my_page_review");
		  mv.addObject("reviewStatusList", page);
		  mv.addObject("userNo", userNo);
		  
		  mv.addObject("blockCount", BLOCK_COUNT); 
		  mv.addObject("startPage", startPage);
		  mv.addObject("nowPage", nowPage);
		  System.out.println("컨트롤러 오나용");
		  
		  System.out.println(page.getSize());
		  return mv; 
		  }
	@RequestMapping("/my_page/my_page_review/complete")
	public ModelAndView reviewStatusComplete(Long userNo,@RequestParam(defaultValue = "1") int nowPage) {
		ModelAndView mv= new ModelAndView();
		 
		  Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		  Page<Gather> page = gatherService.selectByReviewState(userNo, true,pageable);
		 
		  
		  int temp= (nowPage -1)%BLOCK_COUNT; 
		  int startPage= nowPage-temp;
		  
		  mv.setViewName("/my_page/my_page_review_complete");
		  mv.addObject("reviewStatusCompleteList", page);
		  mv.addObject("userNo", userNo);
		  
		  
		  mv.addObject("blockCount", BLOCK_COUNT); 
		  mv.addObject("startPage", startPage);
		  mv.addObject("nowPage", nowPage);
		  
		  System.out.println(page.getSize());
		  return mv; 
		  }
	
	
	
	}

