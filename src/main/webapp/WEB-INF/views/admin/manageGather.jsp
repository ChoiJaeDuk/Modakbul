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
    <title>MODAKBUL</title>
    <link href="${pageContext.request.contextPath}/css/admin/adminLayout.css" rel="stylesheet" />
   	<link href="${pageContext.request.contextPath}/css/admin/adminCharged.css" rel="stylesheet" />
	<style type="text/css">
		
	</style>
	<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
  	<script type="text/javascript">
  	$(function() {
  	    //사용 예시 **************************
  	    $(document).on("click", ".button-agree", function () {
  	    	$("#approve").val($(this).attr("id"))
  	    	$("#approve").attr("name",$(this).val())
  	        action_popup.confirm("해당 모임을 승인하시겠습니까?", function (res) {
  	            if (res) {
  	                action_popup.alert("승인되었습니다!!");
  	            }
  	        })
  	    });
  	    
  	    
  	  $(document).on("click", ".button-deny", function () {
	    	$("#approve").val($(this).attr("id"))
	    	$("#approve").attr("name",$(this).val())
	        action_popup.confirm("해당 모임을 거절하시겠습니까?", function (res) {
	            if (res) {
	                action_popup.alert("거절되었습니다");
	            }
	        })
	    });
  	    
 
  	  	$(".modal_close").on("click", function () {
          	action_popup.close(this);
     	});
  	  
  	 	$("#approve").on("click", function() {
  			location.href="${pageContext.request.contextPath}/admin/gatherApprove?gatherNo="+$(this).val()+"&state=" + $(this).attr("name");
		});
  	 	
  	 	
  	 	
  	 	$(document).on("click", ".button-detail", function() {
			alert($(this).attr("id"))
			
			location.href = "${pageContext.request.contextPath}/gatherDetail/info?gatherNo="+$(this).attr("id")+"&userNo=4";
		})
  	});
  	
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
  	</script>
 </head>
 
   <body>

 
   <jsp:include page="../layout/header.jsp" /> 
    <div id="modakbul-outer-wrapper">
    

      <div id="modakbul-inner-wrapper" class="flex">
        <nav class="modakbul-navigation">
          <div class="modakbul-navigation-menu">
           <p onclick="location.href='${pageContext.request.contextPath}/admin/manageAll'">운영현황</p>
          </div>
          <div class="modakbul-navigation-menu navigation-selected">
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
          <!-- 여기에 내용 넣으면 됨. -->
          
		<c:forEach items="${requestScope.gatherList.content}" var="gatherList" varStatus="status">
            <div class="modakbul-charged-grid-row">
              <div class="modakbul-charged-grid-col">
                <img class="gather-img" src="${pageContext.request.contextPath}/save/${gatherList.gatherImg}" alt="modakbul-charged-img" />
              </div>
              <div class="modakbul-charged-grid-col">
                <p class="modakbul-charged-grid-title">
                  ${gatherList.gatherName}
                </p>
                <div class="modakbul-charged-grid-director flex">
                  <p class="modakbul-charged-grid-director-info">
                    <span>주최자</span> ${gatherList.user.userNick}
                  </p>
                  <button class="modakbul-button button-detail" id="${gatherList.gatherNo}" >
                    모임 상세보기
                  </button>
                </div>
              </div>
              <div class="modakbul-charged-grid-col">
                <button class="modakbul-button button-agree" id="${gatherList.gatherNo}" value="모집중">승인하기</button>
                <button class="modakbul-button button-deny" id="${gatherList.gatherNo}" value="승인거절">거절하기</button>
              </div>
            </div>
            </c:forEach>
            
            
          </div>
          <!-- 여기까지 content -->
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
        <div style="text-align: center">
		<!--  블럭당  -->
		 <nav class="pagination-container">
			<div class="pagination">
			<c:set var="doneLoop" value="false"/>
				
				 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
				      <a class="pagination-newer" href="${pageContext.request.contextPath}/admin/manageGather?nowPage=${startPage-1}">PREV</a>
				  </c:if> 
				  
				<span class="pagination-inner"> 
				  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
				  
					    <c:if test="${(i-1)>=gatherList.getTotalPages()}">
					       <c:set var="doneLoop" value="true"/>
					    </c:if> 
				    
				  <c:if test="${not doneLoop}" >
				         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/admin/manageGather?nowPage=${i}">${i}</a> 
				  </c:if>
				   
				</c:forEach>
				</span> 
						
				 <c:if test="${(startPage+blockCount)<=gatherList.getTotalPages()}">
				     <a class="pagination-older" href="${pageContext.request.contextPath}/admin/manageGather?nowPage=${startPage+blockCount}">NEXT</a>
				 </c:if>
						 
					
				
				</div>
			</nav>  
		</div>
        
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
