<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3> user/loginForm.jsp 입니다. </h3>
	<c:if test="${param.err != null}">
		Error message : 
		<b style="color:red">${SPRING_SECURITY_LAST_EXCEPTION.message} / 정보가 일치하지 않습니다.</b>
	</c:if>
<form action="${pageContext.request.contextPath}/loginCheck" method="post">
	id  : <input type="text" name="id"><p>
	pwd : <input type="password" name="pwd"><p>
	<input type="submit" value="login">
	<input type="reset" value="cancle">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
</form>

</body>
</html>