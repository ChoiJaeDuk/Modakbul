package modakbul.mvc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.ServiceQuestion;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.ServiceQuestionService;
import modakbul.mvc.service.UsersService;

@Controller
@RequestMapping("/question")
public class InqueryControllerKyu {
	
	@Autowired
	private ServiceQuestionService serviceQuestionService;
	
	@Autowired
	private UsersService userService;
	
	@Autowired
	private  static int PAGE_COUNT=5;//상수//한 페이지당 5개
	@Autowired
	private  static int BLOCK_COUNT=4;

	@RequestMapping("/inqueryFAQ")
	public void inqueryFAQ() {
	}
	
	@RequestMapping("/inqueryQnA")
	public void qna(Model model, @RequestParam(defaultValue = "1") int nowPage) {
			Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
			
			Page<ServiceQuestion> page= serviceQuestionService.selectAll(pageable);
			List<ServiceQuestion> list=page.getContent(); 
			
			/* Users dbUser=userService.selectById(userNo); */
			
			int temp= (nowPage -1)%BLOCK_COUNT; 
			int startPage= nowPage-temp;
			 
			model.addAttribute("serviceQuestionList", page);
			
			model.addAttribute("blockCount", BLOCK_COUNT);
			model.addAttribute("startPage", startPage);
			model.addAttribute("nowPage", nowPage);
		}
	@RequestMapping("/notice")
	public void notice(Model model, @RequestParam(defaultValue = "1") int nowPage) {
			Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
			
			
			Page<ServiceQuestion> page= serviceQuestionService.selectByAdminNo(pageable);
			List<ServiceQuestion> list=page.getContent(); 
			//Users dbUser=userService.selectById(userNo);
			//ServiceQuestion dbSq=serviceQuestionService.selectByServiceQuestionNo(bb, ., userNo);
			Users dbUser = userService.selectById(4L);
			int temp= (nowPage -1)%BLOCK_COUNT; 
			int startPage= nowPage-temp;
			 
			model.addAttribute("noticeList", page);
			model.addAttribute("user", dbUser);
			
			model.addAttribute("blockCount", BLOCK_COUNT);
			model.addAttribute("startPage", startPage);
			model.addAttribute("nowPage", nowPage);
		}
	
	@RequestMapping("/noticeInsertForm")
	public void noticeInsertForm() {
		
	}
	@RequestMapping("/noticeInsert")	
		public String noticeInsert(ServiceQuestion serviceQuestion) {
			serviceQuestionService.insertServiceQustion(serviceQuestion);
			
			return "redirect:/question/notice";
		}	
	@RequestMapping("/noticeUpdateForm")
	public void noticeUpdateForm(Long serviceQuestionNo,Model model) {
		ServiceQuestion dbNotice=serviceQuestionService.selectNoticeDetail(serviceQuestionNo);
		
		model.addAttribute("dbNotice", dbNotice);
	}
	
	@RequestMapping("/noticeUpdate")
	public ModelAndView noticeUpdate(ServiceQuestion serviceQuestion) {//ServiceQuestion serviceQuestion
		
		ServiceQuestion db=serviceQuestionService.updateNotice(serviceQuestion);
	
		
		return new ModelAndView("question/noticeDetail", "noticeDetail",db);
	}
	
	
	@RequestMapping("/inqueryDetail")
	public void qnaDetail(Long serviceQuestionNo, @RequestParam(required = false) String serviceQuestionPwd, Long userNo, Model model) {
		if(userNo == 4) { //어드민이 들어오면 다 문의사항보여줌 
			ServiceQuestion dbSq=serviceQuestionService.selectByServiceQuestionNo(serviceQuestionNo,null,userNo);
			Users dbUser=userService.selectById(userNo);
			
			model.addAttribute("user", dbUser);
			model.addAttribute("serviceQuestion", dbSq);
			
		}else if(userNo != 4){ //일반 회원이 들어오면 문의사항 보여준다
			ServiceQuestion dbSq=serviceQuestionService.selectByServiceQuestionNo(serviceQuestionNo,serviceQuestionPwd,userNo);
			Users dbUser=userService.selectById(userNo);
			
			model.addAttribute("user", dbUser);
			model.addAttribute("serviceQuestion", dbSq);
		} 
		
	}
	@RequestMapping("/pwdCheck")
	@ResponseBody
	public String pwqCheck(HttpServletRequest request , Authentication auth) {
	 	System.out.println("auth = " + auth);
	 	Users user =(Users)auth.getPrincipal();
	 	System.out.println("user = "+user);
	 	//System.out.println(serviceQuestionNo);
	 	
		String sqNo=request.getParameter("serviceQuestionNo");
		Long.parseLong(sqNo);
		System.out.println(sqNo);
		
		String password=request.getParameter("password");
		System.out.println(user.getUserId() +"//////////"+password);
		
		
		ServiceQuestion sq=serviceQuestionService.selectByServiceQuestionNo(Long.parseLong(sqNo), password, user.getUserNo());
		if (!sq.getServiceQuestionPwd().equals(password)) {
			return "비밀번호가 맞지않습니다.";			
		}
		return "?serviceQuestionNo="+Long.parseLong(sqNo)+"&serviceQuestionPwd="+password+"&userNo="+user.getUserNo();
	}
	
	@RequestMapping("/noticeDetail")
	public void noticeDetail(Long serviceQuestionNo,Model model) {
		ServiceQuestion dbNotice=serviceQuestionService.selectNoticeDetail(serviceQuestionNo );
		
		model.addAttribute("noticeDetail", dbNotice);
	}
		
	@RequestMapping("/question_insert")
	public void inauiryInsertForm() {}
	
	
	@RequestMapping("/questionInsert")
	public String inquiryInsert(ServiceQuestion serviceQuestion) {
		serviceQuestionService.insertServiceQustion(serviceQuestion);
		System.out.println("이거타나 ;;?");
		return "redirect:/question/inqueryQnA";
	}
	
	@RequestMapping("/serviceQuestionDelete")
	public String serviceQuestionDelete(Long serviceQuestionNo,String serviceQuestionPwd) {
		serviceQuestionService.deleteServiceQuestion(serviceQuestionNo, serviceQuestionPwd);
		return null;
	}
	
}
	