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
              <h2 class="text-white font-36">1:1문의</h2>
              <ol class="breadcrumb text-left mt-10 white">
                <li><a href="${pageContext.request.contextPath}">Home</a></li>
                <li class="active">PersonalQuestion</li>
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
            <h4 class="title">1:1문의</h4>

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
							<c:choose>
								<c:when test="${empty list}">
								
									<div class="container pb-0">
										<div class="section-title">
											<div class="row">
												<div class="col-md-6 col-md-offset-3">
													<div class="text-center">
														<!-- <h5 class="sub-title">Sub Title Here</h5> -->
														<td colspan='4' align="center"><h2 class="title">등록된 1:1 문의가 없습니다.</h2>
														
														<a href="${pageContext.request.contextPath}/mypage/personalQuestionForm" class="btn btn-dark btn-theme-colored btn-lg mt-20">1:1 문의하러 가기<i class="fa fa-arrow-circle-right"></i></a>
														</td>
													</div>
												</div>
											</div>
										</div>
									</div>
									
								</c:when>
								<c:otherwise>
									<c:forEach items="${list}" var="question" varStatus="status">
										<tr>
											<th scope="row">${status.count}</th>
											<td><a href="${pageContext.request.contextPath}/personalQuestionDetail/${question.code}">${question.subject}</a></td>
											<td>${question.regdate}</td>
											<c:choose>
												<c:when test="${question.state==200}">
													<td>답변대기중</td>
												</c:when>
												<c:otherwise>
													<td>답변완료</td>
												</c:otherwise>
												
											</c:choose>
										</tr>
									</c:forEach>
									<td colspan='4' align="center">

				
										<a href="${pageContext.request.contextPath}/mypage/personalQuestionForm" class="btn btn-dark btn-theme-colored btn-lg mt-20">1:1 문의하러 가기 <i class="fa fa-arrow-circle-right"></i></a>
									</td>
								</c:otherwise>
							</c:choose>
							
							
							</tbody>
						</table>
					</div>
					
					
          </div>
        </div>

      </div>
    </section> 
  </div>
  <!-- end main-content -->