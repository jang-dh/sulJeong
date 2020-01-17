<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>

	//페이지 이동
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/mypage/myOpenFunding/${fundingCode}?curPage="+curPage;
	}
	
	
	$(function() { 
		
		//페이징 시작
		var curUrl = location.href;
		var curPageNum = curUrl.split("=")[1];
		console.log(curPageNum);
		
		$(".numberBtn").eq(curPageNum-1).addClass("active");
		//페이징 끝
		
		$(document).on("click", "#deliveryBtn", function() {
			
		 var num = $(this).parent().prev().find(":first").val();
		 var cour = $(this).parent().prev().prev().find(":first").val()
		 
		 if(cour==""){
			alert("택배사를 입력해주세요");
			$(this).parent().prev().prev().find(":first").focus();
			return;
		 }
		 
		 if(num==""){
			 alert("송장번호를 입력해주세요");
			 $(this).parent().prev().find(":first").focus();
			 
			 return;
		 }
		
		
		 
		 $("#fundingCode").val($(this).parent().prev().children().next().next().val())
		 $("#memberCode").val($(this).parent().prev().children().next().val())
		 
		 $("#deliveryNumber").val(num)
		 $("#courier").val(cour)
		 
		 
		 //전송하기
		 $("#userInfo").submit();			
			 
			 
			
		});//버튼 클릭시
		
		
		
	});
</script>

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
						<li class="active"><a href="#tab18" data-toggle="tab"
							aria-expanded="true">펀딩 문의 관리</a></li>
						<li class=""><a href="#tab19" data-toggle="tab"
							aria-expanded="false">참가한 사용자</a></li>
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
													<th scope="row">${fundingReqManage.member.code}</th>
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
						
						<!-- 페이징 -->
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
						<!-- 페이징 끝 -->
						
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
												<th></th>
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
													
													<c:choose>
													<c:when test="${fundingOpenPeople.purchase.courier==null}">
													<td>
													<input type="text" > <!--  courier-->
													</td>
													<td>
													<input type="text" ><!--  deliveryNumber-->
													
													<input type="hidden"  value="${fundingOpenPeople.code}"> <!-- memberCode -->
													<input type="hidden"  value="${fundingCode}"><!-- fundingCode -->
													</td>
													<td>
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
														</td>
														<td>
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
				<a href="${pageContext.request.contextPath}/mypage/myOpenFunding">리스트로 돌아가기</a>
			</div>
		</div>
	</div>
</section>

