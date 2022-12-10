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
			$('.filter-list-wrap div').click(function(){
				var tab_id = $(this).attr('data-tab');
	
				$('.filter-list-wrap div').removeClass('selected');
				$('.table-wrap').removeClass('selected');
	
				$(this).addClass('selected');
				$("#"+tab_id).addClass('selected');
			})
	
		})
		
	 $(document).ready(function(){		
			$('#check1').change(function(){
				$('#host').removeClass('selected');
				$('.table-wrap').removeClass('selected');
				$('.filter-list-wrap div').removeClass('selected');
				
				$("#applicationList").addClass('selected');
				$("#tab-1").addClass('selected');
				$("#guest").addClass('selected');
				
			})
			
			$('#check2').change(function(){
				$('#guest').removeClass('selected');
				$('.table-wrap').removeClass('selected');
				$('.filter-list-item div').removeClass('selected');
				
				$("#recruitmentList").addClass('selected');
				$("#tab-4").addClass('selected');
				$("#host").addClass('selected');
				
			})
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
                    	<div class="filter-list-item selected" data-tab="tab-1" id="applicationList">신청목록</div>
                        <div class="filter-list-item" data-tab="tab-2" id="upcomingList">예정목록</div>        
                        <div class="filter-list-item" data-tab="tab-3" id="participationList">참가목록</div>                
                    </div>
	                <div class="filter-list-wrap" id="host">
                        <div class="filter-list-item selected" data-tab="tab-4" id="recruitmentList">신청목록</div>
                        <div class="filter-list-item" data-tab="tab-5" id="waitingList">모집중</div>
                        <div class="filter-list-item" data-tab="tab-6" id="completionList">모집완료</div>
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
                <!-- 예정목록 테이블 -->
                <div class="table-wrap selected" id="tab-1">
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
                        <c:forEach items="${requestScope.applicationList.content}" var="applicationList" varStatus="status">
                        	<tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
                                <div class="table-small-image-wrap">
                                        <img src="${pageContext.request.contextPath}/save/${applicationList.gatherImg}" class="gather-img" alt="이미지"/>
                                    </div>
                                </td>
                                <td>${applicationList.gatherName}</td>
                                <td>${applicationList.user.userNick}</td>
                                <td>${applicationList.gatherDate}</td>
                                <td>
                                    <button class="my-page-button">취소</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                                <div style="text-align: center">
		<!--  블럭당  -->
				 <nav class="pagination-container">
					<div class="pagination">
					<c:set var="doneLoop" value="false"/>
						
						 <c:if test="${(startPage-blockCount) > 0}"> <!-- (-2) > 0  -->
						      <a class="pagination-newer" href="${pageContext.request.contextPath}/my_page/myPage-gatherSelect?nowPage=${startPage-1}&userNo=6">PREV</a>
						  </c:if> 
						  
						<span class="pagination-inner"> 
						  <c:forEach var='i' begin='${startPage}' end='${(startPage-1)+blockCount}'> 
						  
							    <c:if test="${(i-1)>=applicationList.getTotalPages()}">
							       <c:set var="doneLoop" value="true"/>
							    </c:if> 
						    
						  <c:if test="${not doneLoop}" >
						         <a class="${i==nowPage?'pagination-active':page}" href="${pageContext.request.contextPath}/my_page/myPage-gatherSelect?nowPage=${i}&userNo=6">${i}</a> 
						  </c:if>
						   
						</c:forEach>
						</span> 
								
						 <c:if test="${(startPage+blockCount)<=applicationList.getTotalPages()}">
						     <a class="pagination-older" href="${pageContext.request.contextPath}/my_page/myPage-gatherSelect?nowPage=${startPage+blockCount}&userNo=6">NEXT</a>
						 </c:if>
								 
							
						
						</div>
					</nav>  
				</div>
                </div>
    
               <!-- 신청목록 테이블 -->
                <div class="table-wrap" id="tab-2">
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
                                    <button class="my-page-button">취소</button>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- 참가목록 테이블 -->
                <div class="table-wrap" id="tab-3">
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
                            <th>진행상태</th>
                            <th>모임날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.participationList.content}" var="participationList" varStatus="status">
                            <tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
									<div class="table-small-image-wrap">
                                        <img src="${pageContext.request.contextPath}/save/${participationList.gatherImg}" class="gather-img" alt="이미지"/>
                                    </div>			
								</td>
                                <td>${participationList.gatherName}</td>   
                                <td>${participationList.user.userNick}</td>
                                <td>${participationList.gatherState}</td>
                                <td>${participationList.gatherDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="class-search">
            <!-- 주최자 -->
                
                <div class="table-wrap" id="tab-4">
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
                            <th>신청날짜</th>
                            <th>신청취소</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.recruitmentList.content}" var="recruitmentList" varStatus="status">
                            <tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
                                    <div class="table-small-image-wrap">
                                        <img src="${pageContext.request.contextPath}/save/${recruitmentList.gatherImg}" alt="이미지" class="gather-img"/>
                                    </div>
                                </td>
                                <td>${recruitmentList.gatherName}</td>
                                <td>${recruitmentList.gatherRegisDate}</td>
                                <td class="inquiry-replied">
                                    <button class="my-page-button">취소하기</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- 모집 중 -->
                <div class="table-wrap" id="tab-5">
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
                            <tr class="table-body">
                                <td>1</td>
                                <td>
                                    <div class="table-small-image-wrap">
                                        <img src="" alt="이미지" class="gather-img"/>
                                    </div>
                                </td>
                                <td>핸드드립</td>
                                <td>2022.11.23</td>
                                <td>답변 대기</td>
                                <td>
                                    <div class="table-interest-wrap">
                                        <div class="table-heart"></div>
                                        <div>
                                            24
                                        </div>
                                    </div>
                                </td>
                                <td class="inquiry-replied">
                                    <button class="my-page-button">확인하기</button>
                                </td>
                            </tr>
                            <tr class="table-body">
                                <td>2</td>
                                <td>
                                    <div class="table-small-image-wrap">
                                        <img src="" alt="이미지" class="gather-img"/>
                                    </div>
                                </td>
                                <td>커피</td>
                                <td>2022.11.23</td>
                                <td>9/10명</td>
                                <td>
                                    <div class="table-interest-wrap">
                                        <div class="table-heart"></div>
                                        <div>
                                            24
                                        </div>
                                    </div>
                                </td>
                                <td class="inquiry-replied">
                                    <button class="my-page-button">확인하기</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="table-wrap" id="tab-6">
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
  </body>
</html>
