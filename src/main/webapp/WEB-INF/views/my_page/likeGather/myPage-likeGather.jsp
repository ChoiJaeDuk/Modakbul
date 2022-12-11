<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${pageContext.request.contextPath}/css/my-page/likeGather/index.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/my-page/likeGather/reset.css" rel="stylesheet" />
    <title>마이페이지-관심모임</title>
</head>
<body>
<div class="wrap">
      <div class="my-page-wrap">
        <div class="my-page-header">
          <div class="my-page-image-wrap">
            <img
              src="https://dummyimage.com/200x200/e8e3e8/fff&text=img"
              alt="img"
            />
          </div>
          <div class="my-page-user-info-wrap">
            <div class="my-page-user-name">
              <div>임지은님</div>
              <button class="my-page-button" type="button">프로필 편집</button>
            </div>
            <div class="my-page-user-temperature">모닥불 온도 : 36.5&#8451</div>
            <div class="my-page-user-follow-wrap">
                <div>
                    <div>팔로워</div>
                    <div>320</div>
                </div>
                <div>
                    <div>팔로잉</div>
                    <div>11</div>
                </div>
            </div>
          </div>
        </div>
        <div class="my-page-content-wrap">
          <nav>
            <ul>
                <li class="my-page-nav-item selected">프로필정보</li>
                <li class="my-page-nav-item">알림함</li>
                <li class="my-page-nav-item">모임조회</li>
                <li class="my-page-nav-item">관심모임</li>
                <li class="my-page-nav-item">후기조회</li>
                <li class="my-page-nav-item">문의조회</li>
                <li class="my-page-nav-item">광고신청</li>
            </ul>
          </nav>
          <section class="my-page-main-content">
            <div class="interest">
                <table class="table">
                    <colgroup>
                        <col width="8%" />
                        <col width="34%" />
                        <col width="15%" />
                        <col width="21%" />
                        <col width="12%" />
                        <col width="12%" />
                    </colgroup>
                    <thead>
                        <tr class="table-header">
                        <th>번호</th>
                        <th>사진</th>
                        <th>모임</th>
                        <th>주최자</th>
                        <th>(모임)날짜</th>
                        <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    	<c:forEach items="${pageList.content}" var="lg" varStatus="state">
                        <tr class="table-body">
                            <td>${state.count}</td>
                            <td><img src="img/${lg.gather.gatherImg}"></td>
                            <td>${lg.gather.gatherName}</td>
                            <td>${lg.gather.user.userNick}</td>
                            <td>
                            	<%-- <fmt:formatDate value="${lg.gather.gatherDate}" pattern="yyyy-MM-dd" type="date"/> --%>
                            	${lg.gather.gatherDate}
                            </td>
                            <td>
                                <button class="my-page-button" onclick="location.href='${pageContext.request.contextPath}/likeGather/deleteButton?gatherNo=${lg.gather.gatherNo}&userNo=${userNo}';">삭제</button>
                            </td>
                        </tr>
                        </c:forEach>
                        
                    </tbody>
                </table>
            </div>
            <div style="text-align: center">
		<!--  블럭당  -->
 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/likeGather/myLikeGather?userNo=${userNo}&nowPage=${startPage-1}">PREV</a>
		  </c:if> 
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=pageList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/likeGather/myLikeGather?userNo=${userNo}&nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=pageList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/likeGather/myLikeGather?userNo=${userNo}&nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
				 
			
		
		</div>
	</nav>  
</div>
          </section>
        </div>
        <div class="modal-wrap" style="display: none">
            <div class="modal-title" >
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
           <div class="modal-text-wrap">하루 전 모임은 취소할 수 없습니다.</div>
            <div class="modal-button-wrap">
                <div></div>
                <button type="button" class="modal-button search-id-button">
                확인
                </button>
            </div>
        </div>
      </div>
    </div>

</body>
</html>