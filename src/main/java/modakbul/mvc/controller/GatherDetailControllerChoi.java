package modakbul.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.ParticipantService;
@Controller
@RequestMapping("/gatherDetail")
@RequiredArgsConstructor
public class GatherDetailControllerChoi {

	
	private final GatherService gatherService;
	private final ParticipantService participantService;
	
	@RequestMapping("/info")
	public void info(Model model, Long gatherNo) {
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		
	}
}
