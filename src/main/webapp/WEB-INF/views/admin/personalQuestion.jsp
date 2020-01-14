<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	// 페이지 이동
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/admin/personalQuestion?curPage="+curPage;
	}
	
	$(function() {
		var curUrl = location.href;
		var curPageNum = curUrl.split("=")[1];
		console.log(curPageNum);
		
		$(".numberBtn").eq(curPageNum-1).addClass("active");
	});
	
</script>


<section>
	<div class="container pt-20 pb-20">
		<div class="esc-heading lr-line left-heading">
			<h4>사이트 관리</h4>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="vertical-tab">
					<ul class="nav nav-tabs">
						<li><a href="siteManagement">사이트 통계</a></li>
						<li><a href="fundingInsert">펀딩 등록</a></li>
						<li class="active"><a href="personalQuestion">1:1 문의 내역</a></li>
						<li><a href="fundingRequest">펀딩 오픈 신청 내역</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-9">
				<div class="tab-content">


					<div class="main-content">
						<section>
							<div class="container">

								<h4 class="title">1:1 문의내역</h4>

								<div data-example-id="hoverable-table" class="bs-example">
									<table class="table table-hover">
										<c:choose>
											<c:when test="${not empty list}">
												<thead>
													<tr>
														<th scope="row">글번호</th>
														<th>제목</th>
														<th>등록일</th>
														<th>상태</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list}" var="question" varStatus="status" >
														<tr>
															<th scope="row">${question.code}</th>
															<td><a href="${pageContext.request.contextPath}/personalQuestionDetail/${question.code}">${question.subject}</a></td>
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
												<th>아직 등록된 글이 없습니다.</th>
											</c:otherwise>
										</c:choose>
									</table>
								</div>

							</div>
							<nav style="text-align: center">
								<ul class="pagination dark">
									<li>
										<a href="#" aria-label="Previous" onClick="fn_paging(${paging.prevPage})"> <span aria-hidden="true">&laquo;</span></a>
									</li>
									<c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
										<li class="numberBtn" value="${pageNum}">
											<a href="#" onClick="fn_paging(${pageNum})" id="pageBtn">${pageNum} <span class="sr-only">(current)</span></a>
										</li>
									</c:forEach>
									<li>
										<a href="#" aria-label="Next" onClick="fn_paging(${paging.nextPage})"> <span aria-hidden="true">»</span></a>
									</li>
								</ul>
							</nav>
						</section>
					</div>

				</div>
			</div>
		</div>
	</div>
</section>


<!-- end main-content -->
