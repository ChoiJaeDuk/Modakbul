<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
<canvas id="line-chart" width="150" height="100"></canvas>
<script>
  new Chart(document.getElementById("line-chart"), {
    type: 'line',
    data: {
      labels: [1,2,3,4,5,6,7,8,9,10,11,12],
      datasets: [{ 
          data: [${gatherLit},114,106,106,107,111,133,221,783,2478],
          label: "모임 매출",
          borderColor: "#3e95cd",
          fill: false
        }, { 
          data: [282,350,411,502,635,809,947,1402,3700,5267],
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
  });
</script>
</head>
<body>



</body>
</html>