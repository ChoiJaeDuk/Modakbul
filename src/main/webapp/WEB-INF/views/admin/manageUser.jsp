<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
	 <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
  <body>
    <div id="modakbul-outer-wrapper">
     <jsp:include page="./header.jsp" />
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageUser'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdv'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
        
		 <div class="cont-wrap">
			<div class="nav-wrap">
				<div id="nav1"><a href="#">전체</a></div>
				<div id="nav2"><a href="#">개인회원</a></div>
				<div id="nav3"><a href="#">기관/사업자</a></div>
				<div id="nav4"><a href="#">모임관리</a></div>
			</div>
			
			<div id="allUser" class="content">
				<table>
					<tr class="table-header">
						<th>진행중인 모닥불 : </th>
						<th>모닥불 회원 : ${count }명</th>
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
			
			<div id="indivUser" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>ID</th>
						<th>닉네임</th>
						<th>성별</th>
						<th>연령</th>
						<th>E-Mail</th>
						<th>구분</th>
						<th>팔로워 수</th>
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
					</tr>
					
				</table>
			</div>
			
			<div id="comUser" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>ID</th>
						<th>기관명</th>
						<th>사업자번호</th>
						<th>E-Mail</th>
						<th>구분</th>
						<th>팔로워 수</th>
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
			
			<div id="gather" class="content">
				<table>
					<tr class="table-header">
						<th>NO</th>
						<th>모임</th>
						<th>모임명</th>
						<th>주최자</th>
						<th>구분</th>
						<th>등록일</th>
						<th>모임일</th>
						<th>모임상태</th>
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
					</tr>
					
				</table>
			</div>
		</div>
	
        </div>
      </div>
    </div>
  </body>
</html>
