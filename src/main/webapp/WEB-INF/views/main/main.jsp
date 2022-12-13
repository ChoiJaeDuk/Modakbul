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
    	$(function() {
			
    		var gatherNo;
    		
    			$(document).on("click", ".gather-img", function() {
				gatherNo = $(this).attr("name");
				location.href="${pageContext.request.contextPath}/gatherDetail/info?gatherNo="+gatherNo;
			})
    	
    		$(document).on("click", ".list-card-title", function() {
    			gatherNo = $(this).attr("id");
    			location.href="${pageContext.request.contextPath}/gatherDetail/info?gatherNo="+gatherNo;
    		})
		})
		
    </script>
  </head>
  <body>
    <div class="wrap">
      <main>
        <div class="main-banner-wrap">
          <img src="" alt="" />
        </div>
        <div class="featured-list-wrap">
          <div class="list-header">
            <div class="list-title">추천 모닥불</div>
          </div>
          
          
          <div class="card-list">
          <c:forEach items="${requestScope.selectAdGather}" var="ad" varStatus="status" begin="0" end="3">
            <div class="list-card">
              <div class="list-image-wrap">
                <a href="dd"><img width="100%" src="${pageContext.request.contextPath}/save/${ad.gather.gatherImg}" alt="사진" /></a>
                <img class="list-card-like" src="${pageContext.request.contextPath}/save/heart.png" alt="하트" />
              </div>
              <div class="list-card-title">
            	<a href="dd">${ad.gather.gatherName}</a>
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
                <img class="gather-img" width="100%" src="${pageContext.request.contextPath}/save/${newGather.gatherImg}" alt="사진"  name="${newGather.gatherNo}"/>
                <img name="${newGather.gatherNo}" class="list-card-like" alt="하트" />
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
                <img class="gather-img" width="100%" src="${pageContext.request.contextPath}/save/${deadLineGatherList.gatherImg}" name="${deadLineGatherList.gatherNo}" alt="사진" />
                <img class="list-card-like" name="${deadLineGatherList.gatherNo}" alt="하트" />
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
  </body>
</html>
