<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심모임</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		//alert(11111111);	
		// 토글
		$(document).on('click', 'button[type=button]',function(){
			if($(this).text() == "♥"){
				alert(22222);
				$.ajax({
					url:"${pageContext.request.contextPath}/likeGather/delete",
					type:"post",
					data:"attentionNo="+$(this).val(),
					dataType:"json",
					success:function(result){
						alert("관심모임 해제 되었습니다.");
						$(this).text("♡");
					},error:function(err){
						alert("err : "+err);
					}
				});//Delete ajax END
			}
			
			//$("#table > tbody > tr > td:nth-child(0)").text()
			if($(this).text()=="♡"){
				$.ajax({
					url:"${pageContext.request.contextPath}/likeGather/insert",
					type:"post",
					data:{gatherNo:$("#table > tbody > tr > td:nth-child(0)").text() , userNo:"${userNo}"},
					dataType:"json",
					success:function(result){
						alert("관심모임 등록 되었습니다.");
						$(this).text("♥");
					},error:function(err){
						alert("err : "+err);
					}
				});//Insert ajax END
			}
		});//click END
		
	});
	
</script>

</head>
<body>

<h3> 관심모임 목록 </h3>
<hr color="blue">

<c:choose>
	<c:when test="${not empty myList}" >
	<table id="table">
		<tr>
	 		<th>모임번호</th>
	 		<th>모임이름</th>
	 		<th>모임장소</th>
	 		<th>카테고리</th>
	 		<th>등록일</th>
	 		<th>마감일</th>
	 		<th>모임일자</th>
	 		<th>개최자</th>
	 		<th>♥♡</th>
	 	</tr>
	<c:forEach items="${myList}" var="lg" >
		 <tr id="${lg.attentionNo}">
		 	<%-- <td><input type="hidden" value="${userNo}"> </td> --%>
		 	<td>${lg.gather.gatherNo}</td>
		 	<td>${lg.gather.gatherName}</td>
		 	<td>${lg.gather.gatherPlace}</td>
		 	<td>${lg.gather.category.categoryName}</td>
		 	<td>${lg.gather.gatherRegisDate}</td>
		 	<td>${lg.gather.gatherDeadline}</td>
		 	<td>${lg.gather.gatherDate}</td>
		 	<td>${lg.gather.user.userNick}</td>
		 	<td><button type="button" id="${lg.attentionNo}" value="${lg.attentionNo}">♥</button></td>
		 </tr>
	</c:forEach>
	</table>
	</c:when>
	<c:otherwise>
		<h4>관심모임이 없습니다.</h4>
	</c:otherwise>
</c:choose>



</body>
</html>