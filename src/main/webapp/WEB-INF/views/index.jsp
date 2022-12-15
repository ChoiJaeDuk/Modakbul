<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${pageContext.request.contextPath}/css/main/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/main/reset.css" rel="stylesheet" />
    <title>Document</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    
	    var index = 0;   //이미지에 접근하는 인덱스
	    window.onload = function(){
	        slideShow();
	    }
	
	    function slideShow() {
	    var i;
	    var x = document.getElementsByClassName("modakbul-banner");  //slide1에 대한 dom 참조
	    for (i = 0; i < x.length; i++) {
	       x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
	    }
	    index++;
	    if (index > x.length) {
	        index = 1;  //인덱스가 초과되면 1로 변경
	    }   
	    x[index-1].style.display = "block";  //해당 인덱스는 block으로
	    setTimeout(slideShow, 4000);   //함수를 4초마다 호출
	
	    }
    	$(function() {
    		var gatherNo;
    		var userNo=$("#userNo").val()
    			$(document).on("click", ".main-gather-img", function() {
    				alert($("#userNo").val())
				gatherNo = $(this).attr("name");
				location.href="${pageContext.request.contextPath}/gatherDetail/info?gatherNo="+gatherNo+"&userNo="+$("#userNo").val();
			})
    	
    		$(document).on("click", ".list-card-title", function() {
    			gatherNo = $(this).attr("id");
    			location.href="${pageContext.request.contextPath}/gatherDetail/info?gatherNo="+gatherNo+"&userNo="+$("#userNo").val();
    		})
		})
		
    </script>
  </head>
  <body>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />
   
   <div class="bannerSection">
		<c:forEach items="${fileNames }" var="banner">
			<img src="${pageContext.request.contextPath}/banner/${banner}"
				alt="modakbul-icon" class="modakbul-banner" onclick="" />
		
		</c:forEach>
 	</div>
    <div class="wrap">
      <main>
     <sec:authorize access="isAuthenticated()">
	<sec:authentication var="user" property="principal" />
	<input type="hidden" value="${user.userNo }" id="userNo">
	</sec:authorize>
       
        <div class="featured-list-wrap">
          <div class="list-header">
            <div class="list-title">추천 모닥불</div>
          </div>
          
          
          <div class="card-list">
          <c:forEach items="${requestScope.selectAdGather}" var="ad" varStatus="status" begin="0" end="3">
            <div class="list-card">
              <div class="list-image-wrap">
                <img class="main-gather-img" width="100%" src="${pageContext.request.contextPath}/save/${ad.gather.gatherImg}" alt="사진" name="${ad.gather.gatherNo}"/>
                
              </div>
              <div class="list-card-title" id="${ad.gather.gatherNo }">
            	${ad.gather.gatherName}
              </div>
            </div>
            </c:forEach> 
          </div>
          
          
        </div>
        <div class="new-list-wrap">
          <div class="list-header">
            <div class="list-title">새로운 모닥불</div>
          </div>
          <div class="card-list">
          <c:forEach items="${requestScope.newGatherList}" var="newGather" varStatus="status">
            <div class="list-card">
              <div class="list-image-wrap">
                <img class="main-gather-img" width="100%" src="${pageContext.request.contextPath}/save/${newGather.gatherImg}" alt="사진"  name="${newGather.gatherNo}"/>
               
              </div>
              <div class="list-card-title" id="${newGather.gatherNo}">
                ${newGather.gatherName}
              </div>
            </div>
          </c:forEach>
          </div>
        <div></div>
        </div>
        
        <div class="featured-list-wrap">
          <div class="list-header">
            <div class="list-title">마감임박 모닥불</div>
          </div>
          <div class="card-list">
           <c:forEach items="${requestScope.deadLineGatherList}" var="deadLineGatherList" varStatus="status">
            <div class="list-card">
              <div class="list-image-wrap">
                <img class="main-gather-img" width="100%" src="${pageContext.request.contextPath}/save/${deadLineGatherList.gatherImg}" name="${deadLineGatherList.gatherNo}" alt="사진" />
          
              </div>
              <div id="${deadLineGatherList.gatherNo}" class="list-card-title">
                 ${deadLineGatherList.gatherName}
              </div>
            </div>
        	</c:forEach>
          </div>
          <div></div>
        </div>
      </main>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
