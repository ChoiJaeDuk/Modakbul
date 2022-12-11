<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${pageContext.request.contextPath}/css/my-page/index.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/my-page/reset.css"
	rel="stylesheet" />
<title>Document</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	<div class="wrap">
		<div class="my-page-wrap">
			<div class="my-page-header">
				<div class="my-page-image-wrap">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<c:set value="${user.userProfileImg}" var="img" />
						<c:set value="true" var="state1" />
						<c:forEach items="${fileNames }" var="file">
							<c:if test="${file eq img }">
								<c:set value="true" var="state2" />
								<img class="sign-up-image"
									src="${pageContext.request.contextPath}/save/${user.userProfileImg }"
									alt="img" />

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="sign-up-image" src="${user.userProfileImg }"
								alt="img" />
						</c:if>

						<input id="sign-up-add-image" class="sign-up-add-image"
							type="file" name="file" accept="image/*" />
					</sec:authorize>
				</div>
				<div class="my-page-user-info-wrap">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<div class="my-page-user-name">

							<div>${user.userName }님</div>


						</div>
						<div class="my-page-user-temperature">모닥불 온도 : ${user.temper }&#8451</div>
						<div class="my-page-user-follow-wrap">
							<div>
								<div>팔로워</div>
								<div>&nbsp;&nbsp;&nbsp;${follower}</div>
							</div>
							<div>
								<div>팔로잉</div>
								<%-- <div>&nbsp;&nbsp;&nbsp;${following}</div> --%>
								<div>
									<a
										href="${pageContext.request.contextPath}/follow/followingList?userNo=7">&nbsp;&nbsp;&nbsp;${following}</a>
								</div>
							</div>
						</div>
					</sec:authorize>
				</div>
			</div>
			<div class="my-page-content-wrap">
				<nav>
					<ul>
						<li class="my-page-nav-item selected">프로필정보</li>
						<li class="my-page-nav-item">알림함</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList/'${user.userNo}">모임조회</li>
						<li class="my-page-nav-item">관심모임</li>
						<li class="my-page-nav-item">후기조회</li>
						<li class="my-page-nav-item">문의조회</li>
						<li class="my-page-nav-item">광고신청</li>
					</ul>
				</nav>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>