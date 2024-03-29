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
   	<link href="${pageContext.request.contextPath}/css/admin/adminCharged.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/admin/adminPaging.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$(".button-agree").click(function(){
  			let btn = $(this).parent().parent().parent();
  			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/admin/updateAdGather",
				dataType:"text",
				data: "${_csrf.parameterName}=${_csrf.token}&status=광고중&advertisementNo="+$(this).val(),			
				success:function(result){
					alert(result);
					console.log(result)
						btn.remove()
					    //$("#advRegis").load(" #advRegis > *");
						$("#count").load(location.href + " #count"); 
						$("button").attr("disabled", false)
			
				},//function
				error:function(error){
					console.log(error)
				}
				
			});//ajax
  		})
  		
  		
  		 $(".button-deny").click(function(){
  			let btn = $(this).parent().parent().parent();
  			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/admin/updateAdGather",
				dataType:"text",
				data: "${_csrf.parameterName}=${_csrf.token}&status=승인거절&advertisementNo="+$(this).val(),			
				success:function(result){
					alert(result)
					console.log(result)
						btn.remove()
						/* $(".cont-wrap").load(location.href + " .cont-wrap"); */
						$("#count").load(location.href + " #count");
						
						
	   					
				
				},//function
				error:function(error){
					console.log(error)
				}
				
			});//ajax
  		}) 
  	})
  	
  	
  	
  
  
  </script>
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
          <div id="count"><b>진행중 광고 : ${fn:length(selectByStatus1)}&emsp;&emsp;신청대기 광고 : ${fn:length(selectByStatus2)}&emsp;&emsp;종료된 광고 : ${fn:length(selectByStatus3)}</b></div>
		<div class="cont-wrap">
			<%-- <div class="ad-wrap">
				<div class="ad">현재 진행중 광고 : ${fn:length(selectByStatus1)}</div>
				<div class="ad">현재 신청대기 광고 : 1</div>
				<div class="ad">종료된 광고 : 1</div>
			</div> --%>
	
			<div class="nav-wrap">
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageAdvAll">전체</a></div>
				<div class="manageGroup-nav selected"><a href="${pageContext.request.contextPath}/admin/manageAdvRegis?adStatus=신청대기">신청대기</a></div>
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageAdvIng?adStatus=광고중">진행중</a></div>
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageAdvEnd?adStatus=광고종료">종료</a></div>
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
					<c:when test="${!empty requestScope.advRegis}">
						<c:forEach var="adv" varStatus="status" items="${advRegis.content}">
						<tr>
							<td>${status.index+1}</td>
							<td><a href="dd"><img width="300px" src="${pageContext.request.contextPath}/save/${adv.gather.gatherImg}" alt="사진" /></a></td>
							<td>${adv.gather.gatherName}</td>
							<td>${adv.user.userNick}</td>
							<td>${adv.user.userJob}</td>
							<td>${fn:substring(adv.adRegisDate,0,10)}</td>
							<td>
                			<div class="modakbul-charged-grid-col">
                			<button type="button" class="modakbul-button button-agree" value="${adv.advertisementNo}" name="${adv.gather.gatherNo}">승인하기</button>   		
                			<button type="button" class="modakbul-button button-deny" value="${adv.advertisementNo}" >거절하기</button>
              				</div>
              				</td>
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
    
<div style="text-align: center">
   <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageAdvRegis?nowPage=${startPage-1}">PREV</a>
		  </c:if> 
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=advRegis.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageAdvRegis?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=advRegis.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageAdvRegis?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
		</div>
	</nav>  
	</div>
	
     <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
