<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>file upload</title>
</head>
<body>

	<h2>파일업로드</h2>

	<div class="container">
		<form action="/fileInsert" method="post"
			enctype="multipart/form-data">
			<input type="file" name="files"> 
			<!-- 여기서 files는 controller에 @RequestPart MultipartFile files -->

			<button type="submit" class="btn btn-dark">업로드</button>
		</form>
	</div>
</body>
</html>