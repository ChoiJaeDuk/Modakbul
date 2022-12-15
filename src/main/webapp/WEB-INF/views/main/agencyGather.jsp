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
    <link href="${pageContext.request.contextPath}/css/main/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/main/reset.css" rel="stylesheet" />
    <title>Document</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
		var categoryList =[];
		var sort="";
		var gatherType="agency";
		var search="";
		var place="";
		var nowPage;
		var agoPage=1;
    	$(function() {
    		
			$(document).ready(function(){
    			
				$("#gov").attr("class", "modakbul-header header-selected");
			 /*  $(":header").css("background-color", "yellow"); */

			});
    		
    		///////////ajax페이징
    		$(document).on("click","a",function() {
    			
    			nowPage=$(this).attr("id");
    			agoPage=$(this).attr("id");
    			selectGatherList();
			})
    		
    		$(document).ajaxSend(function(e,xht,op){
		         xht.setRequestHeader("${_csrf.headerName}" ,"${_csrf.token}");
		      });
    		
    		var object = {
    				"${_csrf.parameterName}":"${_csrf.token}",
    				"categoryList" : categoryList,
    				"sort"	: sort,
    				"search" : search,
    				"place" : place,
    				"gatherType" : gatherType,
    				"nowPage" : nowPage
    		}//JSON.stringify(object)
    		
    		
    		selectGatherList();
    		
    		
    		function selectGatherList() {
    			
    			object = {
        				"${_csrf.parameterName}":"${_csrf.token}",
        				"categoryList" : categoryList,
        				"sort"	: sort,
        				"search" : search,
        				"place" : place,
        				"gatherType" : gatherType,
        				"nowPage" : nowPage
        		}
    			
    			
    			$.ajax({
    				type:"POST",
    				url:"${pageContext.request.contextPath}/main/ajaxPage",
    				data:object, 
    				dataType:"json",
    				//contentType:'application/json;charset=utf-8',
    				success:function(result){
    					
    					console.log(result.gatherList.totalPages)
    					var str ="";
    					$.each(result.gatherList.content, function(index,item) {
    							str += `<article class="search-list-result-item" name="detail" id=${"${item.gatherNo}"}>`;
    							str += `<div class="search-list-result-item-image-wrap">`;
    							str += `<img src="${pageContext.request.contextPath}/save/"${'${item.gatherImg}'} alt="이미지" width="100%" />`;
    							str += `</div>`;
    							str += `<div class="search-list-result-item-info">`;
    							str += `<div class="search-list-result-item-title">`;
    							str += `${"${item.gatherName}"}</div>`;
    							str += `<div class="search-list-result-item-text">모집인원 : ${"${item.gatherMaxUsers}"}</div>`;
    							str += `<div class="search-list-result-item-text">마감일 : ${"${item.gatherDeadline}"}</div>`;
    							str += `<div class="search-list-result-item-date">`;
    							str += `<div>모임날짜 : ${"${item.gatherDate}"}</div>`;
    							str += `<div class="user-nick">작성자 : ${"${item.user.userNick}"}</div>`;
    							str += `</div>`;
    							str += `</div>`;
    							str += `</article>` 
						});
    					var startPage = result.startPage;
    					var blockCount = result.blockCount;
    					var gatherList = result.gatherList;
    					nowPage = result.nowPage;
    					var result = false;
  						
    					var page =`<div class="pagination">`
    					if ( (startPage-blockCount) > 0){
    						
    						page +=	`<a name='page' id=${"${nowPage=startPage-1}"} class="pagination-newer">PREV</a>`
    						
    					} <!-- (-2) > 0  --> 
    				 	page +=	`<span class="pagination-inner">`;
    				 	for(let i = startPage; i<=(startPage-1)+ blockCount ; i++){
    				 		if( (i-1) >= gatherList.totalPages ){
    				 			result=false;
    				 		}else{
    				 			
    				 			page +=`<a name='page' class="${"${i==agoPage ? 'pagination-active': 'page'}"}" id=${"${nowPage=i}"}>${"${i}"}</a>`;
    				 			
    				 		}
    				 		if(result) break;
    				 	}
    				 	page +=	`</span>`; 				
    							 					
    				 	page +=	`</div>`;
    				 	page +=	`</span>`;
    				 	//
    				 	if(startPage+blockCount<=gatherList.totalPages){
    				 		
    				 		page +=	`<a name='page' id=${"${nowPage=startPage+blockCount}"} class="pagination-older">NEXT</a>`;
    				 		
    				 	}		
    				 	
    				 	page +=	`</div>`;
    				 	
    				 
    					$(".pagination-container").html(page);
    					$(".search-list-result-wrap").html(str)
    				},
    				error: function(err) {
						alert(err)
					}
    			})//ajax
    		}
		
    		//////////////////////////////////////
    		
    		$("#search-btn").click(function() {
    			nowPage=1;
			    agoPage=1;
    			search=$("#search-text").val()
    			selectGatherList();
			})
    		
    		$(document).ready(function(){
    			
    			textchange = true;
    			$('.category-btn').click(function(){
    			    if(textchange){
    			      textchange = false;
    			      $(this).addClass("selected")
    			      categoryList[$(this).val()] = $(this).val()+1
    		
    			    }else{
    			      textchange = true;
    			      $(this).removeClass("selected")
    			      delete categoryList[$(this).val()];
    			      
    			    }
    			    nowPage=1;
    			    agoPage=1;
    			    console.log(categoryList)
    			    
    				selectGatherList();
    			})
    		})
    		
    		$("#sort").change(function() {
				sort = $(this).val();
				selectGatherList();
		
			})
			
			
			$("#place-search-btn").click(function() {
				nowPage=1;
			    agoPage=1;
				place = $("#place-search").val();
				selectGatherList();
				$("#place-search").text("")
			})
			
			
			$("#gather-insert-btn").click(function() {
				$(".modal-wrap").show()
				$("#regularGather").val($("#userNo").val())
				$("#dayTime").val($("#userNo").val())
			})
			
			$("#regularGather").click(function() {
				location.href="${pageContext.request.contextPath}/gather/regularGatherInsertForm?userNo="+$(this).val()
			})
			
			$("#dayTime").click(function() {
				location.href="${pageContext.request.contextPath}/gather/dayTimeGatherInsertForm?userNo="+$(this).val()
			})
			
			$(document).on("click", "[name='detail']", function() {
				var gatherNo = $(this).attr("id")
				location.href="${pageContext.request.contextPath}/gatherDetail/info?userNo="+$("#userNo").val()+"&gatherNo="+gatherNo;
			})
			
			$(".cancel-button").click(function() {
				$(".modal-wrap").hide();
			})
		})	    
    </script>
  </head>
  <body>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <sec:authorize access="isAuthenticated()">
	<sec:authentication var="user" property="principal" />
	<input type="hidden" value="${user.userNo }" id="userNo">
	</sec:authorize>
    <div class="wrap">
      <div class="search-list">
        <div class="search-list-top">
        
          <div class="search-list-main-filter">
         	<div><button class="my-page-button" id="gather-insert-btn" value="67">모임등록</button></div>
            <ul class="search-list-main-filter-wrap">
              <li class="search-list-main-filter-item selected" onclick="location.href='${pageContext.request.contextPath}/main/agencyGather'">모임검색</li>
              <li class="search-list-main-filter-item" onclick="location.href='${pageContext.request.contextPath}/main/searchUserCom'">회원검색</li>
            </ul>
            <div class="search">
			  <input id="search-text" type="text" placeholder="검색어 입력">
			  <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" id="search-btn">
			</div>
			<ul class="search-list-main-filter-wrap" style="margin-left: 50px;">
              <li class="search-list-main-filter-item selected">지역검색</li>
            </ul>
			<div class="search place">
			  <input id="place-search" type="text" placeholder="검색어 입력">
			  <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" id="place-search-btn">
			</div>
			
            <select class="select-small" name="sort" id="sort">
              <option value="">---선택---</option>
              <option value="likeCount">관심순</option>
              <option value="userTemper">온도순</option>
              <option value="gatherDeadLine">마감임박순</option>
            </select>
            
          </div>
        </div>
        <div class="search-list-body">
          <aside class="search-list-sub-filter">
            <ul class="search-list-filter-categpry">
              <li class="search-list-filter-item category-btn" value="0">스포츠</li>
              <li class="search-list-filter-item category-btn" value="1">클래스</li>
              <li class="search-list-filter-item category-btn" value="2">자유</li>
            </ul>
          </aside>
          <main>
            <section class="search-list-result-wrap">
       
            </section>
          </main>
        </div>
        <div style="text-align: center">
        	<nav class="pagination-container">
        	
        	</nav>
        </div>
        
        <!-- 기관 개인 선택 모달 -->
      <div class="modal-wrap" hidden="">
        <div class="modal-sign-up-button-wrap">
          <button class="sign-up-agency-button" id="regularGather">정기모임</button>
          <button class="sign-up-individual-button" id="dayTime">일일모임</button>
        </div>
        <div class="modal-button-wrap">
          <div></div>
          <button type="button" class="modal-button cancel-button">닫기</button>
          <div></div>
        </div>
      </div>
      </div>
    </div>
   <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
