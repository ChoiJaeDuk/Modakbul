<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
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
  $(function() {
	  $(document).ready(function(){		
			$('#check1').change(function(){
				location.href = "${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=6";
			})
			
			$('#check2').change(function(){
				location.href = "${pageContext.request.contextPath}/my_page/gatherSelect/waitingList?userNo=6";
			})
		})
  });
  </script>
  <body>
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
									alt="img" />

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="sign-up-image" src="${user.userProfileImg }"
								alt="img" />
						</c:if>

						<input id="sign-up-add-image" class="sign-up-add-image"
							type="file" name="file" accept="image/*" />
					</sec:authorize>
				</div>
				<div class="my-page-user-info-wrap" >
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
								<%-- <div>&nbsp;&nbsp;&nbsp;${following}</div> --%>
								<div>
									<a
										href="${pageContext.request.contextPath}/follow/followingList?userNo=7">&nbsp;&nbsp;&nbsp;${following}</a>
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
						<li class="my-page-nav-item" onclick="location.href='${pageContext.request.contextPath}/my_page/alarm/myAlarm?userNo=${user.userNo}'">알림함</li>
						<li class="my-page-nav-item selected"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=${user.userNo}'">모임조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/likeGather/myLikeGather?userNo=${user.userNo}'">관심모임</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_review?userNo=${user.userNo}'">후기조회</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/my_page_inquiry?userNo=${user.userNo}'">문의조회</li>
						<li class="my-page-nav-item">광고신청</li>
					</ul>
				</nav>
          <section class="my-page-main-content">
            <div class="class-search">
                <div class="filter-wrap">
                    <div class="filter-list-wrap" id="guest">
                    	<div class="filter-list-item selected" data-tab="tab-1" id="applicationList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=6';">신청목록</div>
                        <div class="filter-list-item" data-tab="tab-2" id="upcomingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/upcomingList?userNo=6';">예정목록</div>        
                        <div class="filter-list-item" data-tab="tab-3" id="participationList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/participationList?userNo=6';">참가목록</div>                
                    </div>
	                <div class="filter-list-wrap selected" id="host">
                        <div class="filter-list-item" data-tab="tab-4" id="waitingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/waitingList?userNo=6';">신청목록</div>
                        <div class="filter-list-item" data-tab="tab-5" id="recruitingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/recruitingList?userNo=6';">모집중</div>
                        <div class="filter-list-item selected" data-tab="tab-6" id="completionList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/completionList?userNo=6';">모집완료</div>
	                </div>
                    <div class="filter-type-wrap">
                        <div class="filter-type-item">
                            <div class="custom-radio">
                                <input type="radio" id="check1" name="gather-type"/>
                                <label for="check1"></label>
                            </div>
                            <label for="check1" class="filter-type-label">참가모임</label>
                        </div>
                        <div class="filter-type-item">
                            <div class="custom-radio">
                                <input type="radio" id="check2" name="gather-type" checked="checked"/>
                                <label for="check2"></label>
                            </div>
                            <label for="check2" class="filter-type-label">주최모임</label>
                        </div>
                    </div>
                </div>
                <div class="table-wrap selected" id="tab-6">
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
                            <th>모임날짜</th>
                            <th>모임상태</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.completionList.content}" var="completionList" varStatus="status">
                            <tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
                                    <div class="table-small-image-wrap">
                                        <img src="${pageContext.request.contextPath}/save/${completionList.gatherImg}"" alt="이미지" class="gather-img"/>
                                    </div>
                                </td>
                                <td>${completionList.gatherName}</td>
                               
                                <td>${completionList.gatherDate}</td>
                                <td>${completionList.gatherState}</td>
                            </tr>
                       	</c:forEach>
                    </table>
                </div>
            </div>     
          </section>
          
          </div>
          </div>
 
        </div>
                 <div style="text-align: center">
		<!--  블럭당  -->
 <nav class="pagination-container">
	<div class="pagination">
	<c:set var="doneLoop" value="false"/>
		
		 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
		      <a class="pagination-newer" href="${pageContext.request.contextPath}/my_page/gatherSelect/completionList?userNo=6&nowPage=${startPage-1}">PREV</a>
		  </c:if> 
		  
		<span class="pagination-inner"> 
		  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
		  
			    <c:if test="${(i-1)>=completionList.getTotalPages()}">
			       <c:set var="doneLoop" value="true"/>
			    </c:if> 
		    
		  <c:if test="${not doneLoop}" >
		         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/my_page/gatherSelect/completionList?userNo=6&nowPage=${i}">${i}</a> 
		  </c:if>
		   
		</c:forEach>
		</span> 
				
		 <c:if test="${(startPage+blockCount)<=completionList.getTotalPages()}">
		     <a class="pagination-older" href="${pageContext.request.contextPath}/my_page/gatherSelect/completionList?userNo=6&nowPage=${startPage+blockCount}">NEXT</a>
		 </c:if>
				 
			
		
		</div>
	</nav>  
</div>
      </div>
    </div>
  </body>
</html>
