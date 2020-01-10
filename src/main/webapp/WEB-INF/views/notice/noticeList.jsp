<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="main-content">

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
	// 페이지 이동
	function fn_paging(curPage){
		location.href="${pageContext.request.contextPath}/noticePaging?curPage="+curPage;
	}
	
	$(function() {
		var curUrl = location.href;
		var curPageNum = curUrl.split("=")[1];
		console.log(curPageNum);
		
		$(".numberBtn").eq(curPageNum-1).addClass("active");
	});
	
</script>
<!-- -----------------------------페이지 처리좀 해보자 -->
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="http://placehold.it/1920x1280">
      <div class="container pt-90 pb-40">
        <!-- Section Content -->
        <div class="section-content">
          <div class="row"> 
            <div class="col-md-6">
              <h2 class="text-white font-36">공지사항</h2>
              
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
            <h4 class="title">공지사항</h4>

					<div data-example-id="hoverable-table" class="bs-example">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="row">글번호</th>
									<th>제목</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="length" value="${fn:length(list)}" />
							<c:forEach items="${list}" var="notice" varStatus="status">
								<tr>
									<th scope="row">${length-status.index}</th>
									<td><a href="${pageContext.request.contextPath}/noticeDetail/${notice.code}">${notice.subject}</a></td>
									<td>${notice.regdate}</td>
								</tr>
							</c:forEach>
							
							</tbody>
						</table>
					</div>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
					<a href="${pageContext.request.contextPath}/insertFrom" class="btn btn-dark btn-theme-colored btn-circled">등록</a>
					</sec:authorize>
					
					<!-- -----------------페이지 처리좀 해보자 ------------------ -->
					<nav style="text-align: center">
					<ul class="pagination dark">
						<li>
							<a href="#" aria-label="Previous" onClick="fn_paging(${paging.prevPage})">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
							<li class="numberBtn" value="${pageNum}">
								<a href="#" onClick="fn_paging(${pageNum})" id="pageBtn">${pageNum}
									<span class="sr-only">(current)</span>
								</a>
							</li>
						</c:forEach>
						<li>
							<a href="#" aria-label="Next" onClick="fn_paging(${paging.nextPage})">
								<span aria-hidden="true">»</span>
							</a>
						</li>
					</ul>
				</nav>
					<!-- --------------------페이지 처리좀 해보자 --------------- -->
          </div>
        </div>

      </div>
    </section> 
  </div>
  <!-- end main-content -->