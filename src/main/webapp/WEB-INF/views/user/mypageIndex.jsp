<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
   		$(function(){
   			//alert(1)
   			var data = $("#follower").val();
   			
   		 function readImage(input) {
			  
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
			
			
   			$("#updateBtn").click(function(){
   				alert($("#updateBtn").html());
   				
   				
   				if( $("#updateBtn").html()=="수정하기" ){
   					
   					$("#updateBtn").html("수정완료");
   					$("input").attr({
   						
   						disabled: false
   					})
   					$("button").attr({
   						
   						disabled: false
   					})
   					$("#pwd").attr("readonly", false);
   					$("#phone").attr("readonly", false);
   					$("#postCode").attr("readonly", false);
   					$("#addr").attr("readonly", false);
   					$("#addrDetail").attr("readonly", false);
   					$("#attachSubject").attr("readonly", false);
   					
   					return;
   					
   				}else{
   					alert("프로필정보가 수정되었습니다.");
   					$("#updateBtn").html("수정하기");
					$("input").attr({
   						readonly:true,
   						disabled: true
   					})
					$(".certificate-delete-button").attr({
   						
   						disabled: true
   					})	
					$(".certificate-add-button").attr({
   						
   						disabled: true
   					})	
   				}
  
   			})
   			
   			var number = 0;
			$(document).on("click",".certificate-add-button", function(){
				var count = $(".my-profile-certificate-input").length;
				
				//var $div = $(".certificate-input-wrap").eq(0).clone();	
				//$div.find("input").val("");
				number++;
				
				
				var $div='<div class="my-profile-certificate-wrap"> <input id="id" class="my-profile-certificate-input" name="userAttachmentsFileSubject[]" readonly="readonly"/>';
				$div+='<input id="id" class="my-profile-certificate-input" name="userAttachmentsFileName" readonly="readonly"/>'
				$div+='<label for="certificate-add-file'+number+'" class="certificate-file-button"> 파일 첨부 </label>';
				$div+='<input id="certificate-add-file'+number+'" class="certificate-file-input" type="file" name="filesList[]"/>';
				$div+='<div class="certificate-add-button" >+</div><button type="button" class="certificate-delete-button">-</button></div>';
				
				
		
					if(count < 5){
		
						alert($div)
						$("#certAdd").append($div);
					
					}
			})
			
			$(document).on("click",".certificate-delete-button", function(){
				if( $("#updateBtn").html()=="수정완료" ){
					if(confirm("해당 증명서를 삭제하시겠습니까?")){
						$.ajax({
							type:"POST",
							url:"${pageContext.request.contextPath}/deleteAttach",
							dataType:"json",
							data: "${_csrf.parameterName}=${_csrf.token}&userAttachmentsFileNo="+$(this).attr("id"),			
							success:function(result){
								
								alert(result);
								//location.reload("#userAttch");	
								$("#userAttach").load(location.href + " #userAttach");
								alert(1)
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
				//var index = $(".my-profile-certificate-wrap.certificate-delete-button").index(this);
				//alert(index)
				alert($(this).attr("id"))
				/*$(this).closet("div").remove();
				alert(33243)*/
				
				//$(".my-profile-certificate-wrap").eq(index).remove();\
				
				
			})
			
			
			$(document).on("change", ".certificate-file-input", function(){ //주황색
					
					alert(1)
			        console.log($(this))
			        	var filename = $(this).val().split('/').pop().split('\\').pop();
			          //console.log(filename)
			          
			        $(this).prev().prev().val(filename);
			          //$(this).attr("name","test");
			          
			         console.log($(this))
			        // $(this).prev().find("input").val(filename);

			      
				})   
				
				$(document).on("submit", ".certificate-file-input", function(){ //주황색
					
					alert(1)
			        console.log($(this))
			        	var filename = $(this).val().split('/').pop().split('\\').pop();
			          //console.log(filename)
			          
			        $(this).prev().prev().val(filename);
			          //$(this).attr("name","test");
			          
			         console.log($(this))
			        // $(this).prev().find("input").val(filename);

			      
				})   
   			
   			
   			
   		})
   		
    </script>
  </head>
  <body>
    <div class="wrap">
      <div class="my-page-wrap">
        <div class="my-page-header">
          <div class="my-page-image-wrap">
          <sec:authorize access="isAuthenticated()">
			<sec:authentication var="user" property="principal" /> 
			<c:set value="${user.userProfileImg}" var="img"/>
			<c:set value="state" var="false"/>
			<c:forEach items="${fileNames }" var="file">
				<c:if test="${file eq img }">
					<c:set value="state" var="true"/>
				<img
              class="sign-up-image"
              src="${pageContext.request.contextPath}/save/${user.userProfileImg }"
              alt="img"
           		 />
           		 
				</c:if>
		
			
			</c:forEach>
	
			<c:if test="${state eq false }">
			<img
              class="sign-up-image"
              src="${user.userProfileImg }"
              alt="img"
           		 />
           		 </c:if>
		
         	<input id="sign-up-add-image" class="sign-up-add-image" type="file" name="file" accept="image/*" />
            </sec:authorize>
          </div>
          <div class="my-page-user-info-wrap">
            <sec:authorize access="isAuthenticated()">
			<sec:authentication var="user" property="principal" /> 
            <div class="my-page-user-name">
          
              <div>${user.userName }님</div>
             
              <button class="my-page-button" type="button">프로필 편집</button>
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
                   	<div><a href="${pageContext.request.contextPath}/follow/followingList?userNo=7">&nbsp;&nbsp;&nbsp;${following}</a></div>
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
                <li class="my-page-nav-item">모임조회</li>
                <li class="my-page-nav-item">관심모임</li>
                <li class="my-page-nav-item">후기조회</li>
                <li class="my-page-nav-item">문의조회</li>
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
                    <form action="${pageContext.request.contextPath }/update" id="userInfo">
                    <sec:authorize access="isAuthenticated()">
			<sec:authentication var="user" property="principal" /> 
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">아이디</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="id" class="my-page-form-input" name="userId" value="${user.userId }" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">이름</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="name" class="my-page-form-input" name="userName" value="${user.userName }" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="password" class="my-profile-form-label">비밀번호</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="pwd" user="userpwd" class="my-page-form-input" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="" class="my-profile-form-label">전화번호</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="phone" name="userPhone" class="my-page-form-input" value="${user.userPhone}" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">주소</label>
                            <div class="my-profile-form-input-wrap">
                                <div class="my-page-search-address-wrap ">
                                    <input id="postCode" name="userPostCode" class="my-page-search-address-input" value="${user.userPostCode }" readonly="readonly"/>
                                    <button type="button" class="my-page-button">우편번호 검색</button>
                                </div>
                                <input id="addr" name="userAddr" class="my-page-form-input" value="${user.userAddr }" readonly="readonly"/>
                                <input id="addrDetail" name="userAddrDetail" class="my-page-form-input" value="${user.userAddrDetail }" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item">
                            <label for="id" class="my-profile-form-label">이메일</label>
                            <div class="my-profile-form-input-wrap">
                                <input id="email" name="userEmail" class="my-page-form-input" value="${user.userEmail }" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="my-profile-form-item" id=userAttach>
                        
                            <label class="my-profile-form-label">증명서</label>
                            <c:choose>
	                           <c:when test="${empty requestScope.attachList }">

		                            <div class="my-profile-form-input-wrap" id="certAdd">
		                                <div class="my-profile-certificate-wrap">
		                                    <input id="attachSubject" class="my-profile-certificate-input" name="userAttachmentsFileSubject[]" readonly="readonly"/>
		                                    <input id="attachFile" class="my-profile-certificate-input" name="userAttachmentsFileName" readonly="readonly"/>
		                                    <label for="certificate-add-file" class="certificate-file-button">
		                                        파일 첨부
		                                      </label>
		                                    <input id="certificate-add-file" class="certificate-file-input" name="filesList[]" type="file" disabled="disabled"/>
		                                    <div class="certificate-add-button">+</div>
		                                    <button type="button" class="certificate-delete-button" >-</button>
		                                </div>
		                            </div>
	                            </c:when>
	                            <c:otherwise>
	                            	<c:forEach var="attach" items="${attachList}">
									    <div class="my-profile-form-input-wrap" id="certAdd">
			                                <div class="my-profile-certificate-wrap">
			                               		<input id="id" class="my-profile-certificate-input" value="${attach.userAttachmentsFileSubject}" name="userAttachmentsFileSubject[]" readonly="readonly"/>
			                                    <input id="id" class="my-profile-certificate-input" value="${attach.userAttachmentsFileName}" name="userAttachmentsFileName" readonly="readonly"/>
			                                    <label for="certificate-add-file" class="certificate-file-button" da>
			                                        파일 첨부
			                                      </label>
			                                    <input id="certificate-add-file" class="certificate-file-input" type="file" name="filesList[]" disabled="disabled"/>
			                                    <div class="certificate-add-button">+</div>
			                                    <button type="button" class="certificate-delete-button"  id=${attach.userAttachmentsFileNo} >-</button>
			                                </div>
		                            	</div>
		                            	
									</c:forEach>
      
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
