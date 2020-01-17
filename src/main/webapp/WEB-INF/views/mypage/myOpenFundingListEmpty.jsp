<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- Start main-content -->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg"">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">내가 만든 펀딩</h2>
						<ol class="breadcrumb text-left mt-10 white">
						<!-- <li><a href="#">Home</a></li>
						<li><a href="#">Pages</a></li>
						<li class="active">Causes Grid</li>-->
						</ol> 
					</div>
				</div>
			</div>
		</div>
	</section><br><br>

	<!-- Section: Causes -->
	<section>
		<div class="container pt-40 pb-40">
			<div class="section-content">
				<div class="row multi-row-clearfix" id="list-funding">
					<section class="bg-white-f12 exists">
						<div class="container pb-0">
							<div class="section-title">
								<div class="row">
									<div class="col-md-6 col-md-offset-3">
										<div class="text-center">
											<!-- <h5 class="sub-title">Sub Title Here</h5> -->
											<h2 class="title">아직 오픈한 펀딩이 없습니다.</h2>
											<p>여러 후원자님들이 회원님의 펀딩을 기다립니다!</p>
											<a href="${pageContext.request.contextPath}/fundingOpenRequest" class="btn btn-dark btn-theme-colored btn-lg mt-20">펀딩 오픈 신청하기 <i class="fa fa-arrow-circle-right"></i>
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</section>
</div>
<!-- end main-content -->