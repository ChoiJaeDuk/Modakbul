<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${pageContext.request.contextPath}/css/my-page/alarm/myPage-alarm.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/my-page/alarm/reset.css" rel="stylesheet" />
    <title>마이페이지-알람함</title>
    
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		console.log("새알람 = " + ${newAlarm});
    		if(${newAlarm}==0 || ${newAlarm}==null){
    			$(".nav-counter").hide();
    		}else{
    			$(".nav-counter").show();
    		}
    	})
    </script>
  </head>
 <body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	<div class="wrap">
		<div class="my-page-wrap">
			<div class="my-page-header" >
				<div class="my-page-image-wrap" id="original">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<c:set value="${user.userProfileImg}" var="img" />
						<c:set value="true" var="state1" />
						<c:forEach items="${fileNames }" var="file">
							<c:if test="${file eq img }">
								<c:set value="true" var="state2" />
								<img class="sign-up-image"
									src="${pageContext.request.contextPath}/save/${user.userProfileImg }"
									alt="img" />

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="sign-up-image" src="${user.userProfileImg }"
								alt="img" />
						</c:if>

						<input id="sign-up-add-image" class="sign-up-add-image"
							type="file" name="file" accept="image/*" />
					</sec:authorize>
				</div>
				<div class="my-page-user-info-wrap" >
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<div class="my-page-user-name">

							<div>${user.userName }님</div>


						</div>
						<div class="my-page-user-temperature">모닥불 온도 : ${user.temper }&#8451</div>
						<div class="my-page-user-follow-wrap">
							<div>
								<div>팔로워</div>
								<div>&nbsp;&nbsp;&nbsp;${follower}</div> 
							</div>
							<div>
								<div>팔로잉</div>
							 <div>&nbsp;&nbsp;&nbsp;${following}</div> 
								<div>
									<a
										href="${pageContext.request.contextPath}/follow/followingList?userNo=7">&nbsp;&nbsp;&nbsp;${following}</a>
								</div>
							</div>
						</div>
					</sec:authorize>
				</div>
			</div>
			<div class="my-page-content-wrap">
				<nav>
					<ul>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/profile/myProfile/${user.userNo}'">프로필정보</li>
						<li class="my-page-nav-item" onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'" style="position:relative;"> 
							알림함
							
							<c:choose>
								<c:when test="${newAlarm ne 0 || newAlarm ne null}">
									<span class="nav-counter"> ${newAlarm} </span>
								</c:when>
								<c:otherwise>
									<div class="nav-counter-invi" style="display: none;">
										<span class="nav-counter-invi"> 0 </span>
									</div>
								</c:otherwise> 
							</c:choose>
							
						</li>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
						<li class="my-page-nav-item">광고신청</li>
					</ul>
				</nav>
          <section class="my-page-main-content">
            <div class="alert">
                <div class="table-wrap">
                    <table class="table">
                        <colgroup>
                            <col width="13%" />
                            <col width="13%" />
                            <col width="26%" />
                            <col width="36%" />
                            <col width="12%" />
                        </colgroup>
                        <thead>
                            <tr class="table-header">
                            <th>번호</th>
                            <th>제목</th>
                            <th>내용</th>
                            <th>날짜</th>
                            <th>삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageList.content}" var="ar" varStatus="state">
                            <tr class="table-body">
                            	<c:set var="TextValue" value="${ar.alarm.issueDate}" />
                                <td>${state.count}</td> 
                                <td>${ar.alarm.alarmSubject}</td>
                                <td>${ar.alarm.alarmContent}</td>
                                
                                <td>${fn:substring(TextValue,0,10)}</td>
                                <td>
                                    <button class="my-page-button" onclick="location.href='${pageContext.request.contextPath}/alarm/delete?receiverNo=${ar.alarmReceiveNo}&userNo=${userNo}';">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
             <div style="text-align: center">
		<!--  블럭당  -->
 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  --><!-- /alarm/myAlarm?userNo=9 -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}&nowPage=${startPage-1}">PREV</a>
		  </c:if> 
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=pageList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}&nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=pageList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/my_page/alarm/myAlarm??userNo=${user.userNo}&nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
				 
			
		
		</div>
	</nav>  
</div>
          </section>
        </div>
      </div>
    </div>
  </body>
</html>
