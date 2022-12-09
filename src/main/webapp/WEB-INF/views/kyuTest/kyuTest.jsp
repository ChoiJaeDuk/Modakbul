<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>

<script type="text/javascript">
$(function(){

	$(document).ajaxSend(function(e,xht,op){
         xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
      });

	$(document).on("click", ".gatherReview", function () {
	
		
		let t={'regularGatherNo': $(this).val()}
			console.log(t)
			
		$.ajax({
			url:"${pageContext.request.contextPath}/kyuTest/kyuTest/gr", //서버 요청주소
			type: "post",  //요청방식 (get,post, put,, delete, patch)
			dataType: "json", //서버가 응답(보내온)한 데이터 타입 (text, html, xml, json)
			data : t,
			success: function(result){
				console.log("길이 ="+result.pageList.length)
				
				if(result.pageList.length>0){
					let gatherReviewList=result.pageList;
					let nameList = result.nameList;
					
					let tr='<thead>'+
	        	    '<tr>' +
	                '<th>등록일</th>'+
	                '<th>작성자</th>'+
	                '<th>후기내용 </th>'+
	         	    '</tr>'+
	            '</thead>';
					$.each(gatherReviewList , function(i){
				          tr += '<tr><td>' +  gatherReviewList[i].reviewRegisDate + '</td>'+'<td>'+gatherReviewList.writerUser+ '</td>'+'<td>'+ gatherReviewList[i].gatherReviewContent + '</td></tr>';
					})
				          
					
			       
					$("#tbodyGatherReview").empty();
					$("#tbodyGatherReview").append(tr);
					
				}else{
					
					let tr='<thead>'+
					'<td colspan="5"><p align="center"><b><span style="font-size:9pt;">등록된 게시물이 없습니다.</span></b></p></td></tr></thead>'
					$("#tbodyGatherReview").empty();
					$("#tbodyGatherReview").append(tr);
				}
				
			},error: function(err){
				
				alert(err+"에러 발생 !! ");
				
			}
			});


	})
})
</script>

</head>
<body>
<h1>정기모임 모임후기 조회  일일모임은 모임후기없듬</h1>
<button type="button" class="gatherReview" value="1">모임후기조회</button>

<table align="center" border="0" cellpadding="5" cellspacing="2" width="100%" bordercolordark="white" bordercolorlight="black">
	<tr>
        <td bgcolor="#00cc00">
            <p align="center">
            <font color="white"><b><span style="font-size:9pt;">등록일</span></b></font></p>
        </td>
        <td bgcolor="#00cc00">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">작성자</span></b></font></p>
        </td>
       
        <td bgcolor="#00cc00">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">후기내용</span></b></font></p>
        </td>
    </tr>
  <%--   <c:choose>
    <c:when test="${empty requestScope.pageList}"> --%>
	
<%--     </c:when>
    <c:otherwise> --%>
	<tbody id="tbodyGatherReview">
		    
	 </tbody>   
<%-- 	</c:otherwise>
    </c:choose> --%>
   
</table>








<h1>일일모임의 주최자 후기조회</h1>

<a href="${pageContext.request.contextPath}/kyuTest/kyuTest/ur">유저후기조회</a>


<table align="center" border="0" cellpadding="5" cellspacing="2" width="100%" bordercolordark="white" bordercolorlight="black">
	<tr>
        <td bgcolor="#00cc00">
            <p align="center">
            <font color="white"><b><span style="font-size:9pt;">호스트유저이름</span></b></font></p>
        </td>
        <td bgcolor="#00cc00">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">온도</span></b></font></p>
        </td>
       
        <td bgcolor="#00cc00">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">진행수 </span></b></font></p>
        </td>
        <td bgcolor="#00cc00">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">후기내용</span></b></font></p>
        </td>
        
    </tr>
    <c:choose>
    <c:when test="${empty requestScope.userReviewList}">
	<tr>
        <td colspan="5">
            <p align="center"><b><span style="font-size:9pt;">등록된 게시물이 없습니다.</span></b></p>
        </td>
    </tr>
    </c:when>
    <c:otherwise>
	<c:forEach items="${requestScope.userReviewList}" var="ur">
		    <tr onmouseover="this.style.background='#eaeaea'" onmouseout="this.style.background='white'">
		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${ur.hostUser.userName}</span></p>
		        </td>
		        <td bgcolor="">
					<p><span style="font-size:9pt;">
					  ${ur.userTemper} /  R </b>
					</span></p>
		        </td>

		        <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            진행횟수 불러오는 법 ㅎ</span></p>
		        </td>
		         <td bgcolor="">
		            <p align="center"><span style="font-size:9pt;">
		            ${ur.userReviewContent}</span></p>
		        </td>
		    </tr>
    </c:forEach>
	</c:otherwise>
    </c:choose>
</table>

</body>
</html>