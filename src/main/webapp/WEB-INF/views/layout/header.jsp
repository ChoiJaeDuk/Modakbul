<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MODAKBUL</title>
<link
	href="${pageContext.request.contextPath}/css/admin/adminLayout.css"
	rel="stylesheet"/>
	
<script type="text/javascript">
/* 
$(function(){
	$(".myPageImg").click(function(){
		location.href="${pageContext.request.contextPath}/my_page/my_page_index/${user.userNo}";
	}) 
}) */


var index = 0;   //이미지에 접근하는 인덱스
window.onload = function(){
    slideShow();
}

function slideShow() {
var i;
var x = document.getElementsByClassName("modakbul-banner");  //slide1에 대한 dom 참조
for (i = 0; i < x.length; i++) {
   x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
}
index++;
if (index > x.length) {
    index = 1;  //인덱스가 초과되면 1로 변경
}   
x[index-1].style.display = "block";  //해당 인덱스는 block으로
setTimeout(slideShow, 4000);   //함수를 4초마다 호출

}
</script>
<body>
	<header id="modakbul-header" class="flex">
		<div class="modakbul-header-left flex">
			<img src="${pageContext.request.contextPath}/css/icon.png"
				alt="modakbul-icon" />
			<!-- <h1 class="modakbul-title">MODAKBUL</h1> -->
			<p class="modakbul-title">
				<strong onclick="location.href='/'">MODAKBUL</strong>
			</p>
		</div>
		<div class="modakbul-header-center flex">
			<p class="modakbul-header-menu" onclick="location.href='${pageContext.request.contextPath}/main/regularGather'" id="regular">정기</p>
			<p class="modakbul-header-menu" id="daily" onclick="location.href='${pageContext.request.contextPath}/main/dayTimeGather'">일일</p>
			<p class="modakbul-header-menu" id="gov" onclick="location.href='${pageContext.request.contextPath}/main/agencyGather'">기관</p>
			<p class="modakbul-header-menu" id="notice" onclick="location.href='${pageContext.request.contextPath}/question/notice'">공지사항</p>
		</div>

		<div class="modakbul-header-right">
			<sec:authorize access="isAuthenticated()">
			<sec:authentication var="user" property="principal" /> 
			
			<c:choose>
			
				<c:when test="${user.state == 'ROLE_ADMIN'}">
				
					<div class="loginheader-wrap2">
						<div class="loginheader" id="gotomypage">
						<img src="${pageContext.request.contextPath}/css/mypage.png" class="myPageImg" onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">
						</div>
						<div class="loginheader"  id="gotomypage2"> 
							<form action="${pageContext.request.contextPath}/logout" method="post" class="logout">
								 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								 <input type="image" class="logoutImg" src="${pageContext.request.contextPath}/css/logout.png" value="로그아웃"/> 
								
							</form>
						</div>	  
					</div>
				</c:when>
				
				<c:otherwise>
				<div class="loginheader-wrap">
					<div class="loginheader" id="gotomypage">
					<img src="${pageContext.request.contextPath}/css/mypage.png" class="myPageImg" onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_index/${user.userNo }'">
					</div>
					<div class="loginheader"  id="gotomypage2"> 
						 <form action="${pageContext.request.contextPath}/logout" method="post" class="logout">
							 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							 <input type="image" class="logoutImg" src="${pageContext.request.contextPath}/css/logout.png" value="로그아웃"/> 
							
						 </form>
					</div>	  
				</div>	 
				</c:otherwise> 
				
			</c:choose>	
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
			<img class="loginImg" src="${pageContext.request.contextPath}/css/login.png" onclick="location.href='${pageContext.request.contextPath}/loginForm'"/>
					
			
			</sec:authorize>
		
		<!-- <h3>회원 모드</h3> -->
		
		</div>
	</header>
 <%-- <div class="bannerSection">
	 
		    <img src="${pageContext.request.contextPath}/css/banner3.png"
			alt="modakbul-icon" class="modakbul-banner" onclick="" /> 
			
			<img src="${pageContext.request.contextPath}/css/banner4.png"
			alt="modakbul-icon" class="modakbul-banner" />
			
			<img src="${pageContext.request.contextPath}/css/banner5.png"
			alt="modakbul-icon" class="modakbul-banner" />
			
			<img src="${pageContext.request.contextPath}/css/banner6.png"
			alt="modakbul-icon" class="modakbul-banner" />
			
			<img src="${pageContext.request.contextPath}/css/banner7.png"
			alt="modakbul-icon" class="modakbul-banner" /> 
			
 --%>
	
	
       <!--  <ul class="dot">
            <li class="on"> <input type="button" value="버튼1"></li>
            <li> <input type="button" value="버튼2"></li>
            <li> <input type="button" value="버튼3"></li>
            <li> <input type="button" value="버튼4"></li>
            <li> <input type="button" value="버튼5"></li>
        </ul> -->
 	<!-- </div> -->
	

</body>

</head>

</html>