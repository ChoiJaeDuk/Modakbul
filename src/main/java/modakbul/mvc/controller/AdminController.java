package modakbul.mvc.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;

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

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	@Autowired
	private FollowService followService;
	@Autowired
	private AdminRepository adminRepository;

	private final static int PAGE_COUNT = 10;// 상수//한 페이지당 10개

	private final static int BLOCK_COUNT = 4;

	Gather gather = new Gather(7L);

	Users userTest = new Users().builder().userNo(2L).build();
	

	/**
	 * 모임 페이지
	 * */
	@RequestMapping("/main2")
	public void gatherList1(Model model , 
			@RequestParam(defaultValue = "1") int nowPage) {//model : view로 전달 // nowPage 페이지 넘버 받기

	LocalDateTime date = LocalDateTime.now();
	LocalDateTime deadLine = LocalDateTime.of(2022, 12, 6, 18, 15);
	}
	/**
	 * 유저 페이지
	 */
	@RequestMapping("/userList")
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
	@RequestMapping("/manageAdv")
	public void list(Gather gather, Advertisement advertisement, Model model,
			@RequestParam(defaultValue = "1") int nowPage) {// model : view로 전달 // nowPage 페이지 넘버 받기

		// 광고 리스트
		List<Advertisement> advertisementList = adminService.selectAll();

		model.addAttribute("advertisementList", advertisementList); // list.jsp랑 이름 맞춤 -freeList
		// 광고 상태 리스트(광고중)
		List<Advertisement> adStatusList1 = adminService.selectByStatus1();

		model.addAttribute("adStatusList1", adStatusList1);
		// 광고 상태 리스트(신청대기)
		List<Advertisement> adStatusList2 = adminService.selectByStatus2(advertisement);

		model.addAttribute("adStatusList2", adStatusList2);
		// 광고 상태 리스트(광고종료)
		List<Advertisement> adStatusList3 = adminService.selectByStatus3(advertisement);

		model.addAttribute("adStatusList3", adStatusList3);

		///// 전체 페이징 처리/////
		Pageable pageable = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "advertisementNo");// 0부터 시작,
																										// PAGE_COUNT(10)개씩
																										// 뿌림, 정렬,
																										// 기준=bno
		Page<Advertisement> pageList = adminService.selectAll(pageable);

		int temp = (nowPage - 1) % BLOCK_COUNT;// nowPage=6 //5 % 4 = 1// 나머지

		int startPage = nowPage - temp; // 6 - 1 = 5

		model.addAttribute("pageList", pageList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		
		

	}
	
	/**
	 * 유료모임 승인 리스트
	 * */
	@RequestMapping("/manageGather")
	public void selectGatherState(Model model) {
		// 광고 리스트
				List<Gather> selectGatherState = adminService.selectGatherState();

				model.addAttribute("selectGatherState", selectGatherState);
	}
	
	/**
	 * 유료모임 승인 업데이트
	 * */
	@RequestMapping("/updateGather")
	public String updateGather(Gather gather) {
		
		adminService.updateGather(gather);
		return "admin/manageGather";
	}

	/**
	 * 광고 등록폼
	 */
	@RequestMapping("/adUploadForm")
	public void adUploadForm() {
	}

	/**
	 * 업로드
	 */
	@RequestMapping("/advertisementInsert")
	public String advertisementInsert(Advertisement advertisement, HttpSession session, MultipartFile file) {
		
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
		advertisement.setAdStatus("광고신청");
		advertisement.setGather(gather); 
		advertisement.setUser(userTest);
		advertisement.setAdFileName(originalFileName);

		adminService.advertisementInsert(advertisement);
		
		return "index";
	}


	/**
	 * 광고 등록
	 */
	@RequestMapping("/insert")
	public String advertisementInsert(Advertisement advertisement) {

		adminService.advertisementInsert(advertisement);

		return "index";
	}

	/**
	 * 광고 상태 변경
	 */
	@RequestMapping("/statusUpdate")
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
	@RequestMapping("/userChart")
	public void selectMonthCountUser(Users users, Model model) {

		List<UsersGroupBy> selectMonthCountUser = adminService.selectMonthCountUser(users);
		model.addAttribute("selectMonthCountUser", selectMonthCountUser);

	}

	/**
	 * 카테고리별 모임 개수 차트
	 */
	@RequestMapping("/categoryGatherChart")
	public void selectCategoryCount(Gather gather, Model model) {

		List<GatherGroupBy> selectCategoryCount = adminService.selectCategoryCount(gather);
		model.addAttribute("selectCategoryCount", selectCategoryCount);

	}

	/**
	 * 광고 매출 차트
	 */
	@RequestMapping("/manageSales")
	public void chart(Advertisement advertisement, Model model) {

		List<AdvertisementGroupBy> selectAdTotalPrice = adminService.selectAdTotalPrice(advertisement);

		model.addAttribute("selectAdTotalPrice", selectAdTotalPrice);

	}
	
	/**
	 * 마이페이지2 광고 
	 * */
	@RequestMapping("/myPage-ad/myPageAd")
	public void myPageAd() {}
	

	
	@RequestMapping("/{url}")
	public void url() {
		
	}

}