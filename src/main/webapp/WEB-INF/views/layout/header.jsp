<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>     
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
          <!-- <h1 class="modakbul-title">MODAKBUL</h1> -->
          <p class="modakbul-title"><strong>MODAKBUL</strong></p>
        </div>
        <div class="modakbul-header-center flex">
          <p class="modakbul-header-menu header-selected">메뉴</p>
          <p class="modakbul-header-menu">메뉴</p>
          <p class="modakbul-header-menu">메뉴</p>
          <p class="modakbul-header-menu">메뉴</p>
        </div>
        
        <div class="modakbul-header-right">
        <%-- <sec:authorize access="isAuthenticated()">
			<sec:authentication var="user" property="principal" /> 
			<c:choose>
				<c:when test="${user.state } eq 'ROLE_ADMIN'">
					 <h3>관리자 모드</h3>
				</c:when>
				<c:otherwise>
					<c:set value="${user.userProfileImg}" var="img"/>
			<c:set value="true" var="state1"/>
			<c:forEach items="${fileNames }" var="file">
				<c:if test="${file eq img }">
					<c:set value="true" var="state2"/>
				<img
              class="sign-up-image"
              src="${pageContext.request.contextPath}/save/${user.userProfileImg }"
              alt="img"
           		 />
           		 
				</c:if>

			</c:forEach>

		<c:if test="${state1 ne state2}">
			<img
              class="sign-up-image"
              src="${user.userProfileImg }"
              alt="img"
           		 />
          </c:if>
					<h3>회원 모드</h3>
				</c:otherwise>
			
			</c:choose>
			
		</sec:authorize>	 --%>
         <h3>관리자 모드</h3>
        </div>
      </header>
      <div class="bannerSection">
<img src="${pageContext.request.contextPath}/css/banner4.png" alt="modakbul-icon" class="modakbul-banner"/>
</div>
	</body>
     
</head>

</html>