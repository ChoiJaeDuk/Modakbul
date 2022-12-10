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
     <jsp:include page="../layout/header.jsp" />
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
				<div id="nav1"><a href="${pageContext.request.contextPath}/admin/manageAll" >전체</a></div>
				<div id="nav2"><a href="${pageContext.request.contextPath}/admin/manageIndiv?job=개인">개인회원</a></div>
				<div id="nav3"><a href="${pageContext.request.contextPath}/admin/manageCom?job=기관">기관/사업자</a></div>
				<div id="nav4"><a href="${pageContext.request.contextPath}/admin/manageGroup">모임관리</a></div>
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
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageCom?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		
			    <c:if test="${(i-1)>=comList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageCom?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=comList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageCom?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if> 
				 
			
		
		</div>
	</nav>
  </body>
   <jsp:include page="../layout/footer.jsp" />
</html>