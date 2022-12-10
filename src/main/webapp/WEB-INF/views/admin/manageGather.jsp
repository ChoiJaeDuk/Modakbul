<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
    <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
   	<link href="${pageContext.request.contextPath}/css/admin/adminCharged.css" rel="stylesheet" />
 </head>
   <body>
    <div id="modakbul-outer-wrapper">
<jsp:include page="../layout/header.jsp" />	
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu">
           <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
             <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdvAll'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
          <!-- 여기에 내용 넣으면 됨. -->
            <div class="modakbul-charged-grid-row">
              <div class="modakbul-charged-grid-col">
                <img src="" alt="modakbul-charged-img" />
              </div>
              <div class="modakbul-charged-grid-col">
                <p class="modakbul-charged-grid-title">
                  이니셜 담은 카드지갑 원데이 클래스
                </p>
                <div class="modakbul-charged-grid-director flex">
                  <p class="modakbul-charged-grid-director-info">
                    <span>주최자</span> 장희정 쌤
                  </p>
                  <button class="modakbul-button button-detail">
                    모임 상세보기
                  </button>
                </div>
              </div>
              <div class="modakbul-charged-grid-col">
                <button class="modakbul-button button-agree">승인하기</button>
                <button class="modakbul-button button-deny">거절하기</button>
              </div>
            </div>
            <div class="modakbul-charged-grid-row">
              <div class="modakbul-charged-grid-col">
                <img src="" alt="modakbul-charged-img" />
              </div>
              <div class="modakbul-charged-grid-col">
                <p class="modakbul-charged-grid-title">
                  이니셜 담은 카드지갑 원데이 클래스
                </p>
                <div class="modakbul-charged-grid-director flex">
                  <p class="modakbul-charged-grid-director-info">
                    <span>주최자</span> 장희정 쌤
                  </p>
                  <button class="modakbul-button button-detail">
                    모임 상세보기
                  </button>
                </div>
              </div>
              <div class="modakbul-charged-grid-col">
                <button class="modakbul-button button-agree">승인하기</button>
                <button class="modakbul-button button-deny">거절하기</button>
              </div>
            </div>
            <div class="modakbul-charged-grid-row">
              <div class="modakbul-charged-grid-col">
                <img src="" alt="modakbul-charged-img" />
              </div>
              <div class="modakbul-charged-grid-col">
                <p class="modakbul-charged-grid-title">
                  이니셜 담은 카드지갑 원데이 클래스
                </p>
                <div class="modakbul-charged-grid-director flex">
                  <p class="modakbul-charged-grid-director-info">
                    <span>주최자</span> 장희정 쌤
                  </p>
                  <button class="modakbul-button button-detail">
                    모임 상세보기
                  </button>
                </div>
              </div>
              <div class="modakbul-charged-grid-col">
                <button class="modakbul-button button-agree">승인하기</button>
                <button class="modakbul-button button-deny">거절하기</button>
              </div>
            </div>
            
          </div>
          <!-- 여기까지 content -->
        </div>
      </div>
    </div>
     <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
