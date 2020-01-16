<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script src="${pageContext.request.contextPath}/js/jquery-2.2.4.min.js"></script>
<SCRIPT language=javascript>
   $(function(){

	   $("input[value=승인하기]").click(function(){
		   //document.requestForm.action="${pageContext.request.contextPath}/board/updateForm";
		   alert("승인되었습니다.");
		   $("#requestForm").attr("action", "${pageContext.request.contextPath}/admin/approve?code=${detail.code}");
		   $("#requestForm").submit();
	   })
	   
	   
	   $("input[value=거절하기]").click(function(){
		   alert("거절되었습니다.");
		   $("#requestForm").attr("action", "${pageContext.request.contextPath}/admin/reject?code=${detail.code}");
		   $("#requestForm").submit();
	   })
	   
   })
</script>
    
    
<!-- Start main-content -->
  <div class="main-content">
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="http://placehold.it/1920x1280">
      <div class="container pt-90 pb-40">
        <!-- Section Content -->
        <div class="section-content">
          <div class="row"> 
            <div class="col-md-6">
              <h2 class="text-white font-36">펀딩등록신청</h2>
              
            </div>
          </div>
        </div>
      </div>      
    </section>

    <section>
      <div class="container pt-70">
        <div class="row">
          
          <div class="col-md-7">
            <h3 class="text-theme-colored mt-0 mb-20">제목 : ${detail.subject }</h3>
            <%-- <hr>
            <h4 class="text-theme-colored mt-0 mb-20">작성일 : ${detail.regdate}</h4> --%>
            <hr>
            <p>작성일 : ${detail.regdate}</p>
            <c:if test="${!empty detail.filename}">
            <a class="btn btn-gray mt-20" href="${pageContext.request.contextPath}/down2?fileName=${detail.filename}">${detail.filename }</a>
            </c:if>   
            <hr>         
            <a href="${pageContext.request.contextPath}/admin/fundingRequest" class="active">리스트로 돌아가기</a>
            <p></p>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
            <form name="requestForm" method="post" id="requestForm">
           		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
				<input type=hidden name="id" value="${detail.code}">
				<c:if test="${detail.state eq '102'}">
				<input type=button value="승인하기" class="btn btn-dark btn-theme-colored btn-circled btn-sm">
				<input type=button value="거절하기" class="btn btn-dark btn-theme-colored btn-circled btn-sm" >
				</c:if>
			</form>
			</sec:authorize>
          </div>
        </div>
      </div>
    </section>


    
    
  </div>
  <!-- end main-content -->