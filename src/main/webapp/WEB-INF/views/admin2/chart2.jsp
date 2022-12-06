<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

$(function(){
	

		
		let x = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
		
		let y = [${fn:length(selectAdStatusIng1)},
			${fn:length(selectAdStatusIng2)},
			${fn:length(selectAdStatusIng3)},
			${fn:length(selectAdStatusIng4)},
			${fn:length(selectAdStatusIng5)},
			${fn:length(selectAdStatusIng6)},
			${fn:length(selectAdStatusIng7)},
			${fn:length(selectAdStatusIng8)},
			${fn:length(selectAdStatusIng9)},
			${fn:length(selectAdStatusIng10)},
			${fn:length(selectAdStatusIng11)},
			${fn:length(selectAdStatusIng12)}];
		
		let y2 = [${fn:length(selectAdStatusIng1)*300000},
			${fn:length(selectAdStatusIng2)*300000},
			${fn:length(selectAdStatusIng3)*300000},
			${fn:length(selectAdStatusIng4)*300000},
			${fn:length(selectAdStatusIng5)*300000},
			${fn:length(selectAdStatusIng6)*300000},
			${fn:length(selectAdStatusIng7)*300000},
			${fn:length(selectAdStatusIng8)*300000},
			${fn:length(selectAdStatusIng9)*300000},
			${fn:length(selectAdStatusIng10)*300000},
			${fn:length(selectAdStatusIng11)*300000},
			${fn:length(selectAdStatusIng12)*300000}
			];
		
		
		
		var context = document
        .getElementById('myChart')
        .getContext('2d');
		
		var myChart = new Chart(context,{
    type: 'bar',
    data: {
      labels: x,
      datasets: [{ 
          data: y,
          label: "광고수",
          borderColor: "#3e95cd",
          fill: false,
          borderWidth: 3
        }, {
        type: 'line',
          data: y2,
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
	<th>월</th>
	<th>광고수(개)</th>
	<th>광고 매출(원)</th>
	<tr><!-- 첫번째 줄 시작 -->
	    <td>1월</td>
	    <td>${fn:length(selectAdStatusIng1)}</td>
	    <td>${fn:length(selectAdStatusIng1)*300000}</td>
	</tr><!-- 첫번째 줄 끝 -->
	<tr>
	    <td>2월</td>
	    <td>${fn:length(selectAdStatusIng2)}</td>
	    <td>${fn:length(selectAdStatusIng2)*300000}</td>
	</tr>
	<tr>
	    <td>3월</td>
	    <td>${fn:length(selectAdStatusIng3)}</td>
	    <td>${fn:length(selectAdStatusIng3)*300000}</td>
	</tr>
	<tr>
	    <td>3월</td>
	    <td>${fn:length(selectAdStatusIng3)}</td>
	    <td>${fn:length(selectAdStatusIng3)*300000}</td>
	</tr>
	<tr>
	    <td>4월</td>
	    <td>${fn:length(selectAdStatusIng4)}</td>
	    <td>${fn:length(selectAdStatusIng4)*300000}</td>
	</tr>
	<tr>
	    <td>5월</td>
	    <td>${fn:length(selectAdStatusIng5)}</td>
	    <td>${fn:length(selectAdStatusIng5)*300000}</td>
	</tr>
	<tr>
	    <td>6월</td>
	    <td>${fn:length(selectAdStatusIng6)}</td>
	    <td>${fn:length(selectAdStatusIng6)*300000}</td>
	</tr>
	<tr>
	    <td>7월</td>
	    <td>${fn:length(selectAdStatusIng7)}</td>
	    <td>${fn:length(selectAdStatusIng7)*300000}</td>
	</tr>
	<tr>
	    <td>8월</td>
	    <td>${fn:length(selectAdStatusIng8)}</td>
	    <td>${fn:length(selectAdStatusIng8)*300000}</td>
	</tr>
	<tr>
	    <td>9월</td>
	    <td>${fn:length(selectAdStatusIng9)}</td>
	    <td>${fn:length(selectAdStatusIng9)*300000}</td>
	</tr>
	<tr>
	    <td>10월</td>
	    <td>${fn:length(selectAdStatusIng10)}</td>
	    <td>${fn:length(selectAdStatusIng10)*300000}</td>
	</tr>
	<tr>
	    <td>11월</td>
	    <td>${fn:length(selectAdStatusIng11)}</td>
	    <td>${fn:length(selectAdStatusIng11)*300000}</td>
	</tr>
	<tr>
	    <td>12월</td>
	    <td>${fn:length(selectAdStatusIng12)}</td>
	    <td>${fn:length(selectAdStatusIng12)*300000}</td>
	</tr>
	
</table>
    
</body>
</html>