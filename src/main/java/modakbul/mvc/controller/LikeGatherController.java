//package modakbul.mvc.controller;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.servlet.ModelAndView;
//
//import modakbul.mvc.domain.LikeGather;
//import modakbul.mvc.service.LikeGatherService;
//
//@Controller
//@RequestMapping("/likeGather")
//public class LikeGatherController {
//	
//	@Autowired
//	private LikeGatherService likeGatherService;
//	
//	/**
//	 *  유저별 관심모임 목록
//	 */
//	@RequestMapping("/myLikeGather")
//	public ModelAndView myLike(Long userNo) {
//		LikeGather like = likeGatherService.selectById(userNo);
//		
//		return new ModelAndView("myPage/myLikeGather", "myList", like);
//	}
//	
//	/**
//	 * 등록
//	 */
//	@RequestMapping("/insert")
//	public String insert(LikeGather likeGather) {
//		likeGatherService.insert(likeGather);
//		
//		return "";
//	}
//	
//	/**
//	 * 삭제
//	 */
//	@RequestMapping("/delete")
//	public String delete(Long attentionNo) {
//		likeGatherService.delete(attentionNo);
//		
//		return "";
//	}
//	
//}
