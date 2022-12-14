<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 목록</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(function(){
		//alert(11111111);	
		// 토글
		$(document).ajaxSend(function(e,xht,op){
         xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
      	});
		
		$(document).on('click', 'button[type=button]',function(){
			
			let target = {"gatherNo":$(this).val() , "userNo":"${userNo}"}
			let targetBtn = $(this);
			
			if($(this).text() == "♥"){
				alert("딜리트 반응?");
				$.ajax({
					url:"${pageContext.request.contextPath}/likeGather/delete",
					type:"post",
					dataType:"text",
                    data:JSON.stringify(target),   
                    contentType:'application/json;charset=utf-8',
					success:function(result){
						if(result=="ok"){
							alert("관심모임 해제 되었습니다.")						
							
							targetBtn.text("♡")
						}
					},error:function(err){
						alert("err : "+err);
					}
				});//Delete ajax END
			}
			
			if($(this).text()=="♡"){
				alert("인설트반응?");
				$.ajax({
					url:"${pageContext.request.contextPath}/likeGather/insert",
					type:"post",
					dataType:"text",
                    data:JSON.stringify(target),   
                    contentType:'application/json;charset=utf-8',
					success:function(result){
						if(result=="ok"){
							alert("관심모임 등록 되었습니다.")						
							
							targetBtn.text("♥")
						}
						
					},error:function(err){
						alert("err : "+err);
					}
				});//Insert ajax END
			}
		});//click END
		
	});
});
	
</script>
</head>
<body>
<h3>모임 리스트</h3>
<table id="table">
	<tr>
		<th>모임번호</th>
		<th>모임이름</th>
		<th>카테고리</th>
		<th>주최자</th>	
	 	<th>♥♡</th>
	</tr>
<c:forEach items="${pageList.content}" var="ga">
	<tr>
		<td>${ga.gatherNo}</td>
		<td>${ga.gatherName}</td>
		<td>${ga.category.categoryName}</td>
		<td>${ga.user.userNick}</td><p>
		<td><button type="button" name="like" id="${ga.gatherNo}" value="${ga.gatherNo}">♡</button></td>
	</tr>
</c:forEach>
</table>
</body>
</html>