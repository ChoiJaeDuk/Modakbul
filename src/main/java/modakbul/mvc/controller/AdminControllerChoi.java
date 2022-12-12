package modakbul.mvc.controller;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.groupby.UsersGroupBy;
import modakbul.mvc.service.AdminService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.RegularGatherService;
import modakbul.mvc.service.UsersService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminControllerChoi {
	
	private final GatherService gatherService;
	
	private final RegularGatherService regularGatherService;
	
	private final UsersService usersService;
	
	private final AdminService adminService;
	
	private final static int PAGE_COUNT=5;
	private final static int BLOCK_COUNT=4;
	
	@RequestMapping("/manageGather")
	public void manageGather(Model model, @RequestParam(defaultValue ="1") int nowPage) {
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT, Direction.DESC,"gatherNo");
		
		Page<Gather> gatherList = gatherService.selectGatherappliList(pageable);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		model.addAttribute("gatherList", gatherList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
	}
	
	
	@RequestMapping("/gatherApprove")
	public String gatherApprove(Long gatherNo, String state) {
		gatherService.updateGatherState(gatherNo, state);
		
		return "redirect:/admin/manageGather";
	}

	
	/**
	 * 마이페이지 프로필정보
	 * */

	@RequestMapping("/manageAll")
	public void selectUser(@RequestParam(defaultValue = "1") int nowPage, Model model,Gather gather,Users users) {
		
		Pageable page = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "userNo");

		Page<Users> userList = usersService.selectUsers(page, null, null);
		List<GatherGroupBy> selectCategoryCount = adminService.selectCategoryCount(gather);
		List<UsersGroupBy> selectMonthCountUser = adminService.selectMonthCountUser(users);
		List<Gather> gatherList = adminService.selectGatherList();

				
		
		int temp = (nowPage - 1) % BLOCK_COUNT;

		int startPage = nowPage - temp;
		
		model.addAttribute("gatherList", gatherList);
		model.addAttribute("selectMonthCountUser", selectMonthCountUser);
		model.addAttribute("selectCategoryCount", selectCategoryCount);
		model.addAttribute("userList", userList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);

		model.addAttribute("count", userList.getTotalElements());
		
	}
	
	@RequestMapping("/manageIndiv")
	public void selectUserIndiv(@RequestParam(defaultValue = "1") int nowPage, Model model) {
		
		Pageable page = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "userNo");

		
		Page<Users> indivList = usersService.selectUsers(page, "개인", null);
		
		int temp = (nowPage - 1) % BLOCK_COUNT;

		int startPage = nowPage - temp;
		
		model.addAttribute("indivList", indivList);
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);

		model.addAttribute("countIdiv", indivList.getTotalElements());
		

	}

	
	@RequestMapping("/manageCom")
	public void selectUserCom(@RequestParam(defaultValue = "1") int nowPage, Model model) {
		
		Pageable page = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "userNo");

	
		Page<Users> comList = usersService.selectUsers(page, "기관", null);

		int temp = (nowPage - 1) % BLOCK_COUNT;

		int startPage = nowPage - temp;
		
		model.addAttribute("comList", comList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);

	
		model.addAttribute("countCom", comList.getTotalElements());

	}
	
	@RequestMapping("/manageGroup")
	public void manageGroup(@RequestParam(defaultValue = "1") int nowPage, Model model) {
		Pageable pageable = PageRequest.of(nowPage - 1, 8, Direction.ASC, "gatherNo");

		
		Page<Gather> gatherList = gatherService.selectGatherManagementList(pageable);
		
		int temp = (nowPage - 1) % BLOCK_COUNT;

		int startPage = nowPage - temp;
	
		model.addAttribute("gatherList", gatherList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
	}
	
	@RequestMapping("/updateGatherState")
	public String updateGatherState(@RequestParam(defaultValue = "1") int nowPage,Long gatherNo
			, String state, Long regularGatherNo, RedirectAttributes redirect) {
		String regularGatherState = "난 아무것도 아니야!";
		System.out.println("state = " + state);
		System.out.println("regularGatherNo = " + regularGatherNo);
		if(regularGatherNo != null) {
			if(state.equals("모집보류")) {
				regularGatherState = "진행보류";
			}else if(state.equals("모집중")) {
				regularGatherState = "진행중";
			}else if(state.equals("모임취소")) {
				regularGatherState = "모임종료";
			}
			regularGatherService.updateRegularGatherState(gatherNo, regularGatherState);
		}
		System.out.println("regularGatherState = " + regularGatherState);
		
		gatherService.updateGatherState(gatherNo, state);
		System.out.println("나는 실행돼?");
		redirect.addAttribute("nowPage",nowPage);
		
		return "redirect:/admin/manageGroup";
	}
}
