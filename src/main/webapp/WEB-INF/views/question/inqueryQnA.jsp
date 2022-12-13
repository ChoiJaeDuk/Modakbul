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
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    $(function() {
        $(".table-row").on("click", function() {
        	
            $(this).next().fadeToggle();
        })
        
    })  
        //비밀번호 비교 
        $("#passwordBtn").click(function(){
        	
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/pwdCheck",
					dataType:"text",
					data: "${_csrf.parameterName}=${_csrf.token}&password="+$("#password").val(),			
					success:function(result){
						if($("#password").val().length==0){
							alert("비밀번호를 입력해주세요.")
							//$("#compareNick").html("");
						}else{
							//$("#compareNick").html(result);
							alert(result);
							/* if(result=="이미 사용중인 닉네임"){
								$("#nick").val("");
								
							}else{
								$("#checkNick").html("중복체크완료");
							}
							
							 */
						}
					},//function
					error:function(error){
						console.log(error)
					} 
					
				});//ajax
       
        
    })
    </script>
  </head>
  <body>
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
                      <td>${status.count}</td>
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
	                    <input type="text" class="password-form" id="password" name="password" />
	                    <button class="password-form-button" type="button" id="passwordBtn"> 확인 </button> 
	                </div>
                    </td>
                    <tr>
                   </c:forEach> 
                  
                  </tbody>
                </table>
              </div>
             
            </section>
          </main>
        </div>
      </div>
    </div>
  </body>
</html>
