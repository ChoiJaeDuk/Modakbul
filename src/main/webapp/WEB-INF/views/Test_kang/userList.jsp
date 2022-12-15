<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"> -->
<style>
 a {text-decoration: none}
 @import url("https://fonts.googleapis.com/css?family=Roboto:400,300");

body {
	color: #2c3e50;
	font-family: 'Roboto', sans-serif;
	font-weight: 400;
}

h1 {
	text-align: center;
	font-size: 2.5rem;
	font-weight: 300;
}

.pagination-container {
	margin: 100px auto;
	text-align: center;
}

.pagination {
	position: relative;
}

.pagination a {
	position: relative;
	display: inline-block;
	color: #2c3e50;
	text-decoration: none;
	font-size: 1.2rem;
	padding: 8px 16px 10px;
}

.pagination a:before {
	z-index: -1;
	position: absolute;
	height: 100%;
	width: 100%;
	content: "";
	top: 0;
	left: 0;
	background-color: #2c3e50;
	border-radius: 24px;
	-webkit-transform: scale(0);
	transform: scale(0);
	transition: all 0.2s;
}

.pagination a:hover, .pagination a .pagination-active {
	color: #fff;
}

.pagination a:hover:before, .pagination a .pagination-active:before {
	-webkit-transform: scale(1);
	transform: scale(1);
}

.pagination .pagination-active {
	color: #fff;
}

.pagination .pagination-active:before {
	-webkit-transform: scale(1);
	transform: scale(1);
}

.pagination-newer {
	margin-right: 50px;
}

.pagination-older {
	margin-left: 50px;
}

img {
	width: 200px;
	height: 350px
}

table td {
	text-align: center;
}
img{width:200px; height:350px}

</style>


<table align="center" border="0" cellpadding="5" cellspacing="2" width="100%" bordercolordark="white" bordercolorlight="black">
<caption>회원 페이지</caption>
	<colgroup>
		<col width="15%"/>
		<col width="30%"/>
		<col width="16%"/>
		<col width="16%"/>
		<col width="7%"/>
		<col width="7%"/>
		<col width="7%"/>
	</colgroup>
	
	<tr>
		<td>
            <p align="center"><font color="black"><b>모닥불 개수 : ${fn:length(gatherList)}</b></font></p>
        </td>
        <td>
            <p align="center"><font color="black"><b>회원수 : ${fn:length(usersList)}</b></font></p>
        </td>
	</tr>
	
	<tr>
        <td bgcolor="blue">
            <p align="center">
            <font color="white"><b><span style="font-size:9pt;">No</span></b></font></p>
        </td>
        <td bgcolor="blue">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">ID</span></b></font></p>
        </td>
        <td bgcolor="blue">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">닉네임</span></b></font></p>
        </td>
        <td bgcolor="blue">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">성별</span></b></font></p>
        </td>
        <td bgcolor="blue">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">연령</span></b></font></p>
        </td>
        <td bgcolor="blue">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">email</span></b></font></p>
        </td>
        <td bgcolor="blue">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">구분</span></b></font></p>
        </td>
        <td bgcolor="blue">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">팔로워수</span></b></font></p>
        </td>
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
	<c:forEach items="${requestScope.pageList.content}" var="users">
		    <tr onmouseover="this.style.background='#eaeaea'" onmouseout="this.style.background='white'">
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${users.userNo}</span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					<a href="${pageContext.request.contextPath}/board/read/${advertisement.advertisementNo}"> 
					  ${users.userName}
					</a>
					</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${users.userNick}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${users.userGender}</span></p>
		        </td>
		         <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${users.userValidateNo}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${users.userEmail}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${users.userJob}</span></p>
		        </td>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${fn:length(users.followerList)}</span></p>
		        </td>
		    </tr>
    </c:forEach>
	</c:otherwise>
    </c:choose>
    
</table>

<hr>
<%-- ${pageList.hasPrevious()}  /  ${pageList.hasNext()} --%>
<div style="text-align: center">
		<!--  블럭당  -->
 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  --> <!--양수가 나오면 이전이 있다-->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin2/userList?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> <!-- 1부터 11 페이지까지 뿌림 --> 
		  
			    <c:if test="${(i-1)>=pageList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin2/userList?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=pageList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin2/userList?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
				 
			
		
		</div>
	</nav>  
</div>


<div align=right>
<span style="font-size:9pt;">&lt;<a href="${pageContext.request.contextPath}/board/write">글쓰기</a>&gt;</span></div>














