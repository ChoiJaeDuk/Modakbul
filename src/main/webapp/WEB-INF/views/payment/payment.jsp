<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(function() {
		
		
		$("#a").click(function(){				
			alert(1)
			/* if($("#address").val()==""){
				return;	
			} */
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/ajaxTest",
				data:"${_csrf.parameterName}=${_csrf.token}",
				dataType:"text",
				success:function(result){
					alert(1231)
					 /* var data="<table border='1' cellpadding='5'>";
					 $.each(result, function(index, item){
						 data+="<tr>";
							data+="<td>"+item.id+"</td>";
							data+="<td>"+item.name+"</td>";
							data+="</tr>";
					 }) 
					data+="</table>"; */
					
					//$("#memberListView").html(data);	
					
									
				}//function
			});//ajax
		});//click 
		
		////////////////////////////////////
		
		$(document).ajaxSend(function(e,xht,op){
			xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
		});
		

		$("#kakaopyBtn")
				.click(
						function() {

							var IMP = window.IMP;
							IMP.init('imp55744106');
							IMP.request_pay(
											{
												pg : "kakaopay",
												pay_method : 'card',
												merchant_uid : 'merchant_'
														+ new Date().getTime(),
												name : '상품명',
												amount : '1', //총판매가격
												buyer_email : 'kyucando@gmail.com',
												buyer_name : '규야 ',
												buyer_tel : '01085510356',
												buyer_addr : '경기도 용인시 ',
												buyer_postcode : '01234',
												//m_redirect_url : '/index.jsp'
											},
											function(rsp) {
												if (rsp.success) {
													var msg = '결제가 완료되었습니다.';
													var result = {
													"imp_uid" : rsp.imp_uid,													
			 										"pay_date" : new Date().getTime(),
													"amount" : rsp.paid_amount,
													"buyer_name": rsp.buyer_name
													
											     }
													
													//console.log("result = " + result.imp_uid);
													//alert("${_csrf.parameterName}")
													//alert("${_csrf.token}")
													
													$.ajax({
														type : "post",
														url : "${pageContext.request.contextPath}/ajaxTest",  
														dataType:"text",
												   		data:JSON.stringify(result),	
												        contentType:'application/json;charset=utf-8',
												        success : function(result) {
												        location.href="${pageContext.request.contextPath}/success";
														alert("결제됐어요~!]")
												        },
														error : function(err) {
															alert(err);
														}
													});
											
												} else {
													var msg = '결제에 실패하였습니다.';
													rsp.error_msg;
													alert(msg);
												}
											});
						});
	});
});
</script>
</head>
<body>
	<H1>결제 imp55744106</H1>
	
	<button type="button" class="kakaopay" id="kakaopyBtn">
	결제버튼
	</button>
	
	
	
	<H1>아작스테스트 버튼</H1>
	<button type="button" class="a" id="a">
		아작스테스트
	</button>
	

	
	
</body>
</html>