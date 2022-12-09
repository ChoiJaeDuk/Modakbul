package modakbul.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	@RequestMapping("/followingList")
	public ModelAndView myFollowing(Long userNo) {
		System.out.println("누구의 팔로잉 리스트 ? " + userNo);
		
		List<Follow> following = followService.selectByUserId(userNo);
		
		if(following.isEmpty() || following.size()==0) {
			System.out.println("비었거나 팔로잉이 없다.");
		}
		
		for(Follow f : following) {
			System.out.println(f.getFollowingUser());
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("followingList", following);
		mv.addObject("userNo", userNo);
		mv.setViewName("my-page/followingList");
		
		return mv;
	}
	
	
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
	
	/**
	 *  팔로잉 팔로워 수
	 * 	 */
	/*@RequestMapping("/myindex")
	public ModelAndView myindex(Long userNo) {

		List<Follow> follower = followService.myFollower(7L);
		List<Follow> following = followService.myFollowing(7L);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("follower", follower.size());
		mv.addObject("following", following.size());
		mv.setViewName("lee/views/my-page/index");
		
		return mv;
	}*/
	
	/**
	 *  팔로잉 팔로워 수
	 * 	 */
	@RequestMapping("/myindex/{userNo}")
	public ModelAndView jieun(@PathVariable Long userNo) {
		System.out.println("DURL");
		List<Follow> follower = followService.myFollower(userNo);
		List<Follow> following = followService.myFollowing(userNo);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("follower", follower.size());
		mv.addObject("following", following.size());
		mv.setViewName("lee/views/my-page/index");
		
		return mv;
	}
	
}
