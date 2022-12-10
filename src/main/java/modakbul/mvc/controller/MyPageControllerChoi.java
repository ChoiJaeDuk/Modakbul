package modakbul.mvc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	private final static int PAGE_COUNT=5;
	private final static int BLOCK_COUNT=4;
	
	@RequestMapping("/gatherSelect/applicationList")
	public void selectApplicationList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {
	
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> applicationList = participantService.selectApplicationStateByUserNo(userNo, "신청대기", pageable);
		
		
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
;
		model.addAttribute("applicationList", applicationList);
		model.addAttribute("blcokCount", BLOCK_COUNT);
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
		model.addAttribute("blcokCount", BLOCK_COUNT);
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

		model.addAttribute("blcokCount", BLOCK_COUNT);
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

		model.addAttribute("blcokCount", BLOCK_COUNT);
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
		model.addAttribute("blcokCount", BLOCK_COUNT);
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

		model.addAttribute("blcokCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
	
	

	
	

	
	
}
