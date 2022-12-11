<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <jsp:include page="../layout/header.jsp" />
    <div id="modakbul-outer-wrapper">
     
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdvAll'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
          <div><b>진행중 광고 : ${fn:length(selectByStatus1)}&emsp;&emsp;신청대기 광고 : ${fn:length(selectByStatus2)}&emsp;&emsp;종료된 광고 : ${fn:length(selectByStatus3)}</b></div>
		<div class="cont-wrap">
			<div class="ad-wrap">
				<div class="ad">현재 진행중 광고 : 1</div>
				<div class="ad">현재 신청대기 광고 : 1</div>
				<div class="ad">종료된 광고 : 1</div>
			</div>
	
			<div class="nav-wrap">
				<div id="nav1"><a href="${pageContext.request.contextPath}/admin/manageAdvAll">전체</a></div>
				<div id="nav2"><a href="${pageContext.request.contextPath}/admin/manageAdvRegis?adStatus=신청대기">신청대기</a></div>
				<div id="nav3"><a href="${pageContext.request.contextPath}/admin/manageAdvIng?adStatus=광고중">진행중</a></div>
				<div id="nav4"><a href="${pageContext.request.contextPath}/admin/manageAdvEnd?adStatus=광고종료">종료</a></div>
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
					<c:choose>
					<c:when test="${!empty requestScope.advIng}">
						<c:forEach var="adv" items="${advIng.content}">
						<tr>
							<td>${adv.advertisementNo}</td>
							<td>${adv.gather.gatherImg}</td>
							<td>${adv.gather.gatherName}</td>
							<td>${adv.user.userName}</td>
							<td>${adv.user.userJob}</td>
							<td>예정</td>
							<td>${adv.adStatus}</td>
							</tr>
						</c:forEach> 
						</c:when>
					</c:choose>		
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
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageAdvIng?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		
			    <c:if test="${(i-1)>=indivList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageAdvIng?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=indivList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageAdvIng?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if> 
		</div>
	</nav>
     <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
