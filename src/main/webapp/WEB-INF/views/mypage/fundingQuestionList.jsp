<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="main-content">
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="http://placehold.it/1920x1280">
      <div class="container pt-90 pb-40">
        <!-- Section Content -->
        <div class="section-content">
          <div class="row"> 
            <div class="col-md-6">
              <h2 class="text-white font-36">펀딩 문의</h2>
              <ol class="breadcrumb text-left mt-10 white">
                <li><a href="${pageContext.request.contextPath}">Home</a></li>
                <li class="active">FundingQuestion</li>
              </ol>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="container">


        
        <div class="row">
          <div class="col-md-12 mt-40">
            <hr>
            <h4 class="title">펀딩문의</h4>

					<div data-example-id="hoverable-table" class="bs-example">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="row">글번호</th>
									<th>제목</th>
									<th>등록일</th>
									<th>진행상태</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="question" varStatus="status">
								<tr>
									<th scope="row">${status.count}</th>
									<td><a href="${pageContext.request.contextPath}/mypage/fundingQuestionDetailPage/${question.code}">${question.subject}</a></td>
									<td>${question.regdate}</td>
									<td>${question.state}</td>
								</tr>
							</c:forEach>
							
							</tbody>
						</table>
						
						<nav>
							  <ul class="pagination dark">
							    <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							    <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
    ...
  </ul>
</nav>
        </div>

      </div>
    </section> 
  </div>
  <!-- end main-content -->

