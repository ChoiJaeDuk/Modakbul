<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로잉</title>
</head>
<body>
<h3>팔로잉</h3>
<hr color="blue">

<c:choose>
	<c:when test="${not empty followingList}" >
	<c:forEach items="${followingList}" var="f" >
	 회원번호 : ${f.followerUser.userNo} <br>
	 회원닉넴 : ${f.followerUser.userNick} <br>
	 온도 : ${f.followerUser.temper}℃ <br>
	 <p>
	 
	 <hr>
	
	</c:forEach>
	</c:when>
	<c:otherwise>
		<h4>팔로잉 상대가 없습니다.</h4>
	</c:otherwise>
</c:choose>

 


</body>
</html>