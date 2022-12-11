<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
  <body>
    <div id="modakbul-outer-wrapper">
      <jsp:include page="./header.jsp" />
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageUser'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdv'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
          
          <div><b>진행중 광고 : ${fn:length(adStatusList1)}&emsp;&emsp;신청대기 광고 : ${fn:length(adStatusList2)}&emsp;&emsp;종료된 광고 : ${fn:length(adStatusList3)}</b></div>
          
		<div class="cont-wrap">
			<div class="ad-wrap">
				<div class="ad">현재 진행중 광고 : ${fn:length(adStatusList1)}</div>
				<div class="ad">현재 신청대기 광고 : ${fn:length(adStatusList2)}</div>
				<div class="ad">종료된 광고 : ${fn:length(adStatusList3)}</div>
			</div>
	
			<div class="nav-wrap">
				<div id="nav1"><a href="#advAll">전체</a></div>
				<div id="nav2"><a href="#advRegis">신청대기</a></div>
				<div id="nav3"><a href="#advIng">진행중</a></div>
				<div id="nav4"><a href="#advEnd">종료</a></div>
			</div>
			
<div id="advAll" class="content">
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
    <c:when test="${empty requestScope.pageList}">
	<tr>
        <td colspan="5">
            <p align="center"><b><span style="font-size:9pt;">등록된 게시물이 없습니다.</span></b></p>
        </td>
    </tr>
    </c:when>
    <c:otherwise>
	<c:forEach items="${requestScope.pageList.content}" var="advertisement">
		    <tr onmouseover="this.style.background='#eaeaea'" onmouseout="this.style.background='white'">
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.advertisementNo}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.gather.gatherImg}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            <a href="${pageContext.request.contextPath}/a/b/${advertisement.advertisementNo}">
		            ${advertisement.gather.gatherName}</a></span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userName}
					</span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userJob}
					</span></p>
		        </td>
		         <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adRegisDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adStatus}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adApproveDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.deadLine}</span></p>
		        </td>
       
		    </tr>
		    
		   
    </c:forEach>
	</c:otherwise>
    </c:choose>

	</table>
</div>

<div style="text-align: center">
		<!--  블럭당  -->
 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  --> <!--양수가 나오면 이전이 있다-->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageAdv?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> <!-- 1부터 11 페이지까지 뿌림 --> 
		  
			    <c:if test="${(i-1)>=pageList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageAdv?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=pageList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageAdv?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
				 
			
		
		</div>
	</nav>  
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
					
					<c:choose>
    <c:when test="${empty requestScope.adStatusList1}">
	<tr>
        <td colspan="5">
            <p align="center"><b><span style="font-size:9pt;">등록된 게시물이 없습니다.</span></b></p>
        </td>
    </tr>
    </c:when>
    <c:otherwise>
	<c:forEach items="${requestScope.adStatusList1}" var="advertisement">
		    <tr onmouseover="this.style.background='#eaeaea'" onmouseout="this.style.background='white'">
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.advertisementNo}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.gather.gatherImg}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            <a href="${pageContext.request.contextPath}/a/b/${advertisement.advertisementNo}">
		            ${advertisement.gather.gatherName}</a></span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userName}
					</span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userJob}
					</span></p>
		        </td>
		         <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adRegisDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adStatus}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adApproveDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.deadLine}</span></p>
		        </td>
       
		    </tr>
		    
		   
    </c:forEach>
	</c:otherwise>
    </c:choose>
					
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
					
					<c:choose>
    <c:when test="${empty requestScope.adStatusList2}">
	<tr>
        <td colspan="5">
            <p align="center"><b><span style="font-size:9pt;">등록된 게시물이 없습니다.</span></b></p>
        </td>
    </tr>
    </c:when>
    <c:otherwise>
	<c:forEach items="${requestScope.adStatusList2}" var="advertisement">
		    <tr onmouseover="this.style.background='#eaeaea'" onmouseout="this.style.background='white'">
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.advertisementNo}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.gather.gatherImg}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            <a href="${pageContext.request.contextPath}/a/b/${advertisement.advertisementNo}">
		            ${advertisement.gather.gatherName}</a></span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userName}
					</span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userJob}
					</span></p>
		        </td>
		         <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adRegisDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adStatus}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adApproveDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.deadLine}</span></p>
		        </td>
       
		    </tr>
		    
		   
    </c:forEach>
	</c:otherwise>
    </c:choose>
					
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
					
					<c:choose>
    <c:when test="${empty requestScope.adStatusList3}">
	<tr>
        <td colspan="5">
            <p align="center"><b><span style="font-size:9pt;">등록된 게시물이 없습니다.</span></b></p>
        </td>
    </tr>
    </c:when>
    <c:otherwise>
	<c:forEach items="${requestScope.adStatusList3}" var="advertisement">
		    <tr onmouseover="this.style.background='#eaeaea'" onmouseout="this.style.background='white'">
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.advertisementNo}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.gather.gatherImg}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            <a href="${pageContext.request.contextPath}/a/b/${advertisement.advertisementNo}">
		            ${advertisement.gather.gatherName}</a></span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userName}
					</span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${advertisement.user.userJob}
					</span></p>
		        </td>
		         <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adRegisDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adStatus}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.adApproveDate}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${advertisement.deadLine}</span></p>
		        </td>
       
		    </tr>
		    
		   
    </c:forEach>
	</c:otherwise>
    </c:choose>
					
				</table>
			</div>
			
			
		</div>

        </div>
      </div>
    </div>
  </body>
</html>
