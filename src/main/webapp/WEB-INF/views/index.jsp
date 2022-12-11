<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
  a{text-decoration: none;}
</style>
</head>
<body>
<h1>Spring Security 요청</h1>
<h4>
   USER :  사용자 /  
   MEMBER : 가입된 사용자 /
   ADMIN : 관리자 <p>
</h4>

<h1>
<c:if test="${not empty pageContext.request.userPrincipal}">
	<sec:authorize access="isAuthenticated()">
    ${pageContext.request.userPrincipal.name}님<p>
    <sec:authentication property="principal.userName"/>님<p>
    
	<a href="${pageContext.request.contextPath }/my_page/profile/myProfile/<sec:authentication property='principal.userNo'/>">프로필</a> 
    </sec:authorize>

   <form action="${pageContext.request.contextPath}/logout" method="post">
	   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	   <input type="submit" value="로그아웃"/> 
   </form>


</c:if>



	<h3><a href="${pageContext.request.contextPath}/logout">로그아웃</a></h3>


  <a href="${pageContext.request.contextPath}"> index</a></h1>

<h2> USER </h2>
<a href="${pageContext.request.contextPath}/user/main">user/main - 인증없이 접근 가능</a><p>
<a href="${pageContext.request.contextPath}/user/login">user/login - 인증해야만 접근 가능(ROLE_USER)</a><p>
<a href="${pageContext.request.contextPath}/user/loginForm">user/loginForm - 인증없이 접근 가능</a><p>
<a href="${pageContext.request.contextPath}/user/board">user/board - 인증없이 접근 가능</a><p>

<h2> MEMBER </h2>
<a href="${pageContext.request.contextPath}/member/main">member/main - 인증해야만 접근 가능</a><p>
<a href="${pageContext.request.contextPath}/member/myPage">member/myPage - 인증해야만 접근 가능</a><p>

<h2> ADMIN </h2>
<a href="${pageContext.request.contextPath}/admin/main">admin/main - 인증해야만 접근 가능(ROLE_ADMIN,ROLE_USER)</a><p>
<a href="${pageContext.request.contextPath}/admin/board">admin/board - 인증해야만 접근 가능(ROLE_ADMIN,ROLE_USER)</a><p>
<a href="${pageContext.request.contextPath}/admin2/userList">유저 페이지 가기</a><p>
<a href="${pageContext.request.contextPath}/admin2/gatherList">모임 페이지 가기</a><p>
<a href="${pageContext.request.contextPath}/admin2/adList">광고 페이지 가기</a><p>
<a href="${pageContext.request.contextPath}/admin2/adChart">광고 월별 매출 차트</a><p>
<a href="${pageContext.request.contextPath}/admin2/userChart">유저 월별 증가 차트</a><p>
<a href="${pageContext.request.contextPath}/admin2/categoryGatherChart">카테고리별 모임 개수 차트</a><p>
</body>
</html>







