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
  	
  	</script>
 </head>
 
   <body>

 
   <jsp:include page="../layout/header.jsp" /> 
   	<div id="user-outer-wrapper">
   		<div id="user-inner-wrapper" class="divi">
   			 <div class="user-content">
   			 <img src="${pageContext.request.contextPath}/css/pageImg.png"
			alt="modakbul-icon" class="pageimg" /> 
   			 
   			 <%-- <div class="my-page-image-wrap" id="original">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<c:set value="${user.userProfileImg}" var="img" />
						<c:set value="true" var="state1" />
						<c:forEach items="${fileNames }" var="file">
							<c:if test="${file eq img }">
								<c:set value="true" var="state2" />
								 --%>
								 <div class="profileImg">
								<img class="sign-up-image"
									src="${pageContext.request.contextPath}/save/dong.jpg"
									alt="img" />
									</div>
									
								 <div class="my-page-info-wrap">
					   			 	
						   			
						   		</div>
						   		<div class="userNick">
					   			 		닉네임
					
						   			</div>
						   		<div class="user-temper">
					   			 		온도
					
						   			</div>
						   		<div class="plusinfo">
									<span>지역</span>
									</div>
								<div class="follower">
									팔로워
								</div>
								<div class="result-nick"> 지으니요 </div>
								<div class="result-addr"> 경기도 성남시 </div>
								<div class="result-temper"><p> 80°C </p></div>
								<div class="result-follower"><p> 126 </p></div>
								<div class="followBtn">
								<button class="profile-button" type="button"><p>팔로우</p></button>	
								</div>
													<!-- 	<div class="plusinfo">
									<span>지역</span>
									</div>
									<div class="plusinfo">
									팔로워
									</div> -->
		

							<%-- </c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="sign-up-image" src="${user.userProfileImg }"
								alt="img" />
						</c:if>

						<input id="sign-up-add-image" class="sign-up-add-image"
							type="file" name="file" accept="image/*" />
					</sec:authorize> --%>
				</div>
				<!--  <div class="my-page-info-wrap">
   			 	<div class="user-name">
   			 		지은이요

	   			</div>
	   			<div class="user-temper">
   			 		온도

	   			</div>
	   			<div class="user-follow">
   			 		팔로우

	   			</div>
	   		</div> 
   			 </div> -->
   			
   		</div>
   	</div>
   
    <div id="profile-outer-wrapper">
    

      <div id="profile-inner-wrapper" class="divi">
       <%--  <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu">
           <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
             <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdvAll'">광고관리</p>
          </div>
        </nav> --%>
        <div class="profile-content">
          <!-- 여기에 내용 넣으면 됨. -->
          	<div class="subject-title">
			<div class="checkUserSubject">
			<h3 onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather'" style="color: lightgray">주최모임</h3>
			</div>
			<div class="checkUserSubject">
			<h3 onclick="location.href='${pageContext.request.contextPath}/userProfile/profileReview'" >후기</h3>
			</div>
			</div>
			
			<div class="profile-review-list">
              <div class="modakbul-review-grid-col">
                <img class="reviewUser-img"  alt="modakbul-charged-img" />
              </div>
              <div class="modakbul-review-grid-col">
                
                <div class="modakbul-charged-grid-director gather">
                  <p class="review-user-name">
                   닉네임
                  </p>
                  
                    <p class="review-date">
                    날짜
                  </p>
                   <p class="review-content">
                    <input type="text" class="review-content-area" value="하잉 ~ 규 ~"/>
                  </p>
                </div>
              </div>
             
            </div>
			<div class="profile-review-list">
              <div class="modakbul-reivew-grid-col">
                <img class="reviewUser-img"  alt="modakbul-charged-img" />
              </div>
              <div class="modakbul-review-grid-col">
                
                <div class="modakbul-charged-grid-director gather">
                  <p class="review-user-name">
                   닉네임
                  </p>
                  
                    <p class="review-date">
                    날짜
                  </p>
                   <p class="review-content">
                    내용
                  </p>
                </div>
              </div>
             
            </div>
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
