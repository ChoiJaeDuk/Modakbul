<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${pageContext.request.contextPath}/css/my-page/index.css" rel="stylesheet" /> 
    <link href="${pageContext.request.contextPath}/css/my-page/likeGather/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/my-page/likeGather/reset.css" rel="stylesheet" />
    
    <style type="text/css">
    	.pagination-container {
	margin: 100px auto;
	text-align: center; 
}

.pagination {
	position: relative;
}

.pagination a {
	position: relative;
	display: inline-block;
	color: #2c3e50;
	text-decoration: none;
	font-size: 1.2rem;
	padding: 8px 16px 10px;
}

.pagination a:before {
	z-index: -1;
	position: absolute;
	height: 100%;
	width: 100%;
	content: "";
	top: 0;
	left: 0;
	background-color: #2c3e50;
	border-radius: 24px;
	-webkit-transform: scale(0);
	transform: scale(0);
	transition: all 0.2s;
}

.pagination a:hover, .pagination a .pagination-active {
	color: #fff;
}

.pagination a:hover:before, .pagination a .pagination-active:before {
	-webkit-transform: scale(1);
	transform: scale(1);
}

.pagination .pagination-active {
	color: #fff;
}

.pagination .pagination-active:before {
	-webkit-transform: scale(1);
	transform: scale(1);
}

.pagination-newer {
	margin-right: 50px;
}

.pagination-older {
	margin-left: 50px;
}
    	
    </style>
    
    <title>마이페이지-관심모임</title>
     <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    $(function(){
		console.log("새알람 = " + ${newAlarm});
		if(${newAlarm}==0 || ${newAlarm}==null){
			$(".nav-counter").hide();
		}else{
			$(".nav-counter").show();
		}
		})
		
   $(document).ready(function(){
   $(function(){
      let $modal ;
      
      $(document).ajaxSend(function(e,xht,op){
	         xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
	      	});
      
       document.getElementById('following').addEventListener('click', function() {
             // 모달창 띄우기
             modal('my_modal');
             
            // alert("dd = " + document.querySelector(".modakbul-button following"))
              $modal = $("button[class='modakbul-button following']");//document.querySelector(".modakbul-button following");
              
              
              
              $(document).on("click", "button[class='modakbul-button following']" , function(){ 
                      let target = {"follower":$(this).val() , "following":"${userNo}"}
                      console.log("follower = " + $(this).val());
                      console.log("following = " + ${userNo});
                      let targetBtn = $(this); 
                      
                      if($(this).text() == "팔로잉"){ 
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
                            	console.log("err : "+err);
                            }
                         });//Delete ajax END
                      }//Delete if END
                      
                      if($(this).text()=="팔로우"){ 
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
                            	console.log("err : "+err);
                            }
                         });//Insert ajax END
                      }//if  END
                      
                   });///////////////////////////
             
         });//modal 띄우기
   });//ready 다음 function ENd
   
    
   
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
									alt="img"
									onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_index/${user.userNo}'" />

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="sign-up-image" src="${user.userProfileImg }"
								alt="img"
								onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_index/${user.userNo}'" />
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
						<li class="my-page-nav-item" onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'" style="position: relative;">
						알림함
							
							<c:choose>
								<c:when test="${newAlarm ne 0 || newAlarm ne null}">
									<span class="nav-counter"> ${newAlarm} </span>
								</c:when>
								<c:otherwise>
									<div class="nav-counter-invi" style="display: none;">
										<span class="nav-counter-invi"> 0 </span>
									</div>
								</c:otherwise> 
							</c:choose>
							
						</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adApplication?userNo=${user.userNo}'">광고신청</li></li>
					</ul>
				</nav>
          <section class="my-page-main-content">
            <div class="interest">
                <table class="table">
                    <colgroup>
                        <col width="8%" />
                        <col width="29%" />
                        <col width="20%" />
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
                    
                    	<c:forEach items="${pageList.content}" var="lg" varStatus="state">
                        <tr class="table-body">
                        	 <c:set var="TextValue" value="${lg.gather.gatherDate}" />
                            <td>${state.count}</td>
                            <td><img src="${pageContext.request.contextPath}/save/${lg.gather.gatherImg}"></td>
                            <td>${lg.gather.gatherName}</td>
                            <td>${lg.gather.user.userNick}</td>
                            <td>
                            	<%-- <fmt:formatDate value="${lg.gather.gatherDate}" pattern="yyyy-MM-dd" type="date"/> --%>
                            	 ${fn:substring(TextValue,0,10)}
                            </td>
                            <td>
                                <button class="my-page-button" onclick="location.href='${pageContext.request.contextPath}/likeGather/deleteButton?gatherNo=${lg.gather.gatherNo}&userNo=${userNo}';">삭제</button>
                            </td>
                        </tr>
                        </c:forEach>
                        
                    </tbody>
                </table>
            </div>
            <div style="text-align: center">
		<!--  블럭당  -->
 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/likeGather/myLikeGather?userNo=${userNo}&nowPage=${startPage-1}">PREV</a>
		  </c:if> 
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=pageList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/likeGather/myLikeGather?userNo=${userNo}&nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=pageList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/likeGather/myLikeGather?userNo=${userNo}&nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
				 
			
		
		</div>
	</nav>  
</div>
          </section>
        </div>
        </div>
  
        
        <div class="modal-wrap" style="display: none">
            <div class="modal-title" >
                내용
            </div>
           <div class="modal-text-wrap">정말로 삭제하시겠습니까?</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button cancel-button">취소</button>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
        <div class="modal-wrap" style="display: none">
           <div class="modal-text-wrap">하루 전 모임은 취소할 수 없습니다.</div>
            <div class="modal-button-wrap">
                <div></div>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
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
							<c:set value="${f.followerUser.userProfileImg}" var="img" />
						<c:set value="true" var="state1" />
						<c:forEach items="${fileNames }" var="file">
							<c:if test="${file eq img }">
								<c:set value="true" var="state2" />
								<img class="followImg"
									src="${pageContext.request.contextPath}/save/${f.followerUser.userProfileImg}"
									alt="img"/>

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="followImg" src="${f.followerUser.userProfileImg }"
								alt="img"/>
						</c:if>
							</th>
					<th>
						<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${f.followerUser.userNo}'">${f.followerUser.userNick}<p>
					</th>
					<th>
						${f.followerUser.temper}℃
					</th>
					<th style="width: 20%">
						<button class="modakbul-button following" id="" value="${f.followerUser.userNo}">팔로잉</button>
					</th>
				</tr>
			</c:forEach>
	 	</table>
	 
        </div>
      
    </div>
 <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>