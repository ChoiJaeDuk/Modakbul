package modakbul.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.domain.UserReview;
import modakbul.mvc.service.GatherReviewService;
import modakbul.mvc.service.UserReviewService;

@Controller
public class KyuTestController {
	@Autowired
	private GatherReviewService gatherReviewService;
	
	@Autowired
	private UserReviewService userReviewService;
	
	private final static int PAGE_COUNT=3;
	private final static int BLOCK_COUNT=4;	
	
	@RequestMapping("/kyuTest/kyuTest")
	public String index() {
		System.out.println("HomeController의 index..");
		return "kyuTest/kyuTest";
	}
	//정기모임의 모임 후기 조회 
	/*
	 * @RequestMapping("/kyuTest/kyuTest/gr")
	 *  public ModelAndView selectAllByRegularGatherNo(Long regularGatherNo, @RequestParam(defaultValue "0") int nowPage) {
	 * 
	 * ModelAndView mv= new ModelAndView();
	 * 
	 * Pageable pageable = PageRequest.of(nowPage, PAGE_COUNT); Page<GatherReview>
	 * page = gatherReviewService.selectAllByRegularGatherNo(1L, pageable);
	 * List<GatherReview> pageList=page.getContent();
	 * 
	 * int temp= (nowPage -1)%BLOCK_COUNT; int startPage= nowPage-temp;
	 * 
	 * mv.setViewName("/kyuTest/kyuTest"); mv.addObject("pageList", pageList);
	 * mv.addObject("blockCount", BLOCK_COUNT); mv.addObject("startPage",
	 * startPage); mv.addObject("nowPage", nowPage);
	 * 
	 * return mv; }
	 * 
	 * //일일모임의 주최자 후기 조회
	 * 
	 * @RequestMapping("/kyuTest/kyuTest/ur") public String
	 * selectAllByUserReviewNo(Long hostUserNo,Model
	 * model,@RequestParam(defaultValue = "0") int nowPage ) { Pageable pageable =
	 * PageRequest.of(nowPage, PAGE_COUNT); Page<UserReview> page =
	 * userReviewService.selectAllByUserReviewNo(hostUserNo, pageable);
	 * List<UserReview> pageList= page.getContent();
	 * 
	 * int temp= (nowPage-1)%BLOCK_COUNT; int startPage= nowPage-temp;
	 * 
	 * model.addAttribute("userReviewList", pageList);
	 * model.addAttribute("blockCount", BLOCK_COUNT);
	 * model.addAttribute("startPage", startPage); model.addAttribute("nowPage",
	 * nowPage);
	 * 
	 * return "kyuTest/kyuTest"; }
	 */
	@RequestMapping("/kyuTest/kyuTest/gr")
	@ResponseBody
	public String selectAllByRegularGatherNo(@RequestParam long regularGatherNo,Model model, @RequestParam(defaultValue ="0") int nowPage) { 
	
		System.out.println("asdasdasdasdasdas");
		ModelAndView mv= new ModelAndView();
	  
	  Pageable pageable = PageRequest.of(nowPage, PAGE_COUNT);
	  Page<GatherReview> page = gatherReviewService.selectAllByRegularGatherNo(regularGatherNo,pageable);
	 List<GatherReview> pageList=page.getContent();
	 
	 int temp= (nowPage -1)%BLOCK_COUNT; int startPage= nowPage-temp;
	 
	 // mv.setViewName("/kyuTest/kyuTest"); 
	 mv.setViewName("/kyuTest/kyuTest"); 
	 mv.addObject("pageList", pageList);
	 mv.addObject("blockCount", BLOCK_COUNT); 
	 mv.addObject("startPage",startPage); 
	 mv.addObject("nowPage", nowPage);
	  
	  System.out.println("Asdasda");
	  return "ok";
	  }
	
}
