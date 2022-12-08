package modakbul.mvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherAttachments;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.service.GatherService;
@Controller
@RequestMapping("/gather")
@RequiredArgsConstructor
public class GatherController {
	
	private final GatherService gatherService;
	
	@RequestMapping("/gatherInsertForm")
	public void gatherInsertForm() {}
	
	
	@RequestMapping("gatherInsert")
	public ModelAndView gatherInsert(Gather gather, List<GatherAttachments> gatherAttachments , RegularGather regularGather) {
		
		gatherService.insertGather(gather, gatherAttachments, regularGather);
		
		
		
		return new ModelAndView();
	}
}

