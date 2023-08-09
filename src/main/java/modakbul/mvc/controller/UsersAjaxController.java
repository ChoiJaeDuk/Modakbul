package modakbul.mvc.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.service.UserAttachmentsService;
import modakbul.mvc.service.UsersService;

@RestController
@RequiredArgsConstructor
public class UsersAjaxController {
	
	private final UsersService usersService;
	
	private final UserAttachmentsService userAttachService;
	
	private final AuthenticationManager authenticationManager;
	
	@RequestMapping("selectUserId")
	public String selectUserId(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		System.out.println("email = " + email );
		String userId = usersService.selectUserId(email);
		System.out.println(userId);
		if(userId == null) {
			return "이메일에 해당하는 정보가 없습니다.";
		}
		return userId;
		
	}
	
	@RequestMapping("selectUserPwd")
	public String selectUserPwd(HttpServletRequest request) throws Exception{
		
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		System.out.println(email + "," + id);
		boolean result = usersService.selectUserPwd(id, email);
		System.out.println("result = " + result);
		if(result==true) {
			return "해당 이메일로 임시비밀번호가 전송되었습니다.";
		}
		return "해당 정보에 해당하는 회원이 없습니다.";
		
	}
	
	@RequestMapping("sendCode")
	public String emailCheck(HttpServletRequest request) throws Exception {
		String email = request.getParameter("email");
		System.out.println("email = " + email);
		return usersService.sendCode(email);
	}
	
	@RequestMapping("checkId")
	public String checkId(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		
		Users user = usersService.selectById(id);
	
		if(user==null) {
			return "가능";
		}else {
			return "사용";
		}
		
		
	}
	
	@RequestMapping("checkNick")
	public String checkNick(HttpServletRequest request) {
		
		String nick = request.getParameter("nick");
		
		boolean result = usersService.nickCheck(nick);
		System.out.println("nick = " + nick + ", result = " + result);
	
		if(result==true) {
			return "사용가능한 닉네임";
		}else {
			return "이미 사용중인 닉네임";
		}

	}
	
	@RequestMapping("update")
	public String update(Users user,  HttpSession session, @RequestParam(value = "newFilesList[]" , required =false ) List<MultipartFile> filesList
			 , @RequestParam(value = "newFileSubject[]", required = false) List<String> userAttachmentsFileSubject
			, MultipartFile file) {
		System.out.println("왓냥");
	
	    
		UserAttachments userAttach = new UserAttachments();
		
		
		//System.out.println("userAttachmentsFileSubject = " + userAttachmentsFileSubject);
		
		String saveDir = session.getServletContext().getRealPath("/save");
		
		Users dbUser = usersService.selectById(user.getUserId());
		System.out.println("userid = " + user.getUserId());
		System.out.println("user.getUserProfileImg() = "+ user.getUserProfileImg());
		if(user.getUserProfileImg().length() > 0) {
			new File((saveDir + "/" + dbUser.getUserProfileImg())).delete();
			
			System.out.println("여기와썽 ?");
			String fileName = file.getOriginalFilename();
			try {
				file.transferTo(new File(saveDir + "/" + fileName));
			}catch (Exception e) {
				e.getStackTrace();
			}
		}
		user.setUserNo(dbUser.getUserNo());
		usersService.update(user);
		System.out.println("햇어 ?");
		
		/*변경된 세션 등록 */
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(dbUser.getUserId(), dbUser.getUserpwd()));
                
        SecurityContextHolder.getContext().setAuthentication(authentication);
      
		if(filesList !=null) {
			for(int i = 0; i< filesList.size(); i++) {
				
				MultipartFile fileOne = filesList.get(i);
				String originalFileName = fileOne.getOriginalFilename();
				 String subject = userAttachmentsFileSubject.get(i);
				
				 System.out.println("파일 = "+ originalFileName+"/");
				 System.out.println("제목 = " + subject);
				 try { 
					 fileOne.transferTo(new File(saveDir + "/" + originalFileName)); 
				 }
				 catch (Exception e) {
					 
					 e.getStackTrace();
				 }
				 
				 
				 userAttach.setUser(Users.builder().userNo(dbUser.getUserNo()).build());
				 userAttach.setUserAttachmentsFileSubject(subject);
				 userAttach.setUserAttachmentsFileName(originalFileName);
				 userAttachService.insert(userAttach);
			}
			
		}
	

		return "ok";
	}
	


}