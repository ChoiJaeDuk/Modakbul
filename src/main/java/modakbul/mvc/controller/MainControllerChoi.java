package modakbul.mvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.repository.AdminRepository;
import modakbul.mvc.service.AdminService;
import modakbul.mvc.service.GatherService;

@Controller
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainControllerChoi {
	
	private final GatherService gatherService;
	private final AdminService adminService;
	private final AdminRepository adminRepository;
	
	@RequestMapping("/main")
	public void main(Model model) {
		List<Gather> selectAdGather = adminRepository.selectAdGather();
		
		model.addAttribute("selectAdGather", selectAdGather);
	}
	
	@RequestMapping("{url}")
	public void url() {}
}
