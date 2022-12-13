
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
    <link href="${pageContext.request.contextPath}/css/gatherDetail/index.css" rel="stylesheet" />
    
    <title>Document</title>
    <style type="text/css">
 a:link { color: white; text-decoration: none;}
 a:visited { color: white; text-decoration: none;}
 a:hover { color: rgb(243, 156, 18); text-decoration: blink;}
</style>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$("form").on("submit",function() {
	//문의사항 제목
	if($("#serviceQuestionSubject").val()===""){
		alert("제목을  작성해주세요.")
		return false;
	}
	
	if($("#serviceQuestionContent").val()===""){
		alert("내용을  작성해주세요.")
		return false;
	}
	
	if($("#serviceQuestionPwd").val()===""){
		alert("임시비밀번호를  작성해주세요.")
		return false;
	}
})
</script>
  </head>
  <body>
    <div class="wrap">
      <div class="search-list">
        <div class="search-list-body">
          <aside class="search-list-sub-filter">
         <sec:authentication var="user" property="principal" /> 
          </aside>
          <main class="search-list-main">
            <section class="search-inquiry-list-result-wrap">
              <div class="inquiry-top">
                <h2 class="inquiry-title">주최자 후기 등록하기 </h2>
                <div class="inquiry-button-wrap">
                  
                </div>
              </div>
             <div class="underline-wrap">
               
              </div>
              
              <div class="container-fliud">
					<div class="wrapper row">
						<div class="preview col-md-6">
							
							<div class="preview-pic tab-content">
							  <div class="tab-pane active" id="pic-1"><img class="gather-img" src="이미지" /></div>
							</div>	
						</div>
						<div class="gather-info">
							<div class="gather-name">
								<div>
									<h3 class="product-title">고양이 정보 공유해요!</h3>
								</div>
								
								<div class="heart-img">
									<img src="" alt="img">
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
								<span class="category">자유</span>
							</div>
							<div class="gather-detail">
								<div class="gather gather-margin">
									참가비: <span>???</span>
								</div>
								<div class="gather gather-margin">
									모임 날짜: <span>2022-10-20 20:30</span>
								</div>
								<div class="gather inline">
									장소: 서울시 금천구
								</div>
								<div class="gather inline">
									성별: 남녀모두
								</div>
							</div>
							<div class="gather-detail">
								<div class="gather inline">
									연령: 20 ~ 29
								</div>
								<div class="gather inline">
									인원: 신청인원 / 최대인원
								</div>
							</div>
							
						</div>
					</div>
				</div>
              
              <div class="notice-list-wrap">
                <div class="notice-list-title-wrap">
                  <div class="notice-list-title"> ${noticeDetail.serviceQuestionSubject}</div>
                </div>
              </div>
                
                <div class="notice-list-info-wrap">
	                <h2 class="inquiry-guide-comment">
	                주최자 온도 남기기  	                 
	                </h2>
                </div>
                <div class="create-group-wrap">
                <sec:authentication var="user" property="principal" />
			        <form action="${pageContext.request.contextPath}/review/userReviewInsert" method="post" >
			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			        <input type="hidden" name="writeUserNo" value="${user.userNo}" id="writeUserNo"> 
			          <div class="create-group-top">
			            <div class="create-group-wrap-image">
			              <div class="create-group-info-table-item">
			              	<div class="create-group-info-table-item-content">
			                	<input class="create-group-form-input" id="userTemper" name="userTemper"/>
			              	</div>
			              </div>
			            </div>
			             <div class="create-group-info-table-item">
			              <div class="create-group-info-table-item-label">
			              	<h2 class="user-review-content">
			              	주최자 후기
			              	</h2>
			              </div>
			              <div class="create-group-info-table-item-content">
			                <textarea class="create-group-form-textarea" name="userReviewContent" id="userReviewContent"></textarea>
			              </div>
			            </div>
			                <div class="create-group-button-wrap">
					            <button class="create-user-review-button" type="submit">등록하기</button>
					            <button class="create-user-review-cancel-button" type="button">돌아가기</button>
					        </div>
			            </div>
			          </form>
             		</div>
             		
            </section>
          </main>
        </div>
      </div>
    </div>
  </body>
</html>