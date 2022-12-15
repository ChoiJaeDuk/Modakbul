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
<canvas id="myChart" width="500" height="300" ></canvas>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
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
      labels: gatherCategory,
      datasets: [{ 
          data: gatherCount,
          label: "카테고리별 모임 개수",
          borderColor: "#3e95cd",
          fill: false,
          borderWidth: 3
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

</body>
</html>