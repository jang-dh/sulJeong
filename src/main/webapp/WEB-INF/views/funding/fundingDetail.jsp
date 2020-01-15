<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- 카카오 지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4c64b0fa5dfd1841cf29f48be1a0d91&libraries=services"></script>


<!-- 카카오 지도 -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>

 <sec:authorize access="isAuthenticated()">
	<sec:authentication var="principal" property="principal"/>
</sec:authorize>


<script type="text/javascript">
//jquery
$(function() {
	
	$("#fundingModifyBtn").click(function(){
		location.href="${pageContext.request.contextPath}/fundingModifyBtn/${funding.code}";
	});
	
	var IMP = window.IMP;
	IMP.init('imp72693952');
	
	if(!'${likes.fundingCode}'){
		$(".insertLikes").show();
		$(".deleteLikes").hide();
	}else{
		$(".insertLikes").hide();
		$(".deleteLikes").show();
	}
	$(".insertLikes").on("click", function() {
		if(!'${principal.code}')
			alert("로그인 후 사용가능합니다.");
		else
			$.ajax({
				url : "${pageContext.request.contextPath}/likes/insert", // 서버요청주소
				type : "post", // 요청방식(get | post | put | patch | delete)
				data : "fundingCode=${funding.code}",
				dataType : "text", //서버가 보내온 데이터 타입
				/* beforeSend : function(xhr)
	            {   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            }, */
				success : function(result) {
					if(result == '1')
						alert("좋아요가 등록되었습니다.");
					$(".insertLikes").hide();
					$(".deleteLikes").show();
				}, //성공 시
				erorr : function(err) {
					alert(err + " 오류 발생");
				} //실패 시
			});
			//ajax End			
	});
	$(".deleteLikes").on("click", function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/likes/delete", // 서버요청주소
			type : "post", // 요청방식(get | post | put | patch | delete)
			data : "fundingCode=${funding.code}",
			dataType : "text", //서버가 보내온 데이터 타입
			success : function(result) {
				if(result == '1')
					alert("좋아요가 취소되었습니다.");
				$(".deleteLikes").hide();
				$(".insertLikes").show();
			}, //성공 시
			erorr : function(err) {
				alert(err + " 오류 발생");
			} //실패 시
		});
		//ajax End			
	});
	$(".question").on("click", function () {
		var fundingCode = ${funding.code};
		var content = $('input[name="form_content"]').val();
		var subject = $('input[name="form_subject"]').val();
		if(!'${principal.code}')
			alert("로그인 후 사용가능합니다.");
		else
			$.ajax({
				url: "fundingQuestionInsert", // 서버요청주소
				type: "post", // 요청방식
				data: {fundingCode : fundingCode, subject : subject, content : content},
				dataType: "text",
				success: function (result) {
					if(result == '1')
						alert("문의가 등록되었습니다.");
				},
				erorr: function (err) {
					alert(err + "오류 발생");
				}
			});
	}); //문의하기
	
	$(".addFunding").on("click", function() {
		var fundingCode = ${funding.code};
		var price = ${funding.rewardPrice};
		var qty = $('input[name="quantity"]').val();
		var customerUid = '${principal.id}' + new Date().getTime();
		//var merchantUid = 'merchant_' + new Date().getTime();
		
		if(!'${principal.code}')
			alert("로그인 후 사용가능합니다.");
		else{
			//예약 결제를 위한 빌링키 발급
			IMP.request_pay({
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    customer_uid : customerUid,
			    name : '${funding.rewardName}',
			    amount : 0,
			    buyer_email : '${principal.email}',
			    buyer_name : '${principal.name}',
			    buyer_tel : '${principal.phone}',
			    buyer_addr : '${principal.addr}',
			}, function(rsp) {
			    if (rsp.success) {
			    	//빌링키 발급 성공
			        var msg = '결제가 완료되었습니다.';
			        //결제 서버에 빌링키 전달
			        $.ajax({
			            url: "https://www.myservice.com/billings/", // 서비스 웹서버
			            method: "POST",
			            headers: { "Content-Type": "application/json" },
			            data: {
			            	customer_uid: customerUid // 카드(빌링키)와 1:1로 대응하는 값
						}
					});
			        var merchantUid = 'merchant_' + new Date().getTime();
			        //구매 테이블에 추가
					$.ajax({
						url: "${pageContext.request.contextPath}/insertPurchase", //서버요청주소
						type: "post",
						data: {fundingCode : fundingCode, price : price, qty : qty, customerUid : customerUid, merchantUid : merchantUid},
						dataType: "text",
						success: function (result) {
							if(result == '1')
								alert("펀딩이 추가 되었습니다.");
						},
						erorr: function (err) {
							alert(err + "오류 발생");
						}
					});
			    } else {
			    	alert('빌링키 발급 실패');
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			    }
			
			    alert(msg);
			});
			/* $.ajax({
				url: "${pageContext.request.contextPath}/insertPurchase", //서버요청주소
				type: "post",
				data: {fundingCode : fundingCode, price : price, qty : qty, customer_uid : },
				dataType: "text",
				success: function (result) {
					if(result == '1')
						alert("펀딩이 추가 되었습니다.");
				},
				erorr: function (err) {
					alert(err + "오류 발생");
				}
			}); */
			
		}
	});
	//펀딩하기
	//펀딩하기
});
//jquery End
</script>

<!-- Start main-content -->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">펀딩 상세 페이지</h2>
						<!-- <ol class="breadcrumb text-left mt-10 white">
							<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Product Details</li>
						</ol> -->
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container pb-10">
			<div class="section-content">
				<div class="row">
					<div class="product mb-20">
						<div class="col-md-5">
							<div class="product-image">
								<div class="zoom-gallery">
									<a href="http://placehold.it/460x460" title="Title Here 1">
										<img src="${pageContext.request.contextPath}/resources/images/funding/Thumnail_${funding.image}" alt="">
									</a>
								</div>
							</div>
						</div>
						<%-- <form action="transfer"> --%>
						<div class="col-md-7">
							<div class="product-summary">
								<h2 class="product-title">${funding.title}
								
								 <sec:authorize access="hasRole('ROLE_ADMIN')"> 
								<span style="float:right">
									<button style="text-align: right;" class="btn btn-default btn-theme-colored mt-5 font-16 btn-sm" type="button" id="fundingModifyBtn" name="fundingModifyBtn">
													수정하기 <i class="fa fa-gear"></i>
												</button>
												</span>
								
								</sec:authorize></h2>
								
								<div class="product_review">
									<ul class="review_text list-inline">
										<li>
											<div title="Rated 4.50 out of 5" class="star-rating">
												<span style="width: 90%;">3.50</span>
											</div>
										</li>
										<li><a href="#"><span>5</span>Reviews</a></li>
										<li><a href="#">Add reviews</a></li>
									</ul>
								</div>
								<div class="price">
									<span class="amount"><fmt:formatNumber>${funding.rewardPrice}</fmt:formatNumber>원</span>
								</div>
								<div class="short-description">
									<p>Donec volutpat purus tempor sem molestie, sed blandit
										lacus posuere. Lorem ipsum dolor sit amet, consectetur
										adipiscing elit. Ut posuere mollis nulla ut consectetur.</p>
								</div>
								<div class="tags">
									<strong>판매자:</strong> ${funding.member.name}
								</div>
								<div class="category">
									<strong>Category:</strong>
									<c:choose>
										<c:when test="${funding.category == 301}">탁주</c:when>
										<c:when test="${funding.category == 302}">청주</c:when>
										<c:when test="${funding.category == 303}">증류주</c:when>
										<c:when test="${funding.category == 304}">과실주</c:when>
										<c:when test="${funding.category == 305}">와인</c:when>
									</c:choose>
								</div>
								<div class="tags">
									<strong>Tags:</strong> <a href="#">Saddles</a>, <a href="#">Whip</a>
								</div>
								<br>
								<div class="pull-left font-weight-400 text-black-333 pr-0">
									<strong>펀딩종료 </strong>
								</div>
								<div class="col-md-3">
									<div class="text-center" data-countdown="${funding.endDate}"></div>
								</div>
								<script type="text/javascript">
									$(document).ready(function() {
										$('[data-countdown]').each(function() {
											var $this = $(this), finalDate = $(this).data('countdown');
											$this.countdown(finalDate,function(event) {
												$this.html(event.strftime('%D 일 %H:%M:%S'));
											});
										});
									});
								</script>
							</div>
							<div class="pull-right font-weight-400 text-black-333 pr-0">
								<strong>후원인원: </strong><span
									class="text-theme-colored font-weight-700"> ${fundingSponser} 명</span>
							</div>
							<br>
							<div>
								<ul class="list-inline font-weight-600 font-16 clearfix mt-15">
									<li class="pull-left font-weight-400 text-black-333 pr-0"><strong>달성금액:
									</strong><span class="text-theme-colored font-weight-700"><fmt:formatNumber>${funding.stackPrice}</fmt:formatNumber>원</span></li>
									<li class="pull-right font-weight-400 text-black-333 pr-0"><strong>목표금액:
									</strong><span class="text-theme-colored font-weight-700"><fmt:formatNumber>${funding.goalPrice}</fmt:formatNumber>원</span></li>
								</ul>
							</div>
							<div class="progress-item mt-15">
								<div class="progress mb-0">
									<div
										data-percent="${funding.stackPrice/funding.goalPrice *100}"
										class="progress-bar appeared"
										style="width: ${funding.stackPrice/funding.goalPrice *100}%;">
										<span class="percent"><fmt:formatNumber value="${funding.stackPrice/funding.goalPrice}" type="percent"/></span>
									</div>
								</div>
							</div>
							<div class="pull-right font-weight-400 text-black-333 pr-0 mt-15 mb-15">
								<button class="single_add_to_cart_button btn btn-theme-colored deleteLikes" type="button">
									좋아요 취소 <i class="fa fa-thumbs-down text-white mr-10"></i>
								</button>
								<div class="font-icon-list col-md-2 col-sm-3 col-xs-6 col-xs-6"></div>
								<button class="single_add_to_cart_button btn btn-default btn-theme-colored insertLikes" type="button">
									좋아요 <i class="fa fa-thumbs-up"></i>
								</button>
								<div class="font-icon-list col-md-2 col-sm-3 col-xs-6 col-xs-6"></div>
							</div>
						</div>
						<%-- </form> --%>
						<div class="cart-form-wrapper mt-30">
							<!-- <input type="hidden" value="productID" name="add-to-cart"> -->
							<table class="table variations no-border">
								<tbody>
									<tr>
										<td class="col-md-5"></td>
										<td class="name col-md-1"><div class="mt-10">수량</div></td>
										<td class="value mt-10 col-md-4">
											<div class="quantity buttons_added mt-10">
												<input type="button" class="minus" value="-"> 
												<input type="number" size="4" class="input-text qty text" title="Qty" value="1" name="quantity" min="1" step="1">
												<input type="button" class="plus" value="+">
											</div>
										</td>
										<td class="col-md-2">
											<div class="pull-right font-weight-400 text-black-333 pr-0">
												<button class="btn btn-default btn-theme-colored mt-5 font-16 btn-sm addFunding" type="button">
													펀딩하기<i class="flaticon-charity-make-a-donation font-16 ml-5"></i>
												</button>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<form id="product_form" name="product_form" action="${pageContext.request.contextPath}/funding/fundingQuestionInsert"
				method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<div class="col-md-12">
						<div class="horizontal-tab product-tab">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab1" data-toggle="tab">상품상세</a></li>
								<li><a href="#tab2" data-toggle="tab">상품문의</a></li>
								<li><a href="#tab3" data-toggle="tab">배송/교환/반품 안내</a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane fade in active" id="tab1">
									<!-- <h3>Product Description</h3>
									<p>One Lorem ipsum dolor sit amet, consectetur adipisicing
										elit. Quaerat, iste, architecto ullam tenetur quia nemo
										ratione tempora consectetur quos minus voluptates nisi hic
										alias libero explicabo reiciendis sint ut quo nulla ipsa
										aliquid neque molestias et qui sunt. Odit, molestiae. One
										Lorem ipsum dolor sit amet, consectetur adipisicing elit.
										Quaerat, iste, architecto ullam tenetur quia nemo ratione
										tempora consectetur quos minus voluptates nisi hic alias
										libero explicabo reiciendis sint ut quo nulla ipsa aliquid
										neque molestias et qui sunt. Odit, molestiae.</p>
									<p>One Lorem ipsum dolor sit amet, consectetur adipisicing
										elit. Quaerat, iste, architecto ullam tenetur quia nemo
										ratione tempora consectetur quos minus voluptates nisi hic
										alias libero explicabo reiciendis sint ut quo nulla ipsa
										aliquid neque molestias et qui sunt. Odit, molestiae.</p> -->
										<img src="${pageContext.request.contextPath}/resources/images/funding/Detail_${funding.image}" alt="">
									<!-- <table class="table table-striped">
										<tbody>
											<tr>
												<th>Brand</th>
												<td><p>Envato</p></td>
											</tr>
											<tr>
												<th>Color</th>
												<td><p>Brown</p></td>
											</tr>
											<tr>
												<th>Size</th>
												<td><p>Large, Medium</p></td>
											</tr>
											<tr>
												<th>Weight</th>
												<td>27 kg</td>
											</tr>
											<tr>
												<th>Dimensions</th>
												<td>16 x 22 x 123 cm</td>
											</tr>
										</tbody>
									</table> -->
									<h3 class="line-bottom">저희 양조장은 여기 있어요!</h3>
									<div id="map" style="width:100%;height:350px;"></div>
								</div>
									<div class="tab-pane fade" id="tab2">
									<!-- <div class="col-sm-6"> -->
									<div class="funding_question">
										<label>제목 <small>*</small></label> 
										<input name="form_subject" type="text" placeholder="제목을 입력해 주세요." class="form-control">
										<label>문의내용 <small>*</small></label>
										<input name="form_content" type="text" 
											class="form-control required" rows="5"
											placeholder="내용을 입력해 주세요.">
										
										<button type="button" class="btn btn-dark btn-flat question"
											data-toggle="modal" data-target=".bs-example-modal-sm">문의하기</button>

										<!-- <div class="modal fade bs-example-modal-sm" tabindex="-1"
											role="dialog" aria-labelledby="mySmallModalLabel">
											<div class="modal-dialog modal-sm">
												<div class="modal-content">문의가 등록 되었습니다.</div>
											</div>
										</div> -->
										<!-- </div> -->
									</div>
									<!-- </div> -->
								</div>
								<div class="tab-pane fade" id="tab3">
									<!-- <div class="col-sm-6"> -->
									<h5 class="prod-delivery-return-policy-title">배송정보</h5>
									<table class="prod-delivery-return-policy-table">
										<colgroup>
											<col width="150px">
											<col width="340px">
											<col width="150px">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th>배송방법</th>
												<td>순차배송</td>
												<th rowspan="2">배송비</th>
												<td rowspan="2">2,500원<br>- 19,800원 이상 구매 시 무료배송<br>-
													도서산간 지역 추가비용 없음
												</td>
											</tr>
											<tr>
												<th>묶음배송 여부</th>
												<td>가능</td>
											</tr>
											<tr>
												<th>배송기간</th>
												<td colspan="3">
													<ul>
														<li class="prod-delivery-period-contents etc-pdd-info">
															ㆍ<span>주문 및 결제 완료 후, 2-3일 이내 도착</span>
														</li>
														<li class="prod-delivery-period-contents">ㆍ도서 산간 지역등은 
															<p class="prod-delivery-period__notice">ㆍ천재지변, 물량 수급 변동 등 예외적인 사유 발생 시, 다소 지연될 수 있는 점 양해 부탁드립니다.</p>
														</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>

									<h5 class="prod-delivery-return-policy-title">교환/반품 안내</h5>
									<table class="prod-delivery-return-policy-table">
										<colgroup>
											<col width="160px">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th>교환/반품 신청 기준일</th>
												<td>
													<p>ㆍ[단순변심/ 주문 오류의 경우] 신선식품인 술이 포함되어 단순변심 교환/반품을 받지
														않습니다.</p>
													<p>ㆍ상품의 내용이 표시·광고의 내용과 다른 경우에는 상품을 수령한 날부터 3개월 이내, 그 사실을 안 날
														또는 알 수 있었던 날부터<br> 
														<span class="prod-delivery-return-policy__limit-list__indent">
															30일 이내에 청약철회 가능
														</span>
													</p>
												</td>
											</tr>
										</tbody>
									</table>

									<div class="product-item__table product-seller">
										<p class="prod-minor-notice">미성년자가 체결한 계약은 법정대리인이 동의하지 않는
											경우 본인 또는 법정대리인이 취소할 수 있습니다.</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div>
				<div class="col-md-12">
					<!-- 아래 네모 네개 시작
					<h3 class="line-bottom">Related Products</h3>
					<div class="row multi-row-clearfix">
						<div class="products related">
							<div class="col-sm-6 col-md-3 col-lg-3 mb-30">
								<div class="product pb-0">
									<span class="tag-sale">Sale!</span>
									<div class="product-thumb">
										<img alt="" src="http://placehold.it/320x360"
											class="img-responsive img-fullwidth">
										<div class="overlay">
											<div class="btn-add-to-cart-wrapper">
												<a
													class="btn btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">Add To Cart</a>
											</div>
											<div class="btn-product-view-details">
												<a
													class="btn btn-default btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">View detail</a>
											</div>
										</div>
									</div>
									<div class="product-details text-center bg-lighter pt-15 pb-10">
										<a href="#"><h5 class="product-title mt-0">Vests</h5></a>
										<div class="star-rating" title="Rated 3.50 out of 5">
											<span style="width: 80%;">3.50</span>
										</div>
										<div class="price">
											<del>
												<span class="amount">$165.00</span>
											</del>
											<ins>
												<span class="amount">$160.00</span>
											</ins>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-md-3 col-lg-3 mb-30">
								<div class="product pb-0">
									<span class="tag-sale">Sale!</span>
									<div class="product-thumb">
										<img alt="" src="http://placehold.it/320x360"
											class="img-responsive img-fullwidth">
										<div class="overlay">
											<div class="btn-add-to-cart-wrapper">
												<a
													class="btn btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">Add To Cart</a>
											</div>
											<div class="btn-product-view-details">
												<a
													class="btn btn-default btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">View detail</a>
											</div>
										</div>
									</div>
									<div class="product-details text-center bg-lighter pt-15 pb-10">
										<a href="#"><h5 class="product-title mt-0">Saddles</h5></a>
										<div class="star-rating" title="Rated 3.50 out of 5">
											<span style="width: 60%;">3.50</span>
										</div>
										<div class="price">
											<del>
												<span class="amount">$70.00</span>
											</del>
											<ins>
												<span class="amount">$55.00</span>
											</ins>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-md-3 col-lg-3 mb-30">
								<div class="product pb-0">
									<div class="product-thumb">
										<img alt="" src="http://placehold.it/320x360"
											class="img-responsive img-fullwidth">
										<div class="overlay">
											<div class="btn-add-to-cart-wrapper">
												<a
													class="btn btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">Add To Cart</a>
											</div>
											<div class="btn-product-view-details">
												<a
													class="btn btn-default btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">View detail</a>
											</div>
										</div>
									</div>
									<div class="product-details text-center bg-lighter pt-15 pb-10">
										<a href="#"><h5 class="product-title mt-0">Helmets</h5></a>
										<div class="star-rating" title="Rated 3.50 out of 5">
											<span style="width: 75%;">3.50</span>
										</div>
										<div class="price">
											<ins>
												<span class="amount">$185.00</span>
											</ins>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-md3 col-lg-3 mb-30">
								<div class="product pb-0">
									<div class="product-thumb">
										<img alt="" src="http://placehold.it/320x360"
											class="img-responsive img-fullwidth">
										<div class="overlay">
											<div class="btn-add-to-cart-wrapper">
												<a
													class="btn btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">Add To Cart</a>
											</div>
											<div class="btn-product-view-details">
												<a
													class="btn btn-default btn-theme-colored btn-sm btn-flat pl-20 pr-20 btn-add-to-cart text-uppercase font-weight-700"
													href="#">View detail</a>
											</div>
										</div>
									</div>
									<div class="product-details text-center bg-lighter pt-15 pb-10">
										<a href="#"><h5 class="product-title mt-0">Saddles</h5></a>
										<div class="star-rating" title="Rated 5.00 out of 5">
											<span style="width: 100%;">5.00</span>
										</div>
										<div class="price">
											<ins>
												<span class="amount">$480.00</span>
											</ins>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				아래 네모 네개 -->
			</div>
		</div>
		<script>
         var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
             mapOption = {
                 center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                 level: 3 // 지도의 확대 레벨
             };  
         
         // 지도를 생성합니다    
         var map = new kakao.maps.Map(mapContainer, mapOption); 
         
         // 주소-좌표 변환 객체를 생성합니다
         var geocoder = new kakao.maps.services.Geocoder();
         
         // 주소로 좌표를 검색합니다 ${requestScope.gym.addr}
         geocoder.addressSearch('${juso.addr}', function(result, status) {
         
             // 정상적으로 검색이 완료됐으면 
              if (status === kakao.maps.services.Status.OK) {
         
                 var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
         
                 // 결과값으로 받은 위치를 마커로 표시합니다
                 var marker = new kakao.maps.Marker({
                     map: map,
                     position: coords
                 });
         
                 // 인포윈도우로 장소에 대한 설명을 표시합니다
                 var infowindow = new kakao.maps.InfoWindow({
                     content: '<div style="width:150px;text-align:center;padding:6px 0;">${juso.addr}</div>'
                 });
                 infowindow.open(map, marker);
         
                 // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                 map.setCenter(coords);
             } 
         });    
</script>
	</section>
	<!-- end main-content -->
</div>
