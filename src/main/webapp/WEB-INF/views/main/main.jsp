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
          
          <c:choose>
					<c:when test="${!empty requestScope.selectAdGather}">
						<c:forEach var="ad" items="${selectAdGather.content}">
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
            
              </div>
            </div>
            </c:forEach> 
						</c:when>
					</c:choose>	
            
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
          </div>
          <div></div>
        </div>
        <div class="new-list-wrap">
          <div class="list-header">
            <div class="list-title">새로운 모닥불</div>
          </div>
          <div class="card-list">
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
          </div>
          <div></div>
        </div>
        <div class="featured-list-wrap">
          <div class="list-header">
            <div class="list-title">마감임박 모닥불</div>
          </div>
          <div class="card-list">
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
            <div class="list-card">
              <div class="list-image-wrap">
                <img width="100%" src="" alt="사진" />
                <img class="list-card-like" alt="하트" />
              </div>
              <div class="list-card-title">
                플랩 스타디움 가산 마리오 소셜 매치ddd
              </div>
            </div>
          </div>
          <div></div>
        </div>
      </main>
    </div>
  </body>
</html>
