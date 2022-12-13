package modakbul.mvc.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.domain.UserReview;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.FollowService;
import modakbul.mvc.service.GatherReviewService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.UserReviewService;
import modakbul.mvc.service.UsersService;

@Controller
public class ReviewController {
	private final static int PAGE_COUNT=5;
	private final static int BLOCK_COUNT=5;	
	
	@Autowired
	private UserReviewService userReviewService;
	
	@Autowired
	private GatherReviewService gatherReviewService;
	
	@Autowired
	private GatherService gatherService;
	
	@Autowired
	private UsersService usersService;
	
	@Autowired
	private FollowService followService;
	
	@RequestMapping("/my_page/my_page_review")
	public ModelAndView reviewStatus(Long userNo,@RequestParam(defaultValue = "1") int nowPage, HttpSession session) {
		  ModelAndView mv= new ModelAndView();
		  String path = session.getServletContext().getRealPath("/save");
			File file = new File(path);

			String fileNames [] = file.list();
		  
		  Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		  Page<Gather> page = gatherService.selectByReviewState(userNo, false,pageable);
		  List <Gather> confrimSize=page.getContent();
		  Users dbUser=usersService.selectById(userNo);
		  List<Follow> following = followService.myFollowing(userNo);	
		  List<Follow> follower = followService.myFollower(userNo);
		  gatherService.selectGatherByGatherNo(userNo);
		  
		
		  
		  int temp= (nowPage -1)%BLOCK_COUNT; 
		  int startPage= nowPage-temp;
		  
		  mv.setViewName("/my_page/my_page_review");
		  mv.addObject("reviewStatusList", page);
	

		  mv.addObject("user", dbUser);
		  mv.addObject("follower", follower.size());
		  mv.addObject("following", following.size());
		  
		  mv.addObject("blockCount", BLOCK_COUNT); 
		  mv.addObject("startPage", startPage);
		  mv.addObject("nowPage", nowPage);
		  mv.addObject("fileNames", fileNames);
		 
		  
		  System.out.println(page.getSize());
		  return mv; 
		  }
	@RequestMapping("/my_page/my_page_review/complete")
	public ModelAndView reviewStatusComplete(Long userNo,@RequestParam(defaultValue = "1") int nowPage, HttpSession session) {
		ModelAndView mv= new ModelAndView();
		 String path = session.getServletContext().getRealPath("/save");
			File file = new File(path);

			String fileNames [] = file.list();
		  
		  Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		  Page<Gather> page = gatherService.selectByReviewState(userNo, true,pageable);
		  List <Gather> confrimSize=page.getContent();
		  Users dbUser=usersService.selectById(userNo);
		  List<Follow> following = followService.myFollowing(userNo);	
		  List<Follow> follower = followService.myFollower(userNo);
		  
		  int temp= (nowPage -1)%BLOCK_COUNT; 
		  int startPage= nowPage-temp;
		  
		  mv.setViewName("/my_page/my_page_review_complete");
		  mv.addObject("reviewStatusCompleteList", page);
		  
		  
		  mv.addObject("user", dbUser);
		  mv.addObject("follower", follower.size());
		  mv.addObject("following", following.size());
		  
		  mv.addObject("fileNames", fileNames);
		  mv.addObject("blockCount", BLOCK_COUNT); 
		  mv.addObject("startPage", startPage);
		  mv.addObject("nowPage", nowPage);
		  
		  System.out.println(confrimSize.size());
		  System.out.println(page.getSize());
		  
		  return mv; 
		  }
	@RequestMapping("/review/userReviewInsert")
	public void userReviewInsertForm(Long gatherNo, Long userNo,Model model) {
		//userReviewService.insert(userReview);
		Gather gather=gatherService.selectGatherByGatherNo(gatherNo);
		model.addAttribute("gather", gather);
		model.addAttribute("userNo", userNo);
	}
	
	@RequestMapping("/review/userReviewInsertbutton")
	public String userReviewInsertbutton(UserReview userReview, Model model, @RequestParam(defaultValue = "1") int nowPage) {
		userReviewService.insert(userReview);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		  
		model.addAttribute("startPage",startPage);
		model.addAttribute("blockCount", BLOCK_COUNT); 
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		
		
		Long userNo=userReview.getWriterUser().getUserNo();
		System.out.println(userNo);
		
		return "redirect:/my_page/my_page_review?userNo="+userNo; //여기 경우 만들어서 테으스
	}
	
	
	@RequestMapping("/gatherDetail/review")
	public void gatherDetailReview() {
		
	}
	
	}

