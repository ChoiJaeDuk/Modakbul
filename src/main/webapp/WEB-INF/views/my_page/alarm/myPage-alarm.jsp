<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${pageContext.request.contextPath}/css/my-page/alarm/myPage-alarm.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/my-page/alarm/reset.css" rel="stylesheet" />
    <title>마이페이지-알람함</title>
  </head>
  <body>
    <div class="wrap">
      <div class="my-page-wrap">
        <div class="my-page-header">
          <div class="my-page-image-wrap">
            <img
              src="https://dummyimage.com/200x200/e8e3e8/fff&text=img"
              alt="img"
            />
          </div>
          <div class="my-page-user-info-wrap">
            <div class="my-page-user-name">
              <div>임지은님</div>
            </div>
            <div class="my-page-user-temperature">모닥불 온도 : 36.5&#8451</div>
            <div class="my-page-user-follow-wrap">
                <div>
                    <div>팔로워</div>
                    <div>320</div>
                </div>
                <div>
                    <div>팔로잉</div>
                    <div>11</div>
                </div>
            </div>
          </div>
        </div>
        <div class="my-page-content-wrap">
          <nav>
            <ul>
                <li class="my-page-nav-item">프로필정보</li>
                <li class="my-page-nav-item selected">알림함</li>
                <li class="my-page-nav-item">모임조회</li>
                <li class="my-page-nav-item">관심모임</li>
                <li class="my-page-nav-item">후기조회</li>
                <li class="my-page-nav-item">문의조회</li>
                <li class="my-page-nav-item">광고신청</li>
            </ul>
          </nav>
          <section class="my-page-main-content">
            <div class="alert">
                <div class="table-wrap">
                    <table class="table">
                        <colgroup>
                            <col width="8%" />
                            <col width="8%" />
                            <col width="26%" />
                            <col width="36%" />
                            <col width="12%" />
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
                                <td>${state.count}</td> 
                                <td>${ar.alarm.alarmSubject}</td>
                                <td>${ar.alarm.alarmContent}</td>
                                <td>${ar.alarm.issueDate}</td>
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
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/alarm/myAlarm?userNo=${userNo}&nowPage=${startPage-1}">PREV</a>
		  </c:if> 
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=pageList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/alarm/myAlarm?userNo=${userNo}&nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=pageList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/alarm/myAlarm??userNo=${userNo}&nowPage=${startPage+blockCount}">NEXT</a>
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
