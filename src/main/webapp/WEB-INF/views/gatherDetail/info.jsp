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
							  <div class="tab-pane active" id="pic-1"><img class="gather-img" src="${pageContext.request.contextPath}/save/${gather.gatherImg}"/></div>
							</div>	
						</div>
						<div class="gather-info">
							<div class="gather-name">
								<div>
									<h3 class="product-title">${gather.gatherName}</h3>
								</div>
								<div class="heart-img">
									<img src="${pageContext.request.contextPath}/save/no_modak.png" alt="img" style="width: 50px;">
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
									모임 날짜: <span>${gather.gatherDate}</span>
								</div>
								<div class="gather inline">
									장소: ${gather.gatherPlace}
								</div>
								<div class="gather inline">
									성별: 남녀모두
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
									인원: 신청인원 / ${gather.gatherMaxUsers}
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
						<div class="menu selected">상세정보</div>
						<div class="menu">주최자 프로필</div>
						<div class="menu">Q & A</div>
						<div class="menu">후기(?)</div>	
					</div>
				</div>
				<div class="gather-detail-info">
					<div class="gather-content">
						${gather.gatherComment}
					</div>
					<div class="address">상세주소: 스타벅스 2층</div>
				
					<div class="map-space"></div>
				
					<div class="file-down">파일위치</div>
				</div>
			</div>
		
			
		</div>
	</div>
  </body>
</html>
