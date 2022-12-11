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
	public String update(Users user,  HttpSession session, @RequestParam(value = "filesList[]" , required =false ) List<MultipartFile> filesList
			 , @RequestParam(value = "newFileSubject[]", required = false) List<String> userAttachmentsFileSubject) {
		
	     System.out.println("userAttachmentsFileSubject = " + userAttachmentsFileSubject.size());
		UserAttachments userAttach = new UserAttachments();
		System.out.println("왓냥 user = " + user);
		
		System.out.println("userAttachmentsFileSubject = " + userAttachmentsFileSubject);
		
		Users dbUser = usersService.selectById(user.getUserId());
		System.out.println("userid = " + user.getUserId());
		System.out.println("filesList = "+ filesList);
		
		user.setUserNo(dbUser.getUserNo());
		usersService.update(user);
		System.out.println("햇어 ?");
		
		/*변경된 세션 등록 */
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(dbUser.getUserId(), dbUser.getUserpwd()));
                
        SecurityContextHolder.getContext().setAuthentication(authentication);
 
        //return new ResponseEntity<>("success", HttpStatus.OK);
		//userAttachService.update()
		//System.out.println("사이즈 = " + filesList.size());
		String saveDir = session.getServletContext().getRealPath("/save");
		if(filesList !=null) {
			for(int i = 0; i< filesList.size(); i++) {
				
				MultipartFile file = filesList.get(i);
				String originalFileName = file.getOriginalFilename();
				 String subject = userAttachmentsFileSubject.get(i);
				
				 System.out.println("파일 = "+ originalFileName+"/");
				 System.out.println("제목 = " + subject);
				 try { 
					 file.transferTo(new File(saveDir + "/" + originalFileName)); 
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
		 
		
	
		/*
		 * //if(originalFileName.length() > 0) { System.out.println("일루안와 ?");
		 * user.setUserProfileImg(originalFileName); usersService.insert(user); }else {
		 * System.out.println(user.getUserProfileImg()); usersService.insert(user); }
		 */
	
		/*
		 * System.out.println("성공"); System.out.println("userId= " + user.getUserId());
		 * System.out.println("userId= " + user.getUserEmail());
		 * 
		 * 
		 * 
		 * System.out.println("사이즈 + " + filesList.size()); if(filesList.size()>0) {
		 * for(int i = 0; i<filesList.size(); i++) {
		 * 
		 * System.out.println("여기를안와?");
		 * 
		 * MultipartFile file = filesList.get(i);
		 * 
		 * String subject = userAttachmentsFileSubject.get(i); String originalFileName =
		 * file.getOriginalFilename();
		 * 
		 * if(file.getOriginalFilename().length()>0) { try { System.out.println("업로드");
		 * file.transferTo(new File(saveDir + "/" + originalFileName)); }catch(Exception
		 * e) { e.getStackTrace(); System.out.println("안된거야"); }
		 * 
		 * userAttach.setUser(Users.builder().userNo(dbUser.getUserNo()).build());
		 * userAttach.setUserAttachmentsFileSubject(subject);
		 * userAttach.setUserAttachmentsFileName(originalFileName);
		 * userAttachService.insert(userAttach);
		 * 
		 * } } }
		 */

		return "ok";
	}
	

.my-page-button {
    height: 40px;
    padding: 4px 8px;
    background-color: rgb(243, 156, 18);
    font-size: 12px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0;
    cursor: pointer;
}
	


.certificate-file-button {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 40px;
    padding: 4px 8px;
    background-color: rgb(243, 156, 18);
    font-size: 12px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0;
    cursor: pointer;
    box-sizing: border-box;
}
}






 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageUser?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=userList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageUser?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=userList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageUser?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if> 
				 
			
		
		</div>
	</nav>







<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
	 <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminPaging.css" rel="stylesheet" />
    
  <body>
    <div id="modakbul-outer-wrapper">
     <jsp:include page="./header.jsp" />
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageUser'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdv'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
        
		 <div class="cont-wrap">
			<div class="nav-wrap">
				<div id="nav1"><a href="#">전체</a></div>
				<div id="nav2"><a href="#">개인회원</a></div>
				<div id="nav3"><a href="#">기관/사업자</a></div>
				<div id="nav4"><a href="#">모임관리</a></div>
			</div>
			
			<div class="content current" >
				<table>
					<tr class="table-header">
						<th>진행중인 모닥불 : </th>
						<th>모닥불 회원 : ${count }명</th>
					</tr>
					<tr>
						<td>
							<div id="chart1">차트1</div>
							카테고리별 모임수, 전체 모임수 등
						</td>
						<td>
							<div id="chart2">차트2</div>
							월별 회원수 그래프
						</td>
					</tr>
				</table>
	 		</div>
			
			<div id="indivUser" class="content"> 
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>ID</th>
						<th>닉네임</th>
						<th>성별</th>
						<th>연령</th>
						<th>E-Mail</th>
						<th>구분</th>
						<th>팔로워 수</th>
					</tr>
					
					<c:choose>
					
					<c:when test="${!empty requestScope.indivList}">
						<c:forEach var="indiv" items="${indivList.content}">
						<tr>
							<td>${indiv.userNo}</td>
							<td>${indiv.userId }</td>
							<td>${indiv.userNick }</td>
							<td>${indiv.userGender }</td>
							<td>111</td>
							<td>${indiv.userEmail }</td>
							<td>${indiv.userJob }</td>
							<td>${indiv.followerList.size() }</td>
							</tr>
						</c:forEach> 
						</c:when>
						<c:otherwise>
						
							<td>111</td>
						</c:otherwise>
					
					
					</c:choose>
					
					
					
				</table>
		 		  
			</div>
			
			<div id="comUser" class="content"> 
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>ID</th>
						<th>기관명</th>
						<th>사업자번호</th>
						<th>E-Mail</th>
						<th>구분</th>
						<th>팔로워 수</th>
					</tr>
					<c:choose>
					
					<c:when test="${!empty requestScope.comList}">
						<c:forEach var="com" items="${comList.content}">
						<tr>
							<td>${com.userNo}</td>
							<td>${com.userId }</td>
							<td>${com.userNick }</td>
							<td>${com.userValidateNo.substring(0,3) }-${com.userValidateNo.substring(3,5) }-${com.userValidateNo.substring(5) }</td>
							<td>${com.userEmail }</td>
							<td>${com.userJob }</td>
							<td>${com.followerList.size() }</td>
							</tr>
						</c:forEach> 
						</c:when>
						<c:otherwise>
						
							<td>111</td>
						</c:otherwise>
					
					
					</c:choose>
					
				</table>
	 </div>
			
			<div id="gather" class="content"> 
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>모임</th>
						<th>모임명</th>
						<th>주최자</th>
						<th>구분</th>
						<th>등록일</th>
						<th>모임일</th>
						<th>모임상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
		</div> 
		</div>
	
        </div>
        
      </div>
    
      
    </div>
    
 
     <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageUser?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		
			    <c:if test="${(i-1)>=userList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageUser?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=userList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageUser?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if> 
				 
			
		
		</div>
	</nav>
  </body>
</html>

    

<div id="indivUser" class="content"> 
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>ID</th>
						<th>닉네임</th>
						<th>성별</th>
						<th>연령</th>
						<th>E-Mail</th>
						<th>구분</th>
						<th>팔로워 수</th>
					</tr>
					
					<c:choose>
					
					<c:when test="${!empty requestScope.indivList}">
						<c:forEach var="indiv" items="${indivList.content}">
						<tr>
							<td>${indiv.userNo}</td>
							<td>${indiv.userId }</td>
							<td>${indiv.userNick }</td>
							<td>${indiv.userGender }</td>
							<td>111</td>
							<td>${indiv.userEmail }</td>
							<td>${indiv.userJob }</td>
							<td>${indiv.followerList.size() }</td>
							</tr>
						</c:forEach> 
						</c:when>
						<c:otherwise>
						
							<td>111</td>
						</c:otherwise>
					
					
					</c:choose>
					
					
					
				</table>
		 		  
			</div>





<div id="advRegis" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>이미지</th>
						<th>모임명</th>
						<th>신청자</th>
						<th>구분</th>
						<th>신청일</th>
						<th>광고상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
			</div>
			
			<div id="advIng" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>이미지</th>
						<th>모임명</th>
						<th>신청자</th>
						<th>구분</th>
						<th>개월</th>
						<th>광고상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
			</div>
			
			<div id="advEnd" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>이미지</th>
						<th>모임명</th>
						<th>신청자</th>
						<th>구분</th>
						<th>등록일</th>
						<th>종료일</th>
						<th>개월</th>
						<th>광고상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
			</div>
			
