<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 	<link href="/css/gatherInsertForm/index.css" rel="stylesheet" />
 	<link href="/css/gatherInsertForm/jquery.timepicker.min.css" rel="stylesheet" />
 	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 	<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.timepicker.min.js"></script>
    <script type="text/javascript">
    
    $(function() {
    	
    	function readImage(input) {
			  
			// 인풋 태그에 파일이 있는 경우
		    if(input.files && input.files[0]) {
		        // 이미지 파일인지 검사 (생략)
		        // FileReader 인스턴스 생성
		        const reader = new FileReader()
		        // 이미지가 로드가 된 경우
		        reader.onload = e => {
		            const previewImage = document.getElementById("group-image")
		          
		            previewImage.src = e.target.result
		          
		        }
		        // reader가 이미지 읽도록 하기
		        reader.readAsDataURL(input.files[0])
		    }
		}
		// input file에 change 이벤트 부여
		const inputImage = document.getElementById("group-add-image")
		
		inputImage.addEventListener("change", e => {
		    readImage(e.target)
		})
		
		
		      $("#sign-up-add-file").on("change",function(){
		        if(window.FileReader){
		        	var filename = $(this).val().split('/').pop().split('\\').pop();
		          console.log(filename)
		        } else {
		          var filename = $(this).val().split('/').pop().split('\\').pop();
		        }
		        $("#fileName").val(filename);
		      });
		
		
		$(document).on("click","#placeName", function() {
			if(confirm($(this).next().text()+" "+$(this).text()+"을 \n모임장소로 선택하시겠습니까?")){
				$("#gatherPlace").val($(this).next().text()+" "+$(this).text());
			};
		})
		
		
		
		$("#bidSelect").change(function() {
			if($("#bidSelect").is(":checked")){
	            $("#gatherBid").attr("disabled",false);
	        }else{
	        	$("#gatherBid").attr("disabled",true);
	        	$("#gatherBid").val("");
	        }
		});
		
		
		$("#ageLimit").change(function() {
			if($("#ageLimit").is(":checked")){
	            $("#gatherMinAge").attr("disabled",false);
	            $("#gatherMaxAge").attr("disabled",false);
	        }else{
	        	$("#gatherMinAge").attr("disabled",true);
	            $("#gatherMaxAge").attr("disabled",true);
	        	$("#gatherMinAge").val("");
	        	$("#gatherMaxAge").val("");
	        }
		});
		
		
		$("#time").timepicker({
			interval: 30, //시간간격 : 5분
			startTime: "00:00",           
			timeFormat: "HH:mm"    //시간:분 으로표시
		});
		$('#time').attr("readonly",true);
		
		
		
		$("form").on("submit",function() {
		
			if($("#category").val()===""){
				alert("카테고리를 설정해주세요.")
				return false;
			}
			
			//모임명 유효성검사
			if($("#gatherName").val()===""){
				alert("모임명을 입력해주세요.")
				return false;
			}
	
			
			let minUsers = Number($("#gatherMinUsers").val());
			let maxUsers = Number($("#gatherMaxUsers").val());
					
	
			//모임인원 유효성검사
			if($("#gatherMinUsers").val()=="" || $("#gatherMaxUsers").val()==""){
				alert("모임 인원을 설정해주세요.");
				return false;
			}else if(minUsers > maxUsers || $("#gatherMaxUsers").val()< 0 || $("#gatherMinUsers").val() < 0){
				alert("모임 인원을 다시 설정해주세요.")
				return false;
			}
			
			//연령제한 유효성검사
			if($("#ageLimit").is(":checked")){
				if($("#gatherMinAge").val()==""||$("#gatherMaxAge").val()==""){
					alert("연령제한을 설정해주세요.")
					return false;
				}else if($("#gatherMinAge").val()>=$("#gatherMaxAge").val()||$("#gatherMinAge").val()<0 ||$("#gatherMaxAge").val()<0){
					alert("연령제한을 다시 설정해주세요.")
					return false;
				}
			}
			
			
			//모임 주기 유효성 검사
			if($("#regularGatherCycle").val()==""){
				alert("모임 주기를 설정해주세요.")
				return false;
			}else if($("#regularGatherCycle").val()<1){
				alert("모임 주기를 다시 설정해주세요")
				return false;
			}
			
			//진행시간 유효성 검사
			if($("#gatherTime").val()==""){
				alert("진행시간을 입력해주세요.")
				return false;
			}else if(0>$("#gatherTime").val() || $("#gatherTime").val()>24){
				alert("진행시간을 다시 입력해주세요")
				return false;
			}
			
			
			//모임 날짜 유효성검사e);

			let today = new Date();
			//let gatherDate = new Date($("#date").val() + " " + $("#time").val())
			//let gatherDate = LocalDateTime.parse($("#date").val() + "T" + $("#time").val())
			
			if($("#date").val()=="" || $("#time").val()==""){
				alert("모임 날짜 및 시간을 입력해주세요.")
				return false;
			}else if(today>=gatherDate){//현재 날짜와 비교
				alert("모임 날짜를 다시 설정해주세요.")
				return false;
			}else{
				$("#gatherDate").val($("#date").val() + " " + $("#time").val())	
			}
			
			
			//모임 장소 유효성검사
			if($("#gatherPlace").val()==""){
				alert("모임 장소를 설정해주세요")
				return false;
			}
			
		});
		
		
		var count = 1;
		$(document).on("click",".certificate-add-button", function(){
			
			var $div = $(".certificate-input-wrap").eq(0).clone();	
			$div.find("input").val("");
			
			var $div='<div class="certificate-input-wrap">';
			$div+='파일제목 <input class="create-group-form-input-medium" name=gatherAttachmentsFileSubject[] ';
			$div+='id="gatherAttachmentsFileSubject"/>'
			$div+='<input class="create-group-form-input-medium" name="gatherAttachmentsFileName" readonly="readonly"/>';
			$div+='<input id="sign-up-add-file'+count+'" class="sign-up-add-image" type="file" name="filesList[]"/>';
			$div+='<label for="sign-up-add-file'+count+'" class="certificate-file-button" >파일 첨부</label>'
			$div+='<div class="certificate-add-button">+</div>'
			count++;
	
				if(count <=5){
	
					alert($div)
					$(".plus").append($div);
				
				}
		})
		
		$(document).on("change", ".sign-up-add-image", function(){ //주황색
			
			alert(1)
	        console.log($(this))
	       var filename = $(this).val().split('/').pop().split('\\').pop();
	          //console.log(filename)
	          
	        $(this).prev().val(filename);
	          //$(this).attr("name","test");
	          
	         console.log($(this))
	        // $(this).prev().find("input").val(filenam
	      
		})  
		
		$(".create-group-cancel-button").click(function() {
			history.back()
		})
		
		
	})        
  	
	
    </script>
    <title>Document</title>
  </head>
  <body>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="wrap">
     <sec:authorize access="isAuthenticated()">
	<sec:authentication var="user" property="principal" />
		<input type="hidden" value="${user.userNo}" id="userNo">
	</sec:authorize>
      <div class="create-group-wrap">
        <form action="${pageContext.request.contextPath}/gather/gatherInsert" method="post" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
        <input hidden="" id="regularGatherState" name="regularGatherState" value="신청대기"/>
        <input hidden="" id="gatherDate" name="date"/>
        <input hidden="" name="gatherState" value="신청대기"/>
        <input hidden="" id=userNo1 value="${userNo}" name="userNo"> 
          <div class="create-group-top">
            <div class="create-group-wrap-image">
              <div class="group-image-wrap">
                <img
               	  id="group-image"
                  width="100%"
                  height="100%"
                  src="https://dummyimage.com/320x200/dedede/fff&text=image"
                  alt="inmge"
                />
              
              </div>
              <input type="file" class="file-input" id="group-add-image" accept="image/*" name="file"/>
              <div class="image-button-wrap">
                <label for="group-add-image">
                  <div class="small-button">사진 추가</div>
                </label>
              </div>
            </div>
            <div class="account-info-wrap">
              <div class="account-item-wrap">
                <select class="create-group-form-select" name="categoryNo" id="category">
     	          <option value="">--선택--</option>
                  <option value="1">스포츠</option>
                  <option value="2">클래스</option>
                  <option value="3">자유</option>
                </select>
              </div>
              <div class="account-item-wrap">
                <input class="create-group-form-input-medium" name="gatherBid" disabled="disabled" id="gatherBid"/>
                <input type="checkbox" style="width:20px; height:20px;" id="bidSelect" >유료모임
              </div>
            </div>
          </div>
          <div class="create-group-info-wrap">
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">모임명</div>
              <div class="create-group-info-table-item-content">
                <input class="create-group-form-input" name="gatherName"/>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">최소인원</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" name="gatherMinUsers" id="gatherMinUsers" min="0"/>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">최대인원</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" name="gatherMaxUsers" id="gatherMaxUsers" min="0"/>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">성별 선택</div>
                <div class="create-group-info-table-item-content">
                  <select class="create-group-form-select-small" name="gatherSelectGender" id="gatherSelectGender">
                  	<option value="남녀모두">남녀모두</option>
                    <option value="남자">남자</option>
                    <option value="여자">여자</option>
                  </select>
                </div>
              </div>
              <div class="create-group-half-wrap">
              	<div><input type="checkbox" style="width:20px; height:20px;" id="ageLimit" ></div>
                <div class="create-group-info-table-item-label">연령 제한</div>
                <div class="create-group-info-table-item-content">
                  <div class="create-group-form-age-wrap">
                    <input class="create-group-form-input-small" disabled="disabled" name="gatherMinAge" id="gatherMinAge"/>
                    <div>~</div>
                    <input class="create-group-form-input-small" disabled="disabled" name="gatherMaxAge" id="gatherMaxAge"/>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">진행 시간</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="number" name="gatherTime" id="gatherTime"/>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">모임 날짜</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="date" id="date"/>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">모임 시간</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="text" id="time"/>
                </div>
              </div>
              
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">증명서</div>
              <div class="create-group-info-table-item-content">
                <div class="create-group-form-certificate-wrap">
                  <select class="create-group-form-select">
                  	<c:forEach items="${userAttachments}" var="userFile">
                  		<option>${userFile.userAttachmentsFileSubject}
                  	</c:forEach>
                  </select>
                </div>
              </div>
            </div>
           
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">
              	모임 장소
              </div>
              <div class="create-group-info-table-item-content">
              	<div>
              		모임주소 <input class="create-group-form-input-medium" readonly="readonly" name="gatherPlace" id="gatherPlace" style="width:400px;">
              		<p>
              		상세주소 <input class="create-group-form-input-medium" name="gatherPlaceDetail" id="gatherPlaceDetail">
              	</div>
              <div class="map_wrap">
              
			  <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div>
			                <!-- <form onsubmit="searchPlaces();return false;"> -->
		                    키워드 : <input type="text" value="모임장소" id="keyword" size="15"> 
		                    <button type="button" onclick="searchPlaces()"> 검색하기</button> 
			                
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
				</div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cd1727c389a0a4f4cf415a8a0d72e932&libraries&libraries=services,clusterer,drawing"></script>
				<script>
				// 마커를 담을 배열입니다
				var markers = [];
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
				
				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				// 장소 검색 객체를 생성합니다
				var ps = new kakao.maps.services.Places();  
				
				// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({zIndex:1});
				
				// 키워드로 장소를 검색합니다
				searchPlaces();
				
				// 키워드 검색을 요청하는 함수입니다
				function searchPlaces() {
				
				    var keyword = document.getElementById('keyword').value;
				
				    if (!keyword.replace(/^\s+|\s+$/g, '')) {
				        alert('키워드를 입력해주세요!');
				        return false;
				    }
				
				    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
				    ps.keywordSearch( keyword, placesSearchCB); 
				    
				    return false;
				}
				
				// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
				function placesSearchCB(data, status, pagination) {
				    if (status === kakao.maps.services.Status.OK) {
				
				        // 정상적으로 검색이 완료됐으면
				        // 검색 목록과 마커를 표출합니다
				        displayPlaces(data);
				
				        // 페이지 번호를 표출합니다
				        displayPagination(pagination);
				
				    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
				
				        alert('검색 결과가 존재하지 않습니다.');
				        return;
				
				    } else if (status === kakao.maps.services.Status.ERROR) {
				
				        alert('검색 결과 중 오류가 발생했습니다.');
				        return;
				
				    }
				}
				
				// 검색 결과 목록과 마커를 표출하는 함수입니다
				function displayPlaces(places) {
				
				    var listEl = document.getElementById('placesList'), 
				    menuEl = document.getElementById('menu_wrap'),
				    fragment = document.createDocumentFragment(), 
				    bounds = new kakao.maps.LatLngBounds(), 
				    listStr = '';
				    
				    // 검색 결과 목록에 추가된 항목들을 제거합니다
				    removeAllChildNods(listEl);
				
				    // 지도에 표시되고 있는 마커를 제거합니다
				    removeMarker();
				    
				    for ( var i=0; i<places.length; i++ ) {
				
				        // 마커를 생성하고 지도에 표시합니다
				        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
				            marker = addMarker(placePosition, i), 
				            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
				
				        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				        // LatLngBounds 객체에 좌표를 추가합니다
				        bounds.extend(placePosition);
				
				        // 마커와 검색결과 항목에 mouseover 했을때
				        // 해당 장소에 인포윈도우에 장소명을 표시합니다
				        // mouseout 했을 때는 인포윈도우를 닫습니다
				        (function(marker, title) {
				            kakao.maps.event.addListener(marker, 'mouseover', function() {
				                displayInfowindow(marker, title);
				            });
				
				            kakao.maps.event.addListener(marker, 'mouseout', function() {
				                infowindow.close();
				            });
				
				            itemEl.onmouseover =  function () {
				                displayInfowindow(marker, title);
				            };
				
				            itemEl.onmouseout =  function () {
				                infowindow.close();
				            };
				        })(marker, places[i].place_name);
				
				        fragment.appendChild(itemEl);
				    }
				
				    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
				    listEl.appendChild(fragment);
				    menuEl.scrollTop = 0;
				
				    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				    map.setBounds(bounds);
				}
				
				// 검색결과 항목을 Element로 반환하는 함수입니다
				function getListItem(index, places) {
				
				    var el = document.createElement('li'),
				    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
				                '<div class="info">' +
				                "   <a id='placeName'><h5>" + places.place_name + '</h5></a>';
				
				    if (places.road_address_name) {
				        itemStr += '    <span>' + places.road_address_name + '</span>' +
				                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
				    } else {
				        itemStr += '    <span>' +  places.address_name  + '</span>'; 
				    }
				                 
				      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
				                '</div>';           
				
				    el.innerHTML = itemStr;
				    el.className = 'item';
				
				    return el;
				}
				
				// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
				function addMarker(position, idx, title) {
				    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
				        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
				        imgOptions =  {
				            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
				        },
				        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
				            marker = new kakao.maps.Marker({
				            position: position, // 마커의 위치
				            image: markerImage 
				        });
				
				    marker.setMap(map); // 지도 위에 마커를 표출합니다
				    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
				
				    return marker;
				}
				
				// 지도 위에 표시되고 있는 마커를 모두 제거합니다
				function removeMarker() {
				    for ( var i = 0; i < markers.length; i++ ) {
				        markers[i].setMap(null);
				    }   
				    markers = [];
				}
				
				// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
				function displayPagination(pagination) {
				    var paginationEl = document.getElementById('pagination'),
				        fragment = document.createDocumentFragment(),
				        i; 
				
				    // 기존에 추가된 페이지번호를 삭제합니다
				    while (paginationEl.hasChildNodes()) {
				        paginationEl.removeChild (paginationEl.lastChild);
				    }
				
				    for (i=1; i<=pagination.last; i++) {
				        var el = document.createElement('a');
				        el.href = "#";
				        el.innerHTML = i;
				
				        if (i===pagination.current) {
				            el.className = 'on';
				        } else {
				            el.onclick = (function(i) {
				                return function() {
				                    pagination.gotoPage(i);
				                }
				            })(i);
				        }
				
				        fragment.appendChild(el);
				    }
				    paginationEl.appendChild(fragment);
				}
				
				// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
				// 인포윈도우에 장소명을 표시합니다
				function displayInfowindow(marker, title) {
				    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
				
				    infowindow.setContent(content);
				    infowindow.open(map, marker);
				}
				
				 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
				function removeAllChildNods(el) {   
				    while (el.hasChildNodes()) {
				        el.removeChild (el.lastChild);
				    }
				}
				</script>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">내용</div>
              <div class="create-group-info-table-item-content">
                <textarea class="create-group-form-textarea" name="gatherComment" id="gatherComment"></textarea>
              </div>
            </div>
            <div class="create-group-info-table-item" id="certAdd">
              <div class="create-group-info-table-item-label">파일 첨부</div>
			  <div class="plus">             
              <div class="certificate-input-wrap">
              	파일제목 <input class="create-group-form-input-medium" name=gatherAttachmentsFileSubject[] id="gatherAttachmentsFileSubject"/>
                <input class="create-group-form-input-medium" name="gatherAttachmentsFileName" readonly="readonly"/>
                <input id="sign-up-add-file" class="sign-up-add-image" type="file" name="filesList[]" id="fileName"/>
	               <label for="sign-up-add-file" class="certificate-file-button" >
	                  파일 첨부
	              </label>
	              <div class="certificate-add-button">+</div>
              </div>
            </div>
            </div>
          </div>
          <div class="create-group-button-wrap">
            <button class="create-group-cancel-button" type="button">취소</button>
            <button class="create-group-button" type="submit">등록하기</button>
          </div>
        </form>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
