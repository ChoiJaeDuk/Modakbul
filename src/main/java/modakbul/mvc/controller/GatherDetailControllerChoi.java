package modakbul.mvc.controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.jni.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.ParticipantService;
import modakbul.mvc.service.UsersService;
@Controller
@RequestMapping("/gatherDetail")
@RequiredArgsConstructor
public class GatherDetailControllerChoi {

	
	private final GatherService gatherService;
	private final ParticipantService participantService;
	private final UsersService usersService;
	
	@RequestMapping("/info")
	public void info(Model model, Long gatherNo, String userNo) {
		System.out.println("userNo = " + userNo);
		
		
		
		Long userNoLong = Long.parseLong(userNo);
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		  
		int check = participantService.checkParticipant(gatherNo, userNoLong);
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		System.out.println("check = "+check);  
		model.addAttribute("gather", gather); 
		model.addAttribute("participant", participant);
		model.addAttribute("userNo1", userNoLong);
		model.addAttribute("check", check);
		
		
	}
	
	@RequestMapping("/hostProfile")
	public void hostProfile(Model model, Long gatherNo, Long userNo, HttpSession session) {
		
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);
		
		String fileNames [] = file.list();
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		Users user = usersService.selectById(gather.getUser().getUserNo());
		
		model.addAttribute("hostUser", user);
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		model.addAttribute("fileNames", fileNames);
	}
	
	
	@RequestMapping("/qna")
	public void qna(Model model, Long gatherNo, Long userNo) {
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		
	}
	
	
	@RequestMapping("/review")
	public void review(Model model, Long gatherNo, Long userNo) {
		
		Gather gather = gatherService.selectGatherByGatherNo(gatherNo);
		
		int participant = participantService.selectParticipantCountByGatherNo(gatherNo);
		
		model.addAttribute("gather", gather);
		model.addAttribute("participant", participant);
		
	}
	
	@RequestMapping("/insertParticipant")
	public String insertParticipant(Model model, Long userNo, Long gatherNo,RedirectAttributes re) {
		
		System.out.println("userNo = " + userNo);
		System.out.println("gatherNo = " + gatherNo);
		Gather gather = new Gather(gatherNo);
		Users user = new Users(userNo);
		Participant participant = new Participant(0L, gather, user, "신청대기");
		
		int check = participantService.checkParticipant(gatherNo, userNo);
		System.out.println("check = "+check);
		participantService.insertParticipant(participant);
		System.out.println("호출되니?");
		model.addAttribute("check", check);
		re.addAttribute("userNo",userNo);
		re.addAttribute("gatherNo",gatherNo);
		
		return "redirect:/gatherDetail/info";
	}
}
