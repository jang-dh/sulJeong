<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="principal" property="principal" />
<script>
	//contextPath 얻기
	function getContextPath() {
		var hostIndex = location.href.indexOf(location.host)
				+ location.host.length;
		return location.href.substring(hostIndex, location.href.indexOf('/',
				hostIndex + 1));
	}

	$(function() {
		$("#insertBtn").click(function() {
			if ($("#contentBox").val() == "") {
				alert("내용을 입력해주세요");
				$("#contentBox").focus();
				return false;
			}
	
			var contentVal = $("#contentBox").val();
			console.log(contentVal);
	
			//var allDate = {"name":nameVal, "phone":phoneVal};
			var allDate = "${_csrf.parameterName}=${_csrf.token}" + "&contentBox=" + contentVal + "&code=" + ${detail.code};
			$.ajax({
				url : getContextPath() + "/contentInsert", //서버요청주소
				type : "post", //요청방식(get|post|put:patch:delete)
				dataType : "json", //서버가 보내온 데이터 타입(text,html,xml,json)
				data : allDate,//서버에게 보내는 parameter 정보
				success : function(result) {
					$("#comments").html(result.questionCode + "| " + result.content + " | " + result.regdate);
					$("#insertComment").hide();
	
				},//성공했을대
				error : function(err) {
					alert("답변은 한개만 등록가능합니다.");
				}//오류발생했을때
			});
		});
	});
</script>

<!-- Start main-content -->
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
							<li><a href="${pageContext.request.contextPath}/">fundingQuestionDetail</a></li>
							<li class="active">Detail</li> --%>
						</ol>
					</div>
				</div>
			</div>
		</div>

	</section>

	<div class="container pt-70">
		<div class="row">
			<div class="col-md-7 col-md-push-3">
				<h3 class="text-theme-colored mt-0 mb-20">제목 : ${question.subject}</h3>
				<p>작성자 : ${question.member.id}</p>
				<p>작성일 : ${question.regdate}</p>
				<hr>
				<p>${question.content}</p>
				<hr>
				<h3 class="text-theme-colored mt-0 mb-20">답변</h3>
				<c:choose>
					<c:when test="${empty question.fundingAnswer.content}">
						<div class="mb-50">
							등록된 답변이 없습니다.
						</div>
					</c:when>
					<c:otherwise>
						<textarea class="form-control required" rows="5" readonly>${question.fundingAnswer.content}</textarea>
					</c:otherwise>
				</c:choose>
				<!-- 관리자 권한이 있을때만 보이게 해야함 -->
			</div>
		</div>
	</div>
</div>
<!-- end main-content -->
