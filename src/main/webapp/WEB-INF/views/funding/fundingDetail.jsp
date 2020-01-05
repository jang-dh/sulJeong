<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	$(function() {
		$("button[type=button]").on("click", function() {
			//alert(${funding.code});
			$.ajax({
				url : "serialize", // 서버요청주소
				type : "post", // 요청방식(get | post | put | patch | delete)
				data : "fundingCode=" + ${funding.code},
				dataType : "text", //서버가 보내온 데이터 타입
				beforeSend : function(xhr)
                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
				success : function(result) {
					if(result == '1')
						alert("좋아요가 등록되었습니다.");
				}, //성공 시
				erorr : function(err) {
					alert(err + " 오류 발생");
				} //실패 시
				
			});
		});
	});
	
	$("#funding_question").validate({
        submitHandler: function(form) {
          var form_btn = $(form).find('button[type="submit"]');
          var form_result_div = '#form-result';
          $(form_result_div).remove();
          form_btn.before('<div id="form-result" class="alert alert-success" role="alert" style="display: none;"></div>');
          var form_btn_old_msg = form_btn.html();
          form_btn.html(form_btn.prop('disabled', true).data("loading-text"));
          $(form).ajaxSubmit({
            dataType:  'json',
            success: function(data) {
              if( data.status == 'true' ) {
                $(form).find('.form-control').val('');
              }
              form_btn.prop('disabled', false).html(form_btn_old_msg);
              $(form_result_div).html(data.message).fadeIn('slow');
              setTimeout(function(){ $(form_result_div).fadeOut('slow') }, 6000);
            }
          });
        }
      });
</script>

<!-- Start main-content -->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="http://placehold.it/1920x1280">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">Product Details</h2>
						<ol class="breadcrumb text-left mt-10 white">
							<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Product Details</li>
						</ol>
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
									<img src="http://placehold.it/460x460" alt=""></a>
								</div>
							</div>
						</div>
						<div class="col-md-7">
							<div class="product-summary">
								<h2 class="product-title">${funding.title}</h2>
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
									<span class="amount">${funding.rewardPrice}원</span>
								</div>
								<div class="short-description">
									<p>Donec volutpat purus tempor sem molestie, sed blandit
										lacus posuere. Lorem ipsum dolor sit amet, consectetur
										adipiscing elit. Ut posuere mollis nulla ut consectetur.</p>
								</div>
								<div class="tags">
									<strong>SKU:</strong> EA34
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
									<div class="text-center" data-countdown="2020/03/01"></div>
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
									class="text-theme-colored font-weight-700"> 0명</span>
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
									<div data-percent="${fundingList.stackPrice/fundingList.goalPrice *100}" class="progress-bar">
										<span class="percent">${fundingList.stackPrice/fundingList.goalPrice *100}%</span>
									</div>
								</div>
							</div>
							<div class="pull-left font-weight-400 text-black-333 pr-0 mt-15 mb-15">
								<a href="#">문의하기</a>
							</div>
							<div class="pull-right font-weight-400 text-black-333 pr-0 mt-15 mb-15">
								<button class="single_add_to_cart_button btn btn-theme-colored" type="button">좋아요 <i class="fa fa-thumb-tack text-white mr-10"></i></button>
							</div>
							<div class="cart-form-wrapper mt-30">
								<form id="frm" enctype="multipart/form-data" method="post"class="cart"
									action="${pageContext.request.contextPath}/funding/purchase">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<!-- <input type="hidden" value="productID" name="add-to-cart"> -->
									<table class="table variations no-border">
										<tbody>
											<tr>
												<td class="name"><div class="mt-10">수량</div></td>
												<td class="value mt-10">
													<div class="quantity buttons_added mt-10">
														<input type="button" class="minus" value="-">
														<input type="number" size="4" class="input-text qty text" title="Qty" value="1" name="quantity" min="1" step="1">
														<input type="button" class="plus" value="+">
													</div>
												</td>
												<td>
													<div class="pull-right font-weight-400 text-black-333 pr-0">
														<input type="button" id="likeButton"
															class="btn btn-default btn-theme-colored mt-5 font-16 btn-sm"
															class="flaticon-charity-make-a-donation font-16 ml-5"
															value="펀딩하기">
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
					<form id="product_form" name="product_form" method="post" enctype="multipart/form-data">
					<div class="col-md-12">
						<div class="horizontal-tab product-tab">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab1" data-toggle="tab">상품상세</a></li>
								<li><a href="#tab2" data-toggle="tab">상품리뷰</a></li>
								<li><a href="#tab3" data-toggle="tab">상품문의</a></li>
								<li><a href="#tab4" data-toggle="tab">배송/교환/반품 안내</a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane fade in active" id="tab1">
									<h3>Product Description</h3>
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
										aliquid neque molestias et qui sunt. Odit, molestiae.</p>
									<table class="table table-striped">
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
									</table>
								</div>
								<div class="tab-pane fade" id="tab2">
									<div class="reviews">
										<ol class="commentlist">
											<li class="comment">
												<div class="media">
													<a href="#" class="media-left"><img class="img-circle"
														alt="" src="https://placehold.it/75x75" width="75"></a>
													<div class="media-body">
														<ul class="review_text list-inline">
															<li>
																<div title="Rated 5.00 out of 5" class="star-rating">
																	<span style="width: 100%;">5.00</span>
																</div>
															</li>
															<li>
																<h5 class="media-heading meta">
																	<span class="author">Tom Joe</span> â€“ Mar 15, 2015:
																</h5>
															</li>
														</ul>
														Lorem ipsum dolor sit amet, consectetur adipiscing elit.
														Donec volutpat purus tempor sem molestie, sed blandit
														lacus posuere. Lorem ipsum dolor sit amet.
													</div>
												</div>
											</li>
											<li class="comment">
												<div class="media">
													<a href="#" class="media-left"><img class="img-circle"
														alt="" src="https://placehold.it/75x75" width="75"></a>
													<div class="media-body">
														<ul class="review_text list-inline">
															<li>
																<div title="Rated 4.00 out of 5" class="star-rating">
																	<span style="width: 80%;">4.00</span>
																</div>
															</li>
															<li>
																<h5 class="media-heading meta">
																	<span class="author">Mark Doe</span> â€“ Jan 23, 2015:
																</h5>
															</li>
														</ul>
														Lorem ipsum dolor sit amet, consectetur adipiscing elit.
														Donec volutpat purus tempor sem molestie, sed blandit
														lacus posuere. Lorem ipsum dolor sit amet.
													</div>
												</div>
											</li>
										</ol>
									</div>
								</div>
								<div class="tab-pane fade" id="tab3">
									<div class="col-sm-6">
										<div class="funding_question">
											<label>제목 <small>*</small></label>
											<input name="form_content" type="text" placeholder="제목을 입력해 주세요." class="form-control">
											<label>문의내용 <small>*</small></label>
					                		<textarea id="form_message" name="form_message" class="form-control required" rows="5" placeholder="내용을 입력해 주세요.	"></textarea>
											<div class="pull-left font-weight-400 text-black-333 pr-0 mt-15 mb-15">
											<a href="#">문의하기</a>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="#tab4">
									
								</div>
							</div>
						</div>
					</div>
					</form>
					</div>
				</div>
				<div class="col-md-12">
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
			</div>
		</div>
	</section>
<!-- end main-content -->
</div>
