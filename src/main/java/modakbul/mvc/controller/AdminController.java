package modakbul.mvc.controller;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.AdvertisementGroupBy;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.groupby.UsersGroupBy;
import modakbul.mvc.repository.AdminRepository;
import modakbul.mvc.service.AdminService;
import modakbul.mvc.service.AlarmService;
import modakbul.mvc.service.FollowService;
import modakbul.mvc.service.GatherService;

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
	@Autowired
	private AlarmService alarmService;

	private final static int PAGE_COUNT = 5;// 상수//한 페이지당 10개
	private final static int BLOCK_COUNT = 4;

	Gather gather = new Gather(7L);

	Users userTest = new Users().builder().userNo(2L).build();

	
	////////////////////////////광고시작///////////////////////////
	/**
	 * 광고 페이지
	 */
	@RequestMapping("/admin/{url}")
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
	public String updateAdGather(Long advertisementNo, String status, HttpSession session) {
		System.out.println("광고 승인");
		adminService.updateAdGather(advertisementNo, status);
		
		String moveDir = session.getServletContext().getRealPath("/banner");
		String oriDir = session.getServletContext().getRealPath("/regis");
		
		Advertisement adv = adminService.selectByNo(advertisementNo);
		
		String filePath2 = moveDir + "/" + adv.getAdFileName();
		String filePath1 = oriDir + "/" + adv.getAdFileName();
		
		File dir = new File(filePath2);
		
		
		try {
			File file = new File(filePath1);
			
			file.renameTo(dir);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "광고진행상태가 변경되었습니다.";
	}
	
	/**
	 * 광고 상태변경(광고종료)
	 * */
	@ResponseBody
	@RequestMapping("/admin/updateAdCancle")
	public String updateAdCancle(Long advertisementNo, String status, HttpSession session) {
		String dir = session.getServletContext().getRealPath("/banner");
		Advertisement dbAdv = adminService.selectByNo(advertisementNo);
		if(dbAdv.getAdvertisementNo() == null) {
			return "존재하지않는광고입니다.";
		}else {
			new File((dir + "/" + dbAdv.getAdFileName())).delete();
			
		}
		
		adminService.updateAdCancel(advertisementNo, status);
		System.out.println("광고 종료");
		return "광고진행상태가 변경되었습니다sc.";
	}
	
	/**
	 * 마이페이지 광고 상태변경(광고 신청 취소)
	 * */
	@ResponseBody
	@RequestMapping("/my_page/gatherAD/updateMyAdCancel")
	public String updateMyAdCancle(HttpServletRequest request) {
		String advertisementNo = request.getParameter("advertisementNo");
	
		System.out.println("광고 신청 취소");
		adminService.updateMyAdCancel(Long.parseLong(advertisementNo));
		
		return "광고진행상태가 변경되었습니다.";
	}
	
	/**
	 * 광고 등록
	 */
	@RequestMapping("/my_page/gatherAD/insertAd")
	public String advertisementInsert(RedirectAttributes redirect, Advertisement advertisement, 
			HttpSession session, MultipartFile file, HttpServletRequest request
			, Long gatherNo, String date1, String date2, Long userNo) {

		//String userNo2 = request.getParameter("userNo");
		String saveDir = session.getServletContext().getRealPath("/regis");
		String originalFileName = file.getOriginalFilename();
		
		String adPrice = request.getParameter("adPrice");
		
		 DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		 LocalDateTime startDate = LocalDate.parse(date1, dateTimeFormatter).atStartOfDay();
		 LocalDateTime endDate = LocalDate.parse(date2, dateTimeFormatter).atStartOfDay();
		 
		
		Gather gather = new Gather(gatherNo);
		Users users = new Users(userNo);
		
		//LocalDateTime gatherDate = LocalDateTime.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		advertisement.setGather(gather);
	
		System.out.println("originalFileName = "+ originalFileName);
		try {
			file.transferTo(new File(saveDir + "/" + originalFileName));
		} catch (Exception e) {
			e.getStackTrace();
		}
		
		advertisement.setUser(users);
		advertisement.setGather(gather);
		advertisement.setAdApproveDate(startDate);
		advertisement.setDeadLine(endDate);
		//advertisement.setAdRegisDate(LocalDateTime.now()); 자동으로 시간 들어감
		advertisement.setAdStatus("신청대기");
		advertisement.setAdFileName(originalFileName);
		//advertisement.setAdPrice(Integer.parseInt(adPrice));
		advertisement.setAdPrice(Integer.parseInt(adPrice));
		redirect.addAttribute("userNo", users);
		
		
		adminService.advertisementInsert(advertisement);
		System.out.println("광고등록실행");
		return "redirect:/my_page/gatherAD/adApplication";
	
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
	 * 마이페이지 광고(신청대기)
	 */
	@RequestMapping("/my_page/gatherAD/adWaiting")
	public void selectADGatherRegis(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, Long advertisementNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("마이페이지 광고 신청대기");
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		

		Page<Advertisement> selectADGatherRegis = adminService.selectADGatherRegis(userNo, pageable, advertisementNo);
		
		model.addAttribute("selectADGatherRegis", selectADGatherRegis);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);

		model.addAttribute("userNo", userNo);
	}
	
	/**
	 * 마이페이지2 광고(광고중)
	 */
	@RequestMapping("/my_page/gatherAD/adStatus")
	public void selectGatherADIng(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, Long advertisementNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("마이페이지 광고중");
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		Page<Advertisement> selectGatherADIng = adminService.selectGatherADIng(userNo, pageable, advertisementNo);

		
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		
		model.addAttribute("selectGatherADIng", selectGatherADIng);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);
	}

	/**
	 * 광고 배너 수정
	 */
	
	 @RequestMapping(value = "/my_page/gatherAD/bannerUpdate", method = RequestMethod.POST)
	 public String bannerUpdate(String bannerName, HttpSession session,  @RequestParam(value = "file", required = false) MultipartFile file, String advertisementNo, String userNo) {
		//모임 이미지 첨부
		String saveDir = session.getServletContext().getRealPath("/banner");
		String originalFileName = file.getOriginalFilename();
		
		Long advertisementNo2 = Long.parseLong(advertisementNo);
		Advertisement dbAdv = adminService.selectByNo(advertisementNo2);

		if(originalFileName.length() > 0) {
			adminService.updateBanner(advertisementNo2, originalFileName);
			
			try {
				
				new File((saveDir + "/" +dbAdv.getAdFileName())).delete();
				file.transferTo(new File(saveDir + "/" + originalFileName));
			}catch (Exception e) {
				e.getStackTrace();
			}
			
			
		}
	 	return "redirect:/my_page/gatherAD/adStatus?userNo="+userNo; 
	 }
	 ////////////////////////광고끝//////////////////////
	 
	 
	 ////////////////////////차트시작///////////////////////
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
		////////////////////////차트끝///////////////////////
	 /**
		 * 유저 페이지
		 */
/*
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
*/
		/**
		 * 모임 페이지
		 */
		/*
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
		}*/
	 
	 

}