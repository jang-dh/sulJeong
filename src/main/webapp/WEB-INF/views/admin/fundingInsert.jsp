<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <section>
      <div class="container pt-20 pb-20">
        <div class="esc-heading lr-line left-heading">
          <h4>사이트 관리</h4>
        </div>
        <div class="row">
          <div class="col-md-3">
            <div class="vertical-tab">
              <ul class="nav nav-tabs">
                <li><a href="siteManagement">사이트 통계</a></li>
                <li class="active"><a href="fundingInsert" >펀딩 등록</a></li>
                <li><a href="personalQuestion" >1:1 문의 내역</a></li>
                <li><a href="fundingRequest" >펀딩 오픈 신청 내역</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-9">
            <div class="tab-content">

			  <!-- Start main-content -->
  <div class="main-content">
    <!-- Section: home -->
    <section id="home" class="divider bg-lighter">

<div class="bg-lightest border-1px p-25">
                  <h4 class="text-theme-colored text-uppercase m-0">펀딩 등록</h4>
                  <div class="line-bottom mb-30"></div>
                  <p>다음 항목을 모두 채워주세요.</p>
                  <form id="appointment_form" name="appointment_form" class="mt-30" method="post" action="${pageContext.request.contextPath}/admin/fundInsert?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
                    <div class="row">
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <input name="title" class="form-control required" type="text" required="" placeholder="펀딩 이름" aria-required="true">
                        </div>
                      </div>
                      
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <select name="mdCode" class="form-control required" required="" >
    					    <option value="">펀딩승인 목록</option>
    					    <c:forEach items="${list}" var="list">
    					    <c:if test="${list.state eq '101'}">
    					    <option value="${list.memberCode}">${list.subject}</option>
    					    </c:if>    					    
   						    </c:forEach>
						  </select>
                           
                        </div>
                      </div>

                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <input name="rewardName" class="form-control required" type="text" required="" placeholder="상품명" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <input name="rewardPrice" class="form-control required" type="text" required=""  placeholder="상품가격" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <input name="goalPrice" class="form-control required" type="text" required=""  placeholder="목표금액" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <input name="openDate" class="form-control required date-picker" type="text" required=""  placeholder="시작일" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <input name="endDate" class="form-control required date-picker" type="text" required=""  placeholder="마감일" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <select name="category" class="form-control required" required="" >
    					    <option value="">-주종선택-</option>
   						    <option value="탁주">탁주</option>
    					    <option value="청주">청주</option>
    					    <option value="증류주">증류주</option>
    					    <option value="과실주">과실주</option>
    					    <option value="와인">와인</option>
						  </select>
                           
                        </div>
                      </div>
                    </div>
					  <div class="form-group">
						<label>파일 업로드</label>
					    <input name="file" class="file"	type="file" multiple data-show-upload="false" data-show-caption="true"> 
					  </div>
					<div class="form-group mb-0 mt-20">
                      <input name="form_botcheck" class="form-control" type="hidden" value="">
                      <button type="submit" class="btn btn-dark btn-theme-colored" data-loading-text="Please wait...">펀딩 등록</button>
                    </div>
                  </form>

                </div>
    </section>
  </div>  
  <!-- end main-content -->

            </div>
          </div>          
        </div>
      </div>
    </section>