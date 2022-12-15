<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    	  if(${newAlarm}==0 || ${newAlarm}==null){
  			$(".nav-counter").hide();
  		}else{
  			$(".nav-counter").show();
  		}
    	  
    	  $(document).ready(function(){
       	   $(function(){
       	      let $modal ;
       	      
       	      $(document).ajaxSend(function(e,xht,op){
       		         xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
       		      	});
       	      
       	       document.getElementById('following').addEventListener('click', function() {
       	             // 모달창 띄우기
       	             modal('my_modal');
       	             
       	            // alert("dd = " + document.querySelector(".modakbul-button following"))
       	              $modal = $("button[class='modakbul-button following']")//document.querySelector(".modakbul-button following");
       	              
       	              
       	              
       	              $(document).on("click", "button[class='modakbul-button following']" , function(){
       	                

       	                      alert("버튼클릭했음" + " , " + $(this).val());
       	                      
       	                      let target = {"follower":$(this).val() , "following":"${userNo}"}
       	                      console.log("follower = " + $(this).val());
       	                    /*   console.log("following = " + ${userNo}); */
       	                      let targetBtn = $(this);
       	                      
       	                      if($(this).text() == "팔로잉"){
       	                         alert("딜리트 반응?");
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
       	                               alert("err : "+err);
       	                            }
       	                         });//Delete ajax END
       	                      }
       	                      
       	                      if($(this).text()=="팔로우"){
       	                         alert("인설트반응?");
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
       	                               alert("err : "+err);
       	                            }
       	                         });//Insert ajax END
       	                      }//if  END
       	                      
       	                   });///////////////////////////

       	         });
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
       	                modal.querySelector('.modal_close_btn').addEventListener('click', function() {
       	                    bg.remove();
       	                    modal.style.display = 'none';
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

       });//ready END
            
          $(".my-page-button").click(function(){
              var advNo = $(this).val();

              $("#ADCancel").show();

              $(".search-id-button").click(function(){

                  if($(this).val()=="취소"){
                	  $.ajax({
                          type:"POST",
                          url:"${pageContext.request.contextPath}/my_page/gatherAD/updateMyAdCancel",
                          dataType:"text",
                          data: "${_csrf.parameterName}=${_csrf.token}&advertisementNo="+advNo,            
                          success:function(result){
                                  $("#adWaiting").load(location.href + " #adWaiting");
                                  
                                  $("#ADCancel").hide();
      
                          },//function
                          error:function(error){
                              console.log(error)
                          }
                          
                      });
                  }else{
                      $("#ADCancel").hide();
                  }
              })
              
          })
          
          $(".cancel-button").click(function() {
            $("#ADCancel").hide();
        })
        
        
          
      })      
  
  </script>
   
   <body>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
  <div class="wrap">
		<div class="my-page-wrap">
			<div class="my-page-header">
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
				<div class="my-page-user-info-wrap">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<div class="my-page-user-name">

							<div>${user.userName }님</div>


						</div>
						<div class="my-page-user-temperature">모닥불 온도 : ${user.temper }&#8451</div>
						<div class="my-page-user-follow-wrap">
							<div>
								<div>팔로워</div>
								<div>&nbsp;&nbsp;&nbsp;${follower}</div>
							</div>
							<div>
								<div>팔로잉</div>

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
						<!--  <a href="#" class="button" style="width:50px; position:relative;">공지<span class="nav-counter">30</span></a> -->
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'"
							style="position: relative;">알림함 <c:choose>
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
						<li class="my-page-nav-item "
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adApplication?userNo=${user.userNo}'">광고신청</li>
					</ul>
				</nav>
          <section class="my-page-main-content">
            <div class="class-search">
                <div class="filter-wrap">
                <sec:authentication var="user" property="principal" />
                    <div class="filter-list-wrap selected">

                        <div class="filter-list-item" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adApplication?userNo=${user.userNo}'">광고신청</div>
                        <div class="filter-list-item selected" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adWaiting?userNo=${user.userNo}'">신청대기</div>
                        <div class="filter-list-item" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adStatus?userNo=${user.userNo}'">광고진행중</div>

                    </div>
                </div>
                <div class="commercial-wait" id="adWaiting">
                    <table class="table">
                        <colgroup>
                            <col width="8%" />
                            <col width="37%" />
                            <col width="18%" />
                            <col width="24%" />
                            <col width="15%" />
                        </colgroup>
                        <thead>
                            <tr class="table-header">
                            <th>번호</th>
                            <th>사진</th>
                            <th>모임</th>
                            <th>신청상태</th>
                            <th>취소하기</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.selectADGatherRegis.content}" var="data" varStatus="status">
                            <tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
                                    <div class="table-small-image-wrap">
                                        <img src="${pageContext.request.contextPath}/save/${data.gather.gatherImg}" class="gather-img" alt="이미지" width="100%"/>
                                    </div>
                                </td>
                                <td>${data.gather.gatherName}</td>
                                <td>${data.adStatus}</td>
                                <td class="inquiry-replied">
                                    <button type="button" class="my-page-button" id="${data.advertisementNo}" value="${data.advertisementNo}">신청취소</button>
                                </td>
                            </tr>
                           </c:forEach>
                        </tbody>
                    </table>
                </div>
                 <div style="text-align: center">
				   <nav class="pagination-container">
					<div class="pagination">
					<c:set var="doneLoop" value="false"/>
						
						 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
						      <a class="pagination-newer" href="${pageContext.request.contextPath}/my_page/gatherAD/adWaiting?userNo=${user.userNo }&nowPage=${startPage-1}">PREV</a>
						  </c:if> 
						  
						<span class="pagination-inner"> 
						  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
						  
							    <c:if test="${(i-1)>=selectADGatherRegis.getTotalPages()}">
							       <c:set var="doneLoop" value="true"/>
							    </c:if> 
						    
						  <c:if test="${not doneLoop}" >
						         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/my_page/gatherAD/adWaiting?userNo=${user.userNo }&nowPage=${i}">${i}</a> 
						  </c:if>
						   
						</c:forEach>
						</span> 
								
						 <c:if test="${(startPage+blockCount)<=selectADGatherRegis.getTotalPages()}">
						     <a class="pagination-older" href="${pageContext.request.contextPath}/my_page/gatherAD/adWaiting?userNo=${user.userNo }&nowPage=${startPage+blockCount}">NEXT</a>
						 </c:if>
						</div>
					</nav>
					</div>
                </div>
            <!-- 추가된 내용 -->
          </section>
        </div>
        <div class="modal-wrap" style="display: none">
            <div class="modal-title">
                내용
            </div>
           <div class="modal-text-wrap">정말로 삭제하시겠습니까?</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button cancel-button">취소</button>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
        <div class="modal-wrap" style="display: none">
            <div class="modal-title">
                내용
            </div>
           <div class="modal-text-wrap">정말 취소하시겠습니까?</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button cancel-button">취소</button>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
        <div class="modal-wrap" style="display: none">
           <div class="modal-text-wrap">하루 전 모임은 취소할 수 없습니다.</div>
            <div class="modal-button-wrap">
                <div></div>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
        <!-- 추가된 모달 -->
        <div class="commercial-modal-wrap" style="display: none">
            <div class="commercial-modal-title">광고 신청
            </div>
            <div class="create-commercial-wrap">
                <div class="create-commercial-top">
                    <div class="create-commercial-image-wrap">
                        <img width="100%"/>
                    </div>
                    <div class="create-commercial-class-name">핸드드립 커피 클래스</div>
                </div>
                <div class="create-commercial-item">
                    <div class="commercial-modal-label">광고 진행일자:</div>
                    <div class="create-commercial-value-wrap">
                        <div>2022/10/22~2022/11/22</div>
                        <button type="button" class="my-page-button">기간 설정</button>
                    </div>
                </div>
                <div class="create-commercial-item">
                    <div class="commercial-modal-label">광고 배너 이미지 첨부(<span class="create-commercial-value-required">필수</span>)</div>
                    <div class="create-commercial-input-wrap">
                        <div>
                            <input class="my-page-form-input" readonly/>
                            <input id="create-image" type="file" class="commercial-image-input"/>
                            <div class="create-commercial-input-tip">가로 : 1000px  세로 : 200px</div>
                        </div>
                        <label for="create-image" class="commercial-file-button">
                            파일 첨부
                        </label>
                    </div>
                </div>
                <div class="create-commercial-item">
                    <div class="commercial-modal-label">광고 진행 금액:</div>
                    <div class="create-commercial-value-wrap">
                        <div>300원</div>
                        <button type="button" class="my-page-button">결제 완료</button>
                        <button type="button" class="my-page-button-gray">결제 하기</button>
                    </div>
                </div>
            </div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button cancel-button">취소</button>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
        <div class="modal-wrap" style="display: none" id="ADCancel">
           <div class="create-commercial-warning">광고 신청을 정말 취소하시겠습니까?</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button search-id-button" value="취소" >
                확인하기
                </button>
                <button type="button" class="modal-button cancel-button">뒤로가기</button>
            </div>
        </div>
        <div class="commercial-modal-wrap" style="display: none">
            <div class="commercial-modal-title">배너 수정하기</div>
            <div class="modify-commercial-current-image-text">현재 배너 이미지</div>
            <div class="modify-commercial-current-image-wrap">
                <img src="" alt="img"/>
            </div>
            <div class="modify-commercial-change-image-wrap">
                <div class="commercial-modal-label">광고 배너 이미지 첨부</div>
                <div class="modify-commercial-change-image-value-wrap">
                    <div>
                        <input class="my-page-form-input" readonly/>
                        <input id="modify-image" type="file" class="commercial-image-input"/>
                        <div class="create-commercial-input-tip">가로 : 1000px  세로 : 200px</div>
                    </div>
                    <label for="modify-image" class="commercial-file-button">
                        파일 첨부
                    </label>
                </div>
            </div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button search-id-button">
                수정하기
                </button>
                <button type="button" class="modal-button cancel-button">뒤로가기</button>
            </div>
            
        </div>
        <!-- 추가된 모달 -->
        
      </div>
      
      
      
    </div>
    
    <sec:authentication var="user" property="principal" />
   
    <div id="my_modal">
	 	<table id="following" style="width: 100%">
	 		
	 		<tr class="title">
	 	
	 		<th colspan="4" class="th">
	 	
	 		팔로잉
	 	
			</th>
			 <a class="modal_close_btn">X</a>
			
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
						<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${f.followerUser.userNo}'">${f.followerUser.userNick}<p>
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
         <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

  </body>
</html>
