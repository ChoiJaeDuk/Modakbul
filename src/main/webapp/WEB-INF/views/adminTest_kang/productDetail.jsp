<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:include page="../common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세</title>
<!--===============================================================================================-->
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/images/icons/favicon.png" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/slick/slick.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/MagnificPopup/magnific-popup.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/util.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/main.css">
<!--===============================================================================================-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#reviewBtn").on("click", function() {
			let user = '${sessionScope.loginUser.nickname}';
			
			let proCode = $("#productCode").val();
			let star = $("#star").val();
			let content = $("#review").val();
			
			$.ajax({
				url:'ajax',
				type:'post',
				dataType:'json',
				data:{
					key:"review",
					methodName:"insertReview",
					productCode:proCode,
					rating:star,
					reviewContent:content
				},
				success:function(result) {
					let str = "";
					
					str+='<div class="flex-w flex-t p-b-68">';
					str+='<div class="wrap-pic-s size-109 bor0 of-hidden m-r-18 m-t-6"></div>';
					str+='<div class="size-207">';
					str+='<div class="flex-w flex-sb-m p-b-17">';
					str+='<span class="mtext-107 cl2 p-r-20">'+user+'</span> <span class="fs-18 cl11"> </span>';
					str+='</div>';
					str+='<p class="stext-102 cl6">'+content+'<p>';
					str+='</div></div>';
					
					$("#endendend").prepend(str);
					$(".w-full").remove(".w-full");
				},
				error : function(err) {
					
				}
			});
		});
	});
</script>
</head>
<body>
	<c:set var="string1" value="${prodocut.image}"/>
	<c:set var="bb" value="${fn:split(string1,'.')[0]}"/>
	<c:set var="cc" value="${fn:split(string1,'.')[1]}"/>
	<c:set var="len" value="${fn:length(bb)}"/>
	<c:set var="aa" value="${fn:substring(bb,0,len-1)}"/>

	<input type="hidden" id="productCode" value="${prodocut.productCode}">

	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="index.html" class="stext-109 cl8 hov-cl1 trans-04"> 스토어
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a> <a href="product.html" class="stext-109 cl8 hov-cl1 trans-04">
				카테고리 <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a> <span class="stext-109 cl4"> 소파 </span>
		</div>
	</div>

	<!-- Product Detail -->
	<section class="sec-product-detail bg0 p-t-65 p-b-60">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-lg-7 p-b-30">
					<div class="p-l-25 p-r-30 p-lr-0-lg">
						<div class="wrap-slick3 flex-sb flex-w">
							<div class="wrap-slick3-dots"></div>
							<div class="wrap-slick3-arrows flex-sb-m flex-w"></div>

							<div class="slick3 gallery-lb">
								<div class="item-slick3"
									data-thumb="${pageContext.request.contextPath}/save/${prodocut.image}">
									<div class="wrap-pic-w pos-relative">
										<img
											src="${pageContext.request.contextPath}/save/${prodocut.image}"
											alt="IMG-PRODUCT"> <a
											class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04"
											href="images/product-detail-01.jpg"> <i
											class="fa fa-expand"></i>
										</a>
									</div>
								</div>

								<div class="item-slick3"
									data-thumb="${pageContext.request.contextPath}/save/${aa}2.${cc}">
									<div class="wrap-pic-w pos-relative">
										<img
											src="${pageContext.request.contextPath}/save/${aa}2.${cc}"
											alt="IMG-PRODUCT"> <a
											class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04"
											href="images/product-detail-02.jpg"> <i
											class="fa fa-expand"></i>
										</a>
									</div>
								</div>

								<div class="item-slick3"
									data-thumb="${pageContext.request.contextPath}/save/${aa}3.${cc}"">
									<div class="wrap-pic-w pos-relative">
										<img
											src="${pageContext.request.contextPath}/save/${aa}3.${cc}""
											alt="IMG-PRODUCT"> <a
											class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04"
											href="images/product-detail-03.jpg"> <i
											class="fa fa-expand"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 col-lg-5 p-b-30">
					<div class="p-r-50 p-t-5 p-lr-0-lg">
						<h4 class="mtext-105 cl2 js-name-detail p-b-14">
							${prodocut.productName}
						</h4>
						<span class="mtext-106 cl2">
							<fmt:formatNumber value="${prodocut.price}" type="currency"/>
						</span>

						<!--  -->
						<div class="flex-w flex-r-m p-b-10">
							<div class="size-203 flex-c-m respon6">Color</div>
							<div class="size-204 respon6-next">
								<div class="rs1-select2 bor8 bg0">
									<select class="js-select2" name="time" id="time">
										<option value="0">색상 선택 옵션</option>
										<c:forEach items="${prodocut.colorList }" var="color">
											<option value="${color.colorName }">${color.colorName }</option>
										</c:forEach>
									</select>
									<div class="dropDownSelect2"></div>
								</div>
							</div>
						</div>

						<div class="flex-w flex-r-m p-b-10">
							<div class="size-204 flex-w flex-m respon6-next">
								<div class="wrap-number-product flex-w m-r-20 m-tb-10">
									<input class="numberProduct" type="number" min="1" max="100"
										value="1" id="odrerQty">
								</div>
							</div>
							<div class="btn_productSelect">
								<div calss="pcart" style="display: block; margin-right: 10px;">
									<button
										class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 js-addcart"
										id="basket">장바구니</button>
								</div>
								<div calss="pbuy">
									<button
										class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 poductbuy"
										id="kakaodirect">
										<span>구매하기</span>
									</button>
								</div>
							</div>
						</div>
					</div>

					<!--  -->
				</div>
			</div>
			<div class="bor10 m-t-50 p-t-43 p-b-40">
				<!-- Tab01 -->
				<div class="tab01">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item p-b-10"><a class="nav-link active"
							data-toggle="tab" href="#description" role="tab">상품상세설명</a></li>

						<li class="nav-item p-b-10"><a class="nav-link"
							data-toggle="tab" href="#information" role="tab">상품정보</a></li>

						<li class="nav-item p-b-10"><a class="nav-link"
							data-toggle="tab" href="#reviews" role="tab">리뷰</a></li>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content p-t-43">
						<!-- - -->
						<div class="tab-pane fade show active" id="description"
							role="tabpanel">
							<div class="how-pos2 p-lr-15-md">
								<p class="stext-102 cl6">${prodocut.productDetail}</p>
							</div>
						</div>

						<!-- - -->
						<div class="tab-pane fade" id="information" role="tabpanel">
							<div class="row">
								<div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
									<ul class="p-lr-28 p-lr-15-sm">
										<li class="flex-w flex-t p-b-7"><span
											class="stext-102 cl3 size-205"> Weight </span> <span
											class="stext-102 cl6 size-206"> 0.79 kg </span></li>

										<li class="flex-w flex-t p-b-7"><span
											class="stext-102 cl3 size-205"> Dimensions </span> <span
											class="stext-102 cl6 size-206"> 110 x 33 x 100 cm </span></li>

										<li class="flex-w flex-t p-b-7"><span
											class="stext-102 cl3 size-205"> Materials </span> <span
											class="stext-102 cl6 size-206"> 60% cotton </span></li>

										<li class="flex-w flex-t p-b-7"><span
											class="stext-102 cl3 size-205"> Color </span> <span
											class="stext-102 cl6 size-206"> Black, Blue, Grey,
												Green, Red, White </span></li>

										<li class="flex-w flex-t p-b-7"><span
											class="stext-102 cl3 size-205"> Size </span> <span
											class="stext-102 cl6 size-206"> XL, L, M, S </span></li>
									</ul>
								</div>
							</div>
						</div>

						<!-- 리뷰 -->
						<!-- 상품코드 ${prodocut.productCode}-->
						<div class="tab-pane fade" id="reviews" role="tabpanel">
							<div class="row">
								<div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
									<div class="p-b-30 m-lr-15-sm">
										<!-- 리뷰작성 -->
										<!-- form에 보낼것 : 상품 -->
										<div class="w-full">
											<input type="hidden" id="reviewProductCode"
												name="productCode" value="${prodocut.productCode}" />
											<h5 class="mtext-108 cl2 p-b-7">리뷰작성</h5>

											<div class="flex-w flex-m p-t-50 p-b-23">
												<span class="stext-102 cl3 m-r-16"> 별점을 선택해주세요! </span> <span
													class="wrap-rating fs-18 cl11 pointer"> <i value="1"
													class="item-rating pointer zmdi zmdi-star-outline"></i> <i
													value="2"
													class="item-rating pointer zmdi zmdi-star-outline"></i> <i
													value="3"
													class="item-rating pointer zmdi zmdi-star-outline"></i> <i
													value="4"
													class="item-rating pointer zmdi zmdi-star-outline"></i> <i
													value="5"
													class="item-rating pointer zmdi zmdi-star-outline"></i> <input
													class="dis-none" type="number" name="rating" id="star">
												</span>
											</div>

											<div class="row p-b-25">
												<div class="col-12 p-b-5">
													<label class="stext-102 cl3" for="review">이 상품을 얼마나
														만족하시나요?</label> <input
														class="size-110 bor8 stext-102 cl2 p-lr-20 p-tb-10"
														id="review" name="review" placeholder="최소 10자 이상 작성해주세요."
														style="font-size: 12px;"></input>
												</div>

											</div>

											<button id="reviewBtn"
												class="flex-c-m stext-101 cl0 size-112 bg7 bor11 hov-btn3 p-lr-15 trans-04 m-b-10">
												등록</button>
										</div>


										<!-- ReviewList -->
										<div id="endendend">
										<c:forEach items="${prodocut.reviewList}" var="review">
											<div class="flex-w flex-t p-b-68">
												<div class="wrap-pic-s size-109 bor0 of-hidden m-r-18 m-t-6"></div>

												<div class="size-207">
													<div class="flex-w flex-sb-m p-b-17">
														<span class="mtext-107 cl2 p-r-20"> ${review.user.nickname} </span> <span
															class="fs-18 cl11"> </span>
													</div>

													<p class="stext-102 cl6">${review.reviewContent}<p>
												</div>
											</div>
										</c:forEach>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>

	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/js/jquery-3.6.1.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<!--===============================================================================================-->
	<script language=javascript>
		$(".js-select2").each(function(){
			$(this).select2({
				minimumResultsForSearch: 20,
				dropdownParent: $(this).next('.dropDownSelect2')
			});
		})
	</script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/daterangepicker/moment.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/parallax100/parallax100.js"></script>
	<script>
        $('.parallax100').parallax100();
	</script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
	<script>
		$('.gallery-lb').each(function() { // the containers for all your galleries
			$(this).magnificPopup({
		        delegate: 'a', // the selector for gallery item
		        type: 'image',
		        gallery: {
		        	enabled:true
		        },
		        mainClass: 'mfp-fade'
		    });
		});
	</script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/isotope/isotope.pkgd.min.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">		
		/*장바구니*/
		$('.js-addcart').each(function(){
			var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				let code=$("#productCode").val();
				let color=$("#time").val();
				
				if(color=="0") {
					alert("색상을 선택하세요");
					return;
				}
				
				let num=$("#odrerQty").val();
				let reurl = confirm("장바구니로 가시겠습니까");
				
				$.ajax({
					url : "ajax",	// 서버의 주소
					type : "post",	// 요청방식(method방식 = post, get, put, delete 등등)
					dataType : "text",	// 서버가 보내온 데이터타입(디폴트 text, html, xml, json)
					data : {
						key : "basket",
						methodName : "insert",
						productCode : code,
						odrerQty : num,
						colorName : color
					},	// 서버에게 보낼 parameter 정보
					success : function(result) {
						swal(nameProduct, "장바구니에 담았습니다.", "success");
						if(reurl) {
							location.href="${pageContext.request.contextPath}/store/cart.jsp";
						}
					},
					error : function(err) {
						
					}
				});	
			});
		});
		/*---------------------------------------------*/
		/*구매하기*/
		$('.poductbuy').each(function(){
			var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				let code=$("#productCode").val();
				let color=$("#time").val();
				
				if(color=="0") {
					alert("색상을 선택하세요");
					return;
				}
				
				let num=$("#odrerQty").val();
				
				$.ajax({
					url : "ajax",	// 서버의 주소
					type : "post",	// 요청방식(method방식 = post, get, put, delete 등등)
					dataType : "text",	// 서버가 보내온 데이터타입(디폴트 text, html, xml, json)
					data : {
						key : "basket",
						methodName : "insert",
						productCode : code,
						odrerQty : num,
						colorName : color
					},	// 서버에게 보낼 parameter 정보
					success : function(result) {
						swal(nameProduct, "결제창으로 이동합니다", "success");
						location.href="${pageContext.request.contextPath}/store/orderBuy.jsp";
					},
					error : function(err) {
						
					}
				});	
			});
		});
		
	</script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script>
		$('.js-pscroll').each(function(){
			$(this).css('position','relative');
			$(this).css('overflow','hidden');
			var ps = new PerfectScrollbar(this, {
				wheelSpeed: 1,
				scrollingThreshold: 1000,
				wheelPropagation: false,
			});

			$(window).on('resize', function(){
				ps.update();
			})
		});
	</script>
	<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
	<script>
	    $('.btn-number-product-down').on('click', function(){
	        var numProduct = Number($(this).next().val());
	        if(numProduct > 0) $(this).next().val(numProduct - 1);
	    });
	
	    $('.btn-number-product-up').on('click', function(){
	        var numProduct = Number($(this).prev().val());
	        $(this).prev().val(numProduct + 1);
	    });
	</script>
	<!--===============================================================================================-->

</body>
</html>
<jsp:include page="../common/footer.jsp" />