<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- Section: inner-header -->
<section class="inner-header divider layer-overlay overlay-dark-8"
	data-bg-img="http://placehold.it/1920x1280">
	<div class="container pt-90 pb-40">
		<!-- Section Content -->
		<div class="section-content">
			<div class="row">
				<div class="col-md-6">
					<h2 class="text-white font-36">내가 만든 펀딩 Detail</h2>
				</div>
			</div>
		</div>
	</div>
</section>
<br>
<br>
<section>
	<div class="container pt-20 pb-20">
		<div class="esc-heading lr-line left-heading">
			<h4>내가 만든 펀딩</h4>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="vertical-tab">
					<ul class="nav nav-tabs">
						<li class=""><a href="#tab18" data-toggle="tab"
							aria-expanded="false">펀딩 문의 관리</a></li>
						<li class="active"><a href="#tab19" data-toggle="tab"
							aria-expanded="true">참가한 사용자</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-9">
				<div class="tab-content">

					<div class="tab-pane fade" id="tab18">
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
													<td>${fundingReqManage.state}</td>
												</tr>
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane fade active in" id="tab19">
						<div class="row">
							<div class="col-md-12">
								<div data-example-id="hoverable-table" class="bs-example">
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
											<c:forEach items="${fundingOpenPeople}"
												var="fundingOpenPeople" varStatus="state">
												<tr>
													<th scope="row">${state.count}</th>
													<th scope="row">${fundingOpenPeople.id}</th>
													<td>${fundingOpenPeople.name}</td>
													<td>${fundingOpenPeople.addr}</td>
													<td>
													<input type="text" id="deliveryCode" name="deliveryCode">
													<button>입력</button>
													</td>
													<td>
													<input type="text" id="courierName" name="courierName">
													<button>입력</button>
													</td>
												</tr>
											</c:forEach>
											
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</section>