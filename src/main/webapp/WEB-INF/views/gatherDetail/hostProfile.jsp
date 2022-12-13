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
							
							
							<div class="action">
								<button class="add-to-cart btn btn-default" type="button">지금 예약하기</button>
							</div>
						</div>
					</div>
				</div>
			
				<div class="tab-container">
					<div class="menu-tab">
						<div class="menu">상세정보</div>
						<div class="menu selected">주최자 프로필</div>
						<div class="menu">Q & A</div>
						<div class="menu">후기(?)</div>	
					</div>
				</div>
				<div class="gather-detail-info">
					<div class="host-profile">
						<div class="my-page-image-wrap">
				            <img
				              src="https://dummyimage.com/200x200/e8e3e8/fff&text=img"
				              alt="img"
				            />
				        </div>
				        <div class="host-profile-info">
				        	
					        <div class="host name">OOO님  </div>
					        <div class="host temper">모닥불 온도 : 36.5&#8451</div>
					        <div class="host">모임 진행횟수 : </div>
					        <div class="host">리뷰 : 3개</div>
				        </div>
					</div>
					<h2 class="host-review">후기</h2>
					<div class="host-review">
						<div class="user-profile-review-item-right">
			                <div class="user-profile-review-item-right-user-info">
			                  <div>
			                    <div class="user-profile-review-item-right-user-name">
			                      닉네임
			                    </div>
			                    <div class="user-profile-review-item-right-date">
			                      2022.22.22
			                    </div>
			                  </div>
			                  <div>여기에 온도</div>
			                </div>
			                <div class="user-profile-review-item-right-introduce">
			                  동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라
			                  만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세
			                </div>
	              		</div>
              		</div>
				</div>
			</div>
			 
			
		</div>
	</div>
  </body>
</html>
