<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
<canvas id="myChart" width="500" height="200"></canvas>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

$(function(){
	

		
		let x = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
		let y = [0,0,0,0,0,0,0,0,0,0,0,${selectGatherBid1}*5];
		
		
		
		var context = document
        .getElementById('myChart')
        .getContext('2d');
		
		var myChart = new Chart(context,{
    type: 'line',
    data: {
      labels: x,
      datasets: [{ 
          data: y,
          label: "모임 매출",
          borderColor: "#3e95cd",
          fill: false
        }, { 
          data: [123,350,411,502,635,809,947,1402,3700,5267,3252,123],
          label: "모임 수수료",
          borderColor: "#8e5ea2",
          fill: false
        }
      ]
    },
    options: {
      title: {
        display: true,
        text: 'World population per region (in millions)'
      }
    }
  })
	

})

  
</script>
</head>
<body>



</body>
</html>