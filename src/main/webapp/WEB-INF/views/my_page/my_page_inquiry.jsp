<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link
	href="${pageContext.request.contextPath}/css/my-page-inquiry/index.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/css/my-page-inquiry/reset.css"
	rel="stylesheet" />
<title>Document</title>
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
						<div>${user.userName} 님</div>
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
						<li class="my-page-nav-item">후기조회</li>
						<li class="my-page-nav-item selected">문의조회</li>
						<li class="my-page-nav-item">광고신청</li>
					</ul>
				</nav>
				<section class="my-page-main-content">

					<!-- 추가된 내용 -->
					<!-- 문의조회 -->
					<div class="inquiry">
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
									<th>모임</th>
									<th>제목</th>
									<th>날짜</th>
									<th>답변상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="inquiry"
									items="${requestScope.inquiryList.content}" varStatus="status">
									<c:set var="TextValue" value="${inquiry.inqRegisDate}" />

									<tr class="table-body">
										<td>${status.count }</td>
										<td>${inquiry.gatherName}</td>
										<td>${inquiry.inqSubject}</td>
										<td>${fn:substring(TextValue,0,10)}</td>
										<c:choose>
											<c:when test="${null eq inquiry.getState() }">
												<td>답변대기</td>
											</c:when>
											<c:otherwise>
												<td><p style="color: rgb(243, 156, 18);">답변완료</td>
											</c:otherwise>
										</c:choose>
									</tr>


								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 페이징 -->
					<div style="text-align: center">
						<!--  블럭당  -->
						<nav class="pagination-container">
							<div class="pagination">
								<c:set var="doneLoop" value="false" />

								<c:if test="${(startPage-blockCount) > 0}"><!-- (-2) > 0  -->
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

								<c:if test="${(startPage+blockCount)<=pageList.getTotalPages()}">
									<a class="pagination-older"
										href="${pageContext.request.contextPath}/board/list?nowPage=${startPage+blockCount}">NEXT</a>
								</c:if>
								<!-- 페이징 끝 -->
								
								<!-- 추가된 내용 -->
				</section>
			</div>
			<div class="modal-wrap" style="display: none">
				<div class="modal-title">내용</div>
				<div class="modal-text-wrap">정말로 삭제하시겠습니까?</div>
				<div class="modal-button-wrap">
					<button type="button" class="modal-button cancel-button">취소</button>
					<button type="button" class="modal-button search-id-button">
						확인</button>
				</div>
			</div>
			<div class="modal-wrap" style="display: none">
				<div class="modal-title">내용</div>
				<div class="modal-text-wrap">정말 취소하시겠습니까?</div>
				<div class="modal-button-wrap">
					<button type="button" class="modal-button cancel-button">취소</button>
					<button type="button" class="modal-button search-id-button">
						확인</button>
				</div>
			</div>
			<div class="modal-wrap" style="display: none">
				<div class="modal-text-wrap">하루 전 모임은 취소할 수 없습니다.</div>
				<div class="modal-button-wrap">
					<div></div>
					<button type="button" class="modal-button search-id-button">
						확인</button>
				</div>
			</div>
			<!-- 추가된 모달 -->
			<div class="commercial-modal-wrap" style="display: none">
				<div class="commercial-modal-title">광고 신청</div>
				<div class="create-commercial-wrap">
					<div class="create-commercial-top">
						<div class="create-commercial-image-wrap">
							<img width="100%" />
						</div>
						<div class="create-commercial-class-name">핸드드립 커피 클래스</div>
					</div>
					<div class="create-commercial-item">
						<div class="commercial-modal-label">광고 진행일자:</div>
						<div class="create-commercial-value-wrap">
							<div>2022/10/22~2022/11/22</div>
							<button type="button" class="my-page-button">기간 설정</button>
						</div>
					</div>
					<div class="create-commercial-item">
						<div class="commercial-modal-label">
							광고 배너 이미지 첨부(<span class="create-commercial-value-required">필수</span>)
						</div>
						<div class="create-commercial-input-wrap">
							<div>
								<input class="my-page-form-input" readonly /> <input
									id="create-image" type="file" class="commercial-image-input" />
								<div class="create-commercial-input-tip">가로 : 1000px 세로 :
									200px</div>
							</div>
							<label for="create-image" class="commercial-file-button">
								파일 첨부 </label>
						</div>
					</div>
					<div class="create-commercial-item">
						<div class="commercial-modal-label">광고 진행 금액:</div>
						<div class="create-commercial-value-wrap">
							<div>300원</div>
							<button type="button" class="my-page-button">결제 완료</button>
							<button type="button" class="my-page-button-gray">결제 하기</button>
						</div>
					</div>
				</div>
				<div class="modal-button-wrap">
					<button type="button" class="modal-button cancel-button">취소</button>
					<button type="button" class="modal-button search-id-button">
						확인</button>
				</div>
			</div>
			<div class="modal-wrap" style="display: none">
				<div class="create-commercial-warning">광고 신청을 정말 취소하시겠습니까?</div>
				<div class="modal-button-wrap">
					<button type="button" class="modal-button search-id-button">
						신청하기</button>
					<button type="button" class="modal-button cancel-button">뒤로가기</button>
				</div>
			</div>
			<div class="commercial-modal-wrap" style="display: none">
				<div class="commercial-modal-title">배너 수정하기</div>
				<div class="modify-commercial-current-image-text">현재 배너 이미지</div>
				<div class="modify-commercial-current-image-wrap">
					<img src="" alt="img" />
				</div>
				<div class="modify-commercial-change-image-wrap">
					<div class="commercial-modal-label">광고 배너 이미지 첨부</div>
					<div class="modify-commercial-change-image-value-wrap">
						<div>
							<input class="my-page-form-input" readonly /> <input
								id="modify-image" type="file" class="commercial-image-input" />
							<div class="create-commercial-input-tip">가로 : 1000px 세로 :
								200px</div>
						</div>
						<label for="modify-image" class="commercial-file-button">
							파일 첨부 </label>
					</div>
				</div>
				<div class="modal-button-wrap">
					<button type="button" class="modal-button search-id-button">
						수정하기</button>
					<button type="button" class="modal-button cancel-button">뒤로가기</button>
				</div>
			</div>
			<!-- 추가된 모달 -->
		</div>
	</div>
	<jsp:include page="../admin/footer.jsp" />
</body>
</html>
