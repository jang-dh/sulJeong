<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	// 페이지 이동
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/mypage/fundingQuestion?curPage="+curPage;
	}
	
	$(function() {
		var curUrl = location.href;
		var curPageNum = 1;
		if(curUrl.includes("curPage"))
			curPageNum = curUrl.split("=")[1];
			
		console.log(curPageNum);
		
		$(".numberBtn").eq(curPageNum-1).addClass("active");
	});
	
</script>

<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">펀딩 문의</h2>
						<ol class="breadcrumb text-left mt-10 white">
							<%-- <li><a href="${pageContext.request.contextPath}">Home</a></li>
							<li class="active">FundingQuestion</li> --%>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container">
			<div class="row">
				<div class="col-md-12 mt-20">
					<div data-example-id="hoverable-table" class="bs-example">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="row">글번호</th>
									<th>제목</th>
									<th>등록일</th>
									<th>진행상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="question" varStatus="status">
									<tr>
										<th scope="row">${question.code}</th>
										<td><a href="${pageContext.request.contextPath}/mypage/fundingQuestionDetailPage/${question.code}">${question.subject}</a></td>
										<td>${question.regdate}</td>
										<c:choose>
											<c:when test="${question.state=='200'}">
												<td>답변대기중</td>
											</c:when>
											<c:otherwise>
												<td>답변완료</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<nav style="text-align: center">
					<ul class="pagination dark">
						<li>
							<a aria-label="Previous" onClick="fn_paging(${paging.prevPage})">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
							<li class="numberBtn" value="${pageNum}">
								<a onClick="fn_paging(${pageNum})" id="pageBtn">${pageNum}
									<span class="sr-only">(current)</span>
								</a>
							</li>
						</c:forEach>
						<li>
							<a aria-label="Next" onClick="fn_paging(${paging.nextPage})">
								<span aria-hidden="true">»</span>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>
	</section>
</div>
<!-- end main-content -->

