<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MODAKBUL</title>
	 <link href="${pageContext.request.contextPath}/css/admin/adminNav.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminPaging.css" rel="stylesheet" />
     <link href="${pageContext.request.contextPath}/css/admin/adminCharged.css" rel="stylesheet" />
     <style type="text/css">
     td:first-child {
		width: 100px;
	 }
     </style>
     <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
	 <script type="text/javascript">
	 	$(function() {
			$(".button-gather-state").hover(
			function() {
				if("모집보류"==$(this).text()){
					$(this).css("background","lightgray")
					$(this).text("모집중")
				}else{
					$(this).css("background","lightgray")
					$(this).text("모집보류")
				}
			},
			function() {
				if("모집보류"==$(this).text()){
					$(this).css("background","white")
					$(this).text("모집중")
				}else{
					$(this).css("background","white")
					$(this).text("모집보류")
				}
			})
			
			$(document).on("click", ".button-gather-state", function () {
		  		$("#approve").attr("name",$(this).text())
				$("#approve").val($(this).val());
		  		$("#regularGatherNo").val($(this).attr("id"))
		        action_popup.confirm("해당 모임을 "+ $(this).text() +"(으)로 상태변경 하시겠습니까?", function (res) {
		            if (res) {
		                action_popup.alert("상태를 변경하였습니다.");
		            }
		        })
		    });
	  	    
			
			$(document).on("click", ".button-gather-cancel", function () {
				$("#approve").attr("name",$(this).text())
				$("#approve").val($(this).val());
				$("#regularGatherNo").val($(this).attr("id"))
		        action_popup.confirm("해당 모임을 취소하시겠습니까?", function (res) {
		            if (res) {
		                action_popup.alert("모임을 취소하였습니다.");
		            }
		        })
		    });
			
	 
	  	  	$(".modal_close").on("click", function () {
	          	action_popup.close(this);
	     	});
	  	  
	  	 	$("#approve").on("click", function() {
	  			location.href="${pageContext.request.contextPath}/admin/updateGatherState?nowPage="+${nowPage}+"&gatherNo=" + $(this).val() + "&state=" + $(this).attr("name") + "&regularGatherNo="+ $("#regularGatherNo").val();
			});
		});
	 	
	 	//팝업/////////////////////////////////////////////////
	 	jQuery.fn.center = function () {
	   	 	 this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	  	 	 this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	    	 return this;
		}
	 	
	 	var action_popup = {
	  		    timer: 500,
	  		    confirm: function (txt, callback) {
	  		        if (txt == null || txt.trim() == "") {
	  		            console.warn("confirm message is empty.");
	  		            return;
	  		        } else if (callback == null || typeof callback != 'function') {
	  		            console.warn("callback is null or not function.");
	  		            return;
	  		        } else {
	  		            $(".type-confirm .btn_ok").on("click", function () {
	  		                $(this).unbind("click");
	  		                callback(true);
	  		                action_popup.close(this);
	  		            });
	  		            this.open("type-confirm", txt);
	  		        }
	  		    },

	  		    alert: function (txt) {
	  		        if (txt == null || txt.trim() == "") {
	  		            console.warn("confirm message is empty.");
	  		            return;
	  		        } else {
	  		            this.open("type-alert", txt);
	  		        }
	  		    },

	  		    open: function (type, txt) {
	  		        var popup = $("." + type);
	  		        popup.find(".menu_msg").text(txt);
	  		        $("body").append("<div class='dimLayer'></div>");
	  		        $(".dimLayer").css('height', $(document).height()).attr("target", type);
	  		        popup.fadeIn(this.timer);
	  		      	popup.center();
	  		    },

	  		    close: function (target) {
	  		        var modal = $(target).closest(".modal-section");
	  		        var dimLayer;
	  		        if (modal.hasClass("type-confirm")) {
	  		            dimLayer = $(".dimLayer[target=type-confirm]");
	  		            $(".type-confirm .btn_ok").unbind("click");
	  		        } else if (modal.hasClass("type-alert")) {
	  		            dimLayer = $(".dimLayer[target=type-alert]")
	  		        } else {
	  		            console.warn("close unknown target.")
	  		            return;
	  		        }
	  		        modal.fadeOut(this.timer);
	  		        setTimeout(function () {
	  		            dimLayer != null ? dimLayer.remove() : "";
	  		        }, this.timer);
	  		    }
	  		}
	 	//////////////////////////////////////////////////
	 </script>
  <body>
   <input type="text" hidden="" id="regularGatherNo"/>
   <jsp:include page="../layout/header.jsp" />
    <div id="modakbul-outer-wrapper">
    
      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu navigation-selected">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageGather'">유료계정 / 승인</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageSales'">매출현황</p>
          </div>
          <div class="modakbul-navigation-menu">
            <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAdvAll'">광고관리</p>
          </div>
        </nav>
        <div class="modakbul-content">
        
		 <div class="cont-wrap">
			<div class="nav-wrap">
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageAll" >전체</a></div>
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageIndiv?job=개인">개인회원</a></div>
				<div class="manageGroup-nav"><a href="${pageContext.request.contextPath}/admin/manageCom?job=기관">기관/사업자</a></div>
				<div class="manageGroup-nav selected" ><a href="${pageContext.request.contextPath}/admin/manageGroup">모임관리</a></div>
			</div>
			
			
			<div id="gather" class="content"> 
				<table>
				
					<tr class="table-header">
						<th>NO</th>
						<th>모임</th>
						<th>모임명</th>
						<th>주최자</th>
						<th>구분</th>
						<th>등록일</th>
						<th>모임일</th>
						<th>모임상태</th>
						<th>모임취소</th>
					</tr>
					<c:forEach items="${requestScope.gatherList.content}" var="gatherList" varStatus="status">
					<c:set var="gatherRegisDate" value="${gatherList.gatherRegisDate}" />
					<c:set var="gatherDate" value="${gatherList.gatherDate}" />
					<tr>
						<td>${status.index+1}</td>
						<td>
							<div class="modakbul-charged-grid-col">
	                			<img class="gather-img" src="${pageContext.request.contextPath}/save/${gatherList.gatherImg}" alt="modakbul-charged-img" />
	              			</div>
	              		</td>
						<td>${gatherList.gatherName}</td>
						<td>${gatherList.user.userNick}</td>
						
						<c:choose>
                        	<c:when test="${null eq gatherList.gatherBid}">
                        		<td>무료</td>
	                        </c:when>
	                        <c:otherwise>
	                          	<td>유료</td>
	                        </c:otherwise>
                        </c:choose>			
						<td>${fn:substring(gatherRegisDate,0,10)}</td>
						<td>${fn:substring(gatherDate,0,10)}</td>
						<td>
							<button class="button-gather-state" id="${gatherList.regularGather.regularGatherNo}" value="${gatherList.gatherNo}">${gatherList.gatherState}</button>
						</td>
						<td>
							<button class="button-gather-cancel" id="${gatherList.regularGather.regularGatherNo}" value="${gatherList.gatherNo}">모임취소</button>
						</td>
					</tr>
				</c:forEach>	
				</table>
			</div> 
		  </div>
	    </div> 
      </div>  
    </div>
    
           <!-- confirm 모달을 쓸 페이지에 추가 start-->
        <section class="modal modal-section type-confirm">
            <div class="enroll_box">
                <p class="menu_msg"></p>
            </div>
            <div class="enroll_btn">
                <button class="btn pink_btn btn_ok">확인</button>
                <button class="btn gray_btn modal_close">취소</button>
            </div>
        </section>

        <!-- confirm 모달을 쓸 페이지에 추가 end-->

        <!-- alert 모달을 쓸 페이지에 추가 start-->
        <section class="modal modal-section type-alert">
            <div class="enroll_box">
                <p class="menu_msg"></p>
            </div>
            <div class="enroll_btn">
                <button class="btn pink_btn modal_close"  id="approve">확인</button>
            </div>
        </section>
    
 
  <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		  <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageGroup?nowPage=${startPage-1}">PREV</a>
		  </c:if>
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		
			    <c:if test="${(i-1)>=gatherList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageGroup?nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=gatherList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageGroup?nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if> 

		</div>
	</nav>
  </body>
   <jsp:include page="../layout/footer.jsp" />
</html>