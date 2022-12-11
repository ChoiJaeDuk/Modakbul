<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link
	href="${pageContext.request.contextPath}/css/my-page-review/index.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/css/my-page-review/reset.css"
	rel="stylesheet" />
<title>Document</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<jsp:include page="../admin/header.jsp" />
	<br>
	<br>
	<br>
	<div class="wrap">
		<div class="my-page-wrap">
			<div class="my-page-header">
				<div class="my-page-image-wrap">
					<img src="https://dummyimage.com/200x200/e8e3e8/fff&text=img"
						alt="img" />
				</div>
				<div class="my-page-user-info-wrap">
					<div class="my-page-user-name">
						<div>${user.userName}님</div>
						<button class="my-page-button" type="button">프로필 편집</button>
					</div>
					<div class="my-page-user-temperature">모닥불 온도 :
						${user.temper}&#8451</div>
					<div class="my-page-user-follow-wrap">
						<div>
							<div>팔로워</div>
							<div>${follower}</div>
						</div>
						<div>
							<div>팔로잉</div>
							<div>${following}</div>
						</div>
					</div>
				</div>
			</div>
			<div class="my-page-content-wrap">
				<nav>
					<ul>
						<li class="my-page-nav-item">프로필정보</li>
						<li class="my-page-nav-item">알림함</li>
						<li class="my-page-nav-item">모임조회</li>
						<li class="my-page-nav-item">관심모임</li>
						<li class="my-page-nav-item selected">후기조회</li>
						<li class="my-page-nav-item">문의조회</li>
						<li class="my-page-nav-item">광고신청</li>
					</ul>
				</nav>
				<section class="my-page-main-content">
					<div class="class-search">
						<div class="filter-wrap">
							<div class="filter-list-wrap">
								<div id="r" class="filter-list-item selected"
									onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기쓰기</div>
								<div id="rc" class="filter-list-item"
									onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review/complete?userNo=${user.userNo}'">작성완료</div>
							</div>
						</div>
						<div class="table-wrap selected" id="tab-1">
							<table class="table">
								<colgroup>
									<col width="8%" />
									<col width="37%" />
									<col width="18%" />
									<col width="24%" />
									<col width="15%" />
								</colgroup>
								<thead>
									<tr class="table-header">
										<th>번호</th>
										<th>사진</th>
										<th>모임</th>
										<th>종료날짜</th>
										<th>후기쓰기</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when
											test="${0 eq requestScope.reviewStatusList.getTotalPages()}">
											<tr>
												<td colspan="5">작성할 후기가 없습니다 🔥</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="review"
												items="${requestScope.reviewStatusList.content}">
												<c:set var="TextValue" value="${review.gatherDeadline}" />
												<tr class="table-body">
													<td>${review.gatherNo}</td>
													<td>
														<div class="table-small-image-wrap">
															<img src="" alt="이미지" width="100%" />
														</div>
													</td>
													<td>${review.gatherName}</td>
													<td>${fn:substring(TextValue,0,10)}</td>
													<td class="inquiry-replied">
														<button class="my-page-button">후기쓰기</button>
													</td>
												</tr>
											</c:forEach>


										</c:otherwise>
									</c:choose>
								</tbody>
							</table>

						</div>
						<div style="text-align: center">
							<!--  블럭당  -->
							<nav class="pagination-container">
								<div class="pagination">
									<c:set var="doneLoop" value="false" />

									<c:if test="${(startPage-blockCount) > 0}">
										<!-- (-2) > 0  -->
										<a class="pagination-newer"
											href="${pageContext.request.contextPath}/board/list?nowPage=${startPage-1}">PREV</a>
									</c:if>

									<span class="pagination-inner"> <c:forEach var='i'
											begin='${startPage}' end='${(startPage-1)+blockCount}'>

											<c:if test="${(i-1)>=pageList.getTotalPages()}">
												<c:set var="doneLoop" value="true" />
											</c:if>

											<c:if test="${not doneLoop}">
												<a class="${i==nowPage?'pagination-active':page}"
													href="${pageContext.request.contextPath}/board/list?nowPage=${i}">${i}</a>
											</c:if>

										</c:forEach>
									</span>

									<c:if
										test="${(startPage+blockCount)<=pageList.getTotalPages()}">
										<a class="pagination-older"
											href="${pageContext.request.contextPath}/board/list?nowPage=${startPage+blockCount}">NEXT</a>
									</c:if>
								</div>
							</nav>
						</div>
					</div>

					<!-- 추가된 내용 -->
				</section>
			</div>


		</div>
	</div>
	<jsp:include page="../layout/footer.jsp" />
</body>
</html>
