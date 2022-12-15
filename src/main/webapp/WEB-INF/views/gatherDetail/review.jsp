
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
    	
    var gatherPlace;		
	
	$(function() {
		
		if($("#application-btn").attr("name")=="모집중"){
		 	if($("#check").val()>0){
				$("#application-btn").css("background","grey")
				$("#application-btn").text("신청완료")
				$("#application-btn").attr("disabled",true)
			}else{
				$("#application-btn").text("신청하기")
			}
		}else if($("#application-btn").attr("name")=="진행완료"){
			$("#application-btn").css("background","grey")
			$("#application-btn").text("진행완료")
			$("#application-btn").attr("disabled",true)
		}else if($("#application-btn").attr("name")=="모임취소"){
			$("#application-btn").css("background","grey")
			$("#application-btn").text("모임취소")
			$("#application-btn").attr("disabled",true)
		}else if($("#application-btn").attr("name")=="진행중"){
			$("#application-btn").css("background","grey")
			$("#application-btn").text("진행중")
			$("#application-btn").attr("disabled",true)
		}else if($("#application-btn").attr("name")=="모집마감"){
			$("#application-btn").css("background","grey")
			$("#application-btn").text("모집마감")
			$("#application-btn").attr("disabled",true)
		}else if($("#application-btn").attr("name")=="신청대기"){
			$("#application-btn").css("background","grey")
			$("#application-btn").text("신청대기")
			$("#application-btn").attr("disabled",true)
		}
		
		
		 
		gatherPlace = $("#gatherPlace").val();
		//alert(gatherPlace)
		
		$("#application-btn").click(function() { 
			if($("#gatherBid").val()==0){
				
				if(confirm("모임 참가를 신청하시겠습니까???")){
			
					location.href="${pageContext.request.contextPath}/gatherDetail/insertParticipant?userNo="+$("#userNo1").val()+"&gatherNo="+$(this).val();
				}	
			}else{
				var IMP = window.IMP;
				IMP.init('imp55744106');
				IMP.request_pay(
								{
									pg : "kakaopay",
									pay_method : 'card',
									merchant_uid : 'merchant_'
											+ new Date().getTime(),
									name : '상품명',
									amount : $("#gatherBid").val(), //총판매가격
									buyer_email : 'kyucando@gmail.com',
									buyer_name : '규야 ',
									buyer_tel : '01085510356',
									buyer_addr : '경기도 용인시 ',
									//buyer_postcode : '01234',
									//m_redirect_url : '/index.jsp'
								},
								function(rsp) {
									if (rsp.success) {
										var msg = '결제가 완료되었습니다.';
										var result = {
										"imp_uid" : rsp.imp_uid,													
 										"pay_date" : new Date().getTime(),
										"amount" : rsp.paid_amount,
										"buyer_name": rsp.buyer_name
										
								     }
										
										//console.log("result = " + result.imp_uid);
										//alert("${_csrf.parameterName}")
										//alert("${_csrf.token}")
										
										$.ajax({
											type : "post",
											url : "${pageContext.request.contextPath}/ajaxTest?${_csrf.parameterName}=${_csrf.token}",  
											dataType:"json",
									   		data:JSON.stringify(result),	
									        contentType:'application/json;charset=utf-8',
									        success : function(result) {
									        
									        	location.href="${pageContext.request.contextPath}/gatherDetail/insertParticipant?userNo="+$("#userNo1").val()+"&gatherNo="+$(this).val();
									        },
											error : function(err) {
												alert(err);
											}
										});
								
									} else {
										var msg = '결제에 실패하였습니다.';
										rsp.error_msg;
										alert(msg);
									}
								});
			}
			
		});
		
	})
    
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
                let target = {"gatherNo": "${gather.gatherNo}", "userNo":"${userNo1}"}
                console.log("gatherNo = " + "${gather.gatherNo}");
                console.log("userNo = " + "${userNo1}");
					
					if($("#like").attr("src")=="${pageContext.request.contextPath}/save/ok_modak.png"){
               
                    $.ajax({
                       url:"${pageContext.request.contextPath}/likeGather/delete", 
                       type:"post",
                       dataType:"text",
                           data:JSON.stringify(target),   
                           contentType:'application/json;charset=utf-8',
                       success:function(result){
                          if(result=="ok"){
                                      
                             
                            $("#like").attr("src","${pageContext.request.contextPath}/save/no_modak.png")
                          }
                       },error:function(err){
                    	   console.log("err");
                       }
                    });//Delete ajax END
                 }//Delete IF END
                 

                 if($("#like").attr("src")=="${pageContext.request.contextPath}/save/no_modak.png"){ 
                    $.ajax({
                       url:"${pageContext.request.contextPath}/likeGather/insert",
                       type:"post",
                       dataType:"text",
                           data:JSON.stringify(target),   
                           contentType:'application/json;charset=utf-8',
                       success:function(result){
                          if(result=="ok"){
                                     
                             
                             $("#like").attr("src","${pageContext.request.contextPath}/save/ok_modak.png")
                          }
                          
                       },error:function(err){
                    	   console.log("로그인을 먼저 진행해주세요.");
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
  	<input hidden="" id="gatherBid" value="${gather.gatherBid}">
  	<input hidden="" id="check" value="${check}">
  	<sec:authorize>
  	<sec:authentication var="user" property="principal" />
  	</sec:authorize>
 	<input hidden="" id="userNo" value="${userNo}">
 	<c:if test="${!empty userNo1}">
 		<input type="hidden" id="userNo1" value="${userNo1}">
 	</c:if>
	<div class="wrap">
		<div class="container">
			<div class="card">
				<div class="container-fliud">
					<div class="wrapper row">
						<div class="preview col-md-6">
							
							<div class="preview-pic tab-content">
							  <div class="tab-pane active" id="pic-1"><img class="gather-detail-img" src="${pageContext.request.contextPath}/save/${gather.gatherImg}"/></div>
							</div>	
						</div>
						<div class="gather-info">
							<div class="gather-name">
								<div>
									<h3 class="product-title">${gather.gatherName}</h3>
								</div>
								<div class="heart-img">
									<img id="like" src="${pageContext.request.contextPath}/save/no_modak.png" alt="img" style="width: 50px;">
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
									참가비: 
									<span>
										<c:choose>
											<c:when test="${gather.gatherBid eq 0}">
												무료
											</c:when>
											<c:otherwise>
												${gather.gatherBid}
											</c:otherwise>
										</c:choose>
									</span>
								</div>
								<div class="gather gather-margin">
									모임 날짜: <span>${fn:replace(gather.gatherDate, 'T', ' ')}</span>
								</div>
								<div class="gather inline">
									장소: ${gather.gatherPlace}
								</div>
								<div class="gather inline">
									성별: ${gather.gatherSelectGender}
								</div>
							</div>
							<div class="gather-detail">
								<div class="gather inline">
									연령 : 
									<c:choose>
											<c:when test="${gather.gatherMinAge eq 0}">
												전연령
											</c:when>
											<c:otherwise>
												${gather.gatherMinAge} ~ ${gather.gatherMaxAge}
											</c:otherwise>
										</c:choose>
								</div>
								<div class="gather inline">
									인원: ${participant} / ${gather.gatherMaxUsers} (최소진행 인원: ${gather.gatherMinUsers}명)
								</div>
							</div>
							
							
							<div class="action">
								<button class="add-to-cart btn btn-default" id="application-btn" value="${gather.gatherNo}" type="button" name="${gather.gatherState}"></button>
							</div>
						</div>
					</div>
				</div>
				
				<div class="tab-container">
					<div class="menu-tab">
						<div class="menu selected" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/info?gatherNo=${gather.gatherNo}&userNo=${userNo1}'"><p>상세정보</p></div>
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/hostProfile?gatherNo=${gather.gatherNo}&userNo=${userNo1}'"><p>주최자 프로필</p></div>
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/qna?gatherNo=${gather.gatherNo}&userNo=${userNo1}'"><p>문의</p></div>
						<div class="menu" onclick="location.href='${pageContext.request.contextPath}/gatherDetail/review?gatherNo=${gather.gatherNo}&userNo=${userNo1}'"><p>후기</p></div>	
					</div>
				</div>
					<div class="space"></div>
					<c:choose>
						<c:when test="${0 eq requestScope.userReviewPageList.getTotalPages()}">
							<div class="profile-review-list-ifnone">
						작성된 후기가 없습니다. 
						</div>				
						</c:when>
					<c:otherwise>	
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
            	</c:otherwise>
	            </c:choose> 
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>