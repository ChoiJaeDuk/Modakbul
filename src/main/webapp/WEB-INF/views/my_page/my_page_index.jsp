<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${pageContext.request.contextPath}/css/my-page/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/my-page/reset.css" rel="stylesheet" />
    <title>Document</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
  
   		
    </script>
  </head>
 <body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	<div class="wrap">
		<div class="my-page-wrap">
			<div class="my-page-header" >
				<div class="my-page-image-wrap" id="original">
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
				<div class="my-page-user-info-wrap" >
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
							 <div>&nbsp;&nbsp;&nbsp;${following}</div> 
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
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/profile/myProfile/${user.userNo}'">프로필정보</li>
							<!--  <a href="#" class="button" style="width:50px; position:relative;">공지<span class="nav-counter">30</span></a> -->
						<li class="my-page-nav-item" onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'" style="position:relative;"> 
							알림함
							<%-- <c:set var="resultVar" value="${newAlarm}" />
							<c:if test="${resultVar ne 0 || resultVar ne null}">
								<span class="nav-counter"> <c:out value="${resultVar}"/> </span>
							</c:if> --%>
						</li>
							<c:choose>
								<c:when test="${newAlarm ne 0 || newAlarm ne null}">
									<span class="nav-counter"> ${newAlarm} </span>
								</c:when>
								<c:otherwise>
									
								</c:otherwise>
							</c:choose>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
						<li class="my-page-nav-item">광고신청</li>
					</ul>
				</nav>
          <section class="my-page-main-content">
            <div class="my-page-profile">
                <div class="my-page-profile-card">
                    <div class="my-page-profile-card-count-wrap">
                        <span class="my-page-profile-card-count">2</span>&nbsp;개
                    </div>
                    <div class="my-page-profile-card-label">참가 신청중인 모닥불</div>
                </div>
                <div class="my-page-profile-card">
                    <div class="my-page-profile-card-count-wrap">
                        <span class="my-page-profile-card-count">2</span>&nbsp;개
                    </div>
                    <div class="my-page-profile-card-label">
                        참가예정인 모닥불
                    </div>
                </div>
                <div class="my-page-profile-card">
                    <div class="my-page-profile-card-count-wrap">
                        <span class="my-page-profile-card-count">2</span>&nbsp;개
                    </div>
                    <div class="my-page-profile-card-label">
                        참가완료한 모닥불
                    </div>
                </div>
                <div class="my-page-profile-card">
                    <div class="my-page-profile-card-count-wrap">
                        <span class="my-page-profile-card-count">2</span>&nbsp;개
                    </div>
                    <div class="my-page-profile-card-label">
                        모집중인 모닥불
                    </div>
                </div>
                <div class="my-page-profile-card">
                    <div class="my-page-profile-card-count-wrap">
                        <span class="my-page-profile-card-count">2</span>&nbsp;개
                    </div>
                    <div class="my-page-profile-card-label">
                        진행완료한 모닥불
                    </div>
                </div>
                <div class="my-page-profile-card">
                    <div class="my-page-profile-card-count-wrap" id="replyState">
                         <a class="btn btn-outline-secondary" href="index.jsp" id="replyState" >
                         <span class="my-page-profile-card-count">${replyState}</span></a>&nbsp;개
                         
                    </div>
                    <div class="my-page-profile-card-label">
                        댓글대기중인 문의글
                    </div>
                </div>
            </div>
            <div class="my-page-profile-info">
                <div class="my-page-form-wrap">
                    <form action="">
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">아이디</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="id" class="my-page-form-input"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">이름</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="id" class="my-page-form-input"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="password" class="my-profile-form-label">비밀번호</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="id" class="my-page-form-input"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">전화번호</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="id" class="my-page-form-input"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">주소</label>
                            <div class="my-profile-form-input-wrap">
                                <div class="my-page-search-address-wrap ">
                                    <input id="id" class="my-page-search-address-input"/>
                                    <button type="button" class="my-page-button">우편번호 검색</button>
                                </div>
                                <input id="id" class="my-page-form-input"/>
                                <input id="id" class="my-page-form-input"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">이메일</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="id" class="my-page-form-input"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label class="my-profile-form-label">증명서</label>
                            <div class="my-profile-form-input-wrap">
                                <div class="my-profile-certificate-wrap">
                                    <input id="id" class="my-profile-certificate-input"/>
                                    <label for="certificate-add-file" class="certificate-file-button">
                                        파일 첨부
                                      </label>
                                    <input id="certificate-add-file" class="certificate-file-input" type="file"/>
                                    <div class="certificate-add-button">+</div>
                                </div>
                            </div>
                        </div>
                        <div class="my-profile-button-wrap">
                            <button type="button" class="my-page-button">수정하기</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="alert">
                <div class="table-wrap">
                    <table class="table">
                        <colgroup>
                            <col width="8%" />
                            <col width="8%" />
                            <col width="26%" />
                            <col width="36%" />
                            <col width="12%" />
                            <col width="12%" />
                        </colgroup>
                        <thead>
                            <tr class="table-header">
                            <th>번호</th>
                            <th>모임</th>
                            <th>제목</th>
                            <th>내용</th>
                            <th>날짜</th>
                            <th>삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table-body">
                                <td>1</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>참가신청이 승인되었습니다.</td>
                                <td>2022.11.22</td>
                                <td>
                                    <button class="my-page-button">삭제</button>
                                </td>
                            </tr>
                            <tr class="table-body">
                                <td>2</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>참가신청이 승인되었습니다.</td>
                                <td>2022.11.22</td>
                                <td>
                                    <button class="my-page-button">삭제</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="class-search">
                <div class="filter-wrap">
                    <div class="filter-list-wrap">
                        <div class="filter-list-item selected">예정목록</div>
                        <div class="filter-list-item">신청목록</div>
                        <div class="filter-list-item">참가목록</div>
                    </div>
                    <div class="filter-type-wrap">
                        <div class="filter-type-item">
                            <div class="custom-checkbox">
                                <input type="checkbox" id="check1"/>
                                <label for="check1"></label>
                            </div>
                            <label for="check1" class="filter-type-label">참가모임</label>
                        </div>
                        <div class="filter-type-item">
                            <div class="custom-checkbox">
                                <input type="checkbox" id="check2"/>
                                <label for="check2"></label>
                            </div>
                            <label for="check2" class="filter-type-label">주최모임</label>
                        </div>
                    </div>
                </div>
                <!-- 예정목록 테이블 -->
                <div class="table-wrap">
                    <table class="table">
                        <colgroup>
                            <col width="8%" />
                            <col width="34%" />
                            <col width="15%" />
                            <col width="21%" />
                            <col width="12%" />
                            <col width="12%" />
                        </colgroup>
                        <thead>
                            <tr class="table-header">
                            <th>번호</th>
                            <th>사진</th>
                            <th>모임</th>
                            <th>주최자</th>
                            <th>모임날짜</th>
                            <th>취소</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table-body">
                                <td>1</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>최재덕</td>
                                <td>2022.11.22</td>
                                <td>
                                    <button class="my-page-button">취소</button>
                                </td>
                            </tr>
                            <tr class="table-body">
                                <td>2</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>최제덕</td>
                                <td>2022.11.22</td>
                                <td>
                                    <button class="my-page-button">취소</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
               <!-- 신청목록 테이블 -->
                <div class="table-wrap">
                    <table class="table">
                        <colgroup>
                            <col width="8%" />
                            <col width="34%" />
                            <col width="15%" />
                            <col width="21%" />
                            <col width="12%" />
                            <col width="12%" />
                        </colgroup>
                        <thead>
                            <tr class="table-header">
                            <th>번호</th>
                            <th>사진</th>
                            <th>모임</th>
                            <th>주최자</th>
                            <th>신청날짜</th>
                            <th>취소</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table-body">
                                <td>1</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>최재덕</td>
                                <td>2022.11.22</td>
                                <td>
                                    <button class="my-page-button">취소</button>
                                </td>
                            </tr>
                            <tr class="table-body">
                                <td>2</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>최제덕</td>
                                <td>2022.11.22</td>
                                <td>
                                    <button class="my-page-button">취소</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- 참가목록 테이블 -->
                <div class="table-wrap">
                    <table class="table">
                        <colgroup>
                            <col width="8%" />
                            <col width="34%" />
                            <col width="15%" />
                            <col width="21%" />
                            <col width="12%" />
                            <col width="12%" />
                        </colgroup>
                        <thead>
                            <tr class="table-header">
                            <th>번호</th>
                            <th>사진</th>
                            <th>모임</th>
                            <th>주최자</th>
                            <th>진행상태</th>
                            <th>모임날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table-body">
                                <td>1</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>최재덕</td>
                                <td>2022.11.22</td>
                                <td>2022.11.22</td>
                            </tr>
                            <tr class="table-body">
                                <td>2</td>
                                <td>축구모임</td>
                                <td>참가신청</td>
                                <td>최제덕</td>
                                <td>2022.11.22</td>
                                <td>2022.11.22</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="interest">
                <table class="table">
                    <colgroup>
                        <col width="8%" />
                        <col width="34%" />
                        <col width="15%" />
                        <col width="21%" />
                        <col width="12%" />
                        <col width="12%" />
                    </colgroup>
                    <thead>
                        <tr class="table-header">
                        <th>번호</th>
                        <th>사진</th>
                        <th>모임</th>
                        <th>주최자</th>
                        <th>(모임)날짜</th>
                        <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="table-body">
                            <td>1</td>
                            <td>축구모임</td>
                            <td>참가신청</td>
                            <td>최제덕</td>
                            <td>2022.11.22</td>
                            <td>
                                <button class="my-page-button">삭제</button>
                            </td>
                        </tr>
                        <tr class="table-body">
                            <td>2</td>
                            <td>축구모임</td>
                            <td>참가신청</td>
                            <td>최재덕</td>
                            <td>2022.11.22</td>
                            <td>
                                <button class="my-page-button">삭제</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
          </section>
        </div>
        <div class="modal-wrap" hidden="">
            <div class="modal-title" >
                내용
            </div>
           <div class="modal-text-wrap"  hidden="">정말로 삭제하시겠습니까?</div>
            <div class="modal-button-wrap" >
                <button type="button" class="modal-button cancel-button">취소</button>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
        <div class="modal-wrap"  hidden="">
            <div class="modal-title"  hidden="">
                내용
            </div>
           <div class="modal-text-wrap" hidden="">정말 취소하시겠습니까?</div>
            <div class="modal-button-wrap" >
                <button type="button" class="modal-button cancel-button">취소</button>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
        <div class="modal-wrap" hidden="">
           <div class="modal-text-wrap" >하루 전 모임은 취소할 수 없습니다.</div>
            <div class="modal-button-wrap" >
                <div></div>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
      </div>
    </div>
  </body>
</html>
