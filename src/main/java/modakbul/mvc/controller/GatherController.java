package modakbul.mvc.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherAttachments;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.RegularGatherService;
@Controller
@RequestMapping("/gather")
@RequiredArgsConstructor
public class GatherController {
	
	private final GatherService gatherService;
	private final RegularGatherService regularGatherService;
	
	@RequestMapping("/gatherInsertForm")
	public void gatherInsertForm() {}
	
	
	@RequestMapping("/gatherInsert")
	public ModelAndView gatherInsert(Gather gather,Long userNo, String date, RegularGather regularGather, /*@RequestParam("filesList[]") List<GatherAttachments> gatherAttachments
			,*/HttpSession session, MultipartFile file) {
		//gatherDate를 Local타입으로 변경
		
		LocalDateTime gatherDate = LocalDateTime.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		//deadLine은 모임 3시간전이므로 gatherDate-3시간
		LocalDateTime deadLine = gatherDate.minusHours(3);
		
		RegularGather rg = null;
		
		//정기모임이 먼저 등록되어야 한다.
		if(regularGather.getRegularGatherCycle()!=0) {
			rg = regularGatherService.insertRegularGather(regularGather);
		}
		Users user = new Users(userNo);
		
		gather.setRegularGather(rg);
		gather.setGatherDate(gatherDate);
		gather.setGatherDeadline(deadLine);
		gather.setUser(user);
		
		//모임 이미지 첨부
		String saveDir = session.getServletContext().getRealPath("/WEB-INF/save");
		String originalFileName = file.getOriginalFilename();
		try {
			file.transferTo(new File(saveDir + "/" + originalFileName));
		}catch (Exception e) {
			e.getStackTrace();
		}
		if(originalFileName.length() > 0) {
			gather.setGatherImg(originalFileName);
		}
		gatherService.insertGather(gather);
		
		
		
		return new ModelAndView("/gather/success");
	}
}

