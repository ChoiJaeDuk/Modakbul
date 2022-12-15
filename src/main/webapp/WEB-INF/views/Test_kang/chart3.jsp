<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Lora:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet" >

<!--
font-family: 'Noto Sans KR', sans-serif;
font-family: 'Roboto', sans-serif;
font-family: 'Lora', serif;

  -->


<!-- 템플릿요소 css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>

<!-- 외부의 css파일 연결하기 -->
<link rel="stylesheet" type="text/css" href="../layout/css/Reset.css">
<link rel="stylesheet" type="text/css" href="../layout/css/Layout.css">
<link rel="stylesheet" type="text/css" href="../css/manager/ManagerSales.css">
<style type="text/css">
.sidebar {
	height: 100%;
	width: 0px;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	background-color: #222;
	overflow-x: hidden;
	transition: 0.5s;
	padding: 0;
	display: none;
}

.sidebar a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 25px;
	color: #818181;
	display: block;
	transition: 0.3s;
	top: 50px;
	position: relative;
}

.sidebar a:hover {
	color: #f1f1f1;
}

.sidebar .closebtn {
	position: absolute;
	top: 0;
	right: 25px;
	font-size: 36px;
	margin-left: 50px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
	.sidebar {
		padding-top: 15px;
	}
	.sidebar a {
		font-size: 18px;
	}
}
</style>

<!-- 차트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

<style type="text/css">
</style>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

	$(function(){
		//브랜드당월별매출 조회
		$(".tablinks").on("click", function(){
			
			
			$.ajax({
				url :"../ajax" , //서버요청주소
				type:"post", //요청방식(method방식 : get | post | put | delete )
				dataType:"json"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
				data: {key:"salesAjax" , methodName : "selectBrandSalesByMonth", brand : $(this).val() },	
				success :function(result){
					let str="";
					$.each(result, function(index, item){
						str+=`<tr>`;
						str+=`<th>${"${item.month}"}</th>`;
						str+=`<th>${"${item.totalSales.toLocaleString()}"}원</th>`;
						str+=`<th>${"${item.totalProfit.toLocaleString()}"}원</th>`;
						str+=`</tr>`;
					})
					
					$("#myTable3 tr:gt(0)").remove();
					$("#myTable3 tr:eq(0)").after(str);
					
					
				} , //성공했을때 실행할 함수 
				error : function(err){  
					alert(err+"에러 발생했어요.");
				}  //실팽했을때 실행할 함수 
			});//ajax끝
			
		
		})
		
		//전체 매출 조회
		function salesList(){
			
			$.ajax({
				url :"../ajax" , //서버요청주소
				type:"post", //요청방식(method방식 : get | post | put | delete )
				dataType:"json"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
				data: {key:"salesAjax" , methodName : "selectSales" },	
				success :function(result){
					
			
					$(".sales-price:eq(0)").text(result.totalSales.toLocaleString());
					$(".sales-price:eq(1)").text(result.totalProfit.toLocaleString());
					
					
				} , //성공했을때 실행할 함수 
				error : function(err){  
					alert(err+"에러 발생했어요.");
				}  //실팽했을때 실행할 함수 
			});//ajax끝


		}
		
		//브랜드당 매출 조회
		function brandSalesList(){
			$.ajax({
				url :"../ajax" , //서버요청주소
				type:"post", //요청방식(method방식 : get | post | put | delete )
				dataType:"json"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
				data: {key:"salesAjax" , methodName : "selectBrandSales"},	
				success :function(result){
					let str="";
					$.each(result, function(index, item){
						str+=`<tr>`;
						str+=`<td>${"${item.brand}"}</th>`;
						str+=`<td>${"${item.totalSales.toLocaleString()}"}원</th>`;
						str+=`<td>${"${item.totalProfit.toLocaleString()}"}원</th>`;
						str+=`</tr>`;
					})
					
					
					$("#myTable2 tr:gt(0)").remove();
					$("#myTable2 tr:eq(0)").after(str);
					
					
				} , //성공했을때 실행할 함수 
				error : function(err){  
					alert(err+"에러 발생했어요.");
				}  //실팽했을때 실행할 함수 
			});//ajax끝
			

		}
		
		//판매량 조회
		function sellRate(){
			let brand = [];
			let rate = [];
			
			$.ajax({
				url :"../ajax" , //서버요청주소
				type:"post", //요청방식(method방식 : get | post | put | delete )
				dataType:"json"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
				data: {key:"salesAjax" , methodName : "selectSalesRateByBrand" },	
				success :function(result){
					for(let i = 0; i< result.length; i++){
						brand.push(result[i].brand);
						rate.push(result[i].totalSalesRate);
						
					}
					
					var context = document
	                 .getElementById('myChart')
	                 .getContext('2d');
					
					var myChart = new Chart(context,{
						type: 'bar', // 차트의 형태
		                data: { // 차트에 들어갈 데이터
		                    labels: brand,//x 축
		                    datasets: [
		                        { //데이터
		                            label: '판매량', //차트 제목
		                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
		                            data: rate, //브랜드별 판매 데이터 값
		                            backgroundColor: [
		                                //색상                               
		                                '#330000',
		                                '#00ccff',
		                                '#ff0033'
		                            ],
		                            borderColor: [
		                                //경계선 색상                            
		                                '#330000',
		                                '#00ccff',                              
		                                '#ff0033'
		                            ],
		                            borderWidth: 1 //경계선 굵기
		                        }
		                    ]	
					
					 }
					,
	                 options: {
	                     scales: {
	                         yAxes: [
	                             {
	                                 ticks: {
	                                     beginAtZero: true
	                                 }
	                             }
	                         ]
	                     }
					 
	                 }
					 
					 
					})
					
				} , //성공했을때 실행할 함수 
				error : function(err){  
					alert(err+"에러 발생했어요.");
				}  //실팽했을때 실행할 함수 
			});//ajax끝

			
		}
		
		//월별매출 조회
		$("#monthlySearch-dtn").on("click", function(){
			$.ajax({
				url :"../ajax" , //서버요청주소
				type:"post", //요청방식(method방식 : get | post | put | delete )
				dataType:"json"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
				data: {key:"salesAjax" , methodName : "selectSalesByMonth" },	
				success :function(result){
					let str="";
					let month = [];
					let sales = [];
					let profit = [];
					
					$.each(result, function(index, item){
						str+=`<tr>`;
						str+=`<th>${"${item.month}"}</th>`;
						str+=`<th>${"${item.totalSales.toLocaleString()}"}</th>`;
						str+=`<th>${"${item.totalProfit.toLocaleString()}"}</th>`;
						str+=`</tr>`;
					})
					
					
					$("#myTable tr:gt(0)").remove();
					$("#myTable tr:eq(0)").after(str);
					
					for(let i = 0; i<result.length; i++){
						month.push(result[i].month);
						sales.push(result[i].totalSales);
						profit.push(result[i].totalProfit);
						
					}
					
					var context = document
									.getElementById('myChart2')
									.getContext('2d');
					var myChart = new Chart(context,{
					
						type:'line',
						data:{
							labels: month,
							datasets:[{
								label:'전체매출',
								fill:false,
								type:'line',
								data:sales,
								backgroudColor:[
									'#ff0000'
									
								],
								borderColor: [
	                                //경계선 색상                            
	                                '#ff0000'
	                                
	                            ],
	                            borderWidth: 1
								},{
								label:'전체순수익',
								fill:false,
								type:'line',
								data:profit,
								backgroudColor:[
									'#ffcc00'
									
								],
								borderColor: [
	                                //경계선 색상                            
	                                '#ffcc00'
	                                
	                            ],
	                            borderWidth: 1

								
							}]
						},
					 options:{
	                     scales: {
	                         yAxes: [
	                             {
	                                 ticks: {
	                                     beginAtZero: true
	                                 }
	                             }
	                         ]
	                     }
					 
					 }	
						
					})
					

					
				} , //성공했을때 실행할 함수 
				error : function(err){  
					alert(err+"에러 발생했어요.");
				}  //실팽했을때 실행할 함수 
			});//ajax끝
			
			
		})
		

		salesList();
		brandSalesList();
		sellRate();
		
	})

</script>
</head>
<body>
	<div id="mySidebar" class="sidebar">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<a href="ManagerMember.jsp">회원관리</a> <a href="ManagerProduct.jsp">상품관리</a> <a href="ManagerOrder.jsp">주문현황</a> <a
			href="ManagerSales.jsp">매출현황</a> <a href="ManagerQABoard.jsp">문의관리</a> <a href="ManagerApproval.jsp">상품승인관리</a>
	</div>
	<div id='wrap'>

		<div class="clear"></div>


		<div id='contents'>
			<div class="container">
			<div id='con'>
				<div id='info-container'>
					<h4>매출관리페이지</h4>
					<div class="sales-detail">	
					 					
					  <div class="sales-all-detail">
					    <div class="sales-card">

					      <div class='sales-all-box' style="background-color: #ef6253; margin-left: 0">
					      	  <div class='sales-all-box-title'>
					     	  	<h3>전체매출 &nbsp;</h3>
					     	  </div>
						      <div class='sales-all-box-text'>
							      <span class='sales-price'></span>
							      <span class='sales-won'>원</span>
						      </div>
					      </div>
					      
					      <div class='sales-all-box' style="background-color: #41b979;">
					     	  <div class='sales-all-box-title'>
					     	  	<h3>전체수익 &nbsp;</h3>
					     	  </div>
						      <div class='sales-all-box-text'>
							      <span class='sales-price'></span>
							      <span class='sales-won'>원</span>
						      </div>
					      </div> 
					      
					      <div style="clear: both;">
					      	<button id="monthlySearch-dtn">월별조회하기</button>
					      	<button id='lookSellRate'>판매량통계보기</button>
							<div id="monthlySearch" style="display: none;">
							 <table id="myTable" class="myTable">
								  <tr class="header">
								    <th style="width:10%;">월</th>
								    <th style="width:45%;">매출</th>
								    <th style="width:45%;">수익</th>
								  </tr>
							</table>
								 
							</div>
					      </div>
					      
					    </div>
					  </div>
					  <br>
					 <div id='chart-box'>
						  <div class="sales-card">
						 	 <div id = "salesChart" style="width: 100%; height: 50%; display: none;">
						 	 	<h3>월별조회</h3>
								<!--차트가 그려질 부분-->
								<canvas id="myChart2"></canvas>
							</div>
							
							<div id = "sellRate" style="width: 400px; height: 200px;  display: none;">
							<h3>판매량통계</h3>
								<!--차트가 그려질 부분-->
								<canvas id="myChart"></canvas>
							</div>
						  </div>
					  </div>
					 	
					  <br>
					  
					  <div class="sales-brand-detail">
					    <div class="sales-card">
					    <h4>브랜드별 매출</h4><br>
					    <div>
					    	<table id="myTable2" class="myTable">
					    		  <tr class="header">
					    		  <th style="width:30%;">브랜드</th>
								    <th style="width:35%;">매출</th>
								    <th style="width:35%;">수익</th>
								  </tr>
								  
					    	</table>
					    	
					    </div>
					      <div class="tab">
								  <button class="tablinks" onclick="openCity(event, 'Paris')" value="샤넬">샤넬</button>
								  <button class="tablinks" onclick="openCity(event, 'Paris')" value="디올">디올</button>
								  <button class="tablinks" onclick="openCity(event, 'Paris')" value="프라다">프라다</button>
							</div>
								

								<!-- <div id="Paris" class="tabcontent">
								  <table id="myTable3" class="myTable">
								  <tr class="header">
								    <th style="width:10%;">월</th>
								    <th style="width:45%;">매출</th>
								    <th style="width:45%;">수익</th>
								  </tr>
								</table> 
								</div> -->
								

					    </div>
					  </div>
					  <div class="sales-brand-detail">
					    <div class="sales-card">
					    <h4>브랜드별 월매출</h4><br>
					    <div>
					    	<div id="Paris" class="tabcontent">
								  <table id="myTable3" class="myTable">
								  <tr class="header">
								    <th style="width:10%;">월</th>
								    <th style="width:45%;">매출</th>
								    <th style="width:45%;">수익</th>
								  </tr>
								</table> 
								</div>
					    </div>
					  </div>
					  </div>
				</div>
				
			</div>
			</div>
		</div>
			<!-- container -->
		</div>
		<!-- contents -->
		<div class="clear"></div>

	</div>
	<!-- 스크립트 -->
		<script>
	function openNav() {
		  document.getElementById("mySidebar").style.width = "250px";
		  document.getElementById("wrap").style.marginLeft = "250px";
		  document.getElementById("mySidebar").style.display = "block";
		}
		
		function closeNav() {
		  document.getElementById("mySidebar").style.width = "0px";
		  document.getElementById("wrap").style.marginLeft= "0px";
		  document.getElementById("mySidebar").style.display = "none";
		}
	
	$(function (){
		$("#monthlySearch-dtn").click(function (){
	  	$("#monthlySearch").toggle();
	  	$("#salesChart").toggle();
	  });
	})
	
	$(function (){
		$("#lookSellRate").click(function (){
		  	$("#sellRate").toggle();
		  });
	})
	
	function openCity(evt, cityName) {
	  // Declare all variables
	  var i, tabcontent, tablinks;
	
	  // Get all elements with class="tabcontent" and hide them
	  tabcontent = document.getElementsByClassName("tabcontent");
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }
	
	  // Get all elements with class="tablinks" and remove the class "active"
	  tablinks = document.getElementsByClassName("tablinks");
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].className = tablinks[i].className.replace(" active", "");
	  }
	
	  // Show the current tab, and add an "active" class to the button that opened the tab
	  document.getElementById(cityName).style.display = "block";
	  evt.currentTarget.className += " active";
	}
	</script>
</body>
