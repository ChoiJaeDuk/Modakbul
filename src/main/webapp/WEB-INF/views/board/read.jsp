<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<HEAD>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
<SCRIPT language=javascript>
   $(function(){
	   //alert(1)
	   $("input[value=수정하기]").click(function(){
		   //document.requestForm.action="${pageContext.request.contextPath}/board/updateForm";
		   
		   $("#requestForm").attr("action", "${pageContext.request.contextPath}/board/updateForm");
		   $("#requestForm").submit();
	   })
	   
	   
	   $("input[value=삭제하기]").click(function(){
		   var pwd = prompt("비밀번호를 입력하세요.");
		   if(pwd){
	           $("#password").val(pwd);
			   $("#requestForm").attr("action", "${pageContext.request.contextPath}/board/delete");
			   $("#requestForm").submit();
		   }
	   })
	   
	   $("input[value=답변하기]").click(function(){
		   //document.requestForm.action="${pageContext.request.contextPath}/board/updateForm";
		   
		   $("#requestForm").attr("action", "${pageContext.request.contextPath}/reply/writeForm");
		   $("#requestForm").submit();
	   })
	   
   })
</script>


</HEAD>


<table align="center" cellpadding="5" cellspacing="2" width="600" border='1'>
    <tr>
        <td width="1220" height="20" colspan="4" bgcolor="#00cc00">
            <p align="center"><font color="white" size="3"><b>
             게시물 자세히보기</b></font></p>
        </td>
    </tr>
    <tr>
        <td width="100" height="20" >
            <p align="right"><b><span style="font-size:9pt;">번호</span></b></p>
        </td>
        <td width="450" height="20" colspan="3">
        	<span style="font-size:9pt;"><b>${board.bno}</b></span>
        </td>
    </tr>
    <tr>
        <td width="100" height="20" >
            <p align="right"><b><span style="font-size:9pt;">등록일</span></b></p>
        </td>
        <td width="300" height="20">
        	<span style="font-size:9pt;"><b>${requestScope.board.insertDate}</b></span>
        </td>
        <td width="100" height="20" >
			<p align="right"><b><span style="font-size:9pt;">조회수</span></b></p>
		</td>
        <td width="100" height="20">
			<p><b><span style="font-size:9pt;"></span>${requestScope.board.readnum}</b></p>
		</td>
    </tr>
    <tr>
        <td width="100" height="20">
            <p align="right"><b><span style="font-size:9pt;">제목</span></b></p>
        </td>
        <td width="450" height="20" colspan="3">
        	<span style="font-size:9pt;"><b>${requestScope.board.subject}</b></span>
        </td>
    </tr>
    <tr>
		<td width="100" height="200" valign="top">
            <p align="right"><b><span style="font-size:9pt;">설명</span></b></p>
        </td>
		<!-- 브라우저에 글 내용을 뿌려줄 때는 개행문자(\n)가 <br>태그로 변환된 문자열을 보여줘야 한다. -->
        <td width="450" height="200" valign="top" colspan="3">
        <span style="font-size:9pt;"><b><pre>${requestScope.board.content}</pre></b></span></td>
    </tr>
    
      
    <tr>
        <td height="20" colspan="4" align="center" valign="middle">
			<!-- 수정시 필요한 데이터들을 hidden으로 숨겨놓고 폼 데이터로 보내준다. -->
			<form name="requestForm" method="post" id="requestForm">
				<input type=hidden name="bno" value="${board.bno}">
				<input type=hidden name="password" value="" id="password">
				<input type=button value="수정하기" >
				<input type=button value="삭제하기" >
				<input type=button value="답변하기" >
			</form>
		</td>
    </tr>
</table>
<h3> Reply INFO </h3>

<%-- 
<c:forEach items="${board.replyList}" var="reply" varStatus="state">
    ${state.count}순서 / ${reply.rno} = ${reply.content}  / ${reply.insertDate}
      <a href="${pageContext.request.contextPath}/reply/delete/${reply.rno}/${board.bno}">삭제</a> 
  <p>

</c:forEach>  --%>


<hr>
<div align=right><span style="font-size:9pt;">&lt;<a href="${pageContext.request.contextPath}/board/list">리스트로 돌아가기</a>&gt;</span></div>








