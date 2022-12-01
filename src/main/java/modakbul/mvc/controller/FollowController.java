package modakbul.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.Follow;
import modakbul.mvc.service.FollowService;

@Controller
@RequestMapping("/follow")
public class FollowController {
	
	@Autowired
	private FollowService followService;
	
	
	/**
	 * 유저별 팔로잉 리스트
	 */
//	@RequestMapping("/following")
//	public ModelAndView myFollowing(String userId) {
//		Follow following = followService.selectByUserId(userId);
//		
//		return new ModelAndView("myPage/myFollowing", "following", following);
//	}
	
	
	/**
	 * 등록
	 */
	@RequestMapping("/insert")
	public String insert(Follow follow) {
		followService.insert(follow);
		
		return "";
	}
	
	
	/**
	 * 삭제
	 */
	@RequestMapping("/delete")
	public String delete(Long followNo) {
		followService.delete(followNo);
		
		return "";
	}
	
}
