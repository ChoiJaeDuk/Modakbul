<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${pageContext.request.contextPath}/css/my-page/index.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/my-page/reset.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/my-page/follow.css"
	rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>
	<script type="text/javascript">
	
	$(function(){
		$("#following").click(function(){
			 $(".my-page-wrap").css("display","block"); //팝업 뒷배경 display block
			alert(11)
			$(".xs83m0k xl56j7k x1iy3rx x1n2onr6 x1sy10c2 x1h5jrl4 xieb3on xmn8rco x1hfn5x7 x13wlyjk x1v7wizp x1l0w46t xa3vuyk xw8ag78").show();
			
		 $(".xs83m0k xl56j7k x1iy3rx x1n2onr6 x1sy10c2 x1h5jrl4 xieb3on xmn8rco x1hfn5x7 x13wlyjk x1v7wizp x1l0w46t xa3vuyk xw8ag78").css({
	                "top": (($(window).height()-$(".xs83m0k xl56j7k x1iy3rx x1n2onr6 x1sy10c2 x1h5jrl4 xieb3on xmn8rco x1hfn5x7 x13wlyjk x1v7wizp x1l0w46t xa3vuyk xw8ag78").outerHeight())/2+$(window).scrollTop())+"px",
	                "left": (($(window).width()-$(".xs83m0k xl56j7k x1iy3rx x1n2onr6 x1sy10c2 x1h5jrl4 xieb3on xmn8rco x1hfn5x7 x13wlyjk x1v7wizp x1l0w46t xa3vuyk xw8ag78").outerWidth())/2+$(window).scrollLeft())+"px"
	                //팝업창을 가운데로 띄우기 위해 현재 화면의 가운데 값과 스크롤 값을 계산하여 팝업창 CSS 설정
	             
	             }); 
	            
	            $("body").attr("opacity", 0.5); //팝업 뒷배경 display block
	            $(".xs83m0k xl56j7k x1iy3rx x1n2onr6 x1sy10c2 x1h5jrl4 xieb3on xmn8rco x1hfn5x7 x13wlyjk x1v7wizp x1l0w46t xa3vuyk xw8ag78").css("display","block"); //팝업창 display block
	            
	//  $("body").css("overflow","hidden");//body 스크롤바 없애기 
			
		})
	}) 
	
	</script>
<title>Document</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	<div class="shadow">
	<div class="wrap">
		<div class="my-page-wrap">
			<div class="my-page-header">
				<div class="my-page-image-wrap">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<c:set value="${user.userProfileImg}" var="img" />
						<c:set value="true" var="state1" />
						<c:forEach items="${fileNames }" var="file">
							<c:if test="${file eq img }">
								<c:set value="true" var="state2" />
								<img class="sign-up-image"
									src="${pageContext.request.contextPath}/save/${user.userProfileImg }"
									alt="img" />

							</c:if>

						</c:forEach>

						<c:if test="${state1 ne state2}">
							<img class="sign-up-image" src="${user.userProfileImg }"
								alt="img" />
						</c:if>

						<input id="sign-up-add-image" class="sign-up-add-image"
							type="file" name="file" accept="image/*" />
					</sec:authorize>
				</div>
				<div class="my-page-user-info-wrap">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication var="user" property="principal" />
						<div class="my-page-user-name">

							<div>${user.userName }님</div>


						</div>
						<div class="my-page-user-temperature">모닥불 온도 : ${user.temper }&#8451</div>
						<div class="my-page-user-follow-wrap">
							<div>
								<div>팔로워</div>
								<div>&nbsp;&nbsp;&nbsp;${follower}</div>
							</div>
							<div>
								<div id="following" onclick="$('#list').show()">팔로잉</div>
								<%-- <div>&nbsp;&nbsp;&nbsp;${following}</div> --%>
								<div>
									<a
										href="${pageContext.request.contextPath}/follow/followingList?userNo=7">&nbsp;&nbsp;&nbsp;${following}</a>
								</div>
							</div>
						</div>
					</sec:authorize>
				</div>
			</div>
			<div class="my-page-content-wrap">
				<nav>
					<ul>
						<li class="my-page-nav-item selected">프로필정보</li>
						<li class="my-page-nav-item">알림함</li>
						<li class="my-page-nav-item"
							onclick="location.href='${pageContext.request.contextPath}/my_page/gatherSelect/applicationList/'${user.userNo}">모임조회</li>
						<li class="my-page-nav-item">관심모임</li>
						<li class="my-page-nav-item">후기조회</li>
						<li class="my-page-nav-item">문의조회</li>
						<li class="my-page-nav-item">광고신청</li>
					</ul>
				</nav>
				
				<div class="x1cy8zhl x9f619 x78zum5 xl56j7k x2lwn1j xeuugli x47corl" >
		<div role="dialog" class="x1ja2u2z x1afcbsf x1a2a7pz x6ikm8r x10wlt62 x71s49j x78zum5 xdt5ytf x1n2onr6 xl56j7k x6s0dn4">
			<div id="list" style="display: none;" class="xs83m0k xl56j7k x1iy3rx x1n2onr6 x1sy10c2 x1h5jrl4 xieb3on xmn8rco x1hfn5x7 x13wlyjk x1v7wizp x1l0w46t xa3vuyk xw8ag78">
				<div></div>
				<div class="x7r02ix xf1ldfh x131esax xdajt7p xxfnqb6 xb88tzc xw2csxc x1odjw0f x5fp0pe" role="dialog">
					<divstyle="display: flex; flex-direction: column; height: 100%; max-width: 100%;">
						<div class="_ab8w  _ab94 _ab99 _ab9f _ab9m _ab9o _abcm" style="max-height: 800px; min-height: 500px;">
							<div class="x1qjc9v5 x78zum5 xdt5ytf">
								<div class="_ac76">
									<div class="_ab8w  _ab94 _ab97 _ab9h _ab9m _ab9p  _abch _abcm" style="height: 100%; width: 100%;">
										<h1 class="_ac78" tabindex="-1" style="width: calc(100% - 100px);">
											<div class="">팔로잉</div>
										</h1>
									</div>
									<div class="_ac7b _ac7c"></div>
									<div class="_ac7b _ac7d">
										<div class="_ab8w  _ab94 _ab99 _ab9f _ab9m _ab9p  _ab9y _abcm">
											<button class="_abl-" type="button">
												<div class="_abm0">
													<svg aria-label="닫기" class="_ab6-" color="#262626" fill="#262626" height="18" role="img" viewBox="0 0 24 24" width="18">
													<polyline fill="none" points="20.643 3.357 12 12 3.353 20.647" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="3"></polyline>
													<line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" x1="20.649" x2="3.354" y1="20.649" y2="3.354"></line>
													</svg>
												</div>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="_acbs" role="tablist">
								<div class="_acbv _acbw _acbx _acby" aria-disabled="false" role="tab" tabindex="0" style="cursor: pointer;">
									<div class="_aacl _aacp _aacw _aacz _aad6 _aadb">사람</div>
								</div>
								<div class="_acbv _acbw _acbx" aria-disabled="false" role="tab" tabindex="0" style="cursor: pointer;">
									<div class="_aacl _aacp _aacw _aacz _aad6 _aadb">해시태그</div>
								</div>
							</div>
							<div class="_aano">
								<div style="height: auto; overflow: hidden auto;">
									<div style="position: relative; display: flex; flex-direction: column; padding-bottom: 0px; padding-top: 0px;">
										<div aria-labelledby="f2ae3595f0f0e84 f19796dbeb922a8 f34fe0a9a95bafc f319ad6383b4fa4" class="_ab8w  _ab94 _ab97 _ab9f _ab9k _ab9p  _ab9- _aba8 _abcm">
											<div class="_ab8w  _ab94 _ab99 _ab9f _ab9m _ab9p  _abbj _abcm">
												<div class="x1lliihq">
													<div class="_aarf" aria-disabled="true" role="button" tabindex="-1">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<table>
								<tr>
								<th>
								임지은
								</th>
								</tr>
							
							</table>
						</div>
					</divstyle>
					</div>
					</div>
					</div>
					</div>								
			</div>
		</div>
	</div>
	</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>