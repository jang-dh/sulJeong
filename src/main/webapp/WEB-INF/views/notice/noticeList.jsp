<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<script>
	// 페이지 이동
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/notice?curPage="+curPage;
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
	<!-- -----------------------------페이지 처리좀 해보자 -->
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay"
		data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">공지사항</h2>
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
		<div class="container">
			<div class="row">
				<div class="col-md-10 mt-20 col-md-push-1">
					<div data-example-id="hoverable-table" class="bs-example">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="row" width="100">글번호</th>
									<th>제목</th>
									<th width="150">등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="length" value="${fn:length(list)}" />
								<c:forEach items="${list}" var="notice" varStatus="status">
									<tr>
										<th scope="row">${notice.code}</th>
										<td><a
											href="${pageContext.request.contextPath}/noticeDetail/${notice.code}">${notice.subject}</a></td>
										<td>${notice.regdate}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a href="${pageContext.request.contextPath}/insertFrom" class="btn btn-dark btn-theme-colored btn-circled">등록</a>
					</sec:authorize>

					<!-- -----------------페이지 처리좀 해보자 ------------------ -->
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
					<!-- --------------------페이지 처리좀 해보자 --------------- -->
				</div>
			</div>
		</div>
	</section>
</div>
<!-- end main-content -->