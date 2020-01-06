<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="${pageContext.request.contextPath}/js/jquery-2.2.4.min.js"></script>
<SCRIPT language=javascript>
   $(function(){

	   $("input[value=수정하기]").click(function(){
		   //document.requestForm.action="${pageContext.request.contextPath}/board/updateForm";
		   alert(1);
		   $("#requestForm").attr("action", "${pageContext.request.contextPath}/updateForm/${detail.code}");
		   $("#requestForm").submit();
	   })
	   
	   
	   $("input[value=삭제하기]").click(function(){
		  
		   $("#requestForm").attr("action", "${pageContext.request.contextPath}/board/updateForm");
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
              <h2 class="text-white font-36">Our Impact</h2>
              <ol class="breadcrumb text-left mt-10 white">
				<li><a href="${pageContext.request.contextPath}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/notice">Notice</a></li>
                <li class="active">Detail</li>
              </ol>
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
            <p>${detail.content}</p>
            <p>작성일 : ${detail.regdate}</p>
            <c:if test="${!empty detail.filename}">
            <a class="btn btn-gray mt-20" href="${pageContext.request.contextPath}/down/${detail.code}">${detail.filename }</a>
            </c:if>   
            <hr>         
            <a href="${pageContext.request.contextPath}/notice" class="active">리스트로 돌아가기</a>
            <p></p>

            <form name="requestForm" method="post" id="requestForm">
				<input type=hidden name="id" value="${detail.code}">
				<input type=button value="수정하기" class="btn btn-dark btn-theme-colored btn-circled btn-sm">
				<input type=button value="삭제하기" class="btn btn-dark btn-theme-colored btn-circled btn-sm" >
			</form>
          </div>
        </div>
      </div>
    </section>


    
    
  </div>
  <!-- end main-content -->
