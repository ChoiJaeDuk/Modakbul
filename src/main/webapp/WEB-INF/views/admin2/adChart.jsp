<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<script
	src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
<canvas id="myChart" width="700" height="400"></canvas>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
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
        .getElementById('myChart')
        .getContext('2d');
		
		var myChart = new Chart(context,{
    type: 'bar',
    data: {
      labels: month,
      datasets: [{ 
          data: adCount,
          label: "광고수",
          borderColor: "#3e95cd",
          fill: false,
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
</head>
<body>

	<table border="1">
		<c:forEach items="${requestScope.selectAdTotalPrice}" var="data">
		<tr><!-- 첫번째 줄 시작 -->
	    	<td>${data.getMonth()}월</td>
	    	<td>${data.getAdCount()}개</td>
	    	<td>${data.getTotalPrice()}원</td>
		</tr><!-- 첫번째 줄 끝 -->
		</c:forEach>

	</table>

</body>
</html>