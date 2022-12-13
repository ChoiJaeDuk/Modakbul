package modakbul.mvc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.repository.AdminRepository;
import modakbul.mvc.service.AdminService;
import modakbul.mvc.service.GatherService;

@Controller
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainControllerChoi {
	
	private final GatherService gatherService;
	private final AdminService adminService;
	private final AdminRepository adminRepository;
	
	private final static int PAGE_COUNT=5;
	private final static int BLOCK_COUNT=4;
	
	@RequestMapping("/main")
	public void main(Model model) {
		
		List<Advertisement> selectAdGather = adminService.selectAdGather();
		
		model.addAttribute("selectAdGather", selectAdGather);
	}
	
	@RequestMapping("{url}")
	public void url() {}
	
	
	@ResponseBody
	@RequestMapping("/dayTimeGather")
	public Map<String, Object> selectGatherList(@RequestParam(defaultValue ="1") int nowPage, List<Long> categoryList, boolean gatherType, String search
			,String place, String sort){
		Map<String, Object> map = new HashMap<String, Object>();
		
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> gatherList = gatherService.selectGatherList(gatherType, categoryList, place, sort, search, pageable);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		map.put("gatherList", gatherList);
		map.put("blockCount", BLOCK_COUNT);
		map.put("startPage",startPage); 
		map.put("nowPage", nowPage);
		
		return null;
	}
}
