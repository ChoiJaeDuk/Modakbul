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
  </head>
  <body>
    <div class="wrap">
      <div class="search-list">
        <div class="search-list-top">
          <h2 class="search-list-title">'커피' 검색 결과</h2>
          <div class="search-list-main-filter">
            <ul class="search-list-main-filter-wrap">
              <li class="search-list-main-filter-item">모임검색</li>
              <li class="search-list-main-filter-item selected">회원검색</li>
            </ul>
            <select class="select-small" name="" id="">
              <option value="인기순">인기순</option>
              <option value="마감임박순">마감임박순</option>
            </select>
          </div>
        </div>
        <div class="search-list-body">
          <aside class="search-list-sub-filter"></aside>
          <main>
            <section class="search-member-list-result-wrap">
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
              <article class="search-member-list-result-item">
                <div class="search-member-list-result-item-image-wrap">
                  <img src="" alt="사진" width="100%" />
                </div>
                <div class="search-member-list-result-item-member-name">
                  이름
                </div>
              </article>
            </section>
          </main>
        </div>
      </div>
    </div>
  </body>
</html>
