<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
    
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    
    <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
      <link href="${pageContext.request.contextPath}/css/admin/adminSales.css" rel="stylesheet" />
  </head>
  <bod>
  <jsp:include page="../layout/header.jsp" />
    <div id="modakbul-outer-wrapper">
     
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
            <div class="modakbul-sales-data-graph">
            
            <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
         <canvas id="myChart" width="600" height="500"></canvas>
            <script type="text/javascript">
            
            $(function(){
               
               let getGatherMonth = [];
              let getTotal = [];
              
              <c:forEach items="${selectBidTotal}" var="list">
               var month = '${list.getGatherMonth()}';
               var Total = '${list.getTotal()}';
                   
                   
               getGatherMonth.push(month);
               getTotal.push(Total);
                   
                   
               </c:forEach>
              var context = document
                .getElementById('myChart')
                .getContext('2d');
              
              var myChart = new Chart(context,{
            type: 'bar',
            data: {
              labels: getGatherMonth,
              datasets: [{ 
                  data: getTotal,
                  label: "모임 수익",
                 
                  fill: false,
                  backgroundColor: "#b9b9ff"
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
            <table class="modakbul-sales-data-table">
              <tr class="table-header">
                <td>월</td>
                <td>매출</td>
                <td>수수료(수익)</td>
              </tr>
         <c:forEach items="${requestScope.selectBidTotal}" var="data">
            <tr align="center"><!-- 첫번째 줄 시작 -->
                <td>${data.getGatherMonth()}</td>
                <td><fmt:formatNumber type="number" value="${data.getTotal()}" maxFractionDigits="3"/>원</td>
                <td><fmt:formatNumber type="number" value="${data.getTotal()/10}" maxFractionDigits="3"/>원</td>
            </tr><!-- 첫번째 줄 끝 -->
         </c:forEach>
            </table>
          </div>
          <div class="modakbul-sales-data">
            <div class="modakbul-sales-data-graph">
            <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
         <canvas id="myChart2" width="600" height="500"></canvas>
            <script type="text/javascript">
$(function(){
   

      
      let month = [];
      let adCount = [];
      let totalPrice = [];
      <c:forEach items="${selectAdTotalPrice}" var="list">
           var m = '${list.getMonth()}';
           var c = '${list.getAdCount()}';
           var t = '${list.getTotalPrice()}';
           
           month.push(m);
           adCount.push(c);
           totalPrice.push(t);
       </c:forEach>
      
      
      
      var context = document
        .getElementById('myChart2')
        .getContext('2d');
      
      var myChart = new Chart(context,{
    type: 'bar',
    data: {
      labels: month,
      datasets: [{ 
          data: adCount,
          label: "광고수",
          borderColor: "#f37c1b",
          fill: true,
          backgroundColor:"f37c1b",
         
          borderWidth: 3
        }, {
        type: 'line',
          data: totalPrice,
          label: "광고 매출",
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

   <table class="modakbul-sales-data-table">
   
        <tr class="table-header">
              <td>월</td>
            <td>광고수</td>
            <td>수수료(수익)</td>
        </tr>
   <c:forEach items="${requestScope.selectAdTotalPrice}" var="data">
      <tr align="center"><!-- 첫번째 줄 시작 -->
          <td>${data.getMonth()}</td>
          <td>${data.getAdCount()}개</td>
          <td><fmt:formatNumber type="number" value="${data.getTotalPrice()}" maxFractionDigits="3"/>원</td>
      </tr><!-- 첫번째 줄 끝 -->
   </c:forEach>

   </table>
          </div>
          <!-- 여기까지 Content -->
        </div>
      </div>
    </div>
     <jsp:include page="../layout/footer.jsp" />
  </body>
</html>