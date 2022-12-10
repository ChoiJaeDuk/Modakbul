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
  $(function() {
	  $(document).ready(function(){		
			$('#check1').change(function(){
				location.href = "${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=6";
			})
			
			$('#check2').change(function(){
				location.href = "${pageContext.request.contextPath}/my_page/gatherSelect/waitingList?userNo=6";
			})
		});
	  
	  $(".my-page-button").click(function() {
			$("#confirm").val($(this).val())
			$("#modal").show()
		})
		
		$("#modalCancel").click(function() {
			$("#modal").hide()
		})
		
		$("#confirm").click(function() {
			location.href="${pageContext.request.contextPath}/my_page/gatherSelect/deleteParticipant?userNo=6&url=upcomingList&gatherNo="+$(this).val();
		})
  });
  </script>
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
                <li class="my-page-nav-item">프로필정보</li>
                <li class="my-page-nav-item">알림함</li>
                <li class="my-page-nav-item selected">모임조회</li>
                <li class="my-page-nav-item">관심모임</li>
                <li class="my-page-nav-item">후기조회</li>
                <li class="my-page-nav-item">문의조회</li>
                <li class="my-page-nav-item">광고신청</li>
            </ul>
          </nav>
          <section class="my-page-main-content">
            <div class="class-search">
                <div class="filter-wrap">
                    <div class="filter-list-wrap selected" id="guest">
                    	<div class="filter-list-item" data-tab="tab-1" id="applicationList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList?userNo=6';">신청목록</div>
                        <div class="filter-list-item selected" data-tab="tab-2" id="upcomingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/upcomingList?userNo=6';">예정목록</div>        
                        <div class="filter-list-item" data-tab="tab-3" id="participationList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/participationList?userNo=6';">참가목록</div>                
                    </div>
	                <div class="filter-list-wrap" id="host">
                        <div class="filter-list-item selected" data-tab="tab-4" id="waitingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/waitingList?userNo=6';">신청목록</div>
                        <div class="filter-list-item" data-tab="tab-5" id="recruitingList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/recruitingList?userNo=6';">모집중</div>
                        <div class="filter-list-item" data-tab="tab-6" id="completionList" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/completionList?userNo=6';">모집완료</div>
	                </div>
	          		<div class="filter-type-wrap">
                        <div class="filter-type-item">
                            <div class="custom-radio">
                                <input type="radio" id="check1" name="gather-type" checked="checked"/>
                                <label for="check1"></label>
                            </div>
                            <label for="check1" class="filter-type-label">참가모임</label>
                        </div>
                        <div class="filter-type-item">
                            <div class="custom-radio">
                                <input type="radio" id="check2" name="gather-type"/>
                                <label for="check2"></label>
                            </div>
                            <label for="check2" class="filter-type-label">주최모임</label>
                        </div>
                    </div>
                </div>
               <!-- 신청목록 테이블 -->
                <div class="table-wrap selected" id="tab-2">
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
                            <th>모임날짜</th>
                            <th>취소</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${requestScope.upcomingList.content}" var="upcomingList" varStatus="status">
                            <tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
                                <div class="table-small-image-wrap">
                                        <img src="${pageContext.request.contextPath}/save/${upcomingList.gatherImg}" class="gather-img" alt="이미지"/>
                                    </div>
                                </td>
                                <td>${upcomingList.gatherName}</td>
                                <td>${upcomingList.user.userNick}</td>
                                <td>${upcomingList.gatherDate}</td>
                                <td>
                                    <button class="my-page-button" value="${upcomingList.gatherNo}">취소</button>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
             </div>
          </section>
          <div class="modal-wrap" hidden="" id="modal">
            <div class="modal-title">
                내용
            </div>
           <div class="modal-text-wrap">정말 신청취소 하시겠습니까?</div>
            <div class="modal-button-wrap" >
                <button type="button" class="modal-button cancel-button" id="modalCancel">취소</button>
                <button type="button" class="modal-button search-id-button" id="confirm">확인</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
