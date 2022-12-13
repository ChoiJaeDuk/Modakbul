package modakbul.mvc.controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.service.GatherAttachmentsService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.ParticipantService;
import modakbul.mvc.service.RegularGatherService;


@Controller
@RequestMapping("/my_page")
@RequiredArgsConstructor
public class MyPageControllerChoi {
	
	private final GatherService gatherService;
	private final RegularGatherService regularGatherService;
	private final GatherAttachmentsService gatherAttachmentsService;
	private final ParticipantService participantService;
	
	private final static int PAGE_COUNT=2;
	private final static int BLOCK_COUNT=4;
	@RequestMapping("/{url}")
	public void aa() {
		
	}
	
	@RequestMapping("/gatherAD/{url}")
	public void url() {}
	
	@RequestMapping("/gatherSelect/applicationList")
	public void selectApplicationList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> applicationList = participantService.selectApplicationStateByUserNo(userNo, "신청대기", pageable);
		File file = new File(path);
		String fileNames [] = file.list();
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		model.addAttribute("fileNames", fileNames);
		model.addAttribute("applicationList", applicationList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
	
	@RequestMapping("/gatherSelect/upcomingList")
	public void selectUpcomingList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {

		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
	
		
		Page<Gather> upcomingList = participantService.selectApplicationStateByUserNo(userNo, "참가승인", pageable);

		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
	
		model.addAttribute("upcomingList", upcomingList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
	
	
	@RequestMapping("/gatherSelect/participationList")
	public void selectparticipationList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {
	
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
	
		
		
		Page<Gather> participationList = participantService.selectApplicationStateByUserNo(userNo, "참가완료", pageable);
	
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;

		model.addAttribute("participationList", participationList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
	
	
	@RequestMapping("/gatherSelect/waitingList")
	public void selectWaitingList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {
	
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> waitingList = gatherService.selectGatherStateByUserNo(pageable, userNo, "신청대기");
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;

		model.addAttribute("waitingList", waitingList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
	
	
	@RequestMapping("/gatherSelect/recruitingList")
	public void selectRecruitingList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {
	
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		Page<GatherGroupBy> recruitingList = gatherService.selectRecruitingList(pageable, userNo);
		
		model.addAttribute("recruitingList", recruitingList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
	
	
	@RequestMapping("/gatherSelect/completionList")
	public void selectCompletionList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {
	
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);

		Page<Gather> completionList = gatherService.selectGatherStateByUserNo(pageable, userNo, "진행완료");
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		model.addAttribute("completionList", completionList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
	
	@RequestMapping("/gatherSelect/deleteParticipant")
	public String deleteParticipant(Long userNo, Long gatherNo, String url, RedirectAttributes redirect) {
		participantService.deleteParticipant(userNo, gatherNo);
		
		redirect.addAttribute("userNo", userNo);
		return "redirect:/my_page/gatherSelect/"+url;
		
	}
	
	@RequestMapping("/gatherSelect/deleteGather")
	public String deleteGather(Long gatherNo, Long regularGatherNo, Long userNo, RedirectAttributes redirect) {
		
		System.out.println("regularGatherNo = " + regularGatherNo);
	
		gatherService.deleteGather(gatherNo);
		
		if(regularGatherNo!=null) {
			regularGatherService.deleteRegularGather(regularGatherNo);
		}
		
		redirect.addAttribute("userNo", userNo);
		
		
		return "redirect:/my_page/gatherSelect/waitingList";
	}
	
	@RequestMapping("/gatherSelect/cancelGather")
	public String cancelGather(Long userNo, Long gatherNo, int regularGatherState ,RedirectAttributes redirect) {
		
		if(regularGatherState == 0) {
			regularGatherService.updateRegularGatherState(gatherNo, "모임종료");
		}
		
		gatherService.updateGatherState(gatherNo, "모임취소");
		
		redirect.addAttribute("userNo", userNo);
		return "redirect:/my_page/gatherSelect/recruitingList";
	}
	
	
	
	//@RequestMapping("/gatherAD/adApplication")
	public void adApplication(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		

		Page<Gather> adApplicationList = gatherService.selectNoneADGatherList(userNo, pageable);
		
		model.addAttribute("adApplicationList", adApplicationList);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
	}
	
	
	//@RequestMapping("/gatherAD/adWaiting")
	public void adWaiting() {
		
	}
	
	//@RequestMapping("/gatherAD/adStatus")
	public void adStatus() {
		
	}
}
