package modakbul.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.service.AdvertisementService;

@Controller
@RequestMapping("/Advertisement")
public class AdvertisementController {
	
	@Autowired
	private AdvertisementService advertisementService;
	
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
	 * 진행 중 광고 조회
	 * */
	@RequestMapping("/select")
	public void select() {}
	
}
