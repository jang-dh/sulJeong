<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	// 페이지 이동
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/mypage/myQuestion?curPage="+curPage;
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
	<section class="inner-header divider layer-overlay"
		data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">

		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">1:1문의</h2>
						<ol class="breadcrumb text-left mt-10 white">
							<%-- <li><a href="${pageContext.request.contextPath}">Home</a></li>
							<li class="active">PersonalQuestion</li> --%>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section>
		<div class="container">
			<div class="col-md-10 col-md-push-1">
				<div data-example-id="hoverable-table" class="bs-example">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="row" width="100">글번호</th>
								<th>제목</th>
								<th width="150">등록일</th>
								<th width="150">상태</th>
							</tr>
						</thead>
						<c:choose>
							<c:when test="${not empty list}">
								<tbody>
									<c:forEach items="${list}" var="question" varStatus="status">
										<tr>
											<th scope="row">${question.code}</th>
											<td><a
												href="${pageContext.request.contextPath}/personalQuestionDetail/${question.code}">${question.subject}</a></td>
											<td>${question.regdate}</td>
											<c:choose>
												<c:when test="${question.state == '200'}">
													<td>진행중</td>
												</c:when>
												<c:otherwise>
													<td>답변완료</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</tbody>
							</c:when>
							<c:otherwise>
								<th colspan="4">
									<h3 align="center">아직 등록된 글이 없습니다.</h3>
								</th>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<div class="text-right">
				<a href="${pageContext.request.contextPath}/mypage/personalQuestionForm" class="btn btn-dark btn-theme-colored btn-lg mt-20">1:1문의 등록하기
					<i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
			</div>
		</div>
		<nav style="text-align: center">
			<ul class="pagination dark">
				<li><a aria-label="Previous" onClick="fn_paging(${paging.prevPage})"> 
				<span aria-hidden="true">&laquo;</span></a></li>
				<c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
					<li class="numberBtn" value="${pageNum}">
					<a onClick="fn_paging(${pageNum})" id="pageBtn">${pageNum} 
					<span class="sr-only">(current)</span></a></li>
				</c:forEach>
				<li><a aria-label="Next" onClick="fn_paging(${paging.nextPage})">
				<span aria-hidden="true">»</span></a></li>
			</ul>
		</nav>
	</section>
</div>
<!-- end main-content -->