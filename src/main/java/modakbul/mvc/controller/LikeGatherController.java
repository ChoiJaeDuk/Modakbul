package modakbul.mvc.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import java.util.List;

import modakbul.mvc.domain.AlarmReceiver;
import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.service.AlarmService;
import modakbul.mvc.service.FollowService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.LikeGatherService;

@Controller
//@RequestMapping("/likeGather")
public class LikeGatherController {

	@Autowired
	private LikeGatherService likeGatherService;
	
	@Autowired
	private FollowService followService;

	@Autowired
	private GatherService gs;
	
	@Autowired
	private AlarmService alarmService;
	

	private final static int PAGE_COUNT=3;
	private final static int BLOCK_COUNT=4;

	/**
	 * 유저별 관심모임 목록
	 */
	@RequestMapping("/my_page/likeGather/myLikeGather")
	public ModelAndView myLike(Long userNo, @RequestParam(defaultValue = "1") int nowPage, HttpSession session) {
		System.out.println("누구의 관심목록 ? " + userNo);
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);

		String fileNames [] = file.list();
		/*List<LikeGather> like = likeGatherService.selectById(userNo);

		if (like.isEmpty() || like.size() == 0) {
			System.out.println("비었거나 팔로잉이 없다.");
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("myList", like);
		mv.addObject("userNo", userNo);
		mv.setViewName("my_page/likeGather/myPage-likeGather");*/
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		
		Pageable page = PageRequest.of((nowPage - 1), PAGE_COUNT, Direction.DESC, "ATTENTION_NO");
		Page<LikeGather> pageList = likeGatherService.selectById(userNo, page);

		int temp = (nowPage - 1) % BLOCK_COUNT;
		int startPage = nowPage - temp;

		ModelAndView mv = new ModelAndView();
		mv.setViewName("my_page/likeGather/myPage-likeGather");
		mv.addObject("pageList", pageList);
		mv.addObject("userNo", userNo);

		mv.addObject("blockCount", BLOCK_COUNT);
		mv.addObject("startPage", startPage);
		mv.addObject("nowPage", nowPage);
		
		mv.addObject("followingList", followList);
		mv.addObject("follower", follower.size());
		mv.addObject("following", following.size());
		mv.addObject("newAlarm", newAlarm);
		mv.addObject("userNo", userNo);
		mv.addObject("fileNames", fileNames);
		return mv;
	}

	/**
	 * 등록
	 */
	@RequestMapping("/likeGather/insert")
	@ResponseBody
	public String insert(@RequestBody Map<String, Object> result) {
//		System.out.println("온거니?");
//		  for (String m:result.keySet()) {
//	          System.out.println("key:"+m+",value:"+result.get(m));
//	      }
		  
		  long userNo = (long)Integer.parseInt((String) result.get("userNo"));		  
		  long gatherNo = (long)Integer.parseInt((String) result.get("gatherNo"));
		  
		LikeGather likeGather = LikeGather.builder()
				.gather(new Gather(gatherNo))
				.user(Users.builder().userNo(userNo).build())
				.build();
				
		try {
			likeGatherService.insert(likeGather);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("관심등록오류");
			return "fail";
		}

		return "ok";
	}

	/**
	 * 삭제 - 토글
	 */
	@RequestMapping("/likeGather/delete")
	@ResponseBody
	public String delete(@RequestBody Map<String, Object> result) {
//		for (String m:result.keySet()) {
//	          System.out.println("key:"+m+",value:"+result.get(m));
//	      }
		long userNo = (long)Integer.parseInt((String) result.get("userNo"));		  
		  long gatherNo = (long)Integer.parseInt((String) result.get("gatherNo"));
		
		likeGatherService.delete(gatherNo, userNo);

		return "ok";
	}
	
	/**
	 * 삭제 - 버튼
	 */
	@RequestMapping("/likeGather/deleteButton")
	@ResponseBody
	public String delete(Long gatherNo, Long userNo) {
		//long userNo = (long)Integer.parseInt((String) result.get("userNo"));		  
		//long gatherNo = (long)Integer.parseInt((String) result.get("gatherNo"));
		
		likeGatherService.delete(gatherNo, userNo);

		return "redirect:/my_page/likeGather/myLikeGather?userNo="+userNo;
	}

	///////////////////////////////////////////////////////////////
//	@RequestMapping("/myindex")
//	public String myindex() {
//		return "my-page/index";
//	}

	/**
	 * GatherList
	 */
	@RequestMapping("/likeGather/gatherList")
	public ModelAndView gatherList(@RequestParam(defaultValue = "1") int nowPage) {

		
		////// 페이징처리////////////////////////
		Pageable page = PageRequest.of((nowPage - 1), PAGE_COUNT, Direction.DESC, "GATHER_NO");
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
