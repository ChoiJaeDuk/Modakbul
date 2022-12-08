package modakbul.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.groupby.SelectReplyState;
import modakbul.mvc.service.InquiryService;

@Controller
public class InquiryController {
	@Autowired
	private InquiryService inqService;

	@RequestMapping("/my_page/my_page_index")
	public ModelAndView main(Long userNo) {
		ModelAndView mv = new ModelAndView();

		List<SelectReplyState> list = inqService.selectReplyState(userNo);
		mv.addObject("replyState", list.size());
		mv.setViewName("my_page/my_page_index");

		return mv;
	}

}
