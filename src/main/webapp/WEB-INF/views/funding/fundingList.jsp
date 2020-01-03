<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Start main-content -->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay overlay-dark-8"
		data-bg-img="http://placehold.it/1920x1280">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">펀딩</h2>
						<!-- <ol class="breadcrumb text-left mt-10 white">
							<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Causes Grid</li>
						</ol> -->
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container pt-40 pb-0">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="#"> <img class="media-object" width="60"
							src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="#">전체보기</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="#"> <img class="media-object" width="60"
							src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="#">탁주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="#"> <img class="media-object" width="60"
							src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="#">청주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="#"> <img class="media-object" width="60"
							src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="#">증류주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="#"> <img class="media-object" width="60"
							src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="#">과실주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="#"> <img class="media-object" width="60"
							src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="#">와인</a>
							</h5>
						</div>
					</div>
				</div>
			</div>
			<div class="container pt-30 pb-0">
				<div class="col-md-5"></div>
				<div class="form-group col-md-2">
					<select class="form-control">
						<option>선택</option>
						<option>판매자 이름</option>
						<option>펀딩명</option>
					</select>
				</div>
				<div class="form-group col-md-2">
					<select class="form-control">
						<option>인기순</option>
						<option>마감임박순</option>
						<option>최신오픈순</option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<form id="mailchimp-subscription-form" class="newsletter-form"
						novalidate="true">
						<div class="input-group">
							<input type="email" value="" name="EMAIL"
								class="form-control input-lg font-16" data-height="45px"
								id="mce-EMAIL-footer" style="height: 45px;"> <span
								class="input-group-btn">
								<button data-height="45px"
									class="btn btn-colored btn-theme-colored btn-xs m-0 font-14"
									type="submit" style="height: 45px;">검색</button>
							</span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<!-- Section: Causes -->
	<section>
		<div class="container pt-0 pb-40">
			<div class="section-content">
				<div class="row multi-row-clearfix">
					<c:forEach begin="1" end="12">
						<div class="col-sm-6 col-md-3">
							<div class="causes bg-silver-light maxwidth500 mb-30">
								<div class="thumb">
									<a href="funding/detail"><img
										src="http://placehold.it/320x240" alt="" class="img-fullwidth"></a>
								</div>
								<div
									class="causes-details border-1px bg-white clearfix p-15 pb-30">
									<h4 class="font-16 text-uppercase">
										<a href="funding/detail">Education for Childreen</a>
									</h4>
									<ul class="list-inline font-weight-600 font-14 clearfix mb-5">
										<li class="pull-left font-weight-400 text-black-333 pr-0">Raised:
											<span class="text-theme-colored font-weight-700">$2860</span>
										</li>
										<li class="pull-right font-weight-400 text-black-333 pr-0">Goal:
											<span class="text-theme-colored font-weight-700">$5000</span>
										</li>
									</ul>
									<div class="progress-item mt-5">
										<div class="progress mb-0">
											<div data-percent="84" class="progress-bar appeared"
												style="width: 84%;">
												<span class="percent">0</span><span class="percent">84%</span>
											</div>
										</div>
									</div>
									<p class="mt-15">Lorem ipsum dolor sit ametconse
										adipisicing elit. Praesent quossrs it.Lorem ipsum dolor is
										emmit</p>
									<a href="funding/detail"
										class="btn btn-default btn-theme-colored mt-10 font-16 btn-sm">펀딩하기
										<i class="flaticon-charity-make-a-donation font-16 ml-5"></i>
									</a>
								</div>
							</div>
						</div>
					</c:forEach>
					<div class="col-md-12">
						<nav>
							<ul class="pagination theme-colored mt-0">
								<li><a href="#" aria-label="Previous"> <span
										aria-hidden="true">«</span>
								</a></li>
								<li class="active"><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">...</a></li>
								<li><a href="#" aria-label="Next"> <span
										aria-hidden="true">»</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<!-- end main-content -->