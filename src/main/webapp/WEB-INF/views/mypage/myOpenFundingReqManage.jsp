<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	$(function() {
		$("#answerButton").click(function() {
			if ($("#answerText").val() == "") {
				alert("답변을 입력해주세요");
				$("#answerText").focus();
				return false;
			}

			var answerVal = $("#answerText").val();
			//console.log(${fundingAnswer.questionCode});
			var allDate = "${_csrf.parameterName}=${_csrf.token}"
					+ "&content=" + answerVal + "&questionCode=${fundingQuestion.code}"
			$.ajax({
				url : "${pageContext.request.contextPath}/fundingAnswer", //서버요청주소
				type : "post", //요청방식(get|post|put:patch:delete)
				dataType : "json", //서버가 보내온 데이터 타입(text,html,xml,json)
				data : allDate,//서버에게 보내는 parameter 정보
				success : function(result) {
					$("#showId").html(result.content)
				},//성공했을대
				error : function(err) {
					alert("답변은 한번만 입력 가능합니다.")
				}//오류발생했을때
			});
		});
	});
</script>
<body>


	<!-- 글 내용-->
		<table border="1" summary="">
			<caption>게시판 상세</caption>
			<colgroup>
				<col style="width: 130px;">
				<col style="width: auto;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td>${fundingQuestion.subject}</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td>${fundingQuestion.member.id}</td>
				</tr>
				<tr>
					<td colspan="2">
						<ul class="etcArea">
							<li class=""><strong>작성일</strong> <span class="txtNum">${fundingQuestion.regdate}</span>
							</li>
						</ul>
						<div class="detail">
							<p></p>

							<p>
								<br>
							</p>
							${fundingQuestion.content}
							<p>
								<br>
							</p>
						</div>
					</td>
				</tr>
				<c:choose>
					<c:when test="${not empty fundingAnswer}">
						<tr>
							<td colspan="2">
								<ul class="etcArea">
									<li class=""><strong>답변 작성일</strong> <span class="txtNum">${fundingAnswer.regdate}</span>
									</li>
								</ul>
								<div class="detail">${fundingAnswer.content}</div>
							</td>
						</tr>
					</c:when>

					<c:otherwise>
						<tr>
							<td colspan="2">
								<div id="showId"></div>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>


	<c:choose>
		<c:when test="${fundingAnswer.content!=null}">
			<input type="hidden">
		</c:when>
		<c:otherwise>
			<input type="text" id="answerText" name="answerText">
			<button type="button" class="btn btn-dark btn-sm" id="answerButton" name="answerButton">등록</button>
		</c:otherwise>
	</c:choose>
	<br>
	<br>
	<a href="${pageContext.request.contextPath}/mypage/???">리스트로 돌아가기</a>

</body>