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
		$("[name=adApplication-btn]").click(function() {
			
			var gatherNo = $(this).val();
			
			$("#ad-form").show();
			$("#ad-form img").attr("src","${pageContext.request.contextPath}/save/"+$(this).val())
			
			$(".search-id-button").click(function(){

                  if($(this).val()=="등록"){
                	  $.ajax({
                          type:"POST",
                          url:"${pageContext.request.contextPath}/my_page/gatherAD/insertAd",
                          dataType:"text",
                          data: "${_csrf.parameterName}=${_csrf.token}&gatherNo="+gatherNo,            
                          success:function(result){
                              
                          
                                  alert(result);
                                  $("#adInsert").load(location.href + " #adInsert");
                                  
                                  $("#ad-form").hide();
      
                          },//function
                          error:function(error){
                              console.log(error)
                          }
                          
                      });
                  }else{
                      $("#ad-form").hide();
                  }
              })
			
		})
		
		$(".cancel-button").click(function() {
			$("#ad-form").hide();
		})
	})
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
                <li class="my-page-nav-item">프로필정보</li>
                <li class="my-page-nav-item">알림함</li>
                <li class="my-page-nav-item">모임조회</li>
                <li class="my-page-nav-item">관심모임</li>
                <li class="my-page-nav-item">후기조회</li>
                <li class="my-page-nav-item">문의조회</li>
                <li class="my-page-nav-item selected">광고신청</li>
            </ul>
          </nav>
          <section class="my-page-main-content">
            <div class="class-search">
                <div class="filter-wrap">
                    <div class="filter-list-wrap selected">
                        <div class="filter-list-item selected" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adApplication?userNo=6'">광고신청</div>
                        <div class="filter-list-item" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adWaiting?userNo=6'">신청대기</div>
                        <div class="filter-list-item" onclick="location.href='${pageContext.request.contextPath}/my_page/gatherAD/adStatus?userNo=6'">광고진행중</div>
                    </div>
                </div>
                <div class="commercial" id="adInsert">
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
                            <th>구분</th>
                            <th>신청하기</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${requestScope.adApplicationList.content}" var="adApplicationList" varStatus="status">
                            <tr class="table-body">
                                <td>${status.index+1}</td>
                                <td>
                                    <div class="table-small-image-wrap">
                                        <img class="gather-img" src="${pageContext.request.contextPath}/save/${adApplicationList.gatherImg}" alt="이미지" width="100%"/>
                                    </div>
                                </td>
                                <td>${adApplicationList.gatherName}</td>
                                <td>
                                <c:choose>
                                	<c:when test="${0 eq adApplicationList.gatherBid}">
                                		무료모임
                                	</c:when>
                                	<c:otherwise>
                                		유료모임
                                	</c:otherwise>
                                </c:choose>
                                </td>
                                <td class="inquiry-replied">
                                    <button class="my-page-button" name="adApplication-btn" id="${adApplicationList.gatherNo}" value="${adApplicationList.gatherImg}">광고신청</button>
                                </td>
                            </tr>
       						</c:forEach>
                        </tbody>
                    </table>
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
        <div class="commercial-modal-wrap" hidden="" id="ad-form" >
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
                        <input type="date" class="my-page-button">~<input type="date" class="my-page-button">
                    </div>
                </div>
                <div class="create-commercial-item">
                    <div class="commercial-modal-label">광고 배너 이미지 첨부(<span class="create-commercial-value-required">필수</span>)</div>
                    <div class="create-commercial-input-wrap">
                        <div>
                         
                       <input class="my-page-form-input" type="text" id="fileName"  name="fileName" readonly>
                       <input class="commercial-image-input" type="file" id="create-image" name="file"  onchange="javascript:document.getElementById('fileName').value = this.value">
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
                <button type="button" class="modal-button search-id-button" value="등록">
                확인
                </button>
            </div>
        </div>
        <div class="modal-wrap" hidden="" id="ADCancel">
           <div class="create-commercial-warning">광고 신청을 정말 취소하시겠습니까?</div>
            <div class="modal-button-wrap">
                <button type="button" class="modal-button search-id-button">
                신청하기
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
  </body>
</html>
