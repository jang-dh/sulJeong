<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
	// 페이지 이동
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/admin/fundingRequest?curPage="+curPage;
	}
	
	$(function() {
		var curUrl = location.href;
		var curPageNum = curUrl.split("=")[1];
		console.log(curPageNum);
		
		$(".numberBtn").eq(curPageNum-1).addClass("active");
	});
	
</script>
<!-- -----------------------------페이지 처리좀 해보자 -->

<section>
	<div class="container pt-20 pb-20">
		<div class="esc-heading lr-line left-heading">
			<h4>사이트 관리</h4>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="vertical-tab">
					<ul class="nav nav-tabs">
						<li><a href="${pageContext.request.contextPath}/admin/siteManagement">사이트 통계</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/fundingInsert">펀딩 등록</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/personalQuestion">1:1 문의 내역</a></li>
						<li class="active"><a href="${pageContext.request.contextPath}/admin/fundingRequest">펀딩 오픈 신청 내역</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-9">
				<div class="tab-content">

					<div class="main-content">
						<section>
							<div class="container">

								<h4 class="title">펀딩등록신청</h4>

								<div data-example-id="hoverable-table" class="bs-example"
									style="width: 70%">
									<table class="table table-hover">
										<thead>
											<tr>
												<th scope="row">글번호</th>
												<th>제목</th>
												<th>등록일</th>
												<th>상태</th>
											</tr>
										</thead>
										<tbody>

											<c:set var="length" value="${fn:length(list)}" />
											<c:forEach items="${list}" var="request" varStatus="status">
												<tr>
													<th scope="row">${request.code}</th>
													<td><a
														href="${pageContext.request.contextPath}/admin/fundingRequestDetail?code=${request.code}">${request.subject}</a></td>
													<td>${request.regdate}</td>
													<c:choose>
														<c:when test="${request.state eq '100'}">
															<td>신청 거절</td>
														</c:when>
														<c:when test="${request.state eq '101'}">
															<td>신청 승인</td>
														</c:when>
														<c:when test="${request.state eq '103'}">
															<td>펀딩 등록 완료</td>
														</c:when>
														<c:otherwise>
															<td>심사중...</td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:forEach>

										</tbody>
									</table>
									
									<!-- -----------------페이지 처리좀 해보자 ------------------ -->
					<nav style="text-align: center">
					<ul class="pagination dark">
						<li>
							<a href="#" aria-label="Previous" onClick="fn_paging(${paging.prevPage})">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
							<li class="numberBtn" value="${pageNum}">
								<a href="#" onClick="fn_paging(${pageNum})" id="pageBtn">${pageNum}
									<span class="sr-only">(current)</span>
								</a>
							</li>
						</c:forEach>
						<li>
							<a href="#" aria-label="Next" onClick="fn_paging(${paging.nextPage})">
								<span aria-hidden="true">»</span>
							</a>
						</li>
					</ul>
				</nav>
					<!-- --------------------페이지 처리좀 해보자 --------------- -->
								</div>
								
								

							</div>
						</section>
					</div>

				</div>
			</div>
		</div>
	</div>
</section>

