<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdvAll'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
        
		 <div class="cont-wrap">
			<div class="nav-wrap">
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageAll" >전체</a></div>
				<div class="manageGroup-nav selected"><a href="${pageContext.request.contextPath}/admin/manageIndiv?job=개인">개인회원</a></div>
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageCom?job=기관">기관/사업자</a></div>
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageGroup">모임관리</a></div>
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
						<jsp:useBean id="now" class="java.util.Date"/>
						<fmt:formatDate value="${now }" pattern="yyyy" var="year"/>
						<fmt:formatDate value="${userValidateNo }" pattern="yyyy-mm-dd" var="birth"/>
						<tr>
							<td>${indiv.userNo}</td>
							<td>${indiv.userId }</td>
							<td>${indiv.userNick }</td>
							<td>${indiv.userGender }</td>
		<%-- 	- ${} --%>
							<td>19${indiv.userValidateNo.substring(0,2)} </td>
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
			
			
			
			
		</div>
	
        </div>
        
      </div>
    
      
    </div>
    
 
     <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageIndiv?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		
			    <c:if test="${(i-1)>=indivList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageIndiv?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=indivList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageIndiv?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if> 
				 
			
		
		</div>
	</nav>
	<jsp:include page="../layout/footer.jsp" />
  </body>
</html>