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
    			
				$("#regular").attr("class", "modakbul-header header-selected");
				
				/* var con = querySelector(`.search-list-body`)
				con.style.visibility="hidden"; */
			 /*  $(":header").css("background-color", "yellow"); */

			});
    		
    		$("#search-btn").click(function(){
    			alert(1)
    			location.href="${pageContext.request.contextPath}/main/searchUserIndivForRegular/"+$("#search-text").val()
    			
    			
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
         	<c:when test="${empty requestScope.searchUser}">
          <h2 class="search-list-title">'' 검색 결과</h2>
          	</c:when>
          	
          	<c:otherwise>
          		<h2 class="search-list-title">'${searchUser.keyword}' 검색 결과</h2>
          	</c:otherwise>
          </c:choose>
          
        </div>
        
        <div class="search-list-body" style="visibility: hidden">
          <aside class="search-list-sub-filter"></aside>
          <main>
            <section class="search-member-list-result-wrap">
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
            </section>
          </main>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
