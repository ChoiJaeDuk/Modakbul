package modakbul.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/question")
public class InqueryControllerKyu {

	@RequestMapping("{url}")
	public void url() {}
	
}
