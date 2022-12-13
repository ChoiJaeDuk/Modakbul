<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
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
						<th class = "count">진행중인 모닥불 : ${fn:length(gatherList)}개</th>
						<th class="count">모닥불 회원 : ${count}명</th>
					</tr>
					<tr>
			<td>
			<div id="chart1" align="center">
			<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
			<canvas id="myChart" width="600" height="500"></canvas>
            <script type="text/javascript">
            
            $(function(){
            	

        		
        		let gatherCount = [];
        		let gatherCategory = [];
        		
        		<c:forEach items="${selectCategoryCount}" var="list">
                   var count = '${list.getGatherCount()}';
                   var category = '${list.getCategory()}';
                   
                   gatherCount.push(count);
                   gatherCategory.push(category);
                   
               </c:forEach>
        		var context = document
                .getElementById('myChart')
                .getContext('2d');
        		
        		var myChart = new Chart(context,{
            type: 'bar',
            data: {
              labels: ["스포츠", "클래스", "자유"],
              datasets: [{ 
                  data: gatherCount,
                  label: "카테고리별 모임 개수",
                  /* borderColor: "#3e95cd", */
                  backgroundColor: ["#b4e379", "#ffff35", "#ff9b9b" ],
                  fill: false
                
                }
              ]
            },
            options: {
            responsive: false,
              title: {
                display: true,
                text: 'World population per region (in millions)',
              }
            }
          })


        })
            
            </script>
							</div>
							카테고리별 모임수, 전체 모임수 등
						</td>
						<td>
						
			<div id="chart2" align="center">
							
			<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
			<canvas id="myChart2" width="600" height="500"></canvas>
            <script type="text/javascript">
			
			$(function(){
	
			let month = [];
			let userCount = [];
			let userTotalCount = [];
			
			<c:forEach items="${selectMonthCountUser}" var="list">
           var m = '${list.getMonth()}';
           var c = '${list.getUserCount()}';
           var t = '${list.getUserTotalCount()}';
           
           month.push(m);
           userCount.push(c);
           userTotalCount.push(t);
       		</c:forEach>
		
		
		
		var context = document
        .getElementById('myChart2')
        .getContext('2d');
		
		var myChart = new Chart(context,{
    type: 'line',
    data: {
      labels: month,
      datasets: [{ 
          data: userCount,
          label: "유저 월별 가입수",
          borderColor: "#3e95cd",
          fill: false,
          borderWidth: 3
        }, {
        type: 'line',
          data: userTotalCount,
          label: "유저 총합 증가수",
          borderColor: "#8e5ea2",
          fill: false
        }
      ]
    },
    options: {
    responsive: false,
      title: {
        display: true,
        text: 'World population per region (in millions)',
      }
    }
  })


})
			</script>
			
							</div>
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
