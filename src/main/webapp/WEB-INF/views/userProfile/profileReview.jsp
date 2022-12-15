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
                        	   console.log("err : "+err);
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
			<h3 onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${user.userNo }?loginUserNo=${loginUserNo }'" style="color: lightgray">주최모임</h3>
			</div>
			<div class="checkUserSubject">
			<h3 onclick="location.href='${pageContext.request.contextPath}/userProfile/profileReview/${user.userNo }?loginUserNo=${loginUserNo }'" >후기</h3>
			</div>
			</nav>
			</div>
			<c:choose>
				<c:when test="${0 eq requestScope.userReviewList.getTotalPages()}">
					<div class="profile-review-list-ifnone">
					작성된 후기가 없습니다. 
					</div>
				</c:when>
			<c:otherwise>
			<c:forEach var="url" items="${requestScope.userReviewList.content}">
				<c:set var="TextValue" value="${url.userRevieweRegisDate}" />
			<div class="profile-review-list">
              <div class="modakbul-review-grid-col">
                <img class="reviewUser-img"  alt="modakbul-charged-img" src="${pageContext.request.contextPath}/save/${url.writerUser.userProfileImg}"/>
              </div>
              <div class="modakbul-review-grid-col">
                
                <div class="modakbul-charged-grid-director gather">
                  <p class="review-user-name">
                   닉네임 : ${url.hostUser.userNick}
                  </p>
                    <p class="review-date">
                   등록일 : ${fn:substring(TextValue,0,10)}
                  </p>
                   <p class="review-content">
                    <input type="text" class="review-content-area" value="${url.userReviewContent}"/>
                  </p>
                </div>
              </div>
            </div>
           </c:forEach>
          </c:otherwise>
		 </c:choose> 
            </div>
          </div>
          
           
          </div>
          <!-- 여기까지 content -->
        
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
		<!--  블럭당  -->
		<%--  <nav class="pagination-container">
			<div class="pagination">
			<c:set var="doneLoop" value="false"/>
				
				 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
				      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageGather?nowPage=${startPage-1}">PREV</a>
				  </c:if> 
				  
				<span class="pagination-inner"> 
				  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
				  
					    <c:if test="${(i-1)>=gatherList.getTotalPages()}">
					       <c:set var="doneLoop" value="true"/>
					    </c:if> 
				    
				  <c:if test="${not doneLoop}" >
				         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageGather?nowPage=${i}">${i}</a> 
				  </c:if>
				   
				</c:forEach>
				</span> 
						
				 <c:if test="${(startPage+blockCount)<=gatherList.getTotalPages()}">
				     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageGather?nowPage=${startPage+blockCount}">NEXT</a>
				 </c:if>
						 
					
				
				</div>
			</nav>   --%>
		</div>
        </div>
        </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
