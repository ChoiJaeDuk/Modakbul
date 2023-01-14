<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${pageContext.request.contextPath}/css/my-page/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/my-page/reset.css" rel="stylesheet" />
    <title>Document</title>
  </head>
  <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
  <script type="text/javascript">
  
	   $(function(){
		    let $modal ;
		   //document.getElementByName('modal-on').addEventListener('click', function() {
	             // 모달창 띄우기
	       	 $(document).on("click","[name='modal-on']", function() {
	   				$("#gatherNo").val($(this).val())
                    $.ajax({
                       url:"${pageContext.request.contextPath}/my_page/selectParticipant", 
                       type:"post",
                       dataType:"json",
                       data:"${_csrf.parameterName}=${_csrf.token}&gatherNo="+$(this).val(),   
                       //contentType:'application/json;charset=utf-8',
                       success:function(result){
                       		console.log("result = " + result)
                       		
                        	str =""
                        	str += `<table id="gather-applicant" style="width: 100%">`;
                        	str += `<tr class="title">`;
                        	str += `<th colspan="4" class="th">참가 신청 리스트</th>`;
                        	str += `<a class="modal_close_btn" style="margin-left: 600px;font-size: 25px;">X</a>`
                        	$.each(result.content, function(index, item) {
                       			console.log(item.user)
                        		str += `<tr>`;
                        		str += `<th>`
                        		str += `<img alt="img" class="followImg" src=${pageContext.request.contextPath}/save/${"${item.user.userProfileImg}"}>`;
                        		str += `</th>`;
                        		str += `<th>`;
                        		str += `<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/'"${"${item.user.userNo}"}>${"${item.user.userNick}"}<p>`;
                        		str += `</th>`;
                        		str += `<th>`;
                        		str += `${"${item.user.temper}"}℃`;
                        		str += `</th>`;
                        		str += `<th style="width: 30%">`;
                        		str += `<button class="modakbul-button approve-btn" name="참가승인" id=${"${item.user.userNo}"} >승인</button>`;
                        		str += `<button class="modakbul-button reject-btn" name="참가거절" id= ${"${item.user.userNo}"} >거부</button>`;
                        		str += `</th>`;
                        		str += `</tr>`;
							});
							str+=`</table>`;
			
							$("#applicant-modal").html(str);
							modal('applicant-modal');
                       },error:function(err){
                          alert("err : "+err);
                       }
                    })
    		});
	             
		   //////////////////////////////////////////////////////////////
		   
		   $(document).on("click", ".approve-btn,.reject-btn", function() {
			  	   
				var userNo = $(this).attr("id")
				var state = $(this).attr("name")
				var gatherNo = $("#gatherNo").val()
				$.ajax({
                       url:"${pageContext.request.contextPath}/my_page/updateApplicationState", 
                       type:"post",
                       //dataType:"json",
                       data:"${_csrf.parameterName}=${_csrf.token}&gatherNo="+gatherNo +"&userNo="+userNo+"&state="+state,   
                       //contentType:'application/json;charset=utf-8',
                       success:function(result){
                       		console.log("result = " + result)
                       		
                       		$.ajax({
                       url:"${pageContext.request.contextPath}/my_page/selectParticipant", 
                       type:"post",
                       dataType:"json",
                       data:"${_csrf.parameterName}=${_csrf.token}&gatherNo="+gatherNo,   
                       //contentType:'application/json;charset=utf-8',
                       success:function(result){
                       		console.log("result = " + result)
                       		
                        	str =""
                        	str += `<table id="gather-applicant" style="width: 100%">`;
                        	str += `<tr class="title">`;
                        	str += `<th colspan="4" class="th">참가 신청 리스트</th>`;
                        	str += `<a class="modal_close_btn" style="margin-left: 600px;font-size: 25px;">X</a>`
                        	$.each(result.content, function(index, item) {
                       			console.log(item.user)
                        		str += `<tr>`;
                        		str += `<th>`
                        		str += `<img alt="img" class="followImg" src="${pageContext.request.contextPath}/save/"${"${item.user.userProfileImg}"}>`;
                        		str += `</th>`;
                        		str += `<th>`;
                        		str += `<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/'"${"${item.user.userNo}"}>${"${item.user.userNick}"}<p>`;
                        		str += `</th>`;
                        		str += `<th>`;
                        		str += `${"${item.user.temper}"}℃`;
                        		str += `</th>`;
                        		str += `<th style="width: 30%">`;
                        		str += `<button class="modakbul-button approve-btn" name="참가승인" id=${"${item.user.userNo}"}>승인</button>`;
                        		str += `<button class="modakbul-button reject-btn" name="참가거절" id=${"${item.user.userNo}"}>거부</button>`;
                        		str += `</th>`;
                        		str += `</tr>`;
							});
							str+=`</table>`;
			
							$("#applicant-modal").html(str);
							
                       },error:function(err){
                          alert("err : "+err);
                       }
                    })
                       		
                       },error:function(err){
                          alert("err : "+err);
                       }
                    })
			})
		   
		   //////////////////////////
	$(document).ready(function(){
	       document.getElementById('following').addEventListener('click', function() {
	             // 모달창 띄우기
	             modal('my_modal');
	             
	            // alert("dd = " + document.querySelector(".modakbul-button following"))
	              $modal = $("button[class='modakbul-button following']")//document.querySelector(".modakbul-button following");
	              
	              
	              
	              $(document).on("click", "button[class='modakbul-button following']" , function(){
	                      let target = {"follower":$(this).val() , "following":"${userNo}"}
	                      console.log("follower = " + $(this).val());
	                    /*   console.log("following = " + ${userNo}); */
	                      let targetBtn = $(this);
	                      
	                      if($(this).text() == "팔로잉"){
	                         $.ajax({
	                            url:"${pageContext.request.contextPath}/follow/delete", 
	                            type:"post",
	                            dataType:"text",
	                                data:JSON.stringify(target),   
	                                contentType:'application/json;charset=utf-8',
	                            success:function(result){
	                               if(result=="ok"){
	                                  alert("팔로잉이 해제 되었습니다.")                  
	                                  
	                                  targetBtn.css("background","rgb(243, 156, 18)")
	                                  targetBtn.text("팔로우")
	                               }
	                            },error:function(err){
	                            	console.log("err : "+err);
	                            }
	                         });//Delete ajax END
	                      }
	                      
	                      if($(this).text()=="팔로우"){
	                         $.ajax({
	                            url:"${pageContext.request.contextPath}/follow/insert",
	                            type:"post",
	                            dataType:"text",
	                                data:JSON.stringify(target),   
	                                contentType:'application/json;charset=utf-8',
	                            success:function(result){
	                               if(result=="ok"){
	                                  alert("팔로우 등록 되었습니다.")                  
	                                  
	                                  targetBtn.css("background","gray")
	                                  targetBtn.text("팔로잉")
	                               }
	                               
	                            },error:function(err){
	                            	console.log("err : "+err);
	                            }
	                         });//Insert ajax END
	                      }//if  END
	                      
	                   });///////////////////////////
	         });
	       
	       var userNo = $("#check1").val()
			$('#check1').change(function(){
				
				location.href = "${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo="+$("#check1").val();
			})
			
			$('#check2').change(function(){
				
				location.href = "${pageContext.request.contextPath}/my_page/gatherSelect/waitingList?userNo="+$("#check2").val();
			})
		
		
			$("#yes").click(function() {
				alert(userNo)
				location.href="${pageContext.request.contextPath}/my_page/gatherSelect/cancelGather?userNo="+userNo+"&regularGatherState=0&gatherNo="+$("#confirm").val();
			})
			$("#no").click(function() {
				location.href="${pageContext.request.contextPath}/my_page/gatherSelect/cancelGather?userNo="+userNo+"&regularGatherState=1&gatherNo="+$("#confirm").val();
			})
			
			$("[name='cancel']").click(function() {
				$("#confirm").val($(this).val())
				$("#regularGatherNo").val($(this).attr("id"))
				$("#modal").show()
			})
		
			$("#modalCancel").click(function() {
				$("#modal").hide();
				$("#modal-2").hide();
	
			})
			$("#modalCancel2").click(function() {
				$("#modal").hide();
				$("#modal-2").hide();
				
			})
			
			$("#confirm").click(function() {
	         if(!$("#regularGatherNo").val()){         
	            
	            location.href="${pageContext.request.contextPath}/my_page/gatherSelect/cancelGather?userNo="+$("#check1").val()+"&regularGatherState=1&gatherNo="+$("#confirm").val();
	         }else{
	            $("#modal-2").show()
	         }
        
    		})
	   
	      	
	       //////////////////////////////////////////////////
	   })
	   
	    function modal(id) {
	                var zIndex = 9999;
	                var modal = document.getElementById(id);

	                // 모달 div 뒤에 희끄무레한 레이어
	                var bg = document.createElement('div');
	                bg.setStyle({
	                    position: 'fixed',
	                    zIndex: zIndex,
	                    left: '0px',
	                    top: '0px',
	                    width: '100%',
	                    height: '100%',
	                    overflow: 'auto',
	                    // 레이어 색갈은 여기서 바꾸면 됨
	                    backgroundColor: 'rgba(0,0,0,0.4)'
	                });
	                document.body.append(bg);

	                // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
	                $(document).on('click','.modal_close_btn' ,function() {
	                    bg.remove();
	                    modal.style.display = 'none';
	                    location.reload()
	                });

	                modal.setStyle({
	                    position: 'fixed',
	                    display: 'block',
	                    boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

	                    // 시꺼먼 레이어 보다 한칸 위에 보이기
	                    zIndex: zIndex + 1,

	                    // div center 정렬
	                    top: '50%',
	                    left: '50%',
	                    transform: 'translate(-50%, -50%)',
	                    msTransform: 'translate(-50%, -50%)',
	                    webkitTransform: 'translate(-50%, -50%)'
	                });
	            }

	            // Element 에 style 한번에 오브젝트로 설정하는 함수 추가
	            Element.prototype.setStyle = function(styles) {
	                for (var k in styles) this.style[k] = styles[k];
	                return this;
	            };
	            
	            
	            $(".gather-img").click(function() {
					location.href="${pageContext.request.contextPath}/gatherDetail/info?gatherNo="+$(this).attr("id")+"&userNo="+$("#check1").val();
				})
			});
		
		
		 
		
 
  </script>
  <body>
  	<input hidden="" id="gatherNo">
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	<div class="wrap">
		<div class="my-page-wrap">
			<div class="my-page-header" >
				<div class="my-page-image-wrap" id="original">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<c:set value="${user.userProfileImg}" var="img" />
						<c:set value="true" var="state1" />
						<c:forEach items="${fileNames }" var="file">
							<c:if test="${file eq img }">
								<c:set value="true" var="state2" />
								<img class="sign-up-image"
									src="${pageContext.request.contextPath}/save/${user.userProfileImg }"
									alt="img"
									onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_index/${user.userNo}'" />

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="sign-up-image" src="${user.userProfileImg }"
								alt="img"
								onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_index/${user.userNo}'" />
						</c:if>

						<input id="sign-up-add-image" class="sign-up-add-image"
							type="file" name="file" accept="image/*" />
					</sec:authorize>
				</div>
				<div class="my-page-user-info-wrap" >
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<div class="my-page-user-name">

							<div>${user.userNick }님</div>


						</div>
						<div class="my-page-user-temperature">모닥불 온도 : ${user.temper }&#8451</div>
						<div class="my-page-user-follow-wrap">
							<div>
								<div>팔로워</div>
								<div>&nbsp;&nbsp;&nbsp;${follower}</div> 
							</div>
							<div>
								<div >팔로잉</div>
							
								<div id="following">
									<a>&nbsp;&nbsp;&nbsp;${following}</a>
								</div>
							</div>
						</div>
					</sec:authorize>
				</div>
			</div>
			<div class="my-page-content-wrap">
				<nav>
					<ul>
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/profile/myProfile/${user.userNo}'">프로필정보</li>
						<li class="my-page-nav-item" onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'" style="position: relative;">
						알림함
							
							<c:choose>
								<c:when test="${newAlarm ne 0 || newAlarm ne null}">
									<span class="nav-counter"> ${newAlarm} </span>
								</c:when>
								<c:otherwise>
									<div class="nav-counter-invi" style="display: none;">
										<span class="nav-counter-invi"> 0 </span>
									</div>
								</c:otherwise> 
							</c:choose>
							
						</li>
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adApplication?userNo=${user.userNo}'">광고신청</li>
					</ul>
				</nav>
          <section class="my-page-main-content">
                <div class="filter-wrap">
                    <div class="filter-list-wrap" id="guest">
                    	<div class="filter-list-item" data-tab="tab-1" id="applicationList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">신청목록</div>
                        <div class="filter-list-item selected" data-tab="tab-2" id="upcomingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/upcomingList?userNo=${user.userNo}'">예정목록</div>        
                        <div class="filter-list-item" data-tab="tab-3" id="participationList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/participationList?userNo=${user.userNo}'">참가목록</div>                
                    </div>
	                <div class="filter-list-wrap selected" id="host">
                         <div class="filter-list-item" data-tab="tab-5" id="waitingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/waitingList?userNo=${user.userNo}'">신청목록</div>
                        <div class="filter-list-item selected" data-tab="tab-4" id="recruitmentList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/recruitingList?userNo=${user.userNo}'">모집중</div>
                        <div class="filter-list-item" data-tab="tab-6" id="completionList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/completionList?userNo=${user.userNo}'">모집완료</div>	               
                   </div>
                    <div class="filter-type-wrap">
                        <div class="filter-type-item">
                            <div class="custom-radio">
                                <input type="radio" id="check1" name="gather-type" value="${user.userNo }"/>
                                <label for="check1"></label>
                            </div>
                            <label for="check1" class="filter-type-label">참가모임</label>
                        </div>
                        <div class="filter-type-item">
                            <div class="custom-radio">
                                <input type="radio" id="check2" name="gather-type" checked="checked" value="${user.userNo }"/>
                                <label for="check2"></label>
                            </div>
                            <label for="check2" class="filter-type-label">주최모임</label>
                        </div>
                    </div>
                </div>
                <!-- 모집 중 -->
                <div class="table-wrap selected" id="tab-5">
                    <table class="table">
                        <colgroup>
                            <col width="8%" />
                            <col width="19%" />
                            <col width="18%" />
                            <col width="12%" />
                            <col width="15%" />
                            <col width="15%" />
                            <col width="15%" />
                        </colgroup>
                        <thead>
                            <tr class="table-header">
                            <th>번호</th>
                            <th>사진</th>
                            <th>모임</th>
                            <th>마감 날짜</th>
                            <th>관심수</th>
                            <th>인원수</th>
                            <th>신청확인</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:choose>
							<c:when
								test="${0 eq requestScope.recruitingList.getTotalPages()}">
								<tr>
									<td colspan="5">모집중인 모닥불이 없습니다 🔥</td>
								</tr>
							</c:when>
							<c:otherwise>
		                        <c:forEach items="${requestScope.recruitingList.content}" var="recruitingList" varStatus="status">
		                            <tr class="table-body" id="${recruitingList}">
		                                <td>${status.index+1}</td>
		                                <td>
		                                    <div class="table-small-image-wrap">
		                                        <img src="${pageContext.request.contextPath}/save/${recruitingList.getGatherImg()}" id="${recruitingList.getGatherNo()}" alt="이미지" class="gather-img"/>
		                                    </div>
		                                </td>
		                                <td>${recruitingList.getGatherName()}</td>
		                                <td>${fn:replace(recruitingList.getGatherDeadline(), 'T', '<br>')}</td>
		                                <td>${recruitingList.getLikeCount()}</td>
		                                <td>
		                                    <div class="table-interest-wrap">
		                                        <div class="table-heart"></div>
		                                        <div>
		                                           ${recruitingList.getPCount()} / ${recruitingList.getGatherMaxUsers()}
		                                        </div>
		                                    </div>
		                                </td>
		                                <td class="inquiry-replied">
		                                    <button name="modal-on" class="my-page-button" name="selectParticipant" value="${recruitingList.getGatherNo()}">확인하기</button>
		                              	
		                                    <button class="my-page-button" name="cancel" id="${recruitingList.getRegularGatherNo()}" value="${recruitingList.getGatherNo()}">취소하기</button>
		                                </td>
		                            </tr>
		                            
		                        </c:forEach>
                        	</c:otherwise>
						</c:choose>
                        </tbody>
                    </table>
                </div>
                <div>
                <div style="text-align: center">
					<!--  블럭당  -->
					 <nav class="pagination-container">
						<div class="pagination">
						<c:set var="doneLoop" value="false"/>
							
							 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
							      <a class="pagination-newer" href="${pageContext.request.contextPath}/my_page/gatherSelect/recruitingList?userNo=${user.userNo }&nowPage=${startPage-1}">PREV</a>
							  </c:if> 
							  
							<span class="pagination-inner"> 
							  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
							  
								    <c:if test="${(i-1)>=recruitingList.getTotalPages()}">
								       <c:set var="doneLoop" value="true"/>
								    </c:if> 
							    
							  <c:if test="${not doneLoop}" >
							         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/my_page/gatherSelect/recruitingList?userNo=${user.userNo }&nowPage=${i}">${i}</a> 
							  </c:if>
							   
							</c:forEach>
							</span> 
									
							 <c:if test="${(startPage+blockCount)<=recruitingList.getTotalPages()}">
							     <a class="pagination-older" href="${pageContext.request.contextPath}/my_page/gatherSelect/recruitingList?userNo=${user.userNo }&nowPage=${startPage+blockCount}">NEXT</a>
							 </c:if>
									 
								
							
							</div>
					</nav>  
				</div>
                </div>
          </section>
             </div>
          </div>
 
         </div>
          <div class="modal-wrap" hidden="" id="modal">
            <div class="modal-title">
                내용
            </div>
           <div class="modal-text-wrap">정말 모임모집을 취소하시겠습니까?</div>
            <div class="modal-button-wrap" >
                <button type="button" class="modal-button cancel-button" id="modalCancel">취소</button>
                <button type="button" class="modal-button search-id-button" id="confirm">확인</button>
            </div>
          </div>
          
          <div class="modal-wrap" hidden="" id="modal-2">
            <div class="modal-title">
                내용
            </div>
           <div class="modal-text-wrap">해당 모임은 정기모임입니다. <br>정기모임도 종료할까요?</div>
            <div class="modal-button-wrap" >
            <div>
             	<button type="button" class="modal-button search-id-button" id="yes">예</button>
                <button type="button" class="modal-button search-id-button" id="no">아니요</button>
            </div>   
                <button type="button" class="modal-button cancel-button" id="modalCancel2">취소</button>
               
            </div>
          </div>
        
         
	 <div id="my_modal">
	 	<table id="following" style="width: 100%">
	 		
	 		<tr class="title">
	 	
	 		<th colspan="4" class="th">
	 	
	 		팔로잉
	 	
			</th>
			<a class="modal_close_btn">X</a>
			<!-- <tr class="user">
			<th style="width: 20%">
			사진
			</th>
			<th style="width: 10%">
			이름
			</th>
			<th style="width: 10%">
			온도
			</th>
			<th style="width: 20%">
			<button class="modakbul-button following" id="" value="">팔로우</button>
			</th>
			</tr> 	 -->
			<c:forEach items="${followingList}" var="f">
				<tr>
					<th>
							<c:set value="${f.followerUser.userProfileImg}" var="img" />
						<c:set value="true" var="state1" />
						<c:forEach items="${fileNames }" var="file">
							<c:if test="${file eq img }">
								<c:set value="true" var="state2" />
								<img class="followImg"
									src="${pageContext.request.contextPath}/save/${f.followerUser.userProfileImg}"
									alt="img"/>

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="followImg" src="${f.followerUser.userProfileImg }"
								alt="img"/>
						</c:if>
							</th>
					<th>
						<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${f.followerUser.userNo}?loginUserNo=${user.userNo}'">${f.followerUser.userNick}<p>
					</th>
					<th>
						${f.followerUser.temper}℃
					</th>
					<th style="width: 20%">
						<button class="modakbul-button following" id="" value="${f.followerUser.userNo}">팔로잉</button>
					</th>
				</tr>
			</c:forEach>
	 	</table>
	 
        </div>
		
	<div class="applicant-modal" id="applicant-modal">
	 	<!-- <table id="gather-applicant" style="width: 100%">	
	 		<tr class="title">
	 		<th colspan="4" class="th">참가 신청 리스트</th>
			<a class="modal_close_btn" style="margin-left: 600px;font-size: 25px;">X</a> -->
			<%-- <c:forEach items="${followingList}" var="f">
				<tr>
					<th> 
						<img alt="img" class="followImg" src="${pageContext.request.contextPath}/save/${f.followerUser.userProfileImg }">
					</th>
					<th>
						<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${f.followerUser.userNo}'">${f.followerUser.userNick}<p>
					</th>
					<th>
						${f.followerUser.temper}℃
					</th>
					<th style="width: 20%">
						<button class="modakbul-button following" id="" value="${f.followerUser.userNo}">승인</button>
						<button class="modakbul-button following" id="" value="${f.followerUser.userNo}">거절</button>
					</th>
				</tr>
			</c:forEach> --%>
	 	<!-- </table> -->
     </div>
          
    
  </body>
</html>
