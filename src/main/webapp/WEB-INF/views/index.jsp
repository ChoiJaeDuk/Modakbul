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
<h1>Spring Security ��û</h1>
<h4>
   USER :  ����� /  
   MEMBER : ���Ե� ����� /
   ADMIN : ������ <p>
</h4>

<h1>
<c:if test="${not empty pageContext.request.userPrincipal}">
	<sec:authorize access="isAuthenticated()">
    ${pageContext.request.userPrincipal.name}��<p>
    <sec:authentication property="principal.userName"/>��<p>
    
	<a href="${pageContext.request.contextPath }/my_page/profile/myProfile/<sec:authentication property='principal.userNo'/>">������</a> 
    </sec:authorize>

   <form action="${pageContext.request.contextPath}/logout" method="post">
	   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	   <input type="submit" value="�α׾ƿ�"/> 
   </form>


</c:if>



	<h3><a href="${pageContext.request.contextPath}/logout">�α׾ƿ�</a></h3>


  <a href="${pageContext.request.contextPath}"> index</a></h1>

<h2> USER </h2>
<a href="${pageContext.request.contextPath}/user/main">user/main - �������� ���� ����</a><p>
<a href="${pageContext.request.contextPath}/user/login">user/login - �����ؾ߸� ���� ����(ROLE_USER)</a><p>
<a href="${pageContext.request.contextPath}/user/loginForm">user/loginForm - �������� ���� ����</a><p>
<a href="${pageContext.request.contextPath}/user/board">user/board - �������� ���� ����</a><p>

<h2> MEMBER </h2>
<a href="${pageContext.request.contextPath}/member/main">member/main - �����ؾ߸� ���� ����</a><p>
<a href="${pageContext.request.contextPath}/member/myPage">member/myPage - �����ؾ߸� ���� ����</a><p>

<h2> ADMIN </h2>
<a href="${pageContext.request.contextPath}/admin/main">admin/main - �����ؾ߸� ���� ����(ROLE_ADMIN,ROLE_USER)</a><p>
<a href="${pageContext.request.contextPath}/admin/board">admin/board - �����ؾ߸� ���� ����(ROLE_ADMIN,ROLE_USER)</a><p>
<a href="${pageContext.request.contextPath}/admin2/userList">���� ������ ����</a><p>
<a href="${pageContext.request.contextPath}/admin2/gatherList">���� ������ ����</a><p>
<a href="${pageContext.request.contextPath}/admin2/adList">���� ������ ����</a><p>
<a href="${pageContext.request.contextPath}/admin2/adChart">���� ���� ���� ��Ʈ</a><p>
<a href="${pageContext.request.contextPath}/admin2/userChart">���� ���� ���� ��Ʈ</a><p>
<a href="${pageContext.request.contextPath}/admin2/categoryGatherChart">ī�װ��� ���� ���� ��Ʈ</a><p>
</body>
</html>







