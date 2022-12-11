<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
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
  </head>
  <body>
    <div class="wrap">
     <div class="search-list">
        <div class="search-list-body">
          <aside class="search-list-sub-filter">
            <ul class="search-list-filter-type">
              <li class="search-list-filter-item">공지사항</li>
              <li class="search-list-filter-item">Q&A</li>
              <li class="search-list-filter-item selected">자주하는 질문</li>
            </ul>
          </aside>
          <main class="search-list-main">
            <section class="search-inquiry-list-result-wrap">
              <div class="inquiry-top">
                <h2 class="inquiry-title">자주하는 질문</h2>
                <div class="inquiry-button-wrap">
                  <button class="search-list-button" type="button">수정</button>
                  <button class="search-list-button" type="button">삭제</button>
                </div>
              </div>
              <div class="inquiry-search-area">
                <div class="inquiry-search-wrap">
                  <input class="inquiry-input" />
                  <button class="search-list-button" type="button">검색</button>
                </div>
              </div>
              <div class="search-inquiry-list">
                <ul>
                  <li>
                    <div class="search-inquiry-list-expand-button">
                      <div
                        class="search-inquiry-list-expand-button-question-icon"
                      >
                        <img src="" alt="" width="100%" />
                      </div>
                      <div class="search-inquiry-list-expand-button-title">
                        망원동 꼼작커피공방 커피바리스타 2급 자격증 단기 속성
                        교육 연습반 모집 (2회실습)
                      </div>
                      <div
                        class="search-inquiry-list-expand-button-expand-icon"
                      >
                        <img src="" alt="" width="100%" />
                      </div>
                    </div>
                    <div class="search-inquiry-reply-wrap">
                      <div
                        class="search-inquiry-list-expand-button-result-icon"
                      >
                        <img src="" alt="" width="100%" />
                      </div>
                      <p class="search-inquiry-reply">
                        소리다이것은 피어나기 전인 유소년에게서 구하지 못할
                        바이며 시들어 가는 노년에게서 구하지 못할 바이며 오직
                        우리 청춘에서만 구할 수 있는 것이다 청춘은 인생의
                        황금시대다 우리는 이 황금시대의 가치를 충분히 발휘하기
                        위하여 이 황금시대를
                      </p>
                    </div>
                  </li>
                  <li class="search-inquiry-list-item"></li>
                </ul>
              </div>
            </section>
          </main>
        </div>
      </div> 
    </div>
  </body>
</html>
