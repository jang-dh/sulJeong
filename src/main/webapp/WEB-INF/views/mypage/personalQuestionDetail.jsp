<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- Start main-content -->
  <div class="main-content">
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
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
            <h3 class="text-theme-colored mt-0 mb-20">제목 : ${question.subject}</h3>
			<p>작성자 : ${question.member.id}</p>
            <hr>
            <p>${question.content}</p>
            <p>작성일 : ${question.regdate}</p> 
            <hr>
            <h3 class="text-theme-colored mt-0 mb-20">답변</h3>
            <c:choose>
            	<c:when test="${!empty question.personalAnswer.content}">
<%-- 		            <form>
		            	<input class="form-control" type="text" value=" ${question.personalAnswer.content} " readonly/>
		            </form>
 --%>		            <textarea class="form-control required" rows="5" readonly>${question.personalAnswer.content}</textarea>
	            </c:when>
	            <c:otherwise>
	            	아직 등록된 답변이 없습니다.<p>
	            	<!-- 관리자 권한이 있을때만 보이게 해야함 -->
	            	<sec:authorize access="hasRole('ROLE_ADMIN')">
	            	<form action="${pageContext.request.contextPath}/admin/answerInsert" method="post">
	            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
	            		<input type="hidden" name="questionCode" value="${question.code}">
	            		<label>답변하기<small>*</small></label>
                  		<textarea name="content" class="form-control required" rows="5" placeholder="내용을 입력해 주세요"></textarea><br>
                  		<input type="submit" value="등록" class="btn btn-dark btn-theme-colored btn-circled">
	            	</form>
	            	</sec:authorize>
	            </c:otherwise>
            </c:choose>
            
            <sec:authorize access="hasRole('ROLE_ADMIN')">
            	<a href="${pageContext.request.contextPath}/admin/personalQuestion" class="active">관리자 리스트로 돌아가기</a><br>
            </sec:authorize>
            <a href="${pageContext.request.contextPath}/mypage/myQuestion" class="active">리스트로 돌아가기</a>
            <p></p>
			
            
          </div>
        </div>
      </div>
    </section>


    
    
  </div>
  <!-- end main-content -->
    