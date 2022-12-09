<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/css/joinForm/index.css" rel="stylesheet" />
    <link href="/css/joinForm/reset.css" rel="stylesheet" />
    <title>Document</title>
    <!-- daum 도로명주소 찾기 api -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
	<script type="text/javascript">
	
	//모든 공백 체크 정규식
	let empJ = /\s/g;
	//아이디 정규식
	//let idJ = /^[a-zA-Z]+[a-z0-9A-Z]{3,19}$/g;
	let idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/;  
	// 비밀번호 정규식
	let pwJ = /^[A-Za-z0-9]{4,12}$/;
	// 이름 정규식
	let nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
	// 이메일 검사 정규식
	let mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	// 휴대폰 번호 정규식
	let phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	let businessJ = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/
	
		$(function(){
			
$("#email").keyup(function(){
				
				$("#sendEmail").html("이메일 인증");
				
		
			})
			
			$("#id").keyup(function(){
				$("#checkId").html(" id 중복체크 ");
	
			})
			
			$("#sendEmail").click(function(){
				
				var email=$("#email").val()+"@"+$(".email-select option:selected").val();
				
				if( !mailJ.test( email ) ){
					alert("이메일을 다시 입력해주세요.");
					$("#email").val("");
					return;
		         }
				
				$(".modal-wrap").show();
			})
			
			$(".cancel-button").click(function(){
				
				
				$(".modal-wrap").hide();
			})
			
			
			$("#sendEmailBtn").click(function(){
				var email = $("#email").val()+"@";
				if($(".email-select option:selected").val()=="free"){
					email += $("#etc").val();
					console.log(email)
				}else{
					email += $(".email-select option:selected").val();
					console.log(email)
				}
				
				$("input[name='userEmail']").val(email);
			
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/sendCode",
					data: "${_csrf.parameterName}=${_csrf.token}&email="+email,			
					dataType:"text",
					success:function(result){
						if(result.length>8){
							alert(result);
							$(".modal-wrap").hide();
							$("#email").val("");
							return;
						}
						alert("인증코드가 전송되었습니다.");
						var data = "<input type='hidden' name='code' id='code' value='"+ result +"'>"
	
						 console.log(data);
						 $("#sendCode").html(data);	

					},//function
					error:function(error){
						
					}
					
				});//ajax
			})
			
			$("#checkCodeBtn").click(function(){
				console.log($("#checkEmail").val())
				console.log($("#code").val())
			
				
				if($("#code").val()==$("#checkEmail").val()){
					alert("성공");
					$("#sendEmail").html("인증완료");
					$(".modal-wrap").hide();
					
				}else{
					alert("인증코드를 다시 확인해주세요");
				}
				
				
			})
			
			$("#checkId").click(function(){
				var uid = document.getElementById("id").value;

				
				if($("#id").val().length == 0 ){
					alert("아이디를 입력해주세요.")
					return;
				}
				
				else if( !idJ.test( uid ) ){
					alert("아이디는 영소문자로 시작하는 5~20자 영문자 또는 숫자이어야 합니다.");
					$("#id").val("");
					return;
		         }
			
				
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/checkId",
					dataType:"text",
					data: "${_csrf.parameterName}=${_csrf.token}&id="+$('#id').val(),			
					//async: false,
					success:function(result){
						console.log(result)
						//var data = result;
						
						if(result=="가능"){
							console.log("사용")
							alert($("#id").val() + "은 사용가능한 아이디입니다.");
							$("#checkId").html("중복체크완료");
							$("#pw").focus();
						}else{
							console.log(result)
							alert($("#id").val() + "은 이미 사용 중인 아이디입니다.");
							$("#id").val("");
							
						}
						

					},//function
					error:function(error){
						console.log(error)
					}
					
				});//ajax
				
			})
			
			$("#pw").keyup(function(){
				//alert(1)
				if($("#pw").val().length==0){
					$("#pwdLength").html(""); 
				}
				else if($("#pw").val().length < 6){
					$("#pwdLength").html("6자리 이상 입력하세요."); 
					if($("#check-pw").val().length==0){
						$("#comparePwd").html("");
					}
					else if($("#check-pw").val()!=$("#pw").val()){
						$("#comparePwd").html("비밀번호 불일치");
					}else{
						$("#comparePwd").html("");
						
					}
				}else{
					$("#pwdLength").html("");
					if($("#check-pw").val().length==0){
						$("#comparePwd").html("");
					}
					else if($("#check-pw").val()!=$("#pw").val()){
						$("#comparePwd").html("비밀번호 불일치");
					}else{
						$("#comparePwd").html("");
						
					}
					
				}
				
			})
			
			
			
			$("#check-pw").keyup(function(){
				if($("#check-pw").val().length==0){
					$("#comparePwd").html("");
				}
				else if($("#check-pw").val()!=$("#pw").val()){
					$("#comparePwd").html("비밀번호 불일치");
				}else{
					$("#comparePwd").html("");
					
				}
			})
		
			
			$("#nick").keyup(function(){
				$("#checkNick").val("닉네임 중복체크")
			})
			
			$("#checkNick").click(function(){
		
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/checkNick",
					dataType:"text",
					data: "${_csrf.parameterName}=${_csrf.token}&nick="+$("#nick").val(),			
					success:function(result){
						if($("#nick").val().length==0){
							alert("닉네임을 입력해주세요.")
							//$("#compareNick").html("");
						}else{
							//$("#compareNick").html(result);
							alert(result);
							if(result=="이미 사용중인 닉네임"){
								$("#nick").val("");
								
							}else{
								$("#checkNick").html("중복체크완료");
							}
							
							
						}
						
						

					},//function
					error:function(error){
						console.log(error)
					}
					
				});//ajax
			})
			
			var count = 1;
			$(document).on("click",".certificate-add-button", function(){
				
			
				var $div = $(".certificate-input-wrap").eq(0).clone();	
				$div.find("input").val("");
				
				var $div=' <div class="certificate-input-wrap" ><input class="sign-up-form-input" name="userAttachmentsFileSubject[]"/>';
				$div+='<input class="sign-up-form-input" name="userAttachmentsFileName" />';
				$div+='<input  id="sign-up-add-file'+count+'" class="sign-up-add-image" type="file" name="filesList[]"/>'
				$div+='<label for="sign-up-add-file'+count+'" class="certificate-file-button" > 파일 첨부 </label>';
				$div+='<div class="certificate-add-button" >+</div> </div></div>';
				
				count++;
		
					if(count <=5){
		
						alert($div)
						$("#certAdd").append($div);
					
					}
			})
			
			
			$(document).on("change", ".sign-up-add-image", function(){ //주황색
					
					alert(1)
			        console.log($(this))
			        	var filename = $(this).val().split('/').pop().split('\\').pop();
			          //console.log(filename)
			          
			        $(this).prev().val(filename);
			          //$(this).attr("name","test");
			          
			         console.log($(this))
			        // $(this).prev().find("input").val(filename);
			       
				
			      
				})   
				
					 function readImage(input) {
						  
						// 인풋 태그에 파일이 있는 경우
					    if(input.files && input.files[0]) {
					        // 이미지 파일인지 검사 (생략)
					        // FileReader 인스턴스 생성
					        const reader = new FileReader()
					        // 이미지가 로드가 된 경우
					        reader.onload = e => {
					            const previewImage = document.getElementById("sign-up-image")
					          
					            previewImage.src = e.target.result
					          
					        }
					        // reader가 이미지 읽도록 하기
					        reader.readAsDataURL(input.files[0])
					    }
					}
					// input file에 change 이벤트 부여
					const inputImage = document.getElementById("sign-up-add-image")
					
					inputImage.addEventListener("change", e => {
					    readImage(e.target)
					})
	
			
			$(".email-select").change(function(){
				$(".email-input").attr("readonly",false);
				$("#sendEmail").html("이메일 인증");
			})
			
			$("form").on("submit",function(){
				
				 if($(".sign-up-add-image").html()==""){
					
					
					$("input[name='userProfileImg']").val($(".sign-up-image").attr("src"));
					
				}
			
		
				let inval_Arr = new Array(10).fill(false);
				//이름확인
				if (nameJ.test($("#name").val())) {
					
					inval_Arr[0] = true;
				} else {
					inval_Arr[0] = false;
					alert("이름은 한글로만 작성가능합니다.");
					return false;
				} 
				
				//id 중복체크 여부
				if($("#checkId").html()=="중복체크완료"){
					
					inval_Arr[1] = true;
					
				}else{
					inval_Arr[1] = false;
					alert("id중복체크를 진행해주세요");
					return false;
				}
				
				// 비밀번호가 같은 경우 && 비밀번호 정규식
				if ($("#comparePwd").html() == "" && $("#pw").val() != "" && $("#check-pw").val() != "" ) {
					inval_Arr[2] = true;
					
				} else {
					inval_Arr[2] = false;
					alert("비밀번호를 확인하세요.");
					return false;
				}
				
				//닉네임
				if($("#checkNick").html()=="중복체크완료"){
					inval_Arr[3] = true;
				
				}else{
					inval_Arr[3] = false;
					alert("닉네임을 다시 입력해주세요.")
					return false;
				}
				
				// 휴대폰번호 정규식
				if (phoneJ.test($("#phone").val())) {
					
					inval_Arr[4] = true;
				
				} else {
					inval_Arr[4] = false;
					alert("휴대폰 번호를 확인하세요.");
					return false;
				} 
						
				//주민번호
				if (businessJ.test($("#business").val())) {
					
					inval_Arr[5] = true;
				
				} else {
					inval_Arr[5] = false;
					alert("사업자등록번호를 확인하세요.");
					return false;
				} 
				
				//이메일
				  if($(".email-validate-error").html()=="인증완료"){
					inval_Arr[6] = true;
					
				}else{
					inval_Arr[6] = false;
					alert("email 인증을 진행해주세요.");
					return false;
				} 
				//파일첨부
					if($("input[name='userAttachmentsFileSubject[]']").val()=="" && $("input[name='userAttachmentsFileName']").val() != "" ){
						inval_Arr[7] = false;
						alert("파일이름을 입력해주세요.");
						return false;

					}else{
						inval_Arr[7] = true;
					}
				
					//우편번호
					if ( $("#zip").val().length >0 ) {
						
						inval_Arr[8] = true;
					
					} else {
						inval_Arr[8] = false;
						alert("우편번호를 입력해주세요.");
						return false;
					} 
					//도로명주소
					if ($("#address").val()!="") {
						
						inval_Arr[9] = true;
					
					} else {
						inval_Arr[9] = false;
						alert("주소를 확인해주세요.");
						return false;
					} 
					
					if ($("#address-detail").val() != "") {
						
						inval_Arr[10] = true;
					
					} else {
						inval_Arr[10] = false;
						alert("주소를 확인해주세요.");
						return false;
					} 
				
				//전체 유효성 검사
				let validAll = true;
				for (let i = 0; i < inval_Arr.length; i++) {
					console.log(inval_Arr[i]);
					if (inval_Arr[i] == false) {
						validAll = false;
					}
				}
				if (validAll == true) { // 유효성 모두 통과
					alert("여기여기 붙어라 ~ 모닥불에 오신걸 환영합니다.");
				} else {
					
					alert("정보를 다시 확인하세요.")
				} 
			});

	    });
		var count = 1;

		function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백("")값을 가지므로, 이를 참고하여 분기 한다.
				let fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				let extraRoadAddr = ""; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== "" && data.apartment === "Y") {
					extraRoadAddr += (extraRoadAddr !== "" ? ", "
							+ data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== "") {
					extraRoadAddr = " (" + extraRoadAddr + ")";
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== "") {
					fullRoadAddr += extraRoadAddr;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				console.log(data.zonecode);
				console.log(fullRoadAddr);

				$("#zip").val(data.zonecode);
				$("#address").val(fullRoadAddr);
				$("#address-detail").focus();
			}
		}).open();
			
		}
	
	
	</script>
  </head>
  <body>
					
    <div class="wrap">
      <div class="sign-up-wrap">
          <form action="${pageContext.request.contextPath }/insert" method="post" enctype="multipart/form-data">
         	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
         	<input type="hidden" name="userJob" value="기관">
         	<input type="hidden" name="state" value="ROLE_USER"> 
         	<input type="hidden" name="temper" value=50> 
         	<input type="hidden" name="temperCount" value=1> 
          <div class="sign-up-image-area">
            <div class="sign-up-form-image ">
              <div class="sign-up-image-wrap">
             
              <img
                  class="sign-up-image"
                  id="sign-up-image"
                  src="https://dummyimage.com/150x150/c2c2c2/ffffff&text=duck"
                  width="100%"
                  height="100%"
                />
         
              </div>
              <input type="hidden" name="userProfileImg">
              <input id="sign-up-add-image" class="sign-up-add-image" type="file" name="file" accept="image/*" />
              
             <!--  파일 첨부 : <input type="file" name="file"/>
				<input type="submit" value="전송"/> -->
              <label for="sign-up-add-image" class="sign-up-form-button">
                사진추가
              </label>
              <span id='View_area'
                  style='position:relative; color: black; border: 0px solid black;'>
              </span>
            </div>
          </div>
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="name">기관명</label>
            <input class="sign-up-form-input-medium" id="name" name="userName" />
           <span class="input-validate-error"></span>
          </div class="sign-up-form-item">
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="id">ID</label>
            <input class="sign-up-form-input-medium" id="id" name="userId" />
           <span class="input-validate-error"></span>
            <button class="sign-up-form-button" type="button" id="checkId"> id 중복체크</button>
          </div class="sign-up-form-item">
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="pw">비밀번호</label>
            <input class="sign-up-form-input-medium" type="password" id="pw" name="userpwd"/>
            <span class="input-validate-error" id="pwdLength"></span>
          </div class="sign-up-form-item">
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="check-pw">비밀번호 확인</label>
            <input type="password" class="sign-up-form-input-medium" id="check-pw" />
            <span class="input-validate-error" id="comparePwd"></span>
            
          </div class="sign-up-form-item">
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="nick">닉네임</label>
            <input class="sign-up-form-input-medium" id="nick" name="userNick" value="${userInfo.get('userNick') }"/>
           	 <span class="input-validate-error"></span>
<!--              <span class="input-validate-error" id="compareNick"></span> -->
            <button class="sign-up-form-button" type="button" id="checkNick"> 닉네임 중복체크</button>
          
          </div class="sign-up-form-item">
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="phone" name="userPhone">전화번호</label>
            <input class="sign-up-form-input-medium" id="phone" name="userPhone" />
          </div class="sign-up-form-item">
          <div class="sign-up-form-item" id=validateNo>
            <label class="sign-up-form-label" for="business">사업자등록번호</label>
            <div class="rrn-input-wrap" name="userValidateNo">
              <input class="rrn-input" id="business" name="userValidateNo"/>
            </div>
          </div class="sign-up-form-item">
          <div class="sign-up-form-item" name="userEmail" id="userEmail">
          	<input type="hidden" name="userEmail">
            <label class="sign-up-form-label" for="email">E-mail</label>
            <div class="email-input-wrap">
      
               <input class="email-input" id="email"/>
              <div>@</div>
              <select class="email-select"> 
              	<option value="free">직접입력</option>
                <option value="naver.com">naver.com</option>
                <option value="daum.net">daum.net</option>
                <option value="gmail.com">gmail.com</option>
              </select>
              <input class="email-input" id="etc"/>
              <button class="sign-up-form-button" type="button" id="sendEmail" >이메일 인증</button>
           
          
            </div>
          </div >
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="zip">우편번호</label>
            <div class="zip-input-wrap">
              <input class="sign-up-form-input" id="zip" name="userPostCode"/>
              <button class="sign-up-form-button" type="button" onclick="execPostCode();">우편번호 찾기</button>
            </div>
          </div>
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="address">주소</label>
            <input class="sign-up-form-input" id="address" name="userAddr"/>
          </div>
          <div class="sign-up-form-item">
            <label class="sign-up-form-label" for="address-detail">상세주소</label>
            <input class="sign-up-form-input" id="address-detail" name="userAddrDetail" />
          </div>
          
          <div class="sign-up-form-item" id="certAdd" style="display: block">
            <label class="sign-up-form-label" for="certificate">증명서</label><p>
            <div class="certificate-input-wrap" >
              <input class="sign-up-form-input" name="userAttachmentsFileSubject[]"/>
              <input class="sign-up-form-input" name="userAttachmentsFileName" />
              <input
              id="sign-up-add-file"
              class="sign-up-add-image"
              type="file" 
              name="filesList[]"
              />

            <label for="sign-up-add-file" class="certificate-file-button" >
              파일 첨부
            </label>
              <div class="certificate-add-button" >+</div>
             
            </div>
         
          </div>
          
          <div class="form-button-wrap">
            <button class="sign-up-cancel-button" type="button">취소</button>
            <button class="sign-up-button" type="submit">회원가입</button>
          </div>
        </form>
        <div class="modal-wrap" style="display: none">
          <div class="modal-title">
            E-Mail 인증
          </div>
          <div class="modal-input-wrap">
            <input class="modal-input" id="checkEmail"/>
            <button class="sign-up-form-button" type="button" id="sendEmailBtn">인증번호 발송</button><br>
           
            	<div class="send-code-result" id="sendCode"></div>
            	
          </div>
        
          <div class="modal-button-wrap">
          	
            <button type="button" class="modal-button cancel-button">취소</button>
            <button type="button" class="modal-button search-id-button" id="checkCodeBtn">
              확인
            </button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
