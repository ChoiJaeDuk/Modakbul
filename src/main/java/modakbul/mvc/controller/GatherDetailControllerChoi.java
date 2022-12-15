package modakbul.mvc.controller;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.domain.InquiryReply;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.InquiryReplytService;
import modakbul.mvc.service.InquiryService;
import modakbul.mvc.service.ParticipantService;
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
	
	@RequestMapping("/info")
	public void info(Model model, Long gatherNo, String userNo) {
		System.out.println("userNo = " + userNo);
		Long userNoLong = Long.parseLong(userNo);
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		  
		int check = participantService.checkParticipant(gatherNo, userNoLong);
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		  
		model.addAttribute("gather", gather); model.addAttribute("participant", participant);
		 
	}
	
	@RequestMapping("/hostProfile")
	public void hostProfile(Model model, Long gatherNo, Long userNo) {
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		
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
	public void review(Model model, Long gatherNo, Long userNo) {
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		
	}
	
	@RequestMapping("/insertParticipant")
	public String insertParticipant(Model model, String userNo, Long gatherNo, String state,RedirectAttributes re) {
		System.out.println("호출되니?");
		System.out.println("userNo = " + userNo);
		System.out.println("gatherNo = " + gatherNo);
		Gather gather = new Gather(gatherNo);
		
		re.addAttribute("userNo",userNo);
		re.addAttribute("gatherNo",gatherNo);
		
		return "redirect:/gatherDetail/info";
	}
}
