<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
$(function() { 
	$(document).on("click", "#deliveryBtn", function() {
		var num = $(this).prev().prev().prev().val();
		var cour = $(this).parent().prev().find(":first").val()
		
		if(cour==""){
			alert("택배사를 입력해주세요");
			$(this).parent().prev().find(":first").focus();
			return;
		}
		
		if(num==""){
			alert("송장번호를 입력해주세요");
			$(this).prev().prev().prev().focus();
			return;
		}
		
		$("#fundingCode").val($(this).prev().val())
		$("#memberCode").val($(this).prev().prev().val())
		$("#deliveryNumber").val(num)
		$("#courier").val(cour)
		
		//전송하기
		$("#userInfo").submit();			
	});//버튼 클릭시
});
</script>

<!-- Section: inner-header -->
<section class="inner-header divider layer-overlay"	data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
	<div class="container pt-90 pb-40">
		<!-- Section Content -->
		<div class="section-content">
			<div class="row">
				<div class="col-md-6">
					<h2 class="text-white font-36">내가 만든 펀딩</h2>
					<ol class="breadcrumb text-left mt-10 white">
						<!--<li><a href="#">Home</a></li>
						<li><a href="#">Pages</a></li>
						<li class="active">Causes Grid</li>-->
					</ol> 
				</div>
			</div>
		</div>
	</div>
</section>

<section>
	<div class="container pt-20 pb-20 mt-20">
		<!-- <div class="esc-heading lr-line left-heading">
			<h4>내가 만든 펀딩</h4>
		</div> -->
		<div class="row">
			<div class="col-md-3">
				<div class="vertical-tab">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab18" data-toggle="tab" aria-expanded="true">펀딩 문의 관리</a>
						</li>
						<li class="">
							<a href="#tab19" data-toggle="tab" aria-expanded="false">참가한 사용자</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="col-md-9">
				<div class="tab-content">
					<div class="tab-pane fade active in" id="tab18">
						<div class="row">
							<div class="col-md-12">
								<div data-example-id="hoverable-table" class="bs-example">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>#</th>
												<th>작성자ID</th>
												<th>제목</th>
												<th>작성일</th>
												<th>답변상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${fundingReqManage}" var="fundingReqManage" varStatus="state">
												<tr>
													<th scope="row">${state.count}</th>
													<td>${fundingReqManage.member.id}</td>
													<td><a href="${pageContext.request.contextPath}/mypage/myOpenFundingReqManage/${fundingReqManage.code}">${fundingReqManage.subject}</a></td>
													<td>${fundingReqManage.regdate}</td>
													<c:choose>
														<c:when test="${fundingReqManage.state=='201'}">
															<td>답변완료</td>
														</c:when>
														<c:otherwise>
															<td>답변 대기중</td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane fade" id="tab19">
						<div class="row">
							<div class="col-md-12">
								<div data-example-id="hoverable-table" class="bs-example">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									<c:choose>
										<c:when test="${funding.fundingState==503}">
											<table class="table table-hover">
												<thead>
													<tr>
														<th>#</th>
														<th>아이디</th>
														<th>이름</th>
														<th>주소</th>
														<th>택배회사</th>
														<th>송장번호</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${fundingOpenPeople}"	var="fundingOpenPeople" varStatus="state">
														<tr>
															<th scope="row">${state.count}</th>
															<th scope="row">${fundingOpenPeople.id}</th>
															<td>${fundingOpenPeople.name}</td>
															<td>${fundingOpenPeople.addr}</td>
															
															<c:choose>
																<c:when test="${fundingOpenPeople.purchase.courier==null}">
																	<td><input type="text" > <!--  courier--></td>
																	<td>
																		<input type="text" ><!--  deliveryNumber-->
																		<input type="hidden"  value="${fundingOpenPeople.code}"> <!-- memberCode -->
																		<input type="hidden"  value="${fundingCode}"><!-- fundingCode -->
																		<input type="button"  id="deliveryBtn" class="btn btn-dark btn-sm" name="deliveryBtn" value="입력">
																	</td>
																</c:when>
																<c:otherwise>
																	<td>
																		<input type="text" id="courier2" name="courier2" value="${fundingOpenPeople.purchase.courier}" readonly="readonly">
																	</td>
																	<td>
																		<input type="text" id="deliveryNumber2" name="deliveryNumber2" value="${fundingOpenPeople.purchase.deliveryNumber}" readonly="readonly">
																		<input type="hidden" id="memberCode2" name="memberCode2" value="${fundingOpenPeople.code}">
																		<input type="hidden" id="fundingCode2" name="fundingCode2" value="${fundingCode}">
																		<input type="button" class="btn btn-dark btn-sm" id="updateBtn" name="updateBtn" onclick="location.href='${pageContext.request.contextPath}/mypage/deliveryUpdate/${fundingCode}/${fundingOpenPeople.code}'" value="수정">
																	</td>
																</c:otherwise>
															</c:choose>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</c:when>
										<c:otherwise>
											<h3>펀딩이 성공된 후 회원 목록을 볼 수 있습니다.</h3>
										</c:otherwise>
									</c:choose>
									<form action="${pageContext.request.contextPath}/mypage/deliveryCode" name="userInfo" id="userInfo" method="post">
										<input type="hidden" id="courier" name="courier">
										<input type="hidden" id="deliveryNumber" name="deliveryNumber"/>
										<input type="hidden" id="memberCode" name="memberCode" >
										<input type="hidden" id="fundingCode" name="fundingCode" >
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<a href="${pageContext.request.contextPath}/mypage/myOpenFunding" class="pull-right mt-10">리스트로 돌아가기</a>
			</div>
		</div>
	</div>
</section>

