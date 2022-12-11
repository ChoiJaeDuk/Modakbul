<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
	 <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminPaging.css" rel="stylesheet" />
    
  <body>
   <jsp:include page="../layout/header.jsp" />
    <div id="modakbul-outer-wrapper">
    
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
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
        
		 <div class="cont-wrap">
			<div class="nav-wrap">
				<div id="nav1"><a href="${pageContext.request.contextPath}/admin/manageAll" >전체</a></div>
				<div id="nav2"><a href="${pageContext.request.contextPath}/admin/manageIndiv?job=개인">개인회원</a></div>
				<div id="nav3"><a href="${pageContext.request.contextPath}/admin/manageCom?job=기관">기관/사업자</a></div>
				<div id="nav4"><a href="${pageContext.request.contextPath}/admin/manageGroup">모임관리</a></div>
			</div>
			
			<div class="content current" >
				<table>
					<tr class="table-header">
						<th class = "count">진행중인 모닥불 : </th>
						<th class="count">모닥불 회원 : ${count }명</th>
					</tr>
					<tr>
						<td>
							<div id="chart1">차트1</div>
							카테고리별 모임수, 전체 모임수 등
						</td>
						<td>
							<div id="chart2">차트2</div>
							월별 회원수 그래프
						</td>
					</tr>
				</table>
	 		</div>
			
			
			
		</div>
	
        </div>
        
      </div>
    
   
    </div>
    
 
  </body>
  <jsp:include page="../layout/footer.jsp" />
</html>
