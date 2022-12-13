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
<!-- daum 도로명주소 찾기 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.min.js"></script>
<script type="text/javascript">
   		$(function(){
   		
   			var data = $("#follower").val();
   			
   		/*  function readImage(input) {
			  
				// 인풋 태그에 파일이 있는 경우
			    if(input.files && input.files[0]) {
			        // 이미지 파일인지 검사 (생략)
			        // FileReader 인스턴스 생성
			        const reader = new FileReader()
			        // 이미지가 로드가 된 경우
			        reader.onload = e => {
			            const previewImage = document.getElementById("sign-up-image")
			          
			            previewImage.src = e.target.result
			          
			        }
			        // reader가 이미지 읽도록 하기
			        reader.readAsDataURL(input.files[0])
			    }
			}
			// input file에 change 이벤트 부여
			const inputImage = document.getElementById("sign-up-add-image")
			
			inputImage.addEventListener("load", e => {
			    readImage(e.target)
			})
			 */
			
			 $(document).on("change", "#sign-up-add-image2", function(){ //주황색
					
					alert(1)
			        console.log($(this))
			        	var filename = $(this).val().split('/').pop().split('\\').pop();
			          //console.log(filename)
			          
			        $(this).prev().val(filename);
			          //$(this).attr("name","test");
			          
			        console.log($(this))
			        // $(this).prev().find("input").val(filename);

			      
				})   
					
					 function readImage(input) {
						  
						// 인풋 태그에 파일이 있는 경우
					    if(input.files && input.files[0]) {
					        // 이미지 파일인지 검사 (생략)
					        // FileReader 인스턴스 생성
					        const reader = new FileReader()
					        // 이미지가 로드가 된 경우
					        reader.onload = e => {
					            const previewImage = document.getElementById("sign-up-image2")
					          
					            previewImage.src = e.target.result
					          
					        }
					        // reader가 이미지 읽도록 하기
					        reader.readAsDataURL(input.files[0])
					    }
					}
					// input file에 change 이벤트 부여
					const inputImage = document.getElementById("sign-up-add-image2")
					
					inputImage.addEventListener("change", e => {
					    readImage(e.target)
					})
				
					 
				
			
   			$(document).on("click", "#updateBtn", function(){
   				alert($("#updateBtn").html());
   				
   				
   				if( $("#updateBtn").html()=="수정하기" ){
   					
   					$("#updateBtn").html("수정완료");
   					
   					
   					$("#pwd").attr("readonly", false);
   					$("#phone").attr("readonly", false);
   					$("#postCode").attr("readonly", false);
   					$("#addr").attr("readonly", false);
   					$("#addrDetail").attr("readonly", false);
   					$("#attachSubject").attr("readonly", false);
   					$("button").attr("disabled", false)
   					
   					return;
   					
   				}else{
						if($("#pwd").val() != ""){
						
							if(confirm("비밀번호를 변경하시겠습니까?")){
								$("#userInfo").ajaxForm({
									type:"POST",
									url:"${pageContext.request.contextPath}/update",
									dataType:"text",
									//data: $("#userInfo").serialize(),	
									success:function(result){
										alert(result)
										alert("프로필정보가 수정되었습니다.");
					   			
										$("#myPage").load(location.href + " #myPage");
										$("#orginal").load(location.href + " #orginal");
											

									},//function
									error:function(error){
										console.log(error)
									}
									
								});//ajax
							}/* else{
								$("#pwd").val("")
								return;
							} */
						
						}
						$("#userInfo").ajaxForm({
							type:"POST",
							url:"${pageContext.request.contextPath}/update",
							dataType:"text",
							//data: $("#userInfo").serialize(),	
							success:function(result){
								alert(result)
								alert("프로필정보가 수정되었습니다.");
			   			
								$("#myPage").load(location.href + " #myPage");
								$("#original").load(location.href + " #original");
								 $("#updateBtn").html("수정하기");
									

							},//function
							error:function(error){
								console.log(error)
							}
							
						});//ajax
		
						$("#userInfo").submit(); //전송
						 $("#updateBtn").html("수정하기");
						 $("input").attr("readonly", true);
						 $("#updateBtn").attr({"readonly":false, "disabled":false})
	
   				}
   			 
   			 //$("#updateBtn").html("수정하기");
  
   			})//
   			
   			var number = 0;
			$(document).on("click",".certificate-add-button", function(){
				var count = $(".my-profile-certificate-wrap").length;
			
				number++;
				
				
				var $div='<div class="my-profile-certificate-wrap"> <input id="id" class="my-profile-certificate-input" name="newFileSubject[]"/>';
				$div+='<input id="userAttachmentsFileName" class="my-profile-certificate-input" name="userAttachmentsFileName" readonly="readonly"/>'
				$div+='<label for="certificate-add-file'+number+'" class="certificate-file-button"> 파일 첨부 </label>';
				$div+='<input id="certificate-add-file'+number+'" class="certificate-file-input" type="file" name="newFilesList[]"/>';
				$div+='<div class="certificate-add-button" >+</div><button type="button" class="certificate-delete-button">-</button></div>';
				
				
				if($("#updateBtn").html()=="수정완료"){
						if(count < 5){
		
						
						$("#certAdd").append($div);
					
						}
			
				}
					
			})
			
			$(document).on("click",".certificate-delete-button", function(){
				
				if( $("#updateBtn").html()=="수정완료" ){
					
					if($(this).attr("id")==undefined){
					
						$(this).parent().remove();
						return;
					}
					
					if(confirm("해당 증명서를 삭제하시겠습니까?")){
						$.ajax({
							type:"POST",
							url:"${pageContext.request.contextPath}/deleteAttach",
							dataType:"text",
							data: "${_csrf.parameterName}=${_csrf.token}&userAttachmentsFileNo="+$(this).attr("id"),			
							success:function(result){
								
								console.log(result)
								
									$("#userAttach").load(location.href + " #userAttach");
									
									$("button").attr({
				   						
				   						disabled: false
				   					
				   					})
				   					
							
							},//function
							error:function(error){
								console.log(error)
							}
							
						});//ajax
					}
				}
			
				
			})
			
			
			$(document).on("change", ".certificate-file-input", function(){ //주황색
				var filename = $(this).val().split('/').pop().split('\\').pop();
			        
			    $(this).prev().prev().val(filename);
			       
				})   

   		})
   		
   		function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백("")값을 가지므로, 이를 참고하여 분기 한다.
				let fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				let extraRoadAddr = ""; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== "" && data.apartment === "Y") {
					extraRoadAddr += (extraRoadAddr !== "" ? ", "
							+ data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== "") {
					extraRoadAddr = " (" + extraRoadAddr + ")";
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== "") {
					fullRoadAddr += extraRoadAddr;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				console.log(data.zonecode);
				console.log(fullRoadAddr);
				
				$("#postCode").val(data.zonecode);
				$("#addr").val(fullRoadAddr);
				
				$("#addrDetail").val("");
				$("#addrDetail").focus();
			}
		}).open();
			
		}
   		
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
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/profile/myProfile/${user.userNo}'">프로필정보</li>
						<li class="my-page-nav-item" onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'">알림함</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">광고신청</li>
					</ul>
				</nav>
				<section class="my-page-main-content">
					<div class="my-page-profile-info">
						<div class="my-page-form-wrap" id="myPage">
							<form action="${pageContext.request.contextPath }/update"
								id="userInfo" method="post" enctype="multipart/form-data">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}">
									
								<sec:authorize access="isAuthenticated()">
									<sec:authentication var="user" property="principal" />
									<div class="my-profile-form-item">
									<div class="my-page-image-wrap">
										<c:set value="${user.userProfileImg}" var="img" />
										<c:set value="true" var="state1" />
										<c:forEach items="${fileNames }" var="file">
											<c:if test="${file eq img }">
												<c:set value="true" var="state2" />
												<img class="sign-up-image" id="sign-up-image2"
													src="${pageContext.request.contextPath}/save/${user.userProfileImg }"
													alt="img" />

											</c:if>

										</c:forEach>

										<c:if test="${state1 ne state2}">
											<img class="sign-up-image" id="sign-up-image2" src="${user.userProfileImg }"
												alt="img" />
										</c:if>

									</div>
									<input type="hidden" name="userProfileImg">
									<input id="sign-up-add-image2" class="sign-up-add-image"
											type="file" name="file" accept="image/*" />
										<label for="sign-up-add-image2" class="sign-up-add-image-Btn"> 사진 편집 </label>
									
									</div>
									
									<div class="my-profile-form-item">
										<label for="id" class="my-profile-form-label">아이디</label>
										<div class="my-profile-form-input-wrap">
											<input id="id" class="my-page-form-input" name="userId"
												value="${user.userId }" readonly="readonly" />
										</div>
									</div>
									<div class="my-profile-form-item">
										<label for="id" class="my-profile-form-label">이름</label>
										<div class="my-profile-form-input-wrap">
											<input id="name" class="my-page-form-input" name="userName"
												value="${user.userName }" readonly="readonly" />
										</div>
									</div>
									<div class="my-profile-form-item">
										<label for="password" class="my-profile-form-label">비밀번호</label>
										<div class="my-profile-form-input-wrap">
											<input type="password" id="pwd" name="userpwd"
												class="my-page-form-input" readonly="readonly" />
										</div>
									</div>
									<div class="my-profile-form-item">
										<label for="" class="my-profile-form-label">전화번호</label>
										<div class="my-profile-form-input-wrap">
											<input id="phone" name="userPhone" class="my-page-form-input"
												value="${user.userPhone}" readonly="readonly" />
										</div>
									</div>
									<div class="my-profile-form-item">
										<label for="id" class="my-profile-form-label">주소</label>
										<div class="my-profile-form-input-wrap">
											<div class="my-page-search-address-wrap ">
												<input id="postCode" name="userPostCode"
													class="my-page-search-address-input"
													value="${user.userPostCode }" readonly="readonly" />
												<button type="button" class="my-page-button"
													onclick="execPostCode();" disabled="disabled">우편번호
													검색</button>
											</div>
											<input id="addr" name="userAddr" class="my-page-form-input"
												value="${user.userAddr }" readonly="readonly" /> <input
												id="addrDetail" name="userAddrDetail"
												class="my-page-form-input" value="${user.userAddrDetail }"
												readonly="readonly" />
										</div>
									</div>
									<div class="my-profile-form-item">
										<label for="id" class="my-profile-form-label">이메일</label>
										<div class="my-profile-form-input-wrap">
											<input id="email" name="userEmail" class="my-page-form-input"
												value="${user.userEmail }" readonly="readonly" />
										</div>
									</div>
									<div class="my-profile-form-item" id=userAttach>

										<label class="my-profile-form-label">증명서</label>
										<c:choose>
											<c:when test="${empty requestScope.attachList }">

												<div class="my-profile-form-input-wrap" id="certAdd">
													<div class="my-profile-certificate-wrap">
														<input id="attachSubject"
															class="my-profile-certificate-input"
															name="newFileSubject[]" readonly="readonly" /> <input
															id="attachFile" class="my-profile-certificate-input"
															name="userAttachmentsFileName" readonly="readonly" /> <label
															for="certificate-add-file"
															class="certificate-file-button"> 파일 첨부 </label> <input
															id="certificate-add-file" class="certificate-file-input"
															name="newFilesList[]" type="file" />
														<div class="certificate-add-button">+</div>
														<button type="button" class="certificate-delete-button">-</button>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="my-profile-form-input-wrap" id="certAdd">
													<c:forEach var="attach" items="${attachList}">

														<div class="my-profile-certificate-wrap">
															<input id="id" class="my-profile-certificate-input"
																value="${attach.userAttachmentsFileSubject}"
																name="fileSubject[]" readonly="readonly" /> <a
																href="${pageContext.request.contextPath}/down?fileName=${attach.userAttachmentsFileName}">
																<input id="id" class="my-profile-certificate-input"
																src="${attach.userAttachmentsFileName}"
																value="${attach.userAttachmentsFileName}"
																name="userAttachmentsFileName" readonly="readonly" />
															</a> <label for="certificate-add-file"
																class="certificate-file-button"> 파일 첨부 </label> <input
																id="certificate-add-file" class="certificate-file-input"
																type="file" name="filesList[]" />
															<div class="certificate-add-button">+</div>
															<button type="button" class="certificate-delete-button"
																id=${attach.userAttachmentsFileNo} >-</button>
														</div>


													</c:forEach>
												</div>

											</c:otherwise>
										</c:choose>


									</div>
									<div class="my-profile-button-wrap">
										<button type="button" id="updateBtn" class="my-page-button">수정하기</button>
									</div>
								</sec:authorize>
							</form>
						</div>
					</div>

				</section>
			</div>
		</div>
	</div>

	 <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
