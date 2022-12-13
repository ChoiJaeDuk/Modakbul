package modakbul.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.service.GatherService;
@Controller
@RequestMapping("/gatherDetail")
@RequiredArgsConstructor
public class GatherDetailControllerChoi {

	
	private final GatherService gatherService;
	
	
	@RequestMapping("/info")
	public void info(Model model, Long gatherNo) {
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		model.addAttribute("gather", gather);
		
	}
}
