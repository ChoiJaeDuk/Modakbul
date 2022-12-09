package modakbul.mvc.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.FollowService;
import modakbul.mvc.service.UserAttachmentsService;
import modakbul.mvc.service.UsersService;

@Controller
//@RequestMapping("/user")
@RequiredArgsConstructor
public class UsersController {
	private final UsersService usersService;
	private final UserAttachmentsService userAttachService;
	
	@Autowired
	private FollowService followService;
	
	@Autowired
	private UserAttachmentsService attachService;
	
	
	@RequestMapping("/{url}")
	public void url() {
		
	}

	@RequestMapping("/user/mypageIndex/{userNo}")
	public String mypage(@PathVariable Long userNo, Model model, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);

		String fileNames [] = file.list();
		List<Follow> follower = followService.myFollower(userNo);
		List<Follow> following = followService.myFollowing(userNo);
		List<UserAttachments> attachList = attachService.selectAll(Users.builder().userNo(userNo).build());
		
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		
		
		model.addAttribute("attachList", attachList);
		model.addAttribute("fileNames", fileNames);
		
		return "user/mypageIndex";
		
	}

	
	@RequestMapping("/login")
	public void login() {
		
	}

	@RequestMapping("/insert")
	public String insert(Users user, @RequestParam("userAttachmentsFileSubject[]") List<String> userAttachmentsFileSubject, HttpSession session, @RequestParam("filesList[]") List<MultipartFile> filesList, MultipartFile file) {
		UserAttachments userAttach = new UserAttachments();
		
		System.out.println(user.getUserProfileImg());
			System.out.println("userGender" + user.getUserGender());
			
			String saveDir = session.getServletContext().getRealPath("/save");
		
			String originalFileName = file.getOriginalFilename();
			System.out.println("파일 = "+ originalFileName+"/");
			try {
				file.transferTo(new File(saveDir + "/" + originalFileName));
			}catch (Exception e) {
				e.getStackTrace();
			}
	
		
		if(originalFileName.length() > 0) {
			System.out.println("일루안와 ?");
			user.setUserProfileImg(originalFileName);
			usersService.insert(user);
		}else {
			System.out.println(user.getUserProfileImg());
			usersService.insert(user);
		}
		
		
		
		
		System.out.println("성공");
		System.out.println("userId= " + user.getUserId());
		System.out.println("userId= " + user.getUserEmail());
		Users dbUser = usersService.selectById(user.getUserId());

		System.out.println("사이즈 + " + filesList.size());
		if(filesList.size()>1) {
			for(int i = 0; i<filesList.size(); i++) {
				
				System.out.println("여기를안와?");
				file = filesList.get(i);
				
				String subject = userAttachmentsFileSubject.get(i);
				originalFileName = file.getOriginalFilename();
					
				if(file.getOriginalFilename().length()>0) {
					try {
						System.out.println("업로드");
						file.transferTo(new File(saveDir + "/" + originalFileName));
					}catch(Exception e) {
						e.getStackTrace();
						System.out.println("안된거야");
					}
					
					  userAttach.setUser(Users.builder().userNo(dbUser.getUserNo()).build());
					  userAttach.setUserAttachmentsFileSubject(subject);
					  userAttach.setUserAttachmentsFileName(originalFileName);
					  userAttachService.insert(userAttach);
				}
			}
			

		}
		
	
		return "loginForm";
	}
	
	@RequestMapping("/update")
	public void update(Users user, HttpSession session, @RequestParam("userAttachmentsFileSubject[]") List<String> userAttachmentsFileSubject, @RequestParam("filesList[]") List<MultipartFile> filesList) {
		usersService.update(user);
		//userAttachService.update()
		
		String saveDir = session.getServletContext().getRealPath("/save");
		
	/*	String originalFileName = files.getOriginalFilename();
		System.out.println("파일 = "+ originalFileName+"/");
		try {
			file.transferTo(new File(saveDir + "/" + originalFileName));
		}catch (Exception e) {
			e.getStackTrace();
		}

	
	if(originalFileName.length() > 0) {
		System.out.println("일루안와 ?");
		user.setUserProfileImg(originalFileName);
		usersService.insert(user);
	}else {
		System.out.println(user.getUserProfileImg());
		usersService.insert(user);
	}
	
	
	
	
	System.out.println("성공");
	System.out.println("userId= " + user.getUserId());
	System.out.println("userId= " + user.getUserEmail());
	Users dbUser = usersService.selectById(user.getUserId());

	System.out.println("사이즈 + " + filesList.size());
	if(filesList.size()>1) {
		for(int i = 0; i<filesList.size(); i++) {
			
			System.out.println("여기를안와?");
			file = filesList.get(i);
			
			String subject = userAttachmentsFileSubject.get(i);
			originalFileName = file.getOriginalFilename();
				
			if(file.getOriginalFilename().length()>0) {
				try {
					System.out.println("업로드");
					file.transferTo(new File(saveDir + "/" + originalFileName));
				}catch(Exception e) {
					e.getStackTrace();
					System.out.println("안된거야");
				}
				
				  userAttach.setUser(Users.builder().userNo(dbUser.getUserNo()).build());
				  userAttach.setUserAttachmentsFileSubject(subject);
				  userAttach.setUserAttachmentsFileName(originalFileName);
				  userAttachService.insert(userAttach);
			}
		}
	}*/
	}

}
