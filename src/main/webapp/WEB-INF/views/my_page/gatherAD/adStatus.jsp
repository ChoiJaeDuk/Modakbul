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
    <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
    <title>Document</title>
  </head>
   
    
  <body>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
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

							<div>${user.userNick }???</div>


						</div>
						<div class="my-page-user-temperature">????????? ?????? : ${user.temper }&#8451</div>
						<div class="my-page-user-follow-wrap">
							<div>
								<div>?????????</div>
								<div>&nbsp;&nbsp;&nbsp;${follower}</div>
							</div>
							<div>
								<div>?????????</div>

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
							onclick="location.href='${pageContext.request.contextPath}/my_page/profile/myProfile/${user.userNo}'">???????????????</li>
						<!--  <a href="#" class="button" style="width:50px; position:relative;">??????<span class="nav-counter">30</span></a> -->
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'"
							style="position: relative;">????????? <c:choose>
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
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">????????????</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">????????????</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">????????????</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">????????????</li>
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adApplication?userNo=${user.userNo}'">????????????</li>
					</ul>
				</nav>
          <section class="my-page-main-content">
            <div class="class-search">
                <div class="filter-wrap">
                    <div class="filter-list-wrap selected">
                        <div class="filter-list-item " onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adApplication?userNo=${user.userNo }'">????????????</div>
                        <div class="filter-list-item " onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adWaiting?userNo=${user.userNo }'">????????????</div>
                        <div class="filter-list-item selected" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adStatus?userNo=${user.userNo }'">???????????????</div>
                    </div>
                </div>
               
                <div class="commercial-ing">
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
                            <th>??????</th>
                            <th>??????</th>
                            <th>??????</th>
                            <th>????????????</th>
                            <th>????????????</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                        <c:forEach items="${requestScope.selectGatherADIng.content}" var="data" varStatus="status">
                            <tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
                                    <div class="table-small-image-wrap">
                                        <img src="${pageContext.request.contextPath}/save/${data.gather.gatherImg}" class="gather-img" alt="?????????" width="100%"/>
                                    </div>
                                </td>
                                <td>${data.gather.gatherName}</td>
                                <td>${fn:substring(data.adApproveDate,0,10)} ~ ${fn:substring(data.deadLine,0,10)}</td>
                                <td class="inquiry-replied">
                                   <button type="button" class="my-page-button" id="${data.advertisementNo}" value="${data.adFileName}">????????????</button>
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
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/my_page/gatherAD/adStatus?userNo=${user.userNo }&nowPage=${startPage-1}">PREV</a>
		  </c:if> 
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=selectGatherADIng.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/my_page/gatherAD/adStatus?userNo=${user.userNo }&nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=selectGatherADIng.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/my_page/gatherAD/adStatus?userNo=${user.userNo }&nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
				 
			
		
		</div>
	</nav>  
	</div>
            </div>
            <!-- ????????? ?????? -->
          </section>
        </div>
        <div class="modal-wrap" style="display: none">
            <div class="modal-title">
                ??????
            </div>
           <div class="modal-text-wrap">????????? ?????????????????????????</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button cancel-button">??????</button>
                <button type="button" class="modal-button search-id-button">
                ??????
                </button>
            </div>
        </div>
        <div class="modal-wrap" style="display: none">
            <div class="modal-title">
                ??????
            </div>
           <div class="modal-text-wrap">?????? ?????????????????????????</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button cancel-button">??????</button>
                <button type="button" class="modal-button search-id-button">
                ??????
                </button>
            </div>
        </div>
        <div class="modal-wrap" style="display: none">
           <div class="modal-text-wrap">?????? ??? ????????? ????????? ??? ????????????.</div>
            <div class="modal-button-wrap">
                <div></div>
                <button type="button" class="modal-button search-id-button">
                ??????
                </button>
            </div>
        </div>
        <!-- ????????? ?????? -->
        <div class="commercial-modal-wrap" style="display: none">
            <div class="commercial-modal-title">?????? ??????
            </div>
            <div class="create-commercial-wrap">
                <div class="create-commercial-top">
                    <div class="create-commercial-image-wrap">
                        <img width="100%" src=""/>
                    </div>
                    <div class="create-commercial-class-name">???????????? ?????? ?????????</div>
                </div>
                <div class="create-commercial-item">
                    <div class="commercial-modal-label">?????? ????????????:</div>
                    <div class="create-commercial-value-wrap">
                        <div>2022/10/22~2022/11/22</div>
                        <button type="button" class="my-page-button">?????? ??????</button>
                    </div>
                </div>
                <div class="create-commercial-item">
                    <div class="commercial-modal-label">?????? ?????? ????????? ??????(<span class="create-commercial-value-required">??????</span>)</div>
                    <div class="create-commercial-input-wrap">
                        <div>
                            <input class="my-page-form-input" readonly/>
                            <input id="create-image" type="file" class="commercial-image-input"/>
                            <div class="create-commercial-input-tip">?????? : 1000px  ?????? : 200px</div>
                        </div>
                        <label for="create-image" class="commercial-file-button">
                            ?????? ??????
                        </label>
                    </div>
                </div>
                <div class="create-commercial-item">
                    <div class="commercial-modal-label">?????? ?????? ??????:</div>
                    <div class="create-commercial-value-wrap">
                        <div>300???</div>
                        <button type="button" class="my-page-button">?????? ??????</button>
                        <button type="button" class="my-page-button-gray">?????? ??????</button>
                    </div>
                </div>
            </div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button cancel-button">??????</button>
                <button type="button" class="modal-button search-id-button">
                ??????
                </button>
            </div>
        </div>
        <div class="modal-wrap" style="display: none">
           <div class="create-commercial-warning">?????? ????????? ?????? ?????????????????????????</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button search-id-button">
                ????????????
                </button>
                <button type="button" class="modal-button cancel-button">????????????</button>
            </div>
        </div>
        
        <!-- 
        	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         -->
         
        <div class="commercial-modal-wrap" style="display: none" id="bannerUpdate">
            <div class="commercial-modal-title">?????? ????????????</div>
            <div class="modify-commercial-current-image-text">?????? ?????? ?????????</div>
            <div class="modify-commercial-current-image-wrap">
            
                <img src="" alt="img" id="current-image"/>
            </div>
            <form id="formId" method="post" enctype="multipart/form-data">
            <div class="modify-commercial-change-image-wrap">
                <div class="commercial-modal-label">?????? ?????? ????????? ??????</div>
                <div class="modify-commercial-change-image-value-wrap">
                <div>
                 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
                        <input class="my-page-form-input" type="text" id="fileName"  name="bannerName" readonly>
                       <input class="commercial-image-input" type="file" id="modify-image" name="file" >
                        <div class="create-commercial-input-tip">?????? : 1000px  ?????? : 200px</div>
                    </div>
                    <label for="modify-image" class="commercial-file-button">
                        ?????? ??????
                    </label>
                </div>
            </div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button search-id-button" onclick="updateBanner();"><!-- onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'" -->
                ????????????
                </button>
                <button type="button" class="modal-button cancel-button">????????????</button>
            </div>
            </form>    
                    
           
        </div>
        <!-- ????????? ?????? -->
      </div>
      <div id="my_modal">
	 	<table id="following" style="width: 100%">
	 		
	 		<tr class="title">
	 	
	 		<th colspan="4" class="th">
	 	
	 		?????????
	 	
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
						<p onclick="location.href='${pageContext.request.contextPath}/userProfile/profileGather/${f.followerUser.userNo}?loginUserNo=${user.userNo}'">${f.followerUser.userNick}<p>
					</th>
					<th>
						${f.followerUser.temper}???
					</th>
					<th style="width: 20%">
						<button class="modakbul-button following" id="" value="${f.followerUser.userNo}">?????????</button>
					</th>
				</tr>
			</c:forEach>
	 	</table>
	 
        </div>
         <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
         
    	</div>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
   
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
       	             // ????????? ?????????
       	             modal('my_modal');
       	             
       	            // alert("dd = " + document.querySelector(".modakbul-button following"))
       	              $modal = $("button[class='modakbul-button following']")//document.querySelector(".modakbul-button following");
       	              
       	              
       	              
       	              $(document).on("click", "button[class='modakbul-button following']" , function(){
       	                

       	                      alert("??????????????????" + " , " + $(this).val());
       	                      
       	                      let target = {"follower":$(this).val() , "following":"${userNo}"}
       	                      console.log("follower = " + $(this).val());
       	                    /*   console.log("following = " + ${userNo}); */
       	                      let targetBtn = $(this);
       	                      
       	                      if($(this).text() == "?????????"){
       	                         alert("????????? ???????");
       	                         $.ajax({
       	                            url:"${pageContext.request.contextPath}/follow/delete", 
       	                            type:"post",
       	                            dataType:"text",
       	                                data:JSON.stringify(target),   
       	                                contentType:'application/json;charset=utf-8',
       	                            success:function(result){
       	                               if(result=="ok"){
       	                                  alert("???????????? ?????? ???????????????.")                  
       	                                  
       	                                  targetBtn.css("background","rgb(243, 156, 18)")
       	                                  targetBtn.text("?????????")
       	                               }
       	                            },error:function(err){
       	                               alert("err : "+err);
       	                            }
       	                         });//Delete ajax END
       	                      }
       	                      
       	                      if($(this).text()=="?????????"){
       	                         alert("????????????????");
       	                         $.ajax({
       	                            url:"${pageContext.request.contextPath}/follow/insert",
       	                            type:"post",
       	                            dataType:"text",
       	                                data:JSON.stringify(target),   
       	                                contentType:'application/json;charset=utf-8',
       	                            success:function(result){
       	                               if(result=="ok"){
       	                                  alert("????????? ?????? ???????????????.")                  
       	                                  
       	                                  targetBtn.css("background","gray")
       	                                  targetBtn.text("?????????")
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

       	                // ?????? div ?????? ??????????????? ?????????
       	                var bg = document.createElement('div');
       	                bg.setStyle({
       	                    position: 'fixed',
       	                    zIndex: zIndex,
       	                    left: '0px',
       	                    top: '0px',
       	                    width: '100%',
       	                    height: '100%',
       	                    overflow: 'auto',
       	                    // ????????? ????????? ????????? ????????? ???
       	                    backgroundColor: 'rgba(0,0,0,0.4)'
       	                });
       	                document.body.append(bg);

       	                // ?????? ?????? ??????, ????????? ???????????? ?????? div ?????????
       	                modal.querySelector('.modal_close_btn').addEventListener('click', function() {
       	                    bg.remove();
       	                    modal.style.display = 'none';
       	                });

       	                modal.setStyle({
       	                    position: 'fixed',
       	                    display: 'block',
       	                    boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

       	                    // ????????? ????????? ?????? ?????? ?????? ?????????
       	                    zIndex: zIndex + 1,

       	                    // div center ??????
       	                    top: '50%',
       	                    left: '50%',
       	                    transform: 'translate(-50%, -50%)',
       	                    msTransform: 'translate(-50%, -50%)',
       	                    webkitTransform: 'translate(-50%, -50%)'
       	                });
       	            }

       	            // Element ??? style ????????? ??????????????? ???????????? ?????? ??????
       	            Element.prototype.setStyle = function(styles) {
       	                for (var k in styles) this.style[k] = styles[k];
       	                return this;
       	            };

       });//ready END

            $(".my-page-button").click(function(){
                var advNo = $(this).val();

                $("#bannerUpdate").show();

                $(".search-id-button").click(function(){

                    if($(this).val()=="??????"){
                  	  $.ajax({
                            type:"POST",
                            url:"${pageContext.request.contextPath}/my_page/gatherAD/updateMyAdCancel",
                            dataType:"text",
                            data: "${_csrf.parameterName}=${_csrf.token}&advertisementNo="+advNo,            
                            success:function(result){
                                    $("#adWaiting").load(location.href + " #adWaiting");
                                    
                                    $("#bannerUpdate").hide();
        
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
              $("#bannerUpdate").hide();
          })
          
          
            
        })   
    	    
        /////////////////////////////////////////////////
       let buttonVal;
  	   let filename;
  	
        $(document).on("click", "button[class='my-page-button']", function(){
        	buttonVal = $(this);
        	console.log("???????????? = " + buttonVal.val())
        	
        	//$(`.modify-commercial-current-image-wrap > img`).attr({ src: "dong.jpg" });
        	$img = document.querySelector(".modify-commercial-current-image-wrap > img");

        	$img.src = "${pageContext.request.contextPath}/save/"+buttonVal.val();//"${pageContext.request.contextPath}/save/"+buttonVal.val();
        });
  	
  	$(document).on("change", ".commercial-image-input", function(){ //?????????
        console.log($(this))
        	filename = $(this).val().split('/').pop().split('\\').pop();
  	// var filename = $(".commercial-image-input").val().split('/').pop().split('\\').pop();
          console.log("1 = "+filename)
          
        	$(this).prev().val(filename);
          //$(this).attr("name","test");
          
        	console.log($(this))
        // $(this).prev().find("input").val(filename);
	})   
	
	
	function readImage(input) {
						  
		// ?????? ????????? ????????? ?????? ??????
	    if(input.files && input.files[0]) {
	        // ????????? ???????????? ?????? (??????)
	        // FileReader ???????????? ??????
	        const reader = new FileReader()
	        // ???????????? ????????? ??? ??????
	        reader.onload = e => {
	            const previewImage = document.getElementById("current-image") 
	          
	            previewImage.src = e.target.result
	          
	        }
	        // reader??? ????????? ????????? ??????
	        reader.readAsDataURL(input.files[0])
	    }
	}

	// input file??? change ????????? ??????
	const inputImage = document.getElementById("modify-image")
	
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	})
	
	function updateBanner(){
		//var bannerName = $(".commercial-image-input").val().split('/').pop().split('\\').pop();
		var advertisementNo = $(buttonVal).attr('id')
		const banner = document.getElementById("modify-image")
		
		const inForm = document.getElementById("formId");
		
		const form = document.createElement('p');
		
		
		form.innerHTML = "<input type='text' name='advertisementNo' value='"+advertisementNo+"'>	<input type='text' name='userNo' value='"+${userNo}+"'>";
		//form.innerHTML = "<input type='text' name='bannerName' value="+filename+">"
		//form.innerHTML = 
		
		inForm.appendChild(form);
		
		inForm.action = "${pageContext.request.contextPath}/my_page/gatherAD/bannerUpdate";
		inForm.encoding="multipart/form-data";
		inForm.submit();
		
		//enctype="multipart/form-data"
		// location.href = "${pageContext.request.contextPath}/my_page/gatherAD/bannerUpdate?advertisementNo="+advertisementNo+"&bannerName="+filename+"&userNo="+${userNo}+"&file="+banner;
	}
					
        
    </script>
    
    <sec:authentication var="user" property="principal" />
    
  </body>
</html>
