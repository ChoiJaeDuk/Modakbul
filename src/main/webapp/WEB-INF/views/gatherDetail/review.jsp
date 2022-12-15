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

  <body>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />
	<div class="wrap">
		<div class="container">
			<div class="card">
				<div class="container-fliud">
					<div class="wrapper row">
						<div class="preview col-md-6">
							
							<div class="preview-pic tab-content">
							  <div class="tab-pane active" id="pic-1"><img class="gather-img" src="http://placekitten.com/400/252" /></div>
							</div>	
						</div>
						<div class="gather-info">
							<div  class="gather-name">
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
									인원: 신청인원 : ${participant} / 최대인원 : ${gatherMaxUsers} (최소진행 인원: ${gather.gatherMinUsers}명)
								</div>
							</div>
							
							
							<div class="action">
								<button class="add-to-cart btn btn-default" type="button">지금 예약하기</button>
							</div>
						</div>
					</div>
				</div>
			
				<div class="tab-container">
					<div class="menu-tab">
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/info?gatherNo=${gather.gatherNo}'">상세정보</div>
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/hostProfile?gatherNo=${gather.gatherNo}'">주최자 프로필</div>
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/qna?gatherNo=${gather.gatherNo}'">Q & A</div>
						<div class="menu selected" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/review?gatherNo=${gather.gatherNo}'">후기(?)</div>		
					</div>
				</div>
					<div class="space"></div>

				<c:forEach var="gr" items="${grList.content}">
	            <div class="search-inquiry-review-wrap">
                     <div class="search-inquiry-review">
                     	<div><b>작성자 : ${gr.writerUser.userName } </b></div>
                     	<div class="review-regis-date">작성날짜: ${gr. reviewRegisDate}</div>
                     </div>
                     <div class="search-inquiry-reply">
                       ${gr.gatherReviewContent}
				  	</div>
                 </div>
            	 </c:forEach>
                 
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
