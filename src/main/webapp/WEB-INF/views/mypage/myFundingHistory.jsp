<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	$(function(){
		$("input[value=후원취소]").click(function(){
			$("#updateForm").attr("action", "${pageContext.request.contextPath}/purchase/update");
			$("#updateForm").submit();
		})
	})
	
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/mypage/fundingHistory?curPage="+curPage;
	}
	
	$(function() {
		var curUrl = location.href;
		var curPageNum = curUrl.split("=")[1];
		console.log(curPageNum);
		
		$(".numberBtn").eq(curPageNum-1).addClass("active");
	});
</script>
<!-- Start main-content-->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay overlay-dark-8"
		data-bg-img="http://placehold.it/1920x1280">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-conte<nt">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">펀딩 내역</h2>
						<ol class="breadcrumb text-left mt-10 white">
							<li><a href="${pageContext.request.contextPath}">Home</a></li>
							<li><a href="${pageContext.request.contextPath}">Pages</a></li>
							<li class="active">Funding Cart</li>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container pt-70 pb-40">
			<div class="section-content">
				<div class="row">
					<div class="col-md-10 col-md-offset-1">
						<table
							class="table table-striped table-bordered tbl-shopping-cart">
							<thead>
								<tr>
									<th>펀딩일자</th>
									<th>펀딩 명칭</th>
									<th>가격</th>
									<th>수량</th>
									<th>합계</th>
									<th>후원상세</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="list" varStatus="status">
									<tr class="cart_item">
										<td class="product-thumbnail">${list.purchaseDate } <br>
											<c:choose>
												<c:when test="${list.funding.fundingState == 501}">
													<span class="label label-primary">진행 중</span>
												</c:when>
												<c:when test="${list.funding.fundingState == 502}">
													<span class="label label-default">오픈 전</span>
												</c:when>
												<c:when test="${list.funding.fundingState == 503}">
													<span class="label label-success">달성 성공</span>
												</c:when>
												<c:when test="${list.funding.fundingState == 504}">
													<span class="label label-warning">달성 실패</span>
												</c:when>
											</c:choose>
										</td>
										<td class="product-name"><a class="text-theme-colored"
											href="#">${list.funding.title}</a>
											<ul class="variation">
												<li class="product-title"><span>펀딩 코드 :
														${list.funding.code}</span></li>
											</ul></td>
										<td class="product-price"><span class="amount"><fmt:formatNumber>${list.funding.rewardPrice}</fmt:formatNumber>원</span></td>
										<td class="product-quantity">
											${list.qty}개 
										</td>
										<td class="product-subtotal"><span class="amount"><fmt:formatNumber>${list.funding.rewardPrice * list.qty}</fmt:formatNumber>원</span></td>
										<td><c:choose>
												<c:when test="${list.purchaseState=='603'}">
													<span class="label label-default">펀딩 결제 예정</span>
												</c:when>
												<c:when test="${list.purchaseState=='601'}">
													<span class="label label-info">펀딩 결제 완료</span>
												</c:when>
												<c:otherwise>
													<span class="label label-danger">펀딩 결제 취소</span>
												</c:otherwise>
											</c:choose>
											<form name="updateForm" method="post" id="updateForm">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
												<input type="hidden" name="code" value="${list.code}" />
												<c:if test="${list.purchaseState=='603' }">
													<input type="button" class="btn btn-default btn-xs pull-right" value="후원취소">
												</c:if>
											</form>
											<ul>
												<li class="deliver">송장 번호 : ${list.deliveryNumber}</li>
												<li class="courier">운송 업체 : ${list.courier}</li>
											</ul>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<nav style="text-align: center">
						<ul class="pagination dark">
							<li><a href="#" aria-label="Previous"
								onClick="fn_paging(${paging.prevPage})"> <span
									aria-hidden="true">&laquo;</span></a></li>
							<c:forEach var="pageNum" begin="${paging.startPage}"
								end="${paging.endPage}">
								<li class="numberBtn" value="${pageNum}"><a href="#"
									onClick="fn_paging(${pageNum})" id="pageBtn">${pageNum} <span
										class="sr-only">(current)</span></a></li>
							</c:forEach>
							<li><a href="#" aria-label="Next"
								onClick="fn_paging(${paging.nextPage})"> <span
									aria-hidden="true">»</span></a></li>
						</ul>
					</nav>
					<div class="col-md-10 col-md-offset-1 mt-30">
						<div class="row">
							<div class="col-md-6">
								<h4>받는사람 정보</h4>
								<form class="form" action="#">
									<table class="table no-border">
										<tbody>
											<sec:authorize access="isAuthenticated()">
												<sec:authentication var="user" property="principal" />
												<tr>
													<td class="member-name">받는사람 : ${user.name}</td>
												</tr>
												<tr>
													<td class="member-addr">받는주소 : ${user.addr}</td>
												</tr>
												<tr>
													<td class="member-phone">연락처 : ${user.phone}</td>
												</tr>
											</sec:authorize>
										</tbody>
									</table>
								</form>
							</div>
							<div class="col-md-6">
								<h4>후원 금액 총계</h4>
								<table class="table table-bordered">
									<tbody>
										<tr>
											<td>Cart Subtotal</td>
											<td>$180.00</td>
										</tr>
										<tr>
											<td>Shipping and Handling</td>
											<td>$70.00</td>
										</tr>
										<tr>
											<td>Order Total</td>
											<td>$250.00</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- end main-content -->

</div>

