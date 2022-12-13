<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${pageContext.request.contextPath}/css/my-page/index.css" rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/css/my-page-inquiry/index.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/css/my-page-inquiry/reset.css"
	rel="stylesheet" />
<title>Document</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function(){
    	   $(function(){
    	      let $modal ;
    	       document.getElementById('following').addEventListener('click', function() {
    	             // 모달창 띄우기
    	             modal('my_modal');
    	             
    	            // alert("dd = " + document.querySelector(".modakbul-button following"))
    	              $modal = $("button[class='modakbul-button following']")//document.querySelector(".modakbul-button following");
    	              
    	              
    	              
    	              $(document).on("click", "button[class='modakbul-button following']" , function(){
    	                

    	                      alert("버튼클릭했음" + " , " + $(this).val());
    	                      
    	                      let target = {"follower":$(this).val() , "following":"${userNo}"}
    	                      console.log("follower = " + $(this).val());
    	                    /*   console.log("following = " + ${userNo}); */
    	                      let targetBtn = $(this);
    	                      
    	                      if($(this).text() == "팔로잉"){
    	                         alert("딜리트 반응?");
    	                         $.ajax({
    	                            url:"${pageContext.request.contextPath}/follow/delete", 
    	                            type:"post",
    	                            dataType:"text",
    	                                data:JSON.stringify(target),   
    	                                contentType:'application/json;charset=utf-8',
    	                            success:function(result){
    	                               if(result=="ok"){
    	                                  alert("팔로잉이 해제 되었습니다.")                  
    	                                  
    	                                  targetBtn.css("background","rgb(243, 156, 18)")
    	                                  targetBtn.text("팔로우")
    	                               }
    	                            },error:function(err){
    	                               alert("err : "+err);
    	                            }
    	                         });//Delete ajax END
    	                      }
    	                      
    	                      if($(this).text()=="팔로우"){
    	                         alert("인설트반응?");
    	                         $.ajax({
    	                            url:"${pageContext.request.contextPath}/follow/insert",
    	                            type:"post",
    	                            dataType:"text",
    	                                data:JSON.stringify(target),   
    	                                contentType:'application/json;charset=utf-8',
    	                            success:function(result){
    	                               if(result=="ok"){
    	                                  alert("팔로우 등록 되었습니다.")                  
    	                                  
    	                                  targetBtn.css("background","gray")
    	                                  targetBtn.text("팔로잉")
    	                               }
    	                               
    	                            },error:function(err){
    	                               alert("err : "+err);
    	                            }
    	                         });//Insert ajax END
    	                      }//if  END
    	                      
    	                   });///////////////////////////
    	             

    	              
    	             
    	             
    	         });
    	   
    	      
    	       //////////////////////////////////////////////////
    	   })
    	   
    	    function modal(id) {
    	                var zIndex = 9999;
    	                var modal = document.getElementById(id);

    	                // 모달 div 뒤에 희끄무레한 레이어
    	                var bg = document.createElement('div');
    	                bg.setStyle({
    	                    position: 'fixed',
    	                    zIndex: zIndex,
    	                    left: '0px',
    	                    top: '0px',
    	                    width: '100%',
    	                    height: '100%',
    	                    overflow: 'auto',
    	                    // 레이어 색갈은 여기서 바꾸면 됨
    	                    backgroundColor: 'rgba(0,0,0,0.4)'
    	                });
    	                document.body.append(bg);

    	                // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
    	                modal.querySelector('.modal_close_btn').addEventListener('click', function() {
    	                    bg.remove();
    	                    modal.style.display = 'none';
    	                });

    	                modal.setStyle({
    	                    position: 'fixed',
    	                    display: 'block',
    	                    boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

    	                    // 시꺼먼 레이어 보다 한칸 위에 보이기
    	                    zIndex: zIndex + 1,

    	                    // div center 정렬
    	                    top: '50%',
    	                    left: '50%',
    	                    transform: 'translate(-50%, -50%)',
    	                    msTransform: 'translate(-50%, -50%)',
    	                    webkitTransform: 'translate(-50%, -50%)'
    	                });
    	            }

    	            // Element 에 style 한번에 오브젝트로 설정하는 함수 추가
    	            Element.prototype.setStyle = function(styles) {
    	                for (var k in styles) this.style[k] = styles[k];
    	                return this;
    	            };
    });
   		
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
								<div >팔로잉</div>
							
								<div id="following">
									<a>&nbsp;&nbsp;&nbsp;${following}</a>
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
						<li class="my-page-nav-item" onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'">알림함</li>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
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
							<c:choose>
										<c:when
											test="${0 eq requestScope.inquiryList.getTotalPages()}">
											<tr>
												<td colspan="5">작성된 문의가 없어요 🔥</td>
											</tr>
										</c:when>
										<c:otherwise>
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
									</c:otherwise>
									</c:choose>
							</tbody>
						</table>
					</div>
					<!-- 페이징 -->
					<div style="text-align:center;">
						<!--  블럭당  -->
						<nav class="pagination-container">
							<div class="pagination">
								<c:set var="doneLoop" value="false" />

								<c:if test="${(startPage-blockCount) > 0}"><!-- (-2) > 0  -->
									<a class="pagination-newer"
										href="${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}&nowPage=${startPage-1}">PREV</a>
								</c:if>

								<span class="pagination-inner"> <c:forEach var='i'
										begin='${startPage}' end='${(startPage-1)+blockCount}'>

										<c:if test="${(i-1)>=inquiryList.getTotalPages()}">
											<c:set var="doneLoop" value="true" />
										</c:if>

										<c:if test="${not doneLoop}">
											<a class="${i==nowPage?'pagination-active':page}"
												href="${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}&nowPage=${i}">${i}</a>
										</c:if>

									</c:forEach>
								</span>

								<c:if test="${(startPage+blockCount)<=inquiryList.getTotalPages()}">
									<a class="pagination-older"
										href="${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}&nowPage=${startPage+blockCount}">NEXT</a>
								</c:if>
								<!-- 페이징 끝 -->
							</div>
							</nav>
						</div>
					</section>
				</div>
		</div>
		
		 <div id="my_modal">
	 	<table id="following" style="width: 100%">
	 		
	 		<tr class="title">
	 	
	 		<th colspan="4" class="th">
	 	
	 		팔로잉
	 	
			</th>
			 <a class="modal_close_btn">X</a>
			<!-- <tr class="user">
			<th style="width: 20%">
			사진
			</th>
			<th style="width: 10%">
			이름
			</th>
			<th style="width: 10%">
			온도
			</th>
			<th style="width: 20%">
			<button class="modakbul-button following" id="" value="">팔로우</button>
			</th>
			</tr> 	 -->
			<c:forEach items="${followingList}" var="f">
				<tr>
					<th> 
						<img alt="img" class="followImg" src="${pageContext.request.contextPath}/save/${f.followerUser.userProfileImg }">
					</th>
					<th>
						<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${f.followerUser.userNo}'">${f.followerUser.userNick}<p>
					</th>
					<th>
						${f.followerUser.temper}℃
					</th>
					<th style="width: 20%">
						<button class="modakbul-button following" id="" value="${f.followerUser.userNo}">팔로우</button>
					</th>
				</tr>
			</c:forEach>
	 	</table>
	 
        </div>
	</div>
	<jsp:include page="../layout/footer.jsp" />
</body>
</html>
