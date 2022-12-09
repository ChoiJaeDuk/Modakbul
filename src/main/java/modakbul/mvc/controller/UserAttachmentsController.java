package modakbul.mvc.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.service.UserAttachmentsService;

@Controller
@RequiredArgsConstructor
public class UserAttachmentsController {
	private final UserAttachmentsService service;
	
	public static final String PATH_SAVE = "/save";
	
	@ResponseBody
	@RequestMapping("deleteAttach")
	public String delete(Long userAttachmentsFileNo, HttpSession session) {
		String saveDir = session.getServletContext().getRealPath("/save");
		UserAttachments attach = service.selectByNo(userAttachmentsFileNo);
		System.out.println("here=" +attach.getUserAttachmentsFileNo());
		if(attach.getUserAttachmentsFileNo()==null) {
			return "false";
		}else {
			System.out.println(saveDir+"/"+attach.getUserAttachmentsFileName());
			new File( (saveDir+"/"+attach.getUserAttachmentsFileName())).delete();
			
			System.out.println("no = " + userAttachmentsFileNo);
			
			service.delete(userAttachmentsFileNo);
			return "true";
		}
		
	}

	@RequestMapping("/down")
	public ModelAndView down(String fileName, HttpSession session) {
	//	String path = session.getServletContext().getRealPath("/WEB-INF/views");
		
		String path = session.getServletContext().getRealPath("/save");
		return new ModelAndView("downLoadView", "fname", new File(path + "/" + fileName));
		
	}
}
