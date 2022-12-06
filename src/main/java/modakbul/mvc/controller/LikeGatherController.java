package modakbul.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;

import modakbul.mvc.domain.LikeGather;


import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.service.LikeGatherService;

@Controller
@RequestMapping("/likeGather")
public class LikeGatherController {
	
	@Autowired
	private LikeGatherService likeGatherService;
	
	/**
	 *  유저별 관심모임 목록
	 */
	@RequestMapping("/myLikeGather")
	public ModelAndView myLike(Long userNo) {
		System.out.println("누구의 관심목록 ? " + userNo);
		
		List<LikeGather> like = likeGatherService.selectById(userNo);
		
		if(like.isEmpty() || like.size()==0) {
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
	public String insert(LikeGather likeGather) {
		likeGatherService.insert(likeGather);
		
		return "";
	}
	
	/**
	 * 삭제
	 */
	@RequestMapping("/delete")
	public String delete(Long attentionNo) {
		System.out.println("온거임? 삭제번호 = " + attentionNo);
		likeGatherService.delete(attentionNo);
		
		return "";
	}
	
	///////////////////////////////////////////////////////////////
//	@RequestMapping("/myindex")
//	public String myindex() {
//		return "my-page/index";
//	}
	
}
