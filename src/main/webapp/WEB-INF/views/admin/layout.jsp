<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
  <body>
    <div id="modakbul-outer-wrapper">
      <header id="modakbul-header" class="flex">
        <div class="modakbul-header-left flex">
          <img src="${pageContext.request.contextPath}/css/icon.png" alt="modakbul-icon" />
          <h1 class="modakbul-title">MODAKBUL</h1>
        </div>
        <div class="modakbul-header-center flex">
          <p class="modakbul-header-menu header-selected">메뉴</p>
          <p class="modakbul-header-menu">메뉴</p>
          <p class="modakbul-header-menu">메뉴</p>
          <p class="modakbul-header-menu">메뉴</p>
        </div>
        <div class="modakbul-header-right">
          <h3>관리자 모드</h3>
        </div>
      </header>
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu navigation-selected">
            <p>운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p>유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p>매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p>광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
          <!-- 여기에 내용 넣으면 됨. -->
        </div>
      </div>
    </div>
  </body>
</html>
