package modakbul.mvc.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.AdvertisementGroupBy;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.groupby.UsersGroupBy;
import modakbul.mvc.repository.AdminRepository;
import modakbul.mvc.service.AdminService;
import modakbul.mvc.service.FollowService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.UsersService;

@Controller
//@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	@Autowired
	private FollowService followService;
	@Autowired
	private AdminRepository adminRepository;
	@Autowired
	private GatherService gatherService;

	private final static int PAGE_COUNT = 5;// 상수//한 페이지당 10개
	private final static int BLOCK_COUNT = 4;

	Gather gather = new Gather(7L);

	Users userTest = new Users().builder().userNo(2L).build();

	/**
	 * 유저 페이지
	 */
	@RequestMapping("/admin/userList")
	public void userList(Long userNo, Model model, @RequestParam(defaultValue = "1") int nowPage) {// model : view로 전달
																									// // nowPage 페이지 넘버
																									// 받기

		// 모임 리스트
		List<Gather> gatherList = adminService.selectGatherList();

		model.addAttribute("gatherList", gatherList);
		// 회원 리스트
		List<Users> usersList = adminService.selectUsersList();

		model.addAttribute("usersList", usersList);
		// 회원 팔로워 리스트
		List<Follow> followerList = followService.myFollower(userNo);

		model.addAttribute("followerList", followerList);
		///// 페이징 처리/////
		Pageable pageable = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "userNo");// 0부터 시작, PAGE_COUNT(10)개씩
																								// 뿌림, 정렬, 기준=bno

		Page<Users> pageList = adminService.selectUsersList(pageable);

		int temp = (nowPage - 1) % BLOCK_COUNT;// nowPage=6 //5 % 4 = 1// 나머지

		int startPage = nowPage - temp; // 6 - 1 = 5

		model.addAttribute("pageList", pageList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);

	}

	/**
	 * 모임 페이지
	 */
	@RequestMapping("/gatherList")
	public void gatherList(Model model, @RequestParam(defaultValue = "1") int nowPage) {// model : view로 전달 // nowPage
																						// 페이지 넘버 받기

		// 모임 리스트
		List<Gather> gatherList = adminService.selectGatherList();

		model.addAttribute("gatherList", gatherList);
		// 회원 리스트
		List<Users> usersList = adminService.selectUsersList();

		model.addAttribute("usersList", usersList);
		///// 페이징 처리/////
		Pageable pageable = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "gatherNo");// 0부터 시작,
																								// PAGE_COUNT(10)개씩 뿌림,
																								// 정렬, 기준=bno

		Page<Gather> pageList = adminService.selectGatherList(pageable);

		int temp = (nowPage - 1) % BLOCK_COUNT;// nowPage=6 //5 % 4 = 1// 나머지

		int startPage = nowPage - temp; // 6 - 1 = 5

		model.addAttribute("pageList", pageList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
	}

	/**
	 * 광고 페이지
	 */
	@RequestMapping("/admin/{uml}")
	public void adList(@RequestParam(defaultValue = "1") int nowPage, Model model, Advertisement advertisement) {// model : view로 전달 // nowPage 페이지
																					// 넘버 받기
		Pageable page = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "advertisementNo");

		Page<Advertisement> advAll = adminService.selectAd(page, null);
		Page<Advertisement> advRegis = adminService.selectAd(page, "신청대기");
		Page<Advertisement> advIng = adminService.selectAd(page, "광고중");
		Page<Advertisement> advEnd = adminService.selectAd(page, "광고종료");
		List<Advertisement> selectByStatus1 = adminService.selectByStatus1();
		List<Advertisement> selectByStatus2 = adminService.selectByStatus2();
		List<Advertisement> selectByStatus3 = adminService.selectByStatus3();
		
		
		
		int temp = (nowPage - 1) % BLOCK_COUNT;
		int startPage = nowPage - temp;

		model.addAttribute("advAll", advAll);
		model.addAttribute("advRegis", advRegis);
		model.addAttribute("advIng", advIng);
		model.addAttribute("advEnd", advEnd);
		model.addAttribute("selectByStatus1", selectByStatus1);
		model.addAttribute("selectByStatus2", selectByStatus2);
		model.addAttribute("selectByStatus3", selectByStatus3);


		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);

		model.addAttribute("countAdvAll", advAll.getTotalElements());
		model.addAttribute("countAdvRegis", advRegis.getTotalElements());
		model.addAttribute("countAdvIng", advIng.getTotalElements());
		model.addAttribute("countAdvEnd", advEnd.getTotalElements());

	}
	/**
	 * 광고 상태변경(광고승인)
	 * */
	@ResponseBody
	@RequestMapping("/admin/updateAdGather")
	public String updateAdGather(Long advertisementNo, String status) {
		System.out.println("광고 승인");
		adminService.updateAdGather(advertisementNo, status);
		
		return "광고진행상태가 변경되었습니다.";
	}
	
	/**
	 * 광고 상태변경(광고종료)
	 * */
	@ResponseBody
	@RequestMapping("/admin/updateAdCancle")
	public String updateAdCancle(Long advertisementNo, String status) {
		System.out.println("광고 종료");
		adminService.updateAdCancle(advertisementNo, status);
		
		return "광고진행상태가 변경되었습니다.";
	}
	
	/**
	 * 광고 상태변경(광고 신청 취소)
	 * */
	@ResponseBody
	@RequestMapping("/my_page/gatherAD/updateMyAdCancel")
	public String updateMyAdCancle(HttpServletRequest request) {
		String advertisementNo = request.getParameter("advertisementNo");
	
		System.out.println("광고 신청 취소");
		adminService.updateMyAdCancel(Long.parseLong(advertisementNo));
		
		return "광고진행상태가 변경되었습니다.";
	}
	
	
	
	

	/*	*//**
			 * 유료모임 승인 리스트
			 *//*
				 * @RequestMapping("/admin/manageGather") public void selectGatherState(Model
				 * model) { // 광고 리스트 List<Gather> selectGatherState =
				 * adminService.selectGatherState();
				 * 
				 * model.addAttribute("selectGatherState", selectGatherState); }
				 */

	/*	*//**
			 * 유료모임 승인 업데이트
			 *//*
				 * @RequestMapping("/admin/updateGather") public String updateGather(Long
				 * gatherNo, Gather gather) {
				 * 
				 * adminService.updateGather(gather, gatherNo); gather.setGatherState("모집중");
				 * return "admin/manageGather"; }
				 */
	
	
	
//	/**
//	 * 유료모임 승인 리스트
//	 * */
//	@RequestMapping("/manageGather")
//	public void selectGatherState(Model model) {
//		// 광고 리스트
//				List<Gather> selectGatherState = adminService.selectGatherState();
//
//				model.addAttribute("selectGatherState", selectGatherState);
//	}
//	
	/**
	 * 유료모임 승인 업데이트
	 * */
	/*
	 * @RequestMapping("/updateGather") public String updateGather(Long gatherNo,
	 * Gather gather) {
	 * 
	 * adminService.updateGather(gather, gatherNo); gather.setGatherState("모집중");
	 * return "admin/manageGather"; }
	 */

	/**
	 * 광고 등록폼
	 */
	@RequestMapping("/admin/adUploadForm")
	public void adUploadForm() {
	}

	/**
	 * 광고 등록
	 */
	@RequestMapping("/my_page/gatherAD/insertAd")
	public String advertisementInsert(Advertisement advertisement, HttpSession session, MultipartFile file, HttpServletRequest request) {
		String gatherNo = request.getParameter("gatherNo");
		String userNo = request.getParameter("userNo");
		String saveDir = session.getServletContext().getRealPath("/save");
		String originalFileName = file.getOriginalFilename();

		try {
			file.transferTo(new File(saveDir + "/" + originalFileName));
		} catch (Exception e) {
			e.getStackTrace();
		}

		advertisement.setAdvertisementNo(0L);
		advertisement.setAdApproveDate(advertisement.getAdApproveDate());
		advertisement.setAdRegisDate(LocalDateTime.now());
		advertisement.setAdStatus("신청대기");
		advertisement.setAdFileName(originalFileName);

		adminService.advertisementInsert(advertisement, Long.parseLong(userNo));

		return "index";
	}


	/**
	 * 광고 상태 변경
	 */
	@RequestMapping("/admin/statusUpdate")
	public String statusUpdate(Advertisement advertisement) {

		adminService.statusUpdate(advertisement);

		return "";
	}

	/**
	 * 광고 배너 수정
	 */
	/*
	 * @RequestMapping("/bannerUpdate") public String bannerUpdate(Advertisement
	 * advertisement) {
	 * 
	 * adminService.bannerUpdate(advertisement);
	 * 
	 * return ""; }
	 */
	/**
	 * 광고 삭제
	 */
	/*
	 * @RequestMapping("/delete") public String delete(Long advertisementNo) {
	 * adminService.delete(advertisementNo); return ""; }
	 */

	/**
	 * 월별 유저 증가수 차트
	 */
	@RequestMapping("/admin/userChart")
	public void selectMonthCountUser(Users users, Model model) {

		List<UsersGroupBy> selectMonthCountUser = adminService.selectMonthCountUser(users);
		model.addAttribute("selectMonthCountUser", selectMonthCountUser);

	}

	/**
	 * 카테고리별 모임 개수 차트
	 */
	@RequestMapping("/admin/manageAll2")
	public void selectCategoryCount(Gather gather, Model model) {

		List<GatherGroupBy> selectCategoryCount = adminService.selectCategoryCount(gather);
		model.addAttribute("selectCategoryCount", selectCategoryCount);

	}

	/**
	 * 모임 ,광고 매출 차트
	 */
	@RequestMapping("/admin/manageSales")
	public void chart(Advertisement advertisement, Model model) {

		List<AdvertisementGroupBy> selectAdTotalPrice = adminService.selectAdTotalPrice(advertisement);
		List<GatherGroupBy> selectBidTotal = gatherService.selectBidTotal("2022");
		
		model.addAttribute("selectAdTotalPrice", selectAdTotalPrice);
		model.addAttribute("selectBidTotal", selectBidTotal);

	}

	/**
	 * 마이페이지2 광고(신청대기)
	 */
	@RequestMapping("/my_page/gatherAD/adWaiting")
	public void selectADGatherRegis(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, Long advertisementNo) {
		System.out.println("마이페이지 광고 신청대기");
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		

		Page<Advertisement> selectADGatherRegis = adminService.selectADGatherRegis(userNo, pageable, advertisementNo);
		
		model.addAttribute("selectADGatherRegis", selectADGatherRegis);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
	}
	
	/**
	 * 마이페이지2 광고(광고중)
	 */
	@RequestMapping("/my_page/gatherAD/adStatus")
	public void selectGatherADIng(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, Long advertisementNo) {

		System.out.println("마이페이지 광고중");
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		Page<Advertisement> selectGatherADIng = adminService.selectGatherADIng(userNo, pageable, advertisementNo);

		
		model.addAttribute("selectGatherADIng", selectGatherADIng);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
	}

}