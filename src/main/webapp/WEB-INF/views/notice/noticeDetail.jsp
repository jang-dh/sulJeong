<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<SCRIPT type="text/javascript">
	$(function() {
		$("input[value=수정하기]")	.click(function() {
			$("#requestForm").attr("action", "${pageContext.request.contextPath}/updateForm/${detail.code}");
			$("#requestForm").submit();
		});

		$("input[value=삭제하기]").click(function() {
			$("#requestForm").attr("action", "${pageContext.request.contextPath}/delete?code=${detail.code}");
			$("#requestForm").submit();
		});
	});
</script>
    <section>
      <div class="container pt-70">
        <div class="row">
          
          <div class="col-md-7">
            <h3 class="text-theme-colored mt-0 mb-20">제목 : ${detail.subject }</h3>
            <%-- <hr>
            <h4 class="text-theme-colored mt-0 mb-20">작성일 : ${detail.regdate}</h4> --%>
            <hr>
            <textarea style="border: 0px" readonly="readonly" cols="100" rows="8">${detail.content}</textarea>
            <%-- <p>${detail.content}</p> --%>
            <p>작성일 : ${detail.regdate}</p>
            <c:if test="${!empty detail.filename}">
            <a class="btn btn-gray mt-20" href="${pageContext.request.contextPath}/down?fileName=${detail.filename}">${detail.filename }</a>
            </c:if>   
            <hr>         
            <a href="${pageContext.request.contextPath}/notice" class="active">리스트로 돌아가기</a>
            <p></p>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
            <form name="requestForm" method="post" id="requestForm">
           		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
				<input type=hidden name="id" value="${detail.code}">
				<input type=button value="수정하기" class="btn btn-dark btn-theme-colored btn-circled btn-sm">
				<input type=button value="삭제하기" class="btn btn-dark btn-theme-colored btn-circled btn-sm" >
			</form>
			</sec:authorize>
          </div>
        </div>
      </div>
     
    </section>
</div>
<!-- end main-content -->
