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
    <link href="${pageContext.request.contextPath}/css/main/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/main/reset.css" rel="stylesheet" />
    <title>Document</title>
     <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$(document).ready(function(){
    			
				$("#gov").attr("class", "modakbul-header header-selected");
				
				/* var con = querySelector(`.search-list-body`)
				con.style.visibility="hidden"; */
			 /*  $(":header").css("background-color", "yellow"); */

			});
    		
    		$("#search-btn").click(function(){
    			alert(1)
    			location.href="${pageContext.request.contextPath}/main/searchUserCom/"+$("#search-text").val()
    			
    			
    		})    
    	})
    
    </script>
  </head>
  <body>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="wrap">
      <div class="search-list">
        <div class="search-list-top">
          
          <div class="search-list-main-filter">
            <ul class="search-list-main-filter-wrap">
              <li class="search-list-main-filter-item" onclick="location.href='${pageContext.request.contextPath}/main/agencyGather'">모임검색</li>
              <li class="search-list-main-filter-item selected" onclick="location.href='${pageContext.request.contextPath}/main/searchUserCom'">회원검색</li>
            </ul>
          
             <div class="search">
			  <input id="search-text" type="text" placeholder="검색어 입력">
			  <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" id="search-btn">
			</div>
          </div>
          <c:choose>
         	<c:when test="${empty requestScope.userList}">
          <h2 class="search-list-title">'' 검색 결과</h2>
          	</c:when>
          	
          	<c:otherwise>
          		<h2 class="search-list-title">'${keyword}' 검색 결과</h2>
          	</c:otherwise>
          </c:choose>
          
        </div>
        
        <div class="search-list-body">
          <aside class="search-list-sub-filter"></aside>
          <main>
             <section class="search-member-list-result-wrap">
            
                <c:choose>
         		<c:when test="${!empty requestScope.userList}">
         			<c:forEach items="${userList.content }" var="user">
         				<article class="search-member-list-result-item">
         				
               				 <div class="search-member-list-result-item-image-wrap">
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
                			<div class="search-member-list-result-item-member-name">
                  				${user.userNick }
                			</div>
              			</article>
         			</c:forEach>
         		</c:when>
         		</c:choose>
         		
         		
         		
               
            </section>
          </main>
        </div>
      </div>
    </div>
     <nav class="pagination-container">
	<div class="pagination">
	<c:if test="${!empty requestScope.userList }">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/main/searchUserCom/${keyword}?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		
			    <c:if test="${(i-1)>=userList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/main/searchUserCom/${keyword}?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=userList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/main/searchUserCom/${keyword}?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if> 
		</c:if>		 
			
		
		</div>
	</nav>
    
    
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
