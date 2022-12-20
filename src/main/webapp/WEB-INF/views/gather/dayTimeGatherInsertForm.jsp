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
			  
			// ��ǲ �±׿� ������ �ִ� ���
		    if(input.files && input.files[0]) {
		        // �̹��� �������� �˻� (����)
		        // FileReader �ν��Ͻ� ����
		        const reader = new FileReader()
		        // �̹����� �ε尡 �� ���
		        reader.onload = e => {
		            const previewImage = document.getElementById("group-image")
		          
		            previewImage.src = e.target.result
		          
		        }
		        // reader�� �̹��� �е��� �ϱ�
		        reader.readAsDataURL(input.files[0])
		    }
		}
		// input file�� change �̺�Ʈ �ο�
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
			if(confirm($(this).next().text()+" "+$(this).text()+"�� \n������ҷ� �����Ͻðڽ��ϱ�?")){
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
			interval: 30, //�ð����� : 5��
			startTime: "00:00",           
			timeFormat: "HH:mm"    //�ð�:�� ����ǥ��
		});
		$('#time').attr("readonly",true);
		
		
		
		$("form").on("submit",function() {
		
			if($("#category").val()===""){
				alert("ī�װ��� �������ּ���.")
				return false;
			}
			
			//���Ӹ� ��ȿ���˻�
			if($("#gatherName").val()===""){
				alert("���Ӹ��� �Է����ּ���.")
				return false;
			}
	
			
			let minUsers = Number($("#gatherMinUsers").val());
			let maxUsers = Number($("#gatherMaxUsers").val());
					
	
			//�����ο� ��ȿ���˻�
			if($("#gatherMinUsers").val()=="" || $("#gatherMaxUsers").val()==""){
				alert("���� �ο��� �������ּ���.");
				return false;
			}else if(minUsers > maxUsers || $("#gatherMaxUsers").val()< 0 || $("#gatherMinUsers").val() < 0){
				alert("���� �ο��� �ٽ� �������ּ���.")
				return false;
			}
			
			//�������� ��ȿ���˻�
			if($("#ageLimit").is(":checked")){
				if($("#gatherMinAge").val()==""||$("#gatherMaxAge").val()==""){
					alert("���������� �������ּ���.")
					return false;
				}else if($("#gatherMinAge").val()>=$("#gatherMaxAge").val()||$("#gatherMinAge").val()<0 ||$("#gatherMaxAge").val()<0){
					alert("���������� �ٽ� �������ּ���.")
					return false;
				}
			}
			
			
			//���� �ֱ� ��ȿ�� �˻�
			if($("#regularGatherCycle").val()==""){
				alert("���� �ֱ⸦ �������ּ���.")
				return false;
			}else if($("#regularGatherCycle").val()<1){
				alert("���� �ֱ⸦ �ٽ� �������ּ���")
				return false;
			}
			
			//����ð� ��ȿ�� �˻�
			if($("#gatherTime").val()==""){
				alert("����ð��� �Է����ּ���.")
				return false;
			}else if(0>$("#gatherTime").val() || $("#gatherTime").val()>24){
				alert("����ð��� �ٽ� �Է����ּ���")
				return false;
			}
			
			
			//���� ��¥ ��ȿ���˻�e);

			let today = new Date();
			//let gatherDate = new Date($("#date").val() + " " + $("#time").val())
			//let gatherDate = LocalDateTime.parse($("#date").val() + "T" + $("#time").val())
			
			if($("#date").val()=="" || $("#time").val()==""){
				alert("���� ��¥ �� �ð��� �Է����ּ���.")
				return false;
			}else if(today>=gatherDate){//���� ��¥�� ��
				alert("���� ��¥�� �ٽ� �������ּ���.")
				return false;
			}else{
				$("#gatherDate").val($("#date").val() + " " + $("#time").val())	
			}
			
			
			//���� ��� ��ȿ���˻�
			if($("#gatherPlace").val()==""){
				alert("���� ��Ҹ� �������ּ���")
				return false;
			}
			
		});
		
		
		var count = 1;
		$(document).on("click",".certificate-add-button", function(){
			
			var $div = $(".certificate-input-wrap").eq(0).clone();	
			$div.find("input").val("");
			
			var $div='<div class="certificate-input-wrap">';
			$div+='�������� <input class="create-group-form-input-medium" name=gatherAttachmentsFileSubject[] ';
			$div+='id="gatherAttachmentsFileSubject"/>'
			$div+='<input class="create-group-form-input-medium" name="gatherAttachmentsFileName" readonly="readonly"/>';
			$div+='<input id="sign-up-add-file'+count+'" class="sign-up-add-image" type="file" name="filesList[]"/>';
			$div+='<label for="sign-up-add-file'+count+'" class="certificate-file-button" >���� ÷��</label>'
			$div+='<div class="certificate-add-button">+</div>'
			count++;
	
				if(count <=5){
	
					alert($div)
					$(".plus").append($div);
				
				}
		})
		
		$(document).on("change", ".sign-up-add-image", function(){ //��Ȳ��
			
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
        <input hidden="" id="regularGatherState" name="regularGatherState" value="��û���"/>
        <input hidden="" id="gatherDate" name="date"/>
        <input hidden="" name="gatherState" value="��û���"/>
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
                  <div class="small-button">���� �߰�</div>
                </label>
              </div>
            </div>
            <div class="account-info-wrap">
              <div class="account-item-wrap">
                <select class="create-group-form-select" name="categoryNo" id="category">
     	          <option value="">--����--</option>
                  <option value="1">������</option>
                  <option value="2">Ŭ����</option>
                  <option value="3">����</option>
                </select>
              </div>
              <div class="account-item-wrap">
                <input class="create-group-form-input-medium" name="gatherBid" disabled="disabled" id="gatherBid"/>
                <input type="checkbox" style="width:20px; height:20px;" id="bidSelect" >�������
              </div>
            </div>
          </div>
          <div class="create-group-info-wrap">
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">���Ӹ�</div>
              <div class="create-group-info-table-item-content">
                <input class="create-group-form-input" name="gatherName"/>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">�ּ��ο�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" name="gatherMinUsers" id="gatherMinUsers" min="0"/>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">�ִ��ο�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" name="gatherMaxUsers" id="gatherMaxUsers" min="0"/>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� ����</div>
                <div class="create-group-info-table-item-content">
                  <select class="create-group-form-select-small" name="gatherSelectGender" id="gatherSelectGender">
                  	<option value="������">������</option>
                    <option value="����">����</option>
                    <option value="����">����</option>
                  </select>
                </div>
              </div>
              <div class="create-group-half-wrap">
              	<div><input type="checkbox" style="width:20px; height:20px;" id="ageLimit" ></div>
                <div class="create-group-info-table-item-label">���� ����</div>
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
                <div class="create-group-info-table-item-label">���� �ð�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="number" name="gatherTime" id="gatherTime"/>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� ��¥</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="date" id="date"/>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� �ð�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="text" id="time"/>
                </div>
              </div>
              
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">����</div>
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
              	���� ���
              </div>
              <div class="create-group-info-table-item-content">
              	<div>
              		�����ּ� <input class="create-group-form-input-medium" readonly="readonly" name="gatherPlace" id="gatherPlace" style="width:400px;">
              		<p>
              		���ּ� <input class="create-group-form-input-medium" name="gatherPlaceDetail" id="gatherPlaceDetail">
              	</div>
              <div class="map_wrap">
              
			  <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div>
			                <!-- <form onsubmit="searchPlaces();return false;"> -->
		                    Ű���� : <input type="text" value="�������" id="keyword" size="15"> 
		                    <button type="button" onclick="searchPlaces()"> �˻��ϱ�</button> 
			                
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
				</div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cd1727c389a0a4f4cf415a8a0d72e932&libraries&libraries=services,clusterer,drawing"></script>
				<script>
				// ��Ŀ�� ���� �迭�Դϴ�
				var markers = [];
				
				var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
				    mapOption = {
				        center: new kakao.maps.LatLng(37.566826, 126.9786567), // ������ �߽���ǥ
				        level: 3 // ������ Ȯ�� ����
				    };  
				
				// ������ �����մϴ�    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				// ��� �˻� ��ü�� �����մϴ�
				var ps = new kakao.maps.services.Places();  
				
				// �˻� ��� ����̳� ��Ŀ�� Ŭ������ �� ��Ҹ��� ǥ���� ���������츦 �����մϴ�
				var infowindow = new kakao.maps.InfoWindow({zIndex:1});
				
				// Ű����� ��Ҹ� �˻��մϴ�
				searchPlaces();
				
				// Ű���� �˻��� ��û�ϴ� �Լ��Դϴ�
				function searchPlaces() {
				
				    var keyword = document.getElementById('keyword').value;
				
				    if (!keyword.replace(/^\s+|\s+$/g, '')) {
				        alert('Ű���带 �Է����ּ���!');
				        return false;
				    }
				
				    // ��Ұ˻� ��ü�� ���� Ű����� ��Ұ˻��� ��û�մϴ�
				    ps.keywordSearch( keyword, placesSearchCB); 
				    
				    return false;
				}
				
				// ��Ұ˻��� �Ϸ���� �� ȣ��Ǵ� �ݹ��Լ� �Դϴ�
				function placesSearchCB(data, status, pagination) {
				    if (status === kakao.maps.services.Status.OK) {
				
				        // ���������� �˻��� �Ϸ������
				        // �˻� ��ϰ� ��Ŀ�� ǥ���մϴ�
				        displayPlaces(data);
				
				        // ������ ��ȣ�� ǥ���մϴ�
				        displayPagination(pagination);
				
				    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
				
				        alert('�˻� ����� �������� �ʽ��ϴ�.');
				        return;
				
				    } else if (status === kakao.maps.services.Status.ERROR) {
				
				        alert('�˻� ��� �� ������ �߻��߽��ϴ�.');
				        return;
				
				    }
				}
				
				// �˻� ��� ��ϰ� ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
				function displayPlaces(places) {
				
				    var listEl = document.getElementById('placesList'), 
				    menuEl = document.getElementById('menu_wrap'),
				    fragment = document.createDocumentFragment(), 
				    bounds = new kakao.maps.LatLngBounds(), 
				    listStr = '';
				    
				    // �˻� ��� ��Ͽ� �߰��� �׸���� �����մϴ�
				    removeAllChildNods(listEl);
				
				    // ������ ǥ�õǰ� �ִ� ��Ŀ�� �����մϴ�
				    removeMarker();
				    
				    for ( var i=0; i<places.length; i++ ) {
				
				        // ��Ŀ�� �����ϰ� ������ ǥ���մϴ�
				        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
				            marker = addMarker(placePosition, i), 
				            itemEl = getListItem(i, places[i]); // �˻� ��� �׸� Element�� �����մϴ�
				
				        // �˻��� ��� ��ġ�� �������� ���� ������ �缳���ϱ�����
				        // LatLngBounds ��ü�� ��ǥ�� �߰��մϴ�
				        bounds.extend(placePosition);
				
				        // ��Ŀ�� �˻���� �׸� mouseover ������
				        // �ش� ��ҿ� ���������쿡 ��Ҹ��� ǥ���մϴ�
				        // mouseout ���� ���� ���������츦 �ݽ��ϴ�
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
				
				    // �˻���� �׸���� �˻���� ��� Element�� �߰��մϴ�
				    listEl.appendChild(fragment);
				    menuEl.scrollTop = 0;
				
				    // �˻��� ��� ��ġ�� �������� ���� ������ �缳���մϴ�
				    map.setBounds(bounds);
				}
				
				// �˻���� �׸��� Element�� ��ȯ�ϴ� �Լ��Դϴ�
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
				
				// ��Ŀ�� �����ϰ� ���� ���� ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
				function addMarker(position, idx, title) {
				    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // ��Ŀ �̹��� url, ��������Ʈ �̹����� ���ϴ�
				        imageSize = new kakao.maps.Size(36, 37),  // ��Ŀ �̹����� ũ��
				        imgOptions =  {
				            spriteSize : new kakao.maps.Size(36, 691), // ��������Ʈ �̹����� ũ��
				            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // ��������Ʈ �̹��� �� ����� ������ �»�� ��ǥ
				            offset: new kakao.maps.Point(13, 37) // ��Ŀ ��ǥ�� ��ġ��ų �̹��� �������� ��ǥ
				        },
				        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
				            marker = new kakao.maps.Marker({
				            position: position, // ��Ŀ�� ��ġ
				            image: markerImage 
				        });
				
				    marker.setMap(map); // ���� ���� ��Ŀ�� ǥ���մϴ�
				    markers.push(marker);  // �迭�� ������ ��Ŀ�� �߰��մϴ�
				
				    return marker;
				}
				
				// ���� ���� ǥ�õǰ� �ִ� ��Ŀ�� ��� �����մϴ�
				function removeMarker() {
				    for ( var i = 0; i < markers.length; i++ ) {
				        markers[i].setMap(null);
				    }   
				    markers = [];
				}
				
				// �˻���� ��� �ϴܿ� ��������ȣ�� ǥ�ô� �Լ��Դϴ�
				function displayPagination(pagination) {
				    var paginationEl = document.getElementById('pagination'),
				        fragment = document.createDocumentFragment(),
				        i; 
				
				    // ������ �߰��� ��������ȣ�� �����մϴ�
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
				
				// �˻���� ��� �Ǵ� ��Ŀ�� Ŭ������ �� ȣ��Ǵ� �Լ��Դϴ�
				// ���������쿡 ��Ҹ��� ǥ���մϴ�
				function displayInfowindow(marker, title) {
				    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
				
				    infowindow.setContent(content);
				    infowindow.open(map, marker);
				}
				
				 // �˻���� ����� �ڽ� Element�� �����ϴ� �Լ��Դϴ�
				function removeAllChildNods(el) {   
				    while (el.hasChildNodes()) {
				        el.removeChild (el.lastChild);
				    }
				}
				</script>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">����</div>
              <div class="create-group-info-table-item-content">
                <textarea class="create-group-form-textarea" name="gatherComment" id="gatherComment"></textarea>
              </div>
            </div>
            <div class="create-group-info-table-item" id="certAdd">
              <div class="create-group-info-table-item-label">���� ÷��</div>
			  <div class="plus">             
              <div class="certificate-input-wrap">
              	�������� <input class="create-group-form-input-medium" name=gatherAttachmentsFileSubject[] id="gatherAttachmentsFileSubject"/>
                <input class="create-group-form-input-medium" name="gatherAttachmentsFileName" readonly="readonly"/>
                <input id="sign-up-add-file" class="sign-up-add-image" type="file" name="filesList[]" id="fileName"/>
	               <label for="sign-up-add-file" class="certificate-file-button" >
	                  ���� ÷��
	              </label>
	              <div class="certificate-add-button">+</div>
              </div>
            </div>
            </div>
          </div>
          <div class="create-group-button-wrap">
            <button class="create-group-cancel-button" type="button">���</button>
            <button class="create-group-button" type="submit">����ϱ�</button>
          </div>
        </form>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
  </body>
</html>
