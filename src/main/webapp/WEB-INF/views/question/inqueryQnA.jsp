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
  </head>
      <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    $(function() {
        $(".table-row").on("click", function() {
        	
            $(this).next().fadeToggle();
        })
        
   	 })  
    	 $(function() {
        //비밀번호 비교 
        
        $(document).on("click", "button[class=password-form-button]" , function(){
        	//alert(11111)
        	alert($("#password").val())
        	//alert($("#serviceQuestionNo").val())
        	//console.log(${serviceQuestionNo})
        	//if($("#password").val().length==0){
			//	alert("비밀번호를 입력해주세요.")
			//	return;
			//}
        	
        	$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/question/pwdCheck",
				dataType:"text",
				data: "${_csrf.parameterName}=${_csrf.token}&password="+$("#password").val()+"&serviceQuestionNo="+$("#serviceQuestionNo").val(),			
				success:function(result){
					
						alert(result);
						location.href="${pageContext.request.contextPath}/question/inqueryDetail"+result;
					
				},//function
				error:function(error){
					console.log(error)
				} 
				
			});//ajax
        });
        ///////////////////////////////////////////////
        $(function() {
        $("#insertQuestion").on("click", function() {
        	
            location.href="${pageContext.request.contextPath}/question/question_insert";
        })
        
   	 })
        
        
    }) 
    </script>
  <body>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
  	<div class="wrap">
      <div class="search-list">
        <div class="search-list-body">
          <aside class="search-list-sub-filter">
            <ul class="search-list-filter-type">
            <li class="search-list-filter-item " onclick="location.href='${pageContext.request.contextPath}/question/notice'">공지사항</li>
              <li class="search-list-filter-item selected"  onclick="location.href='${pageContext.request.contextPath}/question/inqueryQnA'">Q&A</li>
              <li class="search-list-filter-item" onclick="location.href='${pageContext.request.contextPath}/question/inqueryFAQ'">자주하는 질문</li>
            </ul>
          </aside>
          <main class="search-list-main">
            <section class="search-inquiry-list-result-wrap">
              <div class="inquiry-top">
                <h2 class="inquiry-title">Q&A</h2>
                <button class="insert-question-button" type="button" id="insertQuestion"> 등록하기 </button>
                
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
                  
                  <c:forEach var="serviceQ" items="${serviceQuestionList.content}" varStatus="status">
                   	<c:set var="TextValue" value="${serviceQ.serviceQuestionDate}" />
                   	
                 	  <tr class="table-row">
                      <td>${serviceQ.serviceQuestionNo}</td>
                      <td>비밀글 입니다. </td>
                      <td>${serviceQ.user.userName}</td>
                       <td>${fn:substring(TextValue,0,10)}</td> 
                    </tr>
                    
                    
                    <tr class="password-wrap" style="display: none;">
                    <td colspan="5" >
                    <div class="password-inner-wrap" >
               			<div class="password-required-comment">
	                        문의글 작성시 입력한 임시비밀번호를 입력해주세요.
	                    </div>
	                    <input type="hidden" class="id"id="id" name="id" />
	                    <input type="password" class="password-form" id="password" name="password" />
	                    <input type="hidden" value="${serviceQ.serviceQuestionNo}" class="serviceQuestionNo"id="serviceQuestionNo" name="serviceQuestionNo" />
	                    <button class="password-form-button" type="button" > 확인 </button> 
	                </div>
                    </td>
                    <tr>
                   </c:forEach> 
                  
                  </tbody>
                </table>
              </div>
              <!-- 페이징 -->
					<div style="text-align:center;">
						<!--  블럭당  -->
						<nav class="pagination-container">
							<div class="pagination">
								<c:set var="doneLoop" value="false" />

								<c:if test="${(startPage-blockCount) > 0}"><!-- (-2) > 0  -->
									<a class="pagination-newer"
										href="${pageContext.request.contextPath}/question/inqueryQnA?nowPage=${startPage-1}">PREV</a>
								</c:if>

								<span class="pagination-inner"> 
								<c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'>

										<c:if test="${(i-1)>=serviceQuestionList.getTotalPages()}">
											<c:set var="doneLoop" value="true" />
										</c:if>

										<c:if test="${not doneLoop}">
											<a class="${i==nowPage?'pagination-active':page}"
												href="${pageContext.request.contextPath}/question/inqueryQnA?nowPage=${i}">${i}</a>
										</c:if>

									</c:forEach>
								</span>

								<c:if test="${(startPage+blockCount)<=serviceQuestionList.getTotalPages()}">
									<a class="pagination-older"
										href="${pageContext.request.contextPath}/question/inqueryQnA?nowPage=${startPage+blockCount}">NEXT</a>
								</c:if>
								<!-- 페이징 끝 -->
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
