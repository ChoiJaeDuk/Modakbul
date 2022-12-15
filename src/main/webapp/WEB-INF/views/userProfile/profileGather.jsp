<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

  
  <head>
  	
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>

	 <link href="${pageContext.request.contextPath}/css/userProfile/profile.css" rel="stylesheet" />
	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	<style type="text/css">
		
	</style>
	<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
	<script type="text/javascript">
  		$(document).ready(function(){
  			$(function(){
  				console.log("버튼 텍스트 = " + $(".profile-button").text());
  	  			console.log("있어 없어 ? = " + "${searchFollow}" );
  				
  				// 토글
  				$(document).ajaxSend(function(e,xht,op){
  		         xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
  		      	});
  				let str = "yes";
  				if("${searchFollow}"==str){
  					$(".profile-button").text("팔로잉");
  					$(".profile-button").css("background","gray");
  				}
  				
  				$(document).on('click', '.profile-button',function(){ 
                    let target = {"follower":$(this).val() , "following":"${loginUserNo}"}
                    console.log("follower = " + $(this).val());
                    console.log("following = " + "${loginUserNo}");

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
                        	   console.log("err");
                           }
                        });//Delete ajax END
                     }
                     
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
                        	   console.log("로그인을 먼저 진행해주세요.");
                           }
                        });//Insert ajax END
                     }//if  END
  				});//click END
  				
  			});
  		});
  	</script>
 </head>
 
   <body>


   <jsp:include page="../layout/header.jsp" /> 
   	<div id="user-outer-wrapper">
   		<div id="user-inner-wrapper" class="divi">
   			 <div class="user-content">
   			 <!-- <i class="fa-solid fa-user"></i> -->
   			 <img src="${pageContext.request.contextPath}/css/pageImg.png"
			alt="modakbul-icon" class="pageimg" /> 
   			 
   			
								 <div class="profileImg">
								
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
									</div>
									
								 <div class="my-page-info-wrap">
					   			 	
						   			
						   		</div>
						   		<div class="user-info-page">
						   			<table>
						   				<tr class="user-info-page-title">
						   					<th class="userNick"> 닉네임 </th>
						   					<th class="follower"> 팔로워 </th>
						   					<th class="user-temper"> 온도 </th>
						   					<th class="plusinfo"> 지역 </th>
						   				
						   				</tr>
						   				<tr class="user-info-page-content">
						   					<th class="result-nick"> ${user.userNick} </th>
						   					<th class="result-addr"> ${fn:split(user.userAddr,' ')[0]} &nbsp ${fn:split(user.userAddr,' ')[1]} </th>
						   					<th class="result-temper"> ${user.temper}&#8451 </th>
						   					<th class="result-follower">${follower }</th>
						   				</tr>	
						   			</table>

						   		
						   		</div>

								<div class="followBtn">
								<button class="profile-button" type="button" value="${user.userNo}"><p>팔로우</p></button>
								</div>


				</div>
				
   			
   		</div>
   	</div>
   
    <div id="profile-outer-wrapper">
    

      <div id="profile-inner-wrapper" class="divi">
       
        <div class="profile-content">
          <!-- 여기에 내용 넣으면 됨. -->
          	<div class="subject-title">
          	<nav>
			<div class="checkUserSubject">
			<h3 onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${user.userNo }'">주최모임</h3>
			</div>
			<div class="checkUserSubject">
			<h3 onclick="location.href='${pageContext.request.contextPath}/userProfile/profileReview/${user.userNo }'" style="color: lightgray">후기</h3>
			</div>
			</nav>
			</div>
			<c:choose>
				<c:when
					test="${0 eq requestScope.gatherList.getTotalPages()}">
					<div class="profile-review-list-ifnone">
						진행한 모닥불이 없습니다.
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${requestScope.gatherList.content}" var="gatherList" varStatus="status">
					<div class="profile-gather-list" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/info?gatherNo=${gatherList.gatherNo}&userNo=${loginUserNo}'">
		              <div class="modakbul-charged-grid-col">
		                <img class="gatherGroup-img" src="${pageContext.request.contextPath}/save/${gatherList.gatherImg}"  alt="modakbul-charged-img" />
		              </div>
		              <div class="modakbul-charged-grid-col">
		                
		                <div class="modakbul-charged-grid-director gather">
		                  <p class="gather-name">
		                    ${gatherList.gatherName}
		                  </p>
		                  
		                    <p class="gather-date">
		                    마감시간: ${gatherList.gatherDeadline}
		                  </p>
		                   <p class="gather-date">
		                    진행시간: ${gatherList.gatherDate}
		                  </p>
		                </div>
		              </div>
		             
		            </div>
					</c:forEach>
            	</c:otherwise>
			</c:choose>
          </div> 
          </div>
          <!-- 여기까지 content -->
        
      </div>
      
             <!-- confirm 모달을 쓸 페이지에 추가 start-->
        <section class="modal modal-section type-confirm">
            <div class="enroll_box">
                <p class="menu_msg"></p>
            </div>
            <div class="enroll_btn">
                <button class="btn pink_btn btn_ok">확인</button>
                <button class="btn gray_btn modal_close">취소</button>
            </div>
        </section>

        <!-- confirm 모달을 쓸 페이지에 추가 end-->

        <!-- alert 모달을 쓸 페이지에 추가 start-->
        <section class="modal modal-section type-alert">
            <div class="enroll_box">
                <p class="menu_msg"></p>
            </div>
            <div class="enroll_btn">
                <button class="btn pink_btn modal_close"  id="approve">확인</button>
            </div>
        </section>
        <div style="text-align: center">
		
		</div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
