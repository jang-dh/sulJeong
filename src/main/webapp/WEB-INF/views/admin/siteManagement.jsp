<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/jquery-2.2.4.min.js"></script> --%>


    <section>
      <div class="container pt-20 pb-20">
        <div class="esc-heading lr-line left-heading">
          <h4>사이트 관리</h4>
        </div>
        <div class="row">
          <div class="col-md-3">
            <div class="vertical-tab">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab16" data-toggle="tab">펀딩 오픈 신청 내역</a></li>
                <li><a href="#tab17" data-toggle="tab">펀딩 등록</a></li>
                <li><a href="#tab18" data-toggle="tab">1:1 문의 내역</a></li>
                <li><a href="#tab19" data-toggle="tab">사이트 통계</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-9">
            <div class="tab-content">
              <div class="tab-pane fade in active" id="tab16">
                <div class="row">
                  <div class="col-md-12">
                  
                    <iframe src="${pageContext.request.contextPath}/admin/fundingRequest" height="400px"></iframe>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="tab17">
                <div class="row">
                  <div class="col-md-12">
   
                    <iframe src="${pageContext.request.contextPath}/admin/fundingInsert" height="400px"></iframe>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="tab18">
                <div class="row">
                  <div class="col-md-12">
                   
                    <iframe src="${pageContext.request.contextPath}/admin/personalQuestion" height="400px"></iframe>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="tab19">
                <div class="row">
                  <div class="col-md-12">
                    
                    <iframe src="${pageContext.request.contextPath}/admin/statistics" height="400px"></iframe>
                  </div>
                </div>
              </div>
            </div>
          </div>          
        </div>
      </div>
    </section>
    
    
