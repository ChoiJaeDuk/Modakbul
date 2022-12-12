package modakbul.mvc.controller;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.SelectReplyState;
import modakbul.mvc.service.FollowService;
import modakbul.mvc.service.InquiryService;
import modakbul.mvc.service.UsersService;

@Controller
public class InquiryController {
	@Autowired
	private InquiryService inqService;
	
	@Autowired
	private UsersService usersService;
	
	@Autowired
	private FollowService followService;

	@Autowired
	private  static int PAGE_COUNT=5;//상수//한 페이지당 5개
	@Autowired
	private  static int BLOCK_COUNT=4;
	
	@RequestMapping("/my_page/my_page_index")
	public ModelAndView main(Long userNo,@RequestParam(defaultValue = "1") int nowPage) {
		ModelAndView mv= new ModelAndView();
		
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);//0부터 시작, PAGE_COUNT(10)개씩 뿌림, 정렬, 기준=bno
		//PageRequest pageRequest = PageRequest.of(0, 5);
		Page<SelectReplyState> list=inqService.selectReplyState(userNo, pageable);
		List<SelectReplyState> resultList1 = list.getContent();
		Long totalWaiting=list.getTotalElements();

		
		 int temp = (nowPage - 1) % BLOCK_COUNT;
		 int startPage = nowPage - temp;
		 
		
		mv.addObject("replyState", totalWaiting); 
		System.out.println(resultList1.size());
		//mv.addObject("nowPage", pages);
		mv.setViewName("my_page/my_page_index");
		 mv.addObject("blockCount", BLOCK_COUNT);
		 mv.addObject("startPage",startPage);
		 mv.addObject("nowPage", nowPage);
		
		
		return mv;
	}
	
	@RequestMapping("my_page/my_page_inquiry")
	public void inquiryStatus(Long userNo,Model model, @RequestParam(defaultValue = "1") int nowPage, HttpSession session) {
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);

		String fileNames [] = file.list();
		
		Page<SelectReplyState> page= inqService.selectReplyState(userNo, pageable);
		Users dbUser=usersService.selectById(userNo);
		List<Follow> following = followService.myFollowing(userNo);	
		List<Follow> follower = followService.myFollower(userNo);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		 
		model.addAttribute("inquiryList", page);
		
		model.addAttribute("user", dbUser);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("fileNames", fileNames);
		

	}

}
