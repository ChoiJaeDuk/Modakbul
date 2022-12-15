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
  <header>
   <tiles:insertAttribute name="header"/>     
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
        <tiles:insertAttribute name="content"/>
          <!-- 여기에 내용 넣으면 됨. -->
        </div>

      </div>

  </body>
  <tiles:insertAttribute name="footer"/>
</html>
