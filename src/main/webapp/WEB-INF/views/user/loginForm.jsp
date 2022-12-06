<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/css/loginForm/index.css" rel="stylesheet" />
    <title>Document</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
	<script type="text/javascript">
	$(function(){
		//alert(1)
		$("#findId").click(function(){
			//document.getElementById("findIdForm1").style.display="";
			//document.getElementById("findIdForm2").style.display="";
			//$("#findIdForm").show("2000");
			//alert(11);
		})
		
		$("#findIdBtn").click(function(){
			
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/selectUserId",
				data: {"email":$("#email").val()},
				
				dataType:"text",
				success:function(result){
					
					 var data = result;
					 console.log(data);
					 $("#selectId").html(data);	

				},//function
				error:function(error){
					
				}
				
			});//ajax
		})
		
		 $("#findPwdBtn").click(function(){
			console.log($("#idForPwd").val() )
			
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/selectUserPwd",
				data: 
					//"${_csrf.parameterName}=${_csrf.token}&address="+$('#address').val(),+"&id="+$("#idForPwd").val(), 
					"${_csrf.parameterName}=${_csrf.token}&email="+$('#emailForPwd').val()+"&id="+$("#idForPwd").val()

				,
				
				dataType:"text",
				success:function(result){
					 
					 var data = result;
					 console.log(data);
					 //$("#selectId").html(data);	
					 alert(data);

				},//function
				error:function(error){
					
				}
				
			});//ajax
		}) 
	})

	
	</script>

    
  </head>
  <body>
    <div id="wrap">
      <main class="login-wrap">
        <div class="login-logo-wrap">
          <img class="login-logo-image" src="/img/assets/logo.png" />
          <h1 class="login-logo-title">MODAKBUL</h1>
        </div>
        <div>
          <form class="login-form" action="${pageContext.request.contextPath}/user/loginCheck" method="post">
            <div>
              <div class="login-form-item-wrap">
                <label for="id" class="form-label">ID</label>
                <input id="id" name="id" class="form-input" placeholder="���̵� �Է�" />
              </div>
              <div class="login-form-item-wrap">
                <label for="pwd" class="form-label">PW</label>
                <input type="password"id="pwd" name="pwd" class="form-input" placeholder="��й�ȣ �Է�" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
              </div>
            </div>
            <div>
              <button class="login-button" type="submit">�α���</button>
            </div>
          </form>
          <div class="option-wrap">
            <div class="option-item"><a id="findId" href="">���̵� ã��</a></div>
            <div class="option-item"><a>��й�ȣ ã��</a></div>
            <div class="option-item"><a id="f" href="">ȸ������</a></div>
          </div>
          <div class="kakao-login-button-wrap">
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=14b0e31baeb3e5bc554c607d7293b85c&redirect_uri=http://localhost:9000/auth/kakao/callback&response_type=code">
            <img class="kakao-login-button" src="/img/assets/kakao-login.png" />
            </a>
          </div>
        </div>
      </main>
      <!-- ���̵� ã�� -->
  		<div class="modal-wrap" id="findIdForm" style="display: none"> 
        <div>
          <div class="modal-input-wrap">
            <label class="modal-input-label" for="">E-mail</label>
            <input class="modal-input" placeholder="�̸��� �Է�" id="email"/>
          </div>
        </div>
        <div class="search-id-result" id="selectId"></div>
        <div class="modal-button-wrap">
          <button class="modal-button cancel-button">�ݱ�</button>
          <button class="modal-button search-id-button" id="findIdBtn" >���̵� ã��</button>
        </div>
      </div>
      <!-- ��й�ȣ ã�� -->
      <div class="modal-wrap"> 
        <div>
       
          <div class="modal-input-wrap" >
            <label class="modal-input-label" for="">ID</label>
            <input class="modal-input" placeholder="�̸��� �Է�" id="idForPwd"/>
          </div>
          <div class="modal-input-wrap">
            <label class="modal-input-label" for="">E-mail</label>
            <input class="modal-input" placeholder="�̸��� �Է�" id="emailForPwd"/>
          </div>
        </div>
        <div class="modal-button-wrap">
          <button type="button" class="modal-button cancel-button">�ݱ�</button>
          <button type="button" class="modal-button search-id-button" id="findPwdBtn">
            ��й�ȣ ã��
          </button>
         
        </div>
      </div>
      <!-- �Ϸ� �˾� -->
      <div class="modal-wrap" style="display: none">
        <div class="modal-text">
          �ش� �̸��Ϸ� �ӽ� ��й�ȣ��<br />���۵Ǿ����ϴ�.
        </div>
        <div class="modal-button-wrap">
          <div></div>
          <button type="button" class="modal-button cancel-button">�ݱ�</button>
        </div>
      </div>
      <!-- ��� ���� ���� ��� -->
      <div class="modal-wrap" style="display: none">
        <div class="modal-sign-up-button-wrap">
          <button class="sign-up-agency-button">���/�����</button>
          <button class="sign-up-individual-button">����</button>
        </div>
        <div class="modal-button-wrap">
          <div></div>
          <button type="button" class="modal-button cancel-button">�ݱ�</button>
          <div></div>
        </div>
      </div>
    </div>
  </body>
</html>