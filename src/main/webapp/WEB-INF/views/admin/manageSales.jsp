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
   	<link href="${pageContext.request.contextPath}/css/admin/adminSales.css" rel="stylesheet" />
  </head>
  <body>
    <div id="modakbul-outer-wrapper">
     <jsp:include page="../layout/header.jsp" />
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu">
           <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdvAll'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content flex">
          <!-- 여기에 내용 넣으면 됨. -->
          <div class="modakbul-sales-data">
            <div class="modakbul-sales-data-graph"></div>
            <table class="modakbul-sales-data-table">
              <tr class="table-header">
                <td>월</td>
                <td>매출</td>
                <td>수수료(수익)</td>
              </tr>
              <tr>
                <td>1</td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td>2</td>
                <td></td>
                <td></td>
              </tr>
            </table>
          </div>
          <div class="modakbul-sales-data">
            <div class="modakbul-sales-data-graph"></div>
            <table class="modakbul-sales-data-table">
              <tr class="table-header">
                <td>월</td>
                <td>매출</td>
                <td>수수료(수익)</td>
              </tr>
              <tr>
                <td>1</td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td>2</td>
                <td></td>
                <td></td>
              </tr>
            </table>
          </div>
          <!-- 여기까지 Content -->
        </div>
      </div>
    </div>
     <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
