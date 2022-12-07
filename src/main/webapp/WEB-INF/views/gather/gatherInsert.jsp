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
                  <div class="small-button">���� �߰�</div>
                </label>
              </div>
            </div>
            <div class="account-info-wrap">
              <div class="account-item-wrap">
                <select class="create-group-form-select">
                  <option>������</option>
                  <option>Ŭ����</option>
                  <option>����</option>
                </select>
              </div>
              <div class="account-item-wrap">
                <input class="create-group-form-input-medium" />
              </div>
              <div class="account-item-wrap">
                <input class="create-group-form-input-medium" />
                <div>���� ��ȣ</div>
                <select class="create-group-form-select-small">
                  <option>����</option>
                  <option>����</option>
                  <option>�츮</option>
                  <option>���</option>
                </select>
              </div>
            </div>
          </div>
          <div class="create-group-info-wrap">
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">���Ӹ�</div>
              <div class="create-group-info-table-item-content">
                <input class="create-group-form-input" />
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">�ּ��ο�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" />
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">�ּ��ο�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-small" type="number" />
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� ����</div>
                <div class="create-group-info-table-item-content">
                  <select class="create-group-form-select-small">
                    <option>����</option>
                    <option>����</option>
                  </select>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� ����</div>
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
                <div class="create-group-info-table-item-label">���� �ֱ�</div>
                <div class="create-group-info-table-item-content">
                  <div class="create-group-form-term-wrap">
                    <select class="create-group-form-select-small">
                      <option>����</option>
                      <option>�ſ�</option>
                    </select>
                    <select class="create-group-form-select-small">
                      <option>������</option>
                      <option>������</option>
                      <option>�ݿ���</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� �ð�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="time" />
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� ��¥</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" type="date" />
                </div>
              </div>
              <div class="create-group-half-wrap">
                <div class="create-group-info-table-item-label">���� �ð�</div>
                <div class="create-group-info-table-item-content">
                  <input class="create-group-form-input-medium" />
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">����1</div>
              <div class="create-group-info-table-item-content">
                <div class="create-group-form-certificate-wrap">
                  <select class="create-group-form-select">
                    <option>����</option>
                    <option>�ڰ�</option>
                    <option>��</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">����2</div>
              <div class="create-group-info-table-item-content">
                <div class="create-group-form-certificate-wrap">
                  <select class="create-group-form-select">
                    <option>������</option>
                    <option>������</option>
                    <option>�ݿ���</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">����3</div>
              <div class="create-group-info-table-item-content">
                <div class="create-group-form-certificate-wrap">
                  <select class="create-group-form-select">
                    <option>������</option>
                    <option>������</option>
                    <option>�ݿ���</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">���� ���</div>
              <div class="create-group-info-table-item-content">
                <div>
                  <input class="create-group-form-input-medium" />
                  <button class="create-group-form-button" type="button">
                    �˻�
                  </button>
                </div>
                <div class="map-wrap"><div id="map"></div></div>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">����</div>
              <div class="create-group-info-table-item-content">
                <textarea class="create-group-form-textarea"></textarea>
              </div>
            </div>
            <div class="create-group-info-table-item">
              <div class="create-group-info-table-item-label">���� ÷��</div>
              <div class="create-group-info-table-item-content">
                <input class="create-group-form-input-medium" readonly />
                <button class="create-group-form-button" type="button">
                  ���� ÷��
                </button>
              </div>
            </div>
          </div>
          <div class="create-group-button-wrap">
            <button class="create-group-cancel-button">���</button>
            <button class="create-group-button">����ϱ�</button>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
