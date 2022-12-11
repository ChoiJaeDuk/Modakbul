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
              <li class="search-list-filter-item selected">Q&A</li>
              <li class="search-list-filter-item">자주하는 질문</li>
            </ul>
          </aside>
          <main class="search-list-main">
            <section class="search-inquiry-list-result-wrap">
              <div class="inquiry-top">
                <h2 class="inquiry-title">Q&A</h2>
              </div>
              <div class="search-inquiry-list">
                <table class="table">
                  <colgroup>
                    <col width="14%" />
                    <col width="42%" />
                    <col width="32%" />
                    <col width="14%" />
                  </colgroup>
                  <thead>
                    <tr class="table-header">
                      <th>번호</th>
                      <th>제목</th>
                      <th>작성자</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr class="table-row">
                      <td>1</td>
                      <td>제목</td>
                      <td>작성자</td>
                      <td>22.11.13</td>
                    </tr>
                    <tr class="table-row">
                      <td>2</td>
                      <td>제목</td>
                      <td>작성자</td>
                      <td>22.11.13</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </section>
          </main>
        </div>
      </div>
    </div>
  </body>
</html>
