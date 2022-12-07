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
	public void url() {
		
	}
	
	@RequestMapping("/login")
	public void login() {
		
	}
	
	@RequestMapping("/insert")
	public ModelAndView insert(Users user, UserAttachments userAttach, HttpSession session, @RequestParam("filesList[]") List<MultipartFile> filesList, MultipartFile file) {
		
		System.out.println("userGender" + user.getUserGender());
		
		String saveDir = session.getServletContext().getRealPath("/WEB-INF/save");
		//fileList.forEach(b->System.out.println(b));
		
		String originalFileName = file.getOriginalFilename();
		System.out.println("파일 = "+ originalFileName);
		try {
			file.transferTo(new File(saveDir + "/" + originalFileName));
		}catch (Exception e) {
			e.getStackTrace();
		}
		
		if(user.getUserProfileImg()==null) {
			
			user.setUserProfileImg(originalFileName);
		}
		
		usersService.insert(user);
		System.out.println("성공");
		System.out.println("userId= " + user.getUserId());
		Users dbUser = usersService.selectById(user.getUserId());
		
		/*
		 * for(MultipartFile file : fileList) {
		 * //originalFileName.add(file.getOriginalFilename()); try {
		 * 
		 * //file.transferTo(new File(saveDir + "/" + originalFileName)); //���� (���ε�)
		 * 
		 * }catch (Exception e) { e.getStackTrace(); } }
		 */
		System.out.println("사이즈 + " + filesList.size());
		if(filesList.size()>1) {
			for(int i = 0; i<filesList.size(); i++) {
				
				System.out.println("여기를안와?");
				file = filesList.get(i);
				originalFileName = file.getOriginalFilename();
				try {
					System.out.println("업로드");
					file.transferTo(new File(saveDir + "/" + originalFileName));
				}catch(Exception e) {
					e.getStackTrace();
					System.out.println("안된거야");
				}
				System.out.println("attach = " + userAttach.getUserAttachmentsFileSubject());
				userAttach.setUser(Users.builder().userNo(dbUser.getUserNo()).build());
				userAttach.setUserAttachmentsFileName(originalFileName);
				userAttachService.insert(userAttach);
			}
			
			
		}
		
		
		//System.out.println("users.no = " + user.getUserEmail());
		//System.out.println("users.img = " + user.getUserProfileImg());
		
		
		
		
		return null;
	}
	
	
	

}
