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
  

    <title>eCommerce Product Detail</title>
 <link href="${pageContext.request.contextPath}/css/gatherDetail/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/gatherDetail/reset.css" rel="stylesheet" />

<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
	<script type="text/javascript">
    	
    $(document).ready(function(){
		$(function(){
			
			let str = "yes";
				if("${yesOrNo}"==str){
					$("#like").attr("src","${pageContext.request.contextPath}/save/ok_modak.png")
				}// check IF END
			// 토글
			$(document).ajaxSend(function(e,xht,op){
		       xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
		    });
				
		$(document).on('click', '#like',function(){
					
					alert("관심클릭했음" + " , " + "${gather.gatherNo}");
                
                let target = {"gatherNo": "${gather.gatherNo}", "userNo":"${userNo1}"}
                console.log("gatherNo = " + "${gather.gatherNo}");
                console.log("userNo = " + "${userNo1}");
					
					if($("#like").attr("src")=="${pageContext.request.contextPath}/save/ok_modak.png"){
                    alert("딜리트 반응?");
                    $.ajax({
                       url:"${pageContext.request.contextPath}/likeGather/delete", 
                       type:"post",
                       dataType:"text",
                           data:JSON.stringify(target),   
                           contentType:'application/json;charset=utf-8',
                       success:function(result){
                          if(result=="ok"){
                             alert("관심모임이 해제 되었습니다.")                  
                             
                            $("#like").attr("src","${pageContext.request.contextPath}/save/no_modak.png")
                          }
                       },error:function(err){
                          alert("err");
                       }
                    });//Delete ajax END
                 }//Delete IF END
                 
                 if($("#like").attr("src")=="${pageContext.request.contextPath}/save/no_modak.png"){
                    alert("인설트반응?");
                    $.ajax({
                       url:"${pageContext.request.contextPath}/likeGather/insert",
                       type:"post",
                       dataType:"text",
                           data:JSON.stringify(target),   
                           contentType:'application/json;charset=utf-8',
                       success:function(result){
                          if(result=="ok"){
                             alert("관심모임 등록 되었습니다.")                  
                             
                             $("#like").attr("src","${pageContext.request.contextPath}/save/ok_modak.png")
                          }
                          
                       },error:function(err){
                          alert("로그인을 먼저 진행해주세요.");
                       }
                    });//Insert ajax END
                 }//Insert if END
                 
				});//click END
				
		})//첫번쨰 function END
		
	})//ready END
	
    </script>

  </head>
   <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
    $(function() {
        $(this).on("click", function() {
            $(".search-inquiry-reply-wrap-only").fadeToggle();
            $(".reply-btn").show();
            $(".search-inquiry-reply-wrap reply-show").show();
        })
        
   	 }) 
   	   $(function() {
   		 $(".reply-btn").on("click", function() {
             $(this).parent().next().fadeToggle();
             
         })
   	 })
   	 	
   	 
   	 
   	 </script>

  <body>
    <input hidden="" id="gatherBid" value="${gather.gatherBid}">
  	<input hidden="" id="check" value="${participant}">
  	<sec:authentication var="user" property="principal" />
 	<input hidden="" id="userNo" value="${user.userNo}">
	<div class="wrap">
		<div class="container">
			<div class="card">
				<div class="container-fliud">
					<div class="wrapper row">
						<div class="preview col-md-6">
							
							<div class="preview-pic tab-content">
							  <div class="tab-pane active" id="pic-1"><img class="gather-img" src="${pageContext.request.contextPath}/save/no_modak.png" /></div>
							</div>	
						</div>
						<div class="gather-info">
							<div class="gather-name">
								<div>
									<h3 class="product-title">${gather.gatherName}</h3>
								</div>
								<div class="heart-img">
									<img src="${pageContext.request.contextPath}/save/heart.png" alt="img">
								</div>
							</div>
							<div class="rating">
								<div class="stars">
									<span class="fa fa-star checked"></span>
									<span class="fa fa-star checked"></span>
									<span class="fa fa-star checked"></span>
									<span class="fa fa-star"></span>
									<span class="fa fa-star"></span>
								</div>
								<span class="category">${gather.category.categoryName}</span>
							</div>
							<div class="gather-detail">
								<div class="gather gather-margin">
									참가비: <span><c:choose>
											<c:when test="${0 eq gather.gatherBid}">
												무료
											</c:when>
											<c:otherwise>
												${gather.gatherBid}
											</c:otherwise>
										</c:choose>
										</span>
								</div>
								<div class="gather gather-margin">
								
									모임 날짜: <span>${gather.gatherDate}</span>
								</div>
								<div class="gather inline">
									장소: ${gather.gatherPlace }
								</div>
								<div class="gather inline">
									성별: ${gather.gatherSelectGender }
								</div>
							</div>
							<div class="gather-detail">
								<div class="gather inline">
									연령: ${gather.gatherMinAge} ~ ${gather.gatherMaxAge}
								</div>
								<div class="gather inline">
									인원: 신청인원 : ${participant} / 최대인원 : ${gather.gatherMaxUsers} (최소진행 인원: ${gather.gatherMinUsers}명)
								</div>
							</div>
							
							
							<div class="action">
								<button class="add-to-cart btn btn-default" value="${gather.gatherNo}" type="button">지금 예약하기</button>
							</div>
						</div>
					</div>
				</div>
			
				<div class="tab-container">
					<div class="menu-tab">
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/info?gatherNo=${gather.gatherNo}'">상세정보</div>
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/hostProfile?gatherNo=${gather.gatherNo}'">주최자 프로필</div>
						<div class="menu selected" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/qna?gatherNo=${gather.gatherNo}'">Q & A</div>
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/review?gatherNo=${gather.gatherNo}'">후기(?)</div>	
					</div>
				</div>
				<div class="gather-detail-info">
					<div class="qna-write">
						<button class="add-to-cart qna-write-btn" type="button">문의 작성</button>
					</div>			
				</div>
				<form action="insert">
				<input type="hidden"  name="user" value="${user.userNo}" />
				<input type="hidden"  name="gatherNo" value="${gather.gatherNo}" />
				<input type="hidden"  name="gatherName" value="${gather.gatherName}" />
					<div class=qna-write-form>
						
						<div class="gather-detail-info qna-text">
							<label class="sign-up-form-label" for="id">문의 제목</label>
            				<input class="sign-up-form-input-medium" name="inqSubject"/>
						</div>
						<div class="gather-detail-info qna-text">
							<label class="sign-up-form-label" for="id">문의 내용</label>
            				<div class="inquiry-detail-textarea-wrap">
                  				<input class="inquiry-textarea" name="inqContent"></input>
              				</div>	
						</div>
						
						
					</div>
					<div class=qna-write-form-btn>
						<div class="qna-write">
							<button class="add-to-cart" type="submit">작성완료</button>
							<button class="add-to-cart cancel-btn" type="button">취소</button>
						</div>
					</div>
				</form>
				<div>
				<main class="search-list-main">
		            <section class="search-inquiry-list-result-wrap">
		           
		              <div class="search-inquiry-list">
		                <table class="table">
		                  <colgroup>
		                    <col width="14%" />
		                    <col width="30%" />
		                    <col width="32%" />
		                    <col width="14%" />
		                    <col width="10%" />
		                  </colgroup>
		                  <thead>
		                    <tr class="table-header">
		                      <th>번호</th>
		                      <th>제목</th>
		                      <th>작성자</th>
		                      <th>등록일</th>
		                      <th></th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                   <c:forEach var="qna" items="${qnaList.content}" varStatus="status">
                   			<c:set var="TextValue" value="${qna.inqRegisDate}" />
		                    <tr class="table-row">
		                      <td>${status.count}</td>
		                      <td>${qna.inqSubject}</td>
		                      <td>${qna.user.userName }</td>
		                      <td>${fn:substring(TextValue,0,10)}</td>
		                      <td><button class="search-list-button" type="button" value="${qna.inqNo}" >확인</button></td>
		                      
		                    </tr>
		                    
		                   <tr>
		                    <td colspan="5">
		                 	<div class="search-inquiry-reply-wrap-only" style="display: none;" >
		                      <p class="search-inquiry-reply">
		                      ${qna.inqContent}
		                      </p>
		                    </div>
							
							 <%-- <c:if test="${'' eq reply.user.userNo}">  --%>
		                    <c:forEach items="${qna.inquiryReplyList}" var="reply">
		                      <div class="reply-btn" style="display: none;">
		                      	<button class="reply-btn" type="button">답변달기</button>
		                      	<button class="reply-btn" type="button">삭제</button>
		                      </div>
		                    
		                 	<div class="search-inquiry-reply-wrap reply-form-wrap" style="display: none;">
	                       	<label class="reply-form" for="id">답변</label>
	                       	<form action="qnaInsert">
	           				<div class="inquiry-detail-textarea-wrap">
	               				<textarea class="inquiry-textarea reply" name="inquiryReplycontent"></textarea>
	           				</div>	
	           				<div class="reply-btn">
	           				<%-- ${reply.inquiry.inqNo} --%>
	           					 <input type="hidden"  name="gatherNo" value="${gather.gatherNo}" />
	           					<input type="hidden" class="" id="" name="user" value="${user.userNo}" />
	           					<input type="hidden" class="inqNo" id="inqNo" name="inquiry" value="${reply.inquiry.inqNo }" />
		                      	<button class="reply-form-btn" type="submit">답변작성</button>
		                      	<button class="reply-form-btn" type="button">취소</button>
	                      	</div>
	                      	</form>
	                    	 </div>
	                     
	                     <div class="search-inquiry-reply-wrap reply-show" >
	                      <div class="search-inquiry-reply"><b>주최자: ${reply.user.userName } </b></div>
	                      <div class="search-inquiry-reply">
	                      ${reply.inquiryReplycontent}
	                      </div>
	                    </div> </c:forEach>
	                   </td>  
		              
		            </tr>
		          </c:forEach>
	                
		                  </tbody>
		                </table>
		              </div>
		             </section> 
		          </main>
		          </div>
				</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
