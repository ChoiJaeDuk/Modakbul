<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
     <body>
	<header id="modakbul-header" class="flex">
        <div class="modakbul-header-left flex">
          <img src="${pageContext.request.contextPath}/css/icon.png" alt="modakbul-icon" />
          <p class="modakbul-title">MODAKBUL</p>
        </div>
        <div class="modakbul-header-center flex">
          <p class="modakbul-header-menu header-selected">정기</p>
          <p class="modakbul-header-menu">일일</p>
          <p class="modakbul-header-menu">기관</p>
          <p class="modakbul-header-menu">공지사항</p>
        </div>
        <div class="modakbul-header-right">
          <h3>관리자 모드</h3>
        </div>
      </header>

	</body>
     
</head>

</html>