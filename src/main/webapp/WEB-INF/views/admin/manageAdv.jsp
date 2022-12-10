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
     <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
  <body>
    <div id="modakbul-outer-wrapper">
      <jsp:include page="./header.jsp" />
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageUser'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdv'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
          
		<div class="cont-wrap">
			<div class="ad-wrap">
				<div class="ad">현재 진행중 광고 : 1</div>
				<div class="ad">현재 신청대기 광고 : 1</div>
				<div class="ad">종료된 광고 : 1</div>
			</div>
	
			<div class="nav-wrap">
				<div id="nav1"><a href="#">전체</a></div>
				<div id="nav2"><a href="#">신청대기</a></div>
				<div id="nav3"><a href="#">진행중</a></div>
				<div id="nav4"><a href="#">종료</a></div>
			</div>
			
			<div id="advAll" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>이미지</th>
						<th>모임명</th>
						<th>신청자</th>
						<th>구분</th>
						<th>개월</th>
						<th>광고상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
			</div>
			
			<div id="advRegis" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>이미지</th>
						<th>모임명</th>
						<th>신청자</th>
						<th>구분</th>
						<th>신청일</th>
						<th>광고상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
			</div>
			
			<div id="advIng" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>이미지</th>
						<th>모임명</th>
						<th>신청자</th>
						<th>구분</th>
						<th>개월</th>
						<th>광고상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
			</div>
			
			<div id="advEnd" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>이미지</th>
						<th>모임명</th>
						<th>신청자</th>
						<th>구분</th>
						<th>등록일</th>
						<th>종료일</th>
						<th>개월</th>
						<th>광고상태</th>
					</tr>
					<tr>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
						<td>111</td>
					</tr>
					
				</table>
			</div>
			
			
		</div>

        </div>
      </div>
    </div>
  </body>
</html>
