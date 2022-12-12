package modakbul.mvc.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.FollowService;

@Controller
//@RequestMapping("/follow")
public class FollowController {
	
	@Autowired
	private FollowService followService;
	
	
	/**
	 * 유저별 팔로잉 리스트
	 */
	@RequestMapping("/my_page/followingList")
	public ModelAndView myFollowing(Long userNo) {
		System.out.println("누구의 팔로잉 리스트 ? " + userNo);
		
		List<Follow> following = followService.selectByUserId(userNo);
		
		List<Follow> followerSize = followService.myFollower(userNo);
		List<Follow> followingSize = followService.myFollowing(userNo);
		
		if(following.isEmpty() || following.size()==0) {
			System.out.println("비었거나 팔로잉이 없다.");
		}
		
		for(Follow f : following) {
			System.out.println(f.getFollowingUser());
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("followingList", following);
		
		mv.addObject("follower", followerSize.size());
		mv.addObject("following", followingSize.size());
		
		mv.setViewName("my_page/layout");
		
		return mv;
	}
	
	
	/**
	 * 등록
	 */
	@RequestMapping("/follow/insert")
	@ResponseBody
	public String insert(@RequestBody Map<String, Object> result) {
		long follower = (long)Integer.parseInt((String) result.get("follower"));		  
		long following = (long)Integer.parseInt((String) result.get("following"));
		  
		Follow follow = Follow.builder()
				.followerUser(new Users(follower))
				.followingUser(new Users(following))
				.build();
		
		followService.insert(follow);
		
		return "ok";
	}
	
	
	/**
	 * 삭제
	 */
	@RequestMapping("/follow/delete")
	@ResponseBody
	public String delete(@RequestBody Map<String, Object> result) {
		long follower = (long)Integer.parseInt((String) result.get("follower"));		  
		long following = (long)Integer.parseInt((String) result.get("following"));
		 
		followService.delete(follower, following);
		
		return "ok";
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
	@RequestMapping("/my_page/myindex/{userNo}")
	public ModelAndView jieun(@PathVariable Long userNo) {
		System.out.println("누구의 팔로잉 리스트 ? " + userNo);
		
		List<Follow> following = followService.selectByUserId(userNo);
		
		List<Follow> followerSize = followService.myFollower(userNo);
		List<Follow> followingSize = followService.myFollowing(userNo);
		
		if(following.isEmpty() || following.size()==0) {
			System.out.println("비었거나 팔로잉이 없다.");
		}
		
		for(Follow f : following) {
			System.out.println(f.getFollowingUser());
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("followingList", following);
		
		mv.addObject("follower", followerSize.size());
		mv.addObject("following", followingSize.size());
		
		mv.setViewName("my_page/layout");
		
		return mv;		
	}
	
}
