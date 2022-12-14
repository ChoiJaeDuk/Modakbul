package modakbul.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.service.GatherService;
@Controller
//@RequestMapping("/gatherDetail")
@RequiredArgsConstructor
public class GatherDetailController {

	
	private final GatherService gatherService;
	
	
	
}
