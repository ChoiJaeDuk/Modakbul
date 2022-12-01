package modakbul.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.service.AdvertisementService;

@Controller
@RequestMapping("/advertisement")
public class AdvertisementController {
	
	@Autowired
	private AdvertisementService advertisementService;
	
	private final static int PAGE_COUNT=10;//상수//한 페이지당 10개
	
	private final static int BLOCK_COUNT=4;

	/**
	 * 광고 등록
	 * */
	@RequestMapping("/insert")
	public String advertisementInsert(Advertisement advertisement) {
	
		advertisementService.advertisementInsert(advertisement);
		
	return "";
	}
	
	/**
	 * 광고 상태 변경
	 * */
	@RequestMapping("/statusUpdate")
	public String statusUpdate(Advertisement advertisement) {
		
		advertisementService.statusUpdate(advertisement);
	
	return "";
	}
	
	/**
	 * 광고 배너 수정
	 * */
	@RequestMapping("/bannerUpdate")
	public String bannerUpdate(Advertisement advertisement) {
		
		advertisementService.bannerUpdate(advertisement);
	
	return "";
	}
	
	/**
	 * 광고 삭제
	 * */
	@RequestMapping("/delete")
	public String delete(Long advertisementNo) {
		advertisementService.delete(advertisementNo);
		return "";
	}
	
	/**
	 * 전체 검색 페이지
	 * */
	@RequestMapping("/list")
	public void list(Model model , 
			@RequestParam(defaultValue = "1") int nowPage) {//model : view로 전달 // nowPage 페이지 넘버 받기
		//@RequestParam(defaultValue = "1")
	//service -> dao
	/*
	List<FreeBoard> freeBoardList = freeService.selectAll();
	
	model.addAttribute("freeList", freeBoardList); //list.jsp랑 이름 맞춤 -freeList
	*/
		
	/////페이징 처리/////
Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT, Direction.DESC , "bno");//0부터 시작, PAGE_COUNT(10)개씩 뿌림, 정렬, 기준=bno
	
		Page<Advertisement> pageList = advertisementService.selectAll(pageable);
		
		int temp = (nowPage-1)%BLOCK_COUNT;//nowPage=6 //5 % 4 = 1// 나머지
		
		int startPage=nowPage-temp; //6 - 1 = 5
		
		model.addAttribute("pageList", pageList);
		model.addAttribute("blockCount" , BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		
	}
	
}
