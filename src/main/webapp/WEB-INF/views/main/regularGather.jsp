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
    
    
    	$(function() {
    		$(document).ready(function(){
    			  textchange = false;
    			  $('.category-btn').click(function(){
    			    if(textchange){
    			      textchange = false;
    			      $(this).addClass("selected")
    			    }else{
    			      textchange = true;
    			      $(this).removeClass("selected")
    			    }
    			  })
    			})
			
		})
	    
    </script>
  </head>
  <body>
    <div class="wrap">
      <div class="search-list">
        <div class="search-list-top">
          <div class="search-list-main-filter">
            <ul class="search-list-main-filter-wrap">
              <li class="search-list-main-filter-item selected">모임검색</li>
              <li class="search-list-main-filter-item">회원검색</li>
            </ul>
            <select class="select-small" name="" id="">
              <option value="인기순">인기순</option>
              <option value="마감임박순">마감임박순</option>
            </select>
          </div>
        </div>
        <div class="search-list-body">
          <aside class="search-list-sub-filter">
            <ul class="search-list-filter-categpry">
              <li class="search-list-filter-item category-btn" >스포츠</li>
              <li class="search-list-filter-item category-btn">클래스</li>
              <li class="search-list-filter-item category-btn">자유</li>
            </ul>
          </aside>
          <main>
            <section class="search-list-result-wrap">
              <article class="search-list-result-item">
                <div class="search-list-result-item-image-wrap">
                  <img src="" alt="이미지" width="100%" />
                </div>
                <div class="search-list-result-item-info">
                  <div class="search-list-result-item-title">
                    망원동 꼼작커피공방 커피바리스타 2급 자격증 단기 속성 교육
                    연습반 모집 (2회실습)
                  </div>
                  <div class="search-list-result-item-text">모집인원 : 1</div>
                  <div class="search-list-result-item-text">마감일 : 1</div>
                  <div class="search-list-result-item-date">
                    <div>모임날짜 : 1</div>
                    <div>작성자 : ㅇㅇ</div>
                  </div>
                </div>
              </article>
              <article class="search-list-result-item">
                <div class="search-list-result-item-image-wrap">
                  <img src="" alt="이미지" width="100%" />
                </div>
                <div class="search-list-result-item-info">
                  <div class="search-list-result-item-title">
                    망원동 꼼작커피공방 커피바리스타 2급 자격증 단기 속성 교육
                  </div>
                  <div class="search-list-result-item-text">모집인원 : 1</div>
                  <div class="search-list-result-item-text">마감일 : 1</div>
                  <div class="search-list-result-item-date">
                    <div>모임날짜 : 1</div>
                    <div>작성자 : ㅇㅇ</div>
                  </div>
                </div>
              </article>
            </section>
          </main>
        </div>
      </div>
    </div>
  </body>
</html>
