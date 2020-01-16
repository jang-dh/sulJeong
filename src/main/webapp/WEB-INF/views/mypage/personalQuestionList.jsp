<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
   // 페이지 이동
   function fn_paging(curPage){
      location.href="${pageContext.request.contextPath}/mypage/myQuestion?curPage="+curPage;
   }
   
   $(function() {
      var curUrl = location.href;
      var curPageNum = curUrl.split("=")[1];
      console.log(curPageNum);
      
      $(".numberBtn").eq(curPageNum-1).addClass("active");
   });
   
</script>


<div class="main-content">
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
      <div class="container pt-90 pb-40">
        <!-- Section Content -->
        <div class="section-content">
          <div class="row"> 
            <div class="col-md-6">
              <h2 class="text-white font-36">1:1문의</h2>
              
            </div>
          </div>
        </div>
      </div>
    </section>

    <section>
                     <div class="container">

                        <h4 class="title">1:1 문의내역</h4>

                        <div data-example-id="hoverable-table" class="bs-example"
                           style="width: 100%">
                           <table class="table table-hover">
                              <c:choose>
                                 <c:when test="${not empty list}">
                                    <thead>
                                       <tr>
                                          <th scope="row">글번호</th>
                                          <th>제목</th>
                                          <th>등록일</th>
                                          <th>상태</th>
                                       </tr>
                                    </thead>
                                    <tbody>
                                       <c:forEach items="${list}" var="question" varStatus="status" >
                                          <tr>
                                             <th scope="row">${question.code}</th>
                                             <td><a href="${pageContext.request.contextPath}/personalQuestionDetail/${question.code}">${question.subject}</a></td>
                                             <td>${question.regdate}</td>
                                             <c:choose>
                                                <c:when test="${question.state == '200'}">
                                                   <td>진행중</td>
                                                </c:when>
                                                <c:otherwise>
                                                   <td>답변완료</td>
                                                </c:otherwise>
                                             </c:choose>
                                          </tr>
                                       </c:forEach>
                                    </tbody>
                                 </c:when>
                                 <c:otherwise>
                                    <th>아직 등록된 글이 없습니다.</th>
                                 </c:otherwise>
                              </c:choose>
                           </table>
                        </div>
                        <a href="${pageContext.request.contextPath}/mypage/personalQuestionForm" class="btn btn-dark btn-theme-colored btn-circled">등록</a>
                     </div>
                     <nav style="text-align: center">
                        <ul class="pagination dark">
                           <li>
                              <a href="#" aria-label="Previous" onClick="fn_paging(${paging.prevPage})"> <span aria-hidden="true">&laquo;</span></a>
                           </li>
                           <c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
                              <li class="numberBtn" value="${pageNum}">
                                 <a href="#" onClick="fn_paging(${pageNum})" id="pageBtn">${pageNum} <span class="sr-only">(current)</span></a>
                              </li>
                           </c:forEach>
                           <li>
                              <a href="#" aria-label="Next" onClick="fn_paging(${paging.nextPage})"> <span aria-hidden="true">»</span></a>
                           </li>
                        </ul>
                     </nav>
                  </section> 

  </div>
  <!-- end main-content -->