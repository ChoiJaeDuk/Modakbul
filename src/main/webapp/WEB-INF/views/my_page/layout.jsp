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


   <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
   
<title>Document</title>

   
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
              
              let str = "yes"
              if("${searchFollow}"==str){
					$(".profile-button").text("팔로잉");
					$(".profile-button").css("background","gray");
					
				}//searchFollow if END
              
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
	<div class="shadow">
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
								<div>&nbsp;&nbsp;&nbsp;${following}</div>
							</div>
							<div>
								<div id="following">팔로잉</div>
								<%-- <div>&nbsp;&nbsp;&nbsp;${following}</div> --%>
								<div>
								
									<a href="${pageContext.request.contextPath}/my_page/follow/followingList?userNo=${user.userNo}">&nbsp;&nbsp;&nbsp;${follower}</a>
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
					<sec:authentication var="loginUser" property="principal" />
						<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${f.followerUser.userNo}?loginUserNo=${loginUser.userNo}'">${f.followerUser.userNick}<p>
					</th>
					<th>
						<a href="#">${f.followerUser.temper}℃</a>
					</th>
					<th style="width: 20%">
						<button class="modakbul-button following" id="" value="${f.followerUser.userNo}" >팔로잉</button>
					</th>
				</tr>
			</c:forEach>
	 	</table>
	 
        </div>


	</div>
	
	


<%-- <jsp:include page="/WEB-INF/views/layout/footer.jsp" /> --%>
</body>
</html>