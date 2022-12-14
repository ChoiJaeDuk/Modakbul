package modakbul.mvc.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.NamedStoredProcedureQueries;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
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
import modakbul.mvc.repository.UsersRepository;
import modakbul.mvc.service.AlarmService;
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
	
	@Autowired
	private AlarmService alarmService;
	
	private final static int PAGE_COUNT = 5;
	private final static int BLOCK_COUNT=4;
	
	
	@RequestMapping("/{url}")
	public void url() {
		
	}
	
	@RequestMapping("/layout/myProfileLayout")
	public void url2() {
			
	}
	
	@RequestMapping("/userProfile/profileGather/{userNo}")
	public String profileGather(@PathVariable Long userNo, Long loginUserNo, Model model, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);
		
		Users user = usersService.selectById(userNo);
		String fileNames [] = file.list();
		
		List<Follow> follower = followService.myFollower(userNo);
		
		String searchFollow = followService.searchFollowing(userNo, loginUserNo);
		System.out.println("있어 없어? = " + searchFollow);
		
		System.out.println("로그인 :  " + loginUserNo);
		model.addAttribute("follower", follower.size());
		model.addAttribute("user", user);
		model.addAttribute("fileNames", fileNames);
		model.addAttribute("searchFollow",searchFollow);
		model.addAttribute("loginUserNo",loginUserNo);
		
		return "userProfile/profileGather";
	}
	
	@RequestMapping("/userProfile/profileReview/{userNo}")
	public String profileReview(@PathVariable Long userNo, Long loginUserNo, Model model, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);
		
		Users user = usersService.selectById(userNo);
		String fileNames [] = file.list();
		
		List<Follow> follower = followService.myFollower(userNo);
		
		String searchFollow = followService.searchFollowing(userNo, loginUserNo);
		
		model.addAttribute("follower", follower.size());
		model.addAttribute("user", user);
		model.addAttribute("fileNames", fileNames);
		model.addAttribute("searchFollow",searchFollow);
		model.addAttribute("loginUserNo",loginUserNo);
		
		
		return "userProfile/profileReview";
	}
	
	
	@RequestMapping("/my_page/profile/myProfile/{userNo}")
	public String mypage(@PathVariable Long userNo, Model model, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		File file = new File(path);

		String fileNames [] = file.list();
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		List<UserAttachments> attachList = attachService.selectAll(Users.builder().userNo(userNo).build());
		
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);
		
		
		model.addAttribute("attachList", attachList);
		model.addAttribute("fileNames", fileNames);
		
		return "my_page/profile/myProfile";
		
	}

	
	@RequestMapping("/login")
	public void login() {
		
	}

	@RequestMapping("/insert")
	public String insert(Users user, @RequestParam(value="userAttachmentsFileSubject[]", required = false ) List<String> userAttachmentsFileSubject, 
			HttpSession session, @RequestParam(value ="filesList[]", required = false) List<MultipartFile> filesList, MultipartFile file) {
		
		UserAttachments userAttach = new UserAttachments();
		String saveDir = session.getServletContext().getRealPath("/save");
		
		System.out.println(user.getUserProfileImg());
			System.out.println("userGender" + user.getUserGender());
			
			
		
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
		if(filesList.size()>0) {
			System.out.println("오지?");
			for(int i = 0; i<filesList.size(); i++) {
				
				System.out.println("여기를안와?");
				MultipartFile attachFile = filesList.get(i);
				
				String subject = userAttachmentsFileSubject.get(i);
				String originalFileName2 = attachFile.getOriginalFilename();
					System.out.println("gg = " + (originalFileName2.length()));
				if(attachFile.getOriginalFilename().length()>0) {
					
					try {
						System.out.println("업로드");
						attachFile.transferTo(new File(saveDir + "/" + originalFileName2));
					}catch(Exception e) {
						e.getStackTrace();
						System.out.println("안된거야");
					}
					
					  userAttach.setUser(Users.builder().userNo(dbUser.getUserNo()).build());
					  userAttach.setUserAttachmentsFileSubject(subject);
					  userAttach.setUserAttachmentsFileName(originalFileName2);
					  userAttachService.insert(userAttach);
				}
			}
			

		}
		
	
		return "loginForm";
	}
	/*
	 * @RequestMapping("/admin/{url}") public void
	 * selectUser(@RequestParam(defaultValue = "1") int nowPage, Model model){
	 * System.out.println("왔어 ?"); Pageable page = PageRequest.of(nowPage-1,
	 * PAGE_COUNT, Direction.ASC, "userNo");
	 * 
	 * Page<Users> userList = usersService.selectUsers(page, null, null);
	 * Page<Users> indivList = usersService.selectUsers(page, "개인", null);
	 * Page<Users> comList = usersService.selectUsers(page, "기관", null);
	 * 
	 * int temp = (nowPage-1)%BLOCK_COUNT;
	 * 
	 * int startPage = nowPage-temp; System.out.println("startPage = " + startPage);
	 * 
	 * model.addAttribute("userList", userList); model.addAttribute("indivList",
	 * indivList); model.addAttribute("comList", comList);
	 * 
	 * model.addAttribute("blockCount", BLOCK_COUNT);
	 * model.addAttribute("startPage", startPage); model.addAttribute("nowPage",
	 * nowPage);
	 * 
	 * model.addAttribute("count", userList.getTotalElements());
	 * model.addAttribute("countIdiv", indivList.getTotalElements());
	 * model.addAttribute("countCom", comList.getTotalElements());
	 * 
	 * }
	 */
	
	@RequestMapping("/userProfile/{url}")
	public void profile() {
		
	}
}
