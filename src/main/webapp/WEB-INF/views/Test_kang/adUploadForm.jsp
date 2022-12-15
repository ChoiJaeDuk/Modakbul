<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>file upload</title>
</head>
<body>

<h2>광고 신청 폼</h2>
모임 대표사진<p>
모임 제목<p>


<div>
<form action="${pageContext.request.contextPath}/admin2/advertisementInsert" method="post" enctype="multipart/form-data">
	광고 진행 날짜 : <input type="date" name=""> ~ <input type="date" name=""><p>
	파일 첨부 : <input type="file" name="file"/><p>
	가격 : <input type="text" name="adPrice"><p>
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="전송" />
</form>
</div>

</body>
</html>