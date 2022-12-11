package modakbul.mvc.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.UsersService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminControllerChoi {
	
	private final GatherService gatherService;
	
	private final UsersService usersService;
	
	
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
	public void selectUser(@RequestParam(defaultValue = "1") int nowPage, Model model) {
		
		Pageable page = PageRequest.of(nowPage - 1, PAGE_COUNT, Direction.ASC, "userNo");

		Page<Users> userList = usersService.selectUsers(page, null, null);
	

		int temp = (nowPage - 1) % BLOCK_COUNT;

		int startPage = nowPage - temp;
		
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
}
