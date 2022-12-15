<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>


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
    $(function() {
        $(".search-inquiry-list-expand-button").on("click", function() {
        	
            $(this).next().fadeToggle();
        })
    })
</script>
  </head>
  <body>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="wrap">
     <div class="search-list">
        <div class="search-list-body">
          <aside class="search-list-sub-filter">
            <ul class="search-list-filter-type">
           <%--  <sec:authorize access="isAuthenticated()">
                  <sec:authentication var="user" property="principal" />
                  <c:set var="userNo" value="{user.userNo}"/>
                  </sec:authorize> --%>
               <li class="search-list-filter-item " onclick="location.href='${pageContext.request.contextPath}/question/notice'">공지사항</li>
              <li class="search-list-filter-item"  onclick="location.href='${pageContext.request.contextPath}/question/inqueryQnA'">Q&A</li>
              <li class="search-list-filter-item selected" onclick="location.href='${pageContext.request.contextPath}/question/inqueryFAQ'">자주하는 질문</li>
            </ul>
            
          </aside>
          <main class="search-list-main">
            <section class="search-inquiry-list-result-wrap">
              <div class="inquiry-top">
                <h2 class="inquiry-title">자주하는 질문</h2>
               
              </div>
              <div class="inquiry-search-area">
                
              </div>
              <div class="search-inquiry-list">
                <ul>
                  <li>
                    <div class="search-inquiry-list-expand-button">
	                      <div class="search-inquiry-list-expand-button-question-icon">
	                        <img src="/css/question.png" alt="" width="100%" />
	                      </div>
	                      <div class="search-inquiry-list-expand-button-title">
	                        인원이 부족해서 모임이 취소 될 수도 있나요?
	                      </div>
	                      <div class="search-inquiry-list-expand-button-expand-icon" >
	                        <img src="/css/down.png" alt="" width="100%" />
	                      </div>
                    </div>
                    <div class="search-inquiry-reply-wrap" style="display: none">
	                      <div
	                        class="search-inquiry-list-expand-button-result-icon"
	                      >
	                        <img src="/css/answer.png" alt="" width="100%" />
	                      </div>
	                      <p class="search-inquiry-reply">
	                        모임 3시간 전 인원 미달로 경기가 취소되는 경우 알림보내드립니다.
	                      </p>
                    </div>
                  </li>
                  
                  <li>
                    <div class="search-inquiry-list-expand-button">
	                      <div
	                        class="search-inquiry-list-expand-button-question-icon"
	                      >
	                        <img src="/css/question.png" alt="" width="100%" />
	                      </div>
	                      <div class="search-inquiry-list-expand-button-title">
	                        회원온도, 모임온도란 무엇인가요?
	                      </div>
	                      <div
	                        class="search-inquiry-list-expand-button-expand-icon"
	                      >
	                        <img src="/css/down.png" alt="" width="100%" />
	                      </div>
                    </div>
                    <div class="search-inquiry-reply-wrap" style="display: none">
	                      <div class="search-inquiry-list-expand-button-result-icon"
	                      >
							<img src="/css/answer.png" alt="" width="100%" />
	                      </div>
	                      <p class="search-inquiry-reply">
	                       오늘의 모임이 끝난 후 온도와 한줄 리뷰를 남겨보세요 <br>
	                       다양한 모임의 원동력이 됩니다.🔥 <br><br>
	                       
	                       회원 온도 : 주최자에 대한 모닥불 온도 <br>
	                       모임 온도 : 모임에 대한 모닥불 온도 <br>
	                       
	                      </p>
                    </div>
                  </li>
                  
                   <li>
                    <div class="search-inquiry-list-expand-button">
	                      <div
	                        class="search-inquiry-list-expand-button-question-icon"
	                      >
	                        <img src="/css/question.png" alt="" width="100%" />
	                      </div>
	                      <div class="search-inquiry-list-expand-button-title">
	                        유료 광고 계정으로 전환하고 싶어요 ! 
	                      </div>
	                      <div
	                        class="search-inquiry-list-expand-button-expand-icon"
	                      >
	                        <img src="/css/down.png" alt="" width="100%" />
	                      </div>
	                    </div>
                    <div class="search-inquiry-reply-wrap" style="display: none">
	                      <div
	                        class="search-inquiry-list-expand-button-result-icon"
	                      >
	                        <img src="/css/answer.png" alt="" width="100%" />
	                      </div>
	                      <p class="search-inquiry-reply">
	                       마이페이지에서 광고 신청 선택하여 결제 진행해주세요  <br>
	                       카카오페이만 지원하고 있으며 광고료는 월 300,000 입니다.<br>
	                      </p>
                    </div>
                  </li>
                  
                  <li>
                    <div class="search-inquiry-list-expand-button">
	                      <div
	                        class="search-inquiry-list-expand-button-question-icon"
	                      >
	                        <img src="/css/question.png" alt="" width="100%" />
	                      </div>
	                      <div class="search-inquiry-list-expand-button-title">
	                        모임 등록은 아무나 할 수 있나요?
	                      </div>
	                      <div
	                        class="search-inquiry-list-expand-button-expand-icon"
	                      >
	                        <img src="/css/down.png" alt="" width="100%" />
                      </div>
                    </div>
                    <div class="search-inquiry-reply-wrap" style="display: none">
	                      <div
	                        class="search-inquiry-list-expand-button-result-icon"
	                      >
	                        <img src="/css/answer.png" alt="" width="100%" />
	                      </div>
	                      <p class="search-inquiry-reply">
	                       누구나 모임 등록을 하실 수 있습니다.<br><br>
							단, 사업자등록증, 자격증등 자격증명이 가능한 서류를 제출해주셔야 합니다. <br>
							또한 주최자로써 활동하실때 참여자들과 연락하실 연락처를 작성 해주셔야 합니다.<br>
							모임 등록 후 관리자의 최종 승인이 있어야 홈페이지에 게시되고 모집할 수 있습니다.<br>
							관리자는 등록된 수업내용, 이미지, 주최자 프로필 등의 적절성, 사실확인을 검증한 이후 최종 승인을 해드립니다.<br>
	
	                      </p>
                    </div>
                  </li>
                  <li class="search-inquiry-list-item"></li>
                </ul>
              </div>
            </section>
          </main>
        </div>
      </div> 
    </div>
     <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
