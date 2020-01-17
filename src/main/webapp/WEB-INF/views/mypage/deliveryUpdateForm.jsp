<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- Start main-content -->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">배송정보 수정</h2>
						<ol class="breadcrumb text-left mt-10 white">
								<!-- <li><a href="#">Home</a></li>
						<li><a href="#">Pages</a></li>
						<li class="active">Causes Grid</li> -->
						</ol>

					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container pt-70">
			<div class="row">
				<div class="col-md-7">
					<p>아이디 : ${member.id}</p>
					<hr>
					<p>이름 : ${member.name}</p>
					<hr>
					<p>주소 : ${member.addr}</p>
					<hr>
					<form action="${pageContext.request.contextPath}/mypage/deliveryCode" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
						택배회사 : <input class="form-control" id="courier" name="courier" type="text" value="${member.purchase.courier}" /><br> 
						송장번호 : <input class="form-control" id="deliveryNumber" name="deliveryNumber" type="text" value="${member.purchase.deliveryNumber} " /><br>
						<input type="hidden" id="memberCode" name="memberCode" value="${member.code}"> 
						<input type="hidden" id="fundingCode" name="fundingCode" value="${member.purchase.fundingCode}"> 
						<input type="submit" id="answerButton" value="수정" class="btn btn-dark btn-theme-colored btn-circled">
					</form>
					<br> <br>
					<hr>
					<a href="${pageContext.request.contextPath}/mypage/myOpenFunding/${member.purchase.fundingCode}" class="active">목록으로 돌아가기</a>
					<p></p>
				</div>
			</div>
		</div>
	</section>
</div>
<!-- end main-content -->