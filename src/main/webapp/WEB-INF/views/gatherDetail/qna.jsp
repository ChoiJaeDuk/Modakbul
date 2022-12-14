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
				<form>
					<div class=qna-write-form>
						
						<div class="gather-detail-info qna-text">
							<label class="sign-up-form-label" for="id">문의 제목</label>
            				<input class="sign-up-form-input-medium"/>
						</div>
						<div class="gather-detail-info qna-text">
							<label class="sign-up-form-label" for="id">문의 내용</label>
            				<div class="inquiry-detail-textarea-wrap">
                  				<textarea class="inquiry-textarea"></textarea>
              				</div>	
						</div>
						<div class="gather-detail-info qna-text">
							<label class="sign-up-form-label" for="id">비밀번호</label>
            				<input type="password" class="sign-up-form-input-medium"/>
						</div>
						
					</div>
					<div class=qna-write-form-btn>
						<div class="qna-write">
							<button class="add-to-cart" type="button">작성완료</button>
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
		                    <tr class="table-row">
		                      <td>1</td>
		                      <td>제목</td>
		                      <td>작성자</td>
		                      <td>22.11.13</td>
		                      <td><button class="search-list-button" type="button">확인</button></td>
		                    </tr>
		                  </tbody>
		                </table>
		              </div>
		            </section>
		          </main>
		          </div>
		            <div class="search-inquiry-reply-wrap">
                      
                      <p class="search-inquiry-reply">
                        소리다이것은 피어나기 전인 유소년에게서 구하지 못할
                        바이며 시들어 가는 노년에게서 구하지 못할 바이며 오직
                        우리 청춘에서만 구할 수 있는 것이다 청춘은 인생의
                        황금시대다 우리는 이 황금시대의 가치를 충분히 발휘하기
                        위하여 이 황금시대를
                      </p>
                      <div>
                      	<button class="reply-btn" type="button">답변달기</button>
                      	<button class="reply-btn" type="button">삭제</button>
                      </div>
                    </div>
                    <div class="search-inquiry-reply-wrap reply-form-wrap">
                      <label class="reply-form" for="id">답변</label>
           				<div class="inquiry-detail-textarea-wrap">
               				<textarea class="inquiry-textarea reply"></textarea>
           				</div>	
           				<div>
	                      	<button class="reply-form-btn" type="button">답변작성</button>
	                      	<button class="reply-form-btn" type="button">취소</button>
                      	</div>
                    </div>
                    <div class="search-inquiry-reply-wrap reply-show">
                      <div class="search-inquiry-reply"><b>주최자: </b></div>
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
