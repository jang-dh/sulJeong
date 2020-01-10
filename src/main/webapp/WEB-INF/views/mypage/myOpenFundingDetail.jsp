<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	$(function() {
		$("#deliveryBtn").click(function() {
			if ($("#courierName").val() == "") {
				alert("택배사를 입력해주세요");
				$("#courierName").focus();
				return false;
			}
			if ($("#deliveryCode").val() == "") {
				alert("송장번호를 입력해주세요");
				$("#deliveryCode").focus();
				return false;
			}

/* 			var courierVal = $("#courierName").val();
			var delCodeVal = $("#deliveryCode").val();
			//console.log(${fundingAnswer.questionCode});
			var allDate = "${_csrf.parameterName}=${_csrf.token}"
					+ "&courier=" + courierVal + "&deliveryNumber=" + delCodeVal + "&memberCode="+$("#memberCode").val()+"&fundingCode=${fundingCode}"
			$.ajax({
				url : "${pageContext.request.contextPath}/deliveryCode", //서버요청주소
				type : "post", //요청방식(get|post|put:patch:delete)
				dataType : "json", //서버가 보내온 데이터 타입(text,html,xml,json)
				data : allDate,//서버에게 보내는 parameter 정보
				success : function(result){//중복, 사용가능
	      			alert(result +"성공");
	      			$("#deliveryCode").hide();
	      			$("#courierName").hide();
	      			$("#deliveryBtn").hide();
	      			
		      		   var str="";
		      			
		      			str+="<td>"
		      			str+="<input type=text id=deliveryCode value="+result.deliveryNumber+" readonly>"
		      			str+="</td>"
		      			str+="<td>"
		      			str+="<input type=text id=courierName value="+result.Courier+" readonly>"
		      			str+="<input type=button class=btn btn-dark btn-sm id=deliveryBtn name=deliveryBtn value=수정>"
		      			str+="</td>"
		      			
		      		  $("#showId").html(str); 
		      		} ,
					
				error : function(err) {
					alert("답변은 한번만 입력 가능합니다.")
				}//오류발생했을때
			});//ajax */
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
					<div class="tab-pane fade active in" id="tab19">
						<div class="row">
							<div class="col-md-12">
								<div data-example-id="hoverable-table" class="bs-example">
								<form action="${pageContext.request.contextPath}/mypage/deliveryCode" name="userInfo" id="userInfo" method="post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
								
									
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
													
													<c:choose>
													<c:when test="${fundingOpenPeople.purchase.courier==null}">
													<td>
													<input type="text" id="courier" name="courier">
													</td>
													<td>
													<input type="text" id="deliveryNumber" name="deliveryNumber">
													<input type="hidden" id="memberCode" name="memberCode" value="${fundingOpenPeople.code}">
													<input type="hidden" id="fundingCode" name="fundingCode" value="${fundingCode}">
													<input type="submit" class="btn btn-dark btn-sm" id="deliveryBtn" name="deliveryBtn" value="입력">
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
													<input type="submit" class="btn btn-dark btn-sm" id="deliveryBtn2" name="deliveryBtn2" value="수정">
													</td>
													</c:otherwise>
													</c:choose>
													
													
													
												</tr>
											</c:forEach>
											
										</tbody>
									</table>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</section>