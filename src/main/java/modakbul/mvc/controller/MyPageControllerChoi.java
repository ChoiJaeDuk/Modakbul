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
	
	@RequestMapping("/myPage-gatherSelect")
	public void selectGather(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo) {
	
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of(nowPage-1,PAGE_COUNT);
		
		Page<Gather> waitList = participantService.selectApplicationStateByUserNo(userNo, "신청대기", pageable);
		
	
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		model.addAttribute("waitList", waitList);
		model.addAttribute("blcokCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);

	}
}
