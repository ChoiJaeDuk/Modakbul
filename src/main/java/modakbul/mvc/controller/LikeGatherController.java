package modakbul.mvc.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import java.util.List;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.LikeGather;

import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.LikeGatherService;

@Controller
@RequestMapping("/likeGather")
public class LikeGatherController {

	@Autowired
	private LikeGatherService likeGatherService;

	@Autowired
	private GatherService gs;
	

	private final static int PAGE_COUNT=10;
	private final static int BLOCK_COUNT=4;

	/**
	 * 유저별 관심모임 목록
	 */
	@RequestMapping("/myLikeGather")
	public ModelAndView myLike(Long userNo) {
		System.out.println("누구의 관심목록 ? " + userNo);

		List<LikeGather> like = likeGatherService.selectById(userNo);

		if (like.isEmpty() || like.size() == 0) {
			System.out.println("비었거나 팔로잉이 없다.");
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("myList", like);
		mv.addObject("userNo", userNo);
		mv.setViewName("my-page/myLikeGather");

		return mv;
	}

	/**
	 * 등록
	 */
	@RequestMapping("/insert")
	@ResponseBody
	public String insert(@RequestBody Map<String, Object> result) {
		System.out.println("온거니?");
		  for (String m:result.keySet()) {
	          System.out.println("key:"+m+",value:"+result.get(m));
	      }
		//System.out.println("온거임? 등록모임번호 = " + gatherNo + "등록 회원번호 = "+ userNo);
		//LikeGather likeGather = likeGatherService.selectEle((Long)result.get("gatherNo"), (Long)result.get("userNo"));
		//likeGatherService.insert(likeGather);

		return "redirect:/likeGather/gatherList";
	}

	/**
	 * 삭제
	 */
	@RequestMapping("/delete")
	public String delete(Long gatherNo, Long userNo) {
		System.out.println("온거임? 삭제모임번호 = " + gatherNo + "삭제 회원번호 = "+ userNo);
		likeGatherService.delete(gatherNo, userNo);

		return "redirect:/likeGather/gatherList";
	}

	///////////////////////////////////////////////////////////////
//	@RequestMapping("/myindex")
//	public String myindex() {
//		return "my-page/index";
//	}

	/**
	 * GatherList
	 */
	@RequestMapping("/gatherList")
	public ModelAndView gatherList(@RequestParam(defaultValue = "1") int nowPage) {

		
		////// 페이징처리////////////////////////
		Pageable page = PageRequest.of((nowPage - 1), PAGE_COUNT, Direction.DESC, "gatherNo");
		Page<Gather> pageList = gs.selectGatherList(true, null, null, null, null, page);

		int temp = (nowPage - 1) % BLOCK_COUNT;
		int startPage = nowPage - temp;

		ModelAndView mv = new ModelAndView();
		mv.setViewName("lee/views/my-page/gatherList");
		mv.addObject("pageList", pageList);

		mv.addObject("blockCount", BLOCK_COUNT);
		mv.addObject("startPage", startPage);
		mv.addObject("nowPage", nowPage);

		mv.addObject("userNo", 7L);
		return mv;
	}

}
