
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
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
    <style type="text/css">
 a:link { color: white; text-decoration: none;}
 a:visited { color: white; text-decoration: none;}
 a:hover { color: rgb(243, 156, 18); text-decoration: blink;}
</style>

  </head>
  <body>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="wrap">
      <div class="search-list">
        <div class="search-list-body">
          <aside class="search-list-sub-filter">
            <ul class="search-list-filter-type">
            <sec:authorize access="isAuthenticated()">
            <sec:authentication var="user" property="principal" />
              <li class="search-list-filter-item selected" onclick="location.href='${pageContext.request.contextPath}/question/notice'">공지사항</li>
              <li class="search-list-filter-item" onclick="location.href='${pageContext.request.contextPath}/question/inqueryQnA '">Q&A</li>
              <li class="search-list-filter-item" onclick="location.href='${pageContext.request.contextPath}/question/inqueryFAQ'">자주하는 질문</li>
            </ul>
             </sec:authorize>
          </aside>
          <main class="search-list-main">
            <section class="search-inquiry-list-result-wrap">
              <div class="inquiry-top">
                <h2 class="inquiry-title">공지사항</h2>
                <div class="inquiry-button-wrap">
                  <button class="search-list-button" type="button">수정</button>
                  <button class="search-list-button" type="button">삭제</button>
                </div>
              </div>
             <div class="inquiry-search-area">
                <div class="inquiry-search-wrap">
                </div>
              </div>
              
              <div class="notice-list-wrap">
                <div class="notice-list-title-wrap">
                  <div class="notice-list-title"> ${noticeDetail.serviceQuestionSubject}</div>
                </div>
                
                <div class="notice-list-info-wrap">
                <c:set var="TextValue" value="${noticeDetail.serviceQuestionDate}" />
                  <div class="notice-list-info"> ${fn:substring(TextValue,0,10)}</div>
                  <div class="notice-list-info"> 조회수 </div>
                </div>
                <div class="notice-list-content-wrap">
           		  <div class="notice-list-content" id="noticeContent">
           		  ${noticeDetail.serviceQuestionContent}
           		  </div>
          		</div>
                <div class="modal-button-wrap">
                  <button type="button" class="modal-button-list"><a href="${pageContext.request.contextPath}/question/notice">목록으로</a></button>
            	</div>
          
              </div>
          
             
            </section>
          </main>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
