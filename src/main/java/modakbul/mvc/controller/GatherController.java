package modakbul.mvc.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Category;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherAttachments;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.GatherAttachmentsService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.RegularGatherService;
import modakbul.mvc.service.UserAttachmentsService;
import modakbul.mvc.service.UsersService;
@Controller
@RequestMapping("/gather")
@RequiredArgsConstructor
public class GatherController {
	
	private final GatherService gatherService;
	private final RegularGatherService regularGatherService;
	private final GatherAttachmentsService gatherAttachmentsService;
	private final UserAttachmentsService userAttachmentsService;
	
	private final static int PAGE_COUNT=5;
	private final static int BLOCK_COUNT=4;
	
	@RequestMapping("/regularGatherInsertForm")
	public Model regularGatherInsertForm(Model model,Long userNo) {
		System.out.println(userNo);
		List<UserAttachments> userAttachments = userAttachmentsService.selectUserAttachmentsByUserNo(userNo);
		
		
		model.addAttribute("userAttachments", userAttachments);
		model.addAttribute("userNo", userNo);
		
		return model;
	}
	
	
	@RequestMapping("/dayTimeGatherInsertForm")
	public Model dayTimeGatherInsertForm(Model model,Long userNo) {
		
		List<UserAttachments> userAttachments = userAttachmentsService.selectUserAttachmentsByUserNo(userNo);
			
		model.addAttribute("userAttachments", userAttachments);
		model.addAttribute("userNo", userNo);
		
		return model;
	}
	
	
	@RequestMapping("/gatherInsert")
	public String gatherInsert(Gather gather,Long userNo, String date, RegularGather regularGather
			,@RequestParam("gatherAttachmentsFileSubject[]") List<String> gatherAttachmentsFileSubject
			,HttpSession session, MultipartFile file, @RequestParam("filesList[]") List<MultipartFile> filesList, Long categoryNo ) {
		//gatherDate??? Local???????????? ??????
		
		LocalDateTime gatherDate = LocalDateTime.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		//deadLine??? ?????? 3?????????????????? gatherDate-3??????
		LocalDateTime deadLine = gatherDate.minusHours(3);
		
		
		
		//??????????????? ?????? ??????????????? ??????.
		if(regularGather.getRegularGatherCycle()!=0) {
			regularGatherService.insertRegularGather(regularGather);
			gather.setRegularGather(regularGather);
		}else {
			gather.setRegularGather(null);
		}
		Users user = new Users(userNo);
		Category category = new Category(categoryNo);
		
		
		gather.setGatherDate(gatherDate);
		gather.setGatherDeadline(deadLine);
		gather.setUser(user);
		gather.setCategory(category);
		//?????? ????????? ??????
		String saveDir = session.getServletContext().getRealPath("/save");
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
		
		
		
		if(filesList.size()>1) {
			for(int i = 0; i<filesList.size(); i++) {
				GatherAttachments gatherAttachments = new GatherAttachments();
				System.out.println("????????????????");
				file = filesList.get(i);
				
				String subject = gatherAttachmentsFileSubject.get(i);
				originalFileName = file.getOriginalFilename();
					
				
				if(file.getOriginalFilename().length()>0) {
					try {
						System.out.println("?????????");
						file.transferTo(new File(saveDir + "/" + originalFileName));
					}catch(Exception e) {
						e.getStackTrace();
						System.out.println("????????????");
					}
					  
					  gatherAttachments.setGather(gather);
					  gatherAttachments.setGatherAttachmentsFileSubject(subject);
					  gatherAttachments.setGatherAttachmentsFileName(originalFileName);
					  System.out.println("??? ???????");
					  gatherAttachmentsService.insertGatherAttachments(gatherAttachments);
				}
			}
			

		}
		
		return "redirect:/";
	}
	
}

