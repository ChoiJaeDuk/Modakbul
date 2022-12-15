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

  </head>

  <body>
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

			
	            <div class="search-inquiry-review-wrap">
                     <div class="search-inquiry-review">
                     	<div><b>작성자 : </b></div>
                     	<div class="review-regis-date">작성날짜: </div>
                     </div>
                     <div class="search-inquiry-reply">
                       소리다이것은 피어나기 전인 유소년에게서 구하지 못할
                       바이며 시들어 가는 노년에게서 구하지 못할 바이며 오직
                       우리 청춘에서만 구할 수 있는 것이다 청춘은 인생의
                       황금시대다 우리는 이 황금시대의 가치를 충분히 발휘하기
                       위하여 이 황금시대를
				  	</div>
                 </div>
                 <div class="search-inquiry-review-wrap">
                     <div class="search-inquiry-review">
                     	<div><b>작성자 : </b></div>
                     	<div class="review-regis-date">작성날짜: </div>
                     </div>
                     <div class="search-inquiry-reply">
                       소리다이것은 피어나기 전인 유소년에게서 구하지 못할
                       바이며 시들어 가는 노년에게서 구하지 못할 바이며 오직
                       우리 청춘에서만 구할 수 있는 것이다 청춘은 인생의
                       황금시대다 우리는 이 황금시대의 가치를 충분히 발휘하기
                       위하여 이 황금시대를
				  	</div>
                 </div>
			</div>
				 
		</div>
	</div>
  </body>
</html>
