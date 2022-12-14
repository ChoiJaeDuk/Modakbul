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
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: rgb(243, 156, 18); text-decoration: underline;}
</style>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function() {  
		$(document).ready(function(){
		
			$("#notice").attr("class", "modakbul-header header-selected");
		

		});
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
          <li class="search-list-filter-item selected" onclick="location.href='${pageContext.request.contextPath}/question/notice'">공지사항</li>
              <li class="search-list-filter-item"  onclick="location.href='${pageContext.request.contextPath}/question/inqueryQnA'">Q&A</li>
              <li class="search-list-filter-item" onclick="location.href='${pageContext.request.contextPath}/question/inqueryFAQ'">자주하는 질문</li>
            </ul>
          </aside>
          <main class="search-list-main">
            <section class="search-inquiry-list-result-wrap">
              <div class="inquiry-top">
                <h2 class="inquiry-title">공지사항</h2>
                <div class="inquiry-button-wrap">
                  <button class="search-list-button" type="button">등록</button>
                  <button class="search-list-button" type="button">삭제</button>
                </div>
              </div>
              <div class="inquiry-search-area">
                
              </div>
              <div class="search-inquiry-list">
                <table class="table">
                  <colgroup>
                    <col width="14%" />
                    <col width="42%" />
                    <col width="32%" />
                    <col width="14%" />
                  </colgroup>
                  <thead>
                    <tr class="table-header">
                      <th>번호</th>
                      <th>제목</th>
                      <th>작성자</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="notice" items="${noticeList.content}" varStatus="status">
                   	<c:set var="TextValue" value="${notice.serviceQuestionDate}" />
                 	  <tr class="table-row">
                      <td>${status.count}</td>
                      <td><a href="${pageContext.request.contextPath}/question/noticeDetail?serviceQuestionNo=${notice.serviceQuestionNo}" >${notice.serviceQuestionSubject}</a></td>
                      <td>${notice.user.userName}</td>
                       <td>${fn:substring(TextValue,0,10)}</td> 
                    </tr>
                   </c:forEach>
                    
                  </tbody>
                </table>
              </div>
              
              <div style="text-align: center">
							<!--  블럭당  -->
							<nav class="pagination-container">
								<div class="pagination">
									<c:set var="doneLoop" value="false" />

									<c:if test="${(startPage-blockCount) > 0}">
										<!-- (-2) > 0  -->
										<a class="pagination-newer"
											href="${pageContext.request.contextPath}/board/list?nowPage=${startPage-1}">PREV</a>
									</c:if>

									<span class="pagination-inner"> <c:forEach var='i'
											begin='${startPage}' end='${(startPage-1)+blockCount}'>

											<c:if test="${(i-1)>=pageList.getTotalPages()}">
												<c:set var="doneLoop" value="true" />
											</c:if>

											<c:if test="${not doneLoop}">
												<a class="${i==nowPage?'pagination-active':page}"
													href="${pageContext.request.contextPath}/board/list?nowPage=${i}">${i}</a>
											</c:if>

										</c:forEach>
									</span>

									<c:if
										test="${(startPage+blockCount)<=pageList.getTotalPages()}">
										<a class="pagination-older"
											href="${pageContext.request.contextPath}/board/list?nowPage=${startPage+blockCount}">NEXT</a>
									</c:if>
								</div>
							</nav>
						</div>
            </section>
          </main>
        </div>
      </div>
    </div>
     <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
