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
import modakbul.mvc.service.GatherService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminControllerChoi {
	
	private final GatherService gatherService;
	
	
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

}
