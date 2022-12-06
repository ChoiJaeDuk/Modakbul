package modakbul.mvc.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.UserAttachmentsService;
import modakbul.mvc.service.UsersService;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UsersController {
	private final UsersService usersService;
	private final UserAttachmentsService userAttachService;
	
	@RequestMapping("/{url}")
	public void loginForm() {
		
	}
	
	@RequestMapping("/login")
	public void login() {
		
	}
	
	@RequestMapping("/insert")
	public ModelAndView insert(Users user, UserAttachments userAttach, HttpSession session, List<MultipartFile> file) {
		
		System.out.println("하잉");
		String saveDir = session.getServletContext().getRealPath("/WEB-INF/save");
		//fileList.forEach(b->System.out.println(b));
		MultipartFile fileOne = file.get(0);
		
		String originalFileName = fileOne.getOriginalFilename();
		try {
			fileOne.transferTo(new File(saveDir + "/" + originalFileName));
		}catch (Exception e) {
			e.getStackTrace();
		}
		user.setUserProfileImg(originalFileName);
		usersService.insert(user);
		Users dbUser = usersService.selectById(user.getUserId());
		
		/*
		 * for(MultipartFile file : fileList) {
		 * //originalFileName.add(file.getOriginalFilename()); try {
		 * 
		 * //file.transferTo(new File(saveDir + "/" + originalFileName)); //���� (���ε�)
		 * 
		 * }catch (Exception e) { e.getStackTrace(); } }
		 */
		for(int i = 1; i<file.size(); i++) {
			fileOne = file.get(i);
			originalFileName = fileOne.getOriginalFilename();
			try {
				fileOne.transferTo(new File(saveDir + "/" + originalFileName));
			}catch(Exception e) {
				e.getStackTrace();
			}
			System.out.println("attach = " + userAttach.getUserAttachmentsFileSubject());
			userAttach.setUser(Users.builder().userNo(dbUser.getUserNo()).build());
			userAttach.setUserAttachmentsFileName(originalFileName);
			userAttachService.insert(userAttach);
		}
		
		
		//System.out.println("users.no = " + user.getUserEmail());
		//System.out.println("users.img = " + user.getUserProfileImg());
		
		
		
		
		return null;
	}
	
	
	

}
