
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
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
</script>
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
                <h2 class="inquiry-title">공지사항 수정</h2>
                <div class="inquiry-button-wrap">
                  
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
              </div>
                
                <div class="notice-list-info-wrap">
	                <h4 class="inquiry-guide-comment">
	                  모닥불내에 공지 사항 수정하기 
	                  <br><br>
	                 </h4>
                </div>
                <div class="create-group-wrap">
                <sec:authentication var="user" property="principal" />
			        <form action="${pageContext.request.contextPath}/question/noticeUpdate" method="post" >
			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			        <input type="hidden" name="user" value="${user.userNo}" id="user"> 
			        <input type="hidden" name="serviceQuestionNo" value="${dbNotice.serviceQuestionNo}">
			          <div class="create-group-top">
			            <div class="create-group-wrap-image">
			              <div class="create-group-info-table-item">
			              	<div class="create-group-info-table-item-label">제목</div>
			              	<div class="create-group-info-table-item-content">
			                	<input class="create-group-form-input" id="serviceQuestionSubject" name="serviceQuestionSubject" value="${dbNotice.serviceQuestionSubject}"/>
			              	</div>
			              </div>
			            </div>
			             <div class="create-group-info-table-item">
			              <div class="create-group-info-table-item-label">내용</div>
			              <div class="create-group-info-table-item-content">
			                <textarea class="create-group-form-textarea" name="serviceQuestionContent" id="serviceQuestionContent" >${dbNotice.serviceQuestionContent}</textarea>
			              </div>
			            </div>
			            
			            
			                <div class="create-group-button-wrap">
					            <button class="create-group-button" type="submit" >수정하기</button>
					            <button class="create-group-cancel-button" type="button">돌아가기</button>
					        </div>
			          
			            </div>
			          </form>
             		</div>
             		
            </section>
          </main>
        </div>
      </div>
    </div>
   <jsp:include page="/WEB-INF/views/layout/footer.jsp" />	
  </body>
</html>
