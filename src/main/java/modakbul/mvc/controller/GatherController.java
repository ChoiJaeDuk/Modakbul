package modakbul.mvc.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
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
	public ModelAndView gatherInsert(Gather gather,Long userNo, String date, RegularGather regularGather/*, @RequestParam("filesList[]") List<GatherAttachments> gatherAttachments
			, HttpSession session, MultipartFile file*/) {
		LocalDateTime gatherDate = LocalDateTime.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		LocalDateTime deadLine = gatherDate.minusHours(3);
		RegularGather rg = regularGatherService.insertRegularGather(regularGather);
		
		Users user = new Users(userNo);
		
		gather.setRegularGather(rg);
		gather.setGatherDate(gatherDate);
		gather.setGatherDeadline(deadLine);
		gather.setUser(user);
		
		//System.out.println("RegularGather = " + regularGather);
		//gatherService.insertGather(gather, null, null);
//		String saveDir = session.getServletContext().getRealPath("/WEB-INF/save");
//		String originalFileName = file.getOriginalFilename();
//		System.out.println("파일 = "+ originalFileName);
//		try {
//			file.transferTo(new File(saveDir + "/" + originalFileName));
//		}catch (Exception e) {
//			e.getStackTrace();
//		}

//		System.out.println(gather.getCategory().getCategoryName());
//		gatherService.insertGather(gather, gatherAttachments, regularGather);
		
		return new ModelAndView("/gather/success");
	}
}

