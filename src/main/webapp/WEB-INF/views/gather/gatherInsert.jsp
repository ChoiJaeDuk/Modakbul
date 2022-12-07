<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 	<link href="/css/gatherInsertForm/index.css" rel="stylesheet" />
 	<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
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
		const inputImage = document.getElementById("sign-up-add-image")
		
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
   		 
		
})
	})    
    
    </script>
    <title>Document</title>
  </head>
  <body>
    <div class="wrap">
      <div class="create-group-wrap">
        <form action="">
          <div class="create-group-top">
            <div class="create-group-wrap-image">
              <div class="group-image-wrap">
                <img
               	  id="group-image"
                  width="100%"
                  src="https://dummyimage.com/320x200/dedede/fff&text=image"
                  alt="inmge"
                />
              
              </div>
              <input type="file" class="file-input" id="group-add-image" accept="image/*"/>
              <div class="image-button-wrap">
                <label for="group-add-image">
                  <div class="small-button">사진 추가</div>
                </label>
              </div>
            </div>
            <div class="account-info-wrap">
              <div class="account-item-wrap">
                <select class="create-group-form-select">
                  <option>스포츠</option>
                  <option>클래스</option>
                  <option>자유</option>
                </select>
              </div>
              <div class="account-item-wrap">
                <input class="create-group-form-input-medium" />
              </div>
              <div class="account-item-wrap">
                <input class="create-group-form-input-medium" />
                <div>계좌 번호</div>
                <select class="create-group-form-select-small">
                  <option>신한</option>
                  <option>국민</option>
                  <option>우리</option>
                  <option>기업</option>
                </select>
              </div>
            </div>
          </div>
          <div class="create-group-info-wrap">
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">모임명</div>
              <div class="create-group-info-table-item-content">
                <input class="create-group-form-input" />
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">최소인원</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" />
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">최소인원</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" />
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">성별 선택</div>
                <div class="create-group-info-table-item-content">
                  <select class="create-group-form-select-small">
                    <option>남자</option>
                    <option>여자</option>
                  </select>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">연령 제한</div>
                <div class="create-group-info-table-item-content">
                  <div class="create-group-form-age-wrap">
                    <input class="create-group-form-input-small" />
                    <div>~</div>
                    <input class="create-group-form-input-small" />
                  </div>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">모임 주기</div>
                <div class="create-group-info-table-item-content">
                  <div class="create-group-form-term-wrap">
                    <select class="create-group-form-select-small">
                      <option>매주</option>
                      <option>매월</option>
                    </select>
                    <select class="create-group-form-select-small">
                      <option>월요일</option>
                      <option>수요일</option>
                      <option>금요일</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">모임 시간</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="time" />
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">모임 날짜</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="date" />
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">진행 시간</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" />
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">증명서1</div>
              <div class="create-group-info-table-item-content">
                <div class="create-group-form-certificate-wrap">
                  <select class="create-group-form-select">
                    <option>심판</option>
                    <option>자격</option>
                    <option>증</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">증명서2</div>
              <div class="create-group-info-table-item-content">
                <div class="create-group-form-certificate-wrap">
                  <select class="create-group-form-select">
                    <option>월요일</option>
                    <option>수요일</option>
                    <option>금요일</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">증명서3</div>
              <div class="create-group-info-table-item-content">
                <div class="create-group-form-certificate-wrap">
                  <select class="create-group-form-select">
                    <option>월요일</option>
                    <option>수요일</option>
                    <option>금요일</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">모임 장소</div>
              <div class="create-group-info-table-item-content">
                <div>
                  <input class="create-group-form-input-medium" />
                  <button class="create-group-form-button" type="button">
                    검색
                  </button>
                </div>
                <div class="map-wrap"><div id="map"></div></div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">내용</div>
              <div class="create-group-info-table-item-content">
                <textarea class="create-group-form-textarea"></textarea>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">파일 첨부</div>
              <div class="create-group-info-table-item-content">
                <input class="create-group-form-input-medium" readonly />
                <button class="create-group-form-button" type="button">
                  파일 첨부
                </button>
              </div>
            </div>
          </div>
          <div class="create-group-button-wrap">
            <button class="create-group-cancel-button">취소</button>
            <button class="create-group-button">등록하기</button>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
