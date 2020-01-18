<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
					$("#showId").html(result.content);
					$("#showDate").html(result.regdate);
					location.reload();
				},//성공했을대
				error : function(err) {
					alert("답변은 한번만 입력 가능합니다.")
				}//오류발생했을때
			});
		});
	});
</script>
<body>

<!-- Start main-content -->
  <div class="main-content">
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="http://placehold.it/1920x1280">
      <div class="container pt-90 pb-40">
        <!-- Section Content -->
        <div class="section-content">
          <div class="row"> 
            <div class="col-md-6">
              <h2 class="text-white font-36">1:1 문의</h2>
              
            </div>
          </div>
        </div>
      </div>      
    </section>

    <section>
      <div class="container pt-70">
        <div class="row">
          
          <div class="col-md-7">
            <h3 class="text-theme-colored mt-0 mb-20">제목 : ${fundingQuestion.subject}</h3>
			<p>작성자 : ${fundingQuestion.member.id}</p>
            <hr>
            <p>${fundingQuestion.content}</p>
            <p>작성일 : ${fundingQuestion.regdate}</p> 
            <hr>
            <h3 class="text-theme-colored mt-0 mb-20">답변</h3>
            <c:choose>
            	<c:when test="${not empty fundingAnswer}">
		            <form>
		            	<input class="form-control" type="text" value="${fundingAnswer.content} " readonly/><br>
		            	 <ul class="etcArea">
	                     	<li class=""><strong>답변 작성일</strong> <span class="txtNum">${fundingAnswer.regdate}</span>
	                     	</li>
                  		</ul>
		            	
		            </form>
	            </c:when>
	            <c:otherwise>
	            	
	            </c:otherwise>
	        </c:choose>
	            
	            <c:choose>
				<c:when test="${fundingAnswer.content!=null}">
					<input type="hidden">
				</c:when>
				<c:otherwise>
	            		<label>답변하기<small>*</small></label>
                  		<textarea name="content" id="answerText" class="form-control required" rows="5" placeholder="내용을 입력해 주세요"></textarea><br>
                  		
                  		<input type="button" id="answerButton" value="등록" class="btn btn-dark btn-theme-colored btn-circled">
	            </c:otherwise>
            </c:choose>
            <br><br><hr>
            <a href="${pageContext.request.contextPath}/mypage//myOpenFunding/${fundingQuestion.fundingCode}" class="active">리스트로 돌아가기</a>
            <p></p>
          </div>
        </div>
      </div>
    </section>


    
    
  </div>
  <!-- end main-content -->