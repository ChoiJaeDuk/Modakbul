<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/send-one">
		from : <input type="text" name="from"/></br>
		to : <input type="text" name="to" /></br> 
		content : <input type="text" name="content"/></br> 
		<input type="submit" value="로그인" />
	</form>
</body>
</html>