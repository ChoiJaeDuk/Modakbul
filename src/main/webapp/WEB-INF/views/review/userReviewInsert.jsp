
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
   <!--  <script type="text/javascript">
      const drawStar = (e) => {
        console.log(e.value);
        const wrap = document.querySelector('.fire-fill');
        if (wrap) {
          const value = Number(e.value) || 0;
          wrap.style.width = `${value * 10}%`;
        }
      };
    </script> -->
  </head>
  <body>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
   <script type="text/javascript">
      const drawStar = (e) => {
        console.log(e.value);
        const wrap = document.querySelector(`.fire-fill`);
        console.log(wrap)
       
        if (wrap) {
          const value = Number(e.value) || 0;
          console.log(value)
         // alert(value*10)
          wrap.style.width = (value*10) +"%";
          
      		$("input[name=userTemper]").val( value*10 );
          
          
          
          
        }
        
        
      };
      
      
       
    </script>
  
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
							  <div class="tab-pane active" id="pic-1"><img class="gather-img" src="${gather.gatherImg }" /></div>
							</div>	 
						</div>
						<div class="gather-info">
							<div class="gather-name">
								<div>
									<h3 class="product-title">${gather.gatherName}</h3>
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
								<span class="category">${gather.category.categoryName}</span>
							</div>
							<div class="gather-detail">
								<div class="gather gather-margin">
									참가비: <span>${gather.gatherBid}</span>
								</div>
								<div class="gather gather-margin">
									모임 날짜: <span>${gather.gatherDate}</span>
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
									연령 : ${gather.gatherMinAge} ~ ${gather.gatherMaxAge}
								</div>
								<div class="gather inline">
									인원: 신청인원 / ${gather.gatherMaxUsers}
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
			        <form action="${pageContext.request.contextPath}/review/userReviewInsertbutton" method="post" >
			        <input type="hidden" name="gatherNo" value="${gather.gatherNo }"/> 
			        <input type="hidden" name="userTemper" value=""/>
			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			        <input type="hidden" name="writerUser" value="${userNo}" id="writerUser">
			        <input type="hidden" name="hostUser" value="${gather.user.userNo}" id="hostUser">
			        
			          <div class="create-group-top">
			            <div class="create-group-wrap-image">
			              <div class="create-group-info-table-item">
			              	<div class="create-group-info-table-item-content">
			                	 <div class="rate-wrap">
							      <div class="rate">
							        <div class="empty-wrap">
							          <img src="${pageContext.request.contextPath}/img/assets/empty.png" width="30px" />
							          <img src="${pageContext.request.contextPath}/img/assets/empty.png" width="30px" />
							          <img src="${pageContext.request.contextPath}/img/assets/empty.png" width="30px" />
							          <img src="${pageContext.request.contextPath}/img/assets/empty.png" width="30px" />
							          <img src="${pageContext.request.contextPath}/img/assets/empty.png" width="30px" />
							        </div>
							        <div class="fire-fill">
							          <img class="fire-image" src="${pageContext.request.contextPath}/img/assets/logo.png" width="30px" />
							          <img class="fire-image" src="${pageContext.request.contextPath}/img/assets/logo.png" width="30px" />
							          <img class="fire-image" src="${pageContext.request.contextPath}/img/assets/logo.png" width="30px" />
							          <img class="fire-image" src="${pageContext.request.contextPath}/img/assets/logo.png" width="30px" />
							          <img class="fire-image" src="${pageContext.request.contextPath}/img/assets/logo.png" width="30px" />
							        </div>
							        <input
							          type="range"
							          class="rate-input"
							          onInput="drawStar(this)"
							          step="1"
							          min="0"
							          max="10"
							        />
							      </div>
							   </div>
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
					            <button class="create-user-review-button" type="submit" value="2">등록하기</button>
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
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>