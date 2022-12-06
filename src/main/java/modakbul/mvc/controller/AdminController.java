package modakbul.mvc.controller;

import java.util.List;

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
import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.AdminService;
import modakbul.mvc.service.FollowService;

@Controller
@RequestMapping("/admin2")
public class AdminController {

	@Autowired
	private AdminService adminService;
	@Autowired
	private FollowService followService;


	private final static int PAGE_COUNT=5;//상수//한 페이지당 5개

	private final static int BLOCK_COUNT=4;

	/**
	 * 모임 페이지
	 * */
	@RequestMapping("/main2")
	public void gatherList(Model model , 
			@RequestParam(defaultValue = "1") int nowPage) {//model : view로 전달 // nowPage 페이지 넘버 받기

		//모임 리스트
		List<Gather> gatherList = adminService.selectGatherList();

		model.addAttribute("gatherList", gatherList);
		//회원 리스트
		List<Users> usersList = adminService.selectUsersList();

		model.addAttribute("usersList", usersList);
		/////페이징 처리/////
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT, Direction.ASC , "gatherNo");//0부터 시작, PAGE_COUNT(10)개씩 뿌림, 정렬, 기준=bno

		Page<Gather> pageList = adminService.selectGatherList(pageable);

		int temp = (nowPage-1)%BLOCK_COUNT;//nowPage=6 //5 % 4 = 1// 나머지

		int startPage=nowPage-temp; //6 - 1 = 5

		model.addAttribute("pageList", pageList);
		model.addAttribute("blockCount" , BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
	}

	/**
	 * 유저 페이지
	 * */
	@RequestMapping("/main")
	public void userList(Long userNo, Model model , 
			@RequestParam(defaultValue = "1") int nowPage) {//model : view로 전달 // nowPage 페이지 넘버 받기

		//모임 리스트
		List<Gather> gatherList = adminService.selectGatherList();

		model.addAttribute("gatherList", gatherList);
		//회원 리스트
		List<Users> usersList = adminService.selectUsersList();

		model.addAttribute("usersList", usersList);
		//팔로우 수
		Follow selectByUserId = followService.selectByUserId(userNo);

		model.addAttribute("selectByUserId", selectByUserId);
		/////페이징 처리/////
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT, Direction.ASC , "userNo");//0부터 시작, PAGE_COUNT(10)개씩 뿌림, 정렬, 기준=bno

		Page<Users> pageList = adminService.selectUsersList(pageable);

		int temp = (nowPage-1)%BLOCK_COUNT;//nowPage=6 //5 % 4 = 1// 나머지

		int startPage=nowPage-temp; //6 - 1 = 5

		model.addAttribute("pageList", pageList);
		model.addAttribute("blockCount" , BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);

	}

	/**
	 * 광고 페이지
	 * */
	@RequestMapping("/adlist")
	public void list(Gather gather, Advertisement advertisement, Model model , 
			@RequestParam(defaultValue = "1") int nowPage) {//model : view로 전달 // nowPage 페이지 넘버 받기

		//광고 리스트
		List<Advertisement> advertisementList = adminService.selectAll();

		model.addAttribute("advertisementList", advertisementList); //list.jsp랑 이름 맞춤 -freeList
		//광고 상태 리스트(광고중)
		List<Advertisement> adStatusList1 = adminService.selectByStatus1(advertisement);

		model.addAttribute("adStatusList1", adStatusList1);
		//광고 상태 리스트(신청대기)
		List<Advertisement> adStatusList2 = adminService.selectByStatus2(advertisement);

		model.addAttribute("adStatusList2", adStatusList2);
		//광고 상태 리스트(광고종료)
		List<Advertisement> adStatusList3 = adminService.selectByStatus3(advertisement);

		model.addAttribute("adStatusList3", adStatusList3);




		/////페이징 처리/////
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT, Direction.ASC , "advertisementNo");//0부터 시작, PAGE_COUNT(10)개씩 뿌림, 정렬, 기준=bno

		Page<Advertisement> pageList = adminService.selectAll(pageable);

		int temp = (nowPage-1)%BLOCK_COUNT;//nowPage=6 //5 % 4 = 1// 나머지

		int startPage=nowPage-temp; //6 - 1 = 5

		model.addAttribute("pageList", pageList);
		model.addAttribute("blockCount" , BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);

	}

	/**
	 * 광고 등록
	 * */
	@RequestMapping("/insert")
	public String advertisementInsert(Advertisement advertisement) {

		adminService.advertisementInsert(advertisement);

		return "";
	}

	/**
	 * 광고 상태 변경
	 * */
	@RequestMapping("/statusUpdate")
	public String statusUpdate(Advertisement advertisement) {

		adminService.statusUpdate(advertisement);

		return "";
	}

	/**
	 * 광고 배너 수정
	 * */
	@RequestMapping("/bannerUpdate")
	public String bannerUpdate(Advertisement advertisement) {

		adminService.bannerUpdate(advertisement);

		return "";
	}

	/**
	 * 광고 삭제
	 * */
	@RequestMapping("/delete")
	public String delete(Long advertisementNo) {
		adminService.delete(advertisementNo);
		return "";
	}

	/**
	 * 광고 매출 페이지
	 * */
	@RequestMapping("/chart2")
	public void chart(Advertisement advertisement, Model model) {
		//1월 광고중
		List<Advertisement> selectAdStatusIng1 = adminService.selectAdStatusIng1(advertisement);

		model.addAttribute("selectAdStatusIng1", selectAdStatusIng1);
		//2월 광고중
		List<Advertisement> selectAdStatusIng2 = adminService.selectAdStatusIng2(advertisement);

		model.addAttribute("selectAdStatusIng2", selectAdStatusIng2);
		//3월 광고중
		List<Advertisement> selectAdStatusIng3 = adminService.selectAdStatusIng3(advertisement);

		model.addAttribute("selectAdStatusIng3", selectAdStatusIng3);
		//4월 광고중
		List<Advertisement> selectAdStatusIng4 = adminService.selectAdStatusIng4(advertisement);

		model.addAttribute("selectAdStatusIng4", selectAdStatusIng4);
		//5월 광고중
		List<Advertisement> selectAdStatusIng5 = adminService.selectAdStatusIng5(advertisement);

		model.addAttribute("selectAdStatusIng5", selectAdStatusIng5);
		//6월 광고중
		List<Advertisement> selectAdStatusIng6 = adminService.selectAdStatusIng6(advertisement);

		model.addAttribute("selectAdStatusIng6", selectAdStatusIng6);
		//7월 광고중
		List<Advertisement> selectAdStatusIng7 = adminService.selectAdStatusIng7(advertisement);

		model.addAttribute("selectAdStatusIng7", selectAdStatusIng7);
		//8월 광고중
		List<Advertisement> selectAdStatusIng8 = adminService.selectAdStatusIng8(advertisement);

		model.addAttribute("selectAdStatusIng8", selectAdStatusIng8);
		//9월 광고중
		List<Advertisement> selectAdStatusIng9 = adminService.selectAdStatusIng9(advertisement);

		model.addAttribute("selectAdStatusIng9", selectAdStatusIng9);
		//10월 광고중
		List<Advertisement> selectAdStatusIng10 = adminService.selectAdStatusIng10(advertisement);

		model.addAttribute("selectAdStatusIng10", selectAdStatusIng10);
		//11월 광고중
		List<Advertisement> selectAdStatusIng11 = adminService.selectAdStatusIng11(advertisement);

		model.addAttribute("selectAdStatusIng11", selectAdStatusIng11);
		//12월 광고중
		List<Advertisement> selectAdStatusIng12 = adminService.selectAdStatusIng12(advertisement);
		
		model.addAttribute("selectAdStatusIng12", selectAdStatusIng12);

	}
	/**
	 * 모임 매출 페이지
	 * */
	@RequestMapping("/chart")
	public void chart(String gatherBid, Model model) {
		//모임 참가비 1
		String selectGatherBid1 = adminService.selectGatherBid1(gatherBid);

		model.addAttribute("selectGatherBid1", selectGatherBid1);


	}
}