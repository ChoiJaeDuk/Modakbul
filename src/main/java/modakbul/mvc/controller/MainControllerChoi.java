package modakbul.mvc.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
//import oracle.security.crypto.core.DES;

@Controller
//@RequestMapping("/main")
@RequiredArgsConstructor
public class MainControllerChoi {
	
	private final GatherService gatherService;
	private final AdminService adminService;
	private final AdminRepository adminRepository;
	
	private final static int PAGE_COUNT=3;
	private final static int BLOCK_COUNT=4;
	
	@RequestMapping("/")
	public String main(Model model, HttpSession session) {
		String path = session.getServletContext().getRealPath("/banner");
		File file = new File(path);
		
		String fileNames [] = file.list();
		
		Pageable pageable = PageRequest.of(2,4);
		
		List<Advertisement> selectAdGather = adminService.selectAdGather();
		
		Page<Gather> pageGatherList = gatherService.selectGatherOrderByRegisDate(pageable);
		List<Gather> newGatherList = pageGatherList.getContent();
		List<Gather> deadLineGatherList = gatherService.selectDeadlineOrderBy();
		
		model.addAttribute("deadLineGatherList", deadLineGatherList);
		model.addAttribute("newGatherList", newGatherList);
		model.addAttribute("selectAdGather", selectAdGather);
		model.addAttribute("fileNames", fileNames);
		
		
		return "index";
		
	}
	
	@RequestMapping("/main/{url}")
	public void url() {}
	
	@RequestMapping("/main/dayTimeGather")
	public void dayTimeGather() {}
	
	
	@ResponseBody
	@RequestMapping("/main/ajaxPage")
	public Map<String, Object> selectGatherList(HttpServletRequest request,@RequestParam(defaultValue ="1", required = false) int nowPage ,@RequestParam(value="categoryList[]" , required = false) List<Long> categoryList){
		System.out.println("나오니?");
		
		String place = request.getParameter("place");
		System.out.println(place);
		String gatherType = request.getParameter("gatherType");
		String sort = request.getParameter("sort");
		String orderBy = request.getParameter("orderBy");
		String search = request.getParameter("search");
		
		System.out.println("nowPage = " + nowPage);
//		System.out.println("place = "+ place);
//		System.out.println("gatherType = "+ gatherType);
//		System.out.println("sort = "+ sort);
//		System.out.println("search = "+ search);
//		System.out.println("categoryList = "+ categoryList);
		List<Object> list = new ArrayList<Object>(); 
		
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("sort = " + sort);
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT, Sort.by(orderBy, sort));
		System.out.println("여기는 와?");
		Page<Gather> gatherList = gatherService.selectGatherList(gatherType, categoryList, place, sort, search, pageable);
		
		
		
			
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		map.put("gatherList", gatherList);
		map.put("blockCount", BLOCK_COUNT);
		map.put("startPage",startPage); 
		map.put("nowPage", nowPage);
	
		return map;
	}
	

}
