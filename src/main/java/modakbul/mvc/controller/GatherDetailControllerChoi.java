
package modakbul.mvc.controller;


import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.domain.InquiryReply;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.UserReview;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.GatherReviewService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.InquiryReplytService;
import modakbul.mvc.service.InquiryService;
import modakbul.mvc.service.LikeGatherService;
import modakbul.mvc.service.ParticipantService;
import modakbul.mvc.service.UserReviewService;
import modakbul.mvc.service.UsersService;
@Controller
@RequestMapping("/gatherDetail")
@RequiredArgsConstructor
public class GatherDetailControllerChoi {

	
	private final GatherService gatherService;
	private final ParticipantService participantService;

	private final InquiryService inquiryService;
	private final InquiryReplytService inquiryReplyService;
	
	private final static int PAGE_COUNT=5;
	private final static int BLOCK_COUNT=5;

	private final LikeGatherService lgService;

	private final UsersService usersService;
	private final GatherReviewService gatherReviewService;
	private final UserReviewService userReviewService;

	
	@RequestMapping("/info")
	public void info(Model model, Long gatherNo, Long userNo) {
		System.out.println("userNo = " + userNo);
		//Long userNoLong = Long.parseLong(userNo);
		//Long gatherNoLong = Long.parseLong(gatherNo);
	
		String yesOrNo = lgService.selectEle(gatherNo, userNo);
		model.addAttribute("yesOrNo", yesOrNo);
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		List<String> fileList = gatherService.selectGatherFile(gatherNo);
		  
		int check = participantService.checkParticipant(gatherNo, userNo);
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		System.out.println("check = "+check);  
		
		model.addAttribute("fileList", fileList);
		model.addAttribute("gather", gather); 
		model.addAttribute("participant", participant);
		model.addAttribute("userNo1", userNo);
		model.addAttribute("check", check);

	}
	
	@RequestMapping("/hostProfile")
	public void hostProfile(Model model, Long gatherNo, Long userNo, HttpSession session,@RequestParam(defaultValue = "1") int nowPage) {
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);
		
		String fileNames [] = file.list();
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		Users user = usersService.selectById(gather.getUser().getUserNo());
		System.out.println("user = " + user.getUserNo());
		
		//주최한 사람
		Page<UserReview> userReview=userReviewService.selectByUserNo(user.getUserNo(),pageable);
		List<UserReview> list=userReview.getContent();


		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		model.addAttribute("userNo1", userNo);
		model.addAttribute("hostUser", user);
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		model.addAttribute("fileNames", fileNames);
		model.addAttribute("userReviewPageList", userReview);
		model.addAttribute("userReviewList", list);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		
	}
	
	
	@RequestMapping("/qna")
	public void qna(Model model, Long gatherNo, Long userNo, @RequestParam(defaultValue = "1") int nowPage) {
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		//Long userNoLong = Long.parseLong(userNo);
		System.out.println("userno="+userNo);
		
		Page<Inquiry> page =inquiryService.InquiryListByGatherNo(gatherNo, pageable);
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		String yesOrNo = lgService.selectEle(gatherNo, userNo);
		model.addAttribute("yesOrNo", yesOrNo);
		model.addAttribute("userNo1", userNo);
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		model.addAttribute("qnaList", page);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		
	}
	
	@RequestMapping("/qnaInsert")
	public String qnaReplyInsert(InquiryReply inquiryReply,Model model,RedirectAttributes re, Long inquiry, Long gatherNo , @RequestParam(defaultValue = "1") int nowPage) {
		
		System.out.println("ss = " + inquiryReply.getInquiryReplycontent()+"/" + gatherNo);
		
		inquiryReply.setInquiry(Inquiry.builder().inqNo(inquiry).build());
		
		
		inquiryReplyService.insertInquiryReply(inquiryReply);
	
		return "redirect:/gatherDetail/qna?inquiry="+inquiry+"&gatherNo="+gatherNo;
	}
	
	
	@RequestMapping("/review")
	public void review(Model model, Long gatherNo, Long userNo, @RequestParam(defaultValue = "1") int nowPage) {
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);
		Page<GatherReview> page=gatherReviewService.selectAllByRegularGatherNo(gatherNo, null);
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		String yesOrNo = lgService.selectEle(gatherNo, userNo);
		model.addAttribute("yesOrNo", yesOrNo);
		model.addAttribute("userNo1", userNo);
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		model.addAttribute("grList", page);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		
	}
	
	@RequestMapping("/insertParticipant")
	public String insertParticipant(Model model, Long userNo, Long gatherNo,RedirectAttributes re) {
		System.out.println("호출되니?");
		System.out.println("userNo = " + userNo);
		System.out.println("gatherNo = " + gatherNo);
		Gather gather = new Gather(gatherNo);

		Users user = new Users(userNo);
		Participant participant = new Participant(0L, gather, user, "신청대기");
		
		int check = participantService.checkParticipant(gatherNo, userNo);
		System.out.println("check = "+check);
		participantService.insertParticipant(participant);
		
		model.addAttribute("check", check);

		re.addAttribute("userNo",userNo);
		re.addAttribute("gatherNo",gatherNo);
		
		return "redirect:/gatherDetail/info";
	}
	
	@RequestMapping("/insert")
	public String insertInquery(Model model,RedirectAttributes re,String gatherName,Inquiry inquiry,Long userNo, Long gatherNo) {
		System.out.println("userNo2 = " + inquiry.getUser().getUserNo());
		System.out.println("gatherNo = " + gatherNo);
		
		inquiryService.insertInquiry(inquiry, gatherName,gatherNo);
		
		return "redirect:/gatherDetail/qna?inquiry="+inquiry+"&gatherNo="+gatherNo;
	}
	
	
	/**
	 * 다운로드 하기
	 * */
	@RequestMapping("/down")
	public ModelAndView down(String fileName, HttpSession session) {
		String path = session.getServletContext().getRealPath("/WEB-INF/save");
		return new ModelAndView("downLoadView","fname", new File(path+"/"+fileName));//뷰의 이름이 bean이름과 동일한 객체를 찾아서 뷰가 실행된다.
	}
}