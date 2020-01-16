<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
   $(function(){
      
      
      $('#file3').hide();
      $('#file4').hide();
      if("${funding}"!=""){
         $("#title").val("${funding.title}");
         $("#mdCode2").val("${funding.mdCode}");
         $("#rewardName").val("${funding.rewardName}");
         $("#rewardPrice").val("${funding.rewardPrice}");
         $("#goalPrice").val("${funding.goalPrice}");
         $("#openDate2").val("${funding.openDate}");
         $("#endDate2").val("${funding.endDate}");
         $("#category").val("${funding.category}").prop("selected", true);
         
         $("#appointment_form").attr("action","${pageContext.request.contextPath}/admin/fundUpdate");
         
         
         if("${funding.image}"==""){
            $('#Thumnail').text("선택된 파일 없음");
            $('#Detail').text("선택된 파일 없음");
         }
         
         $('#selectFileBtn1').click(function (e) {
            e.preventDefault();
            $('#file3').click();
            
         });
         
         $('#file3').change(function(){
            var name = $(this).val().split('\\');
            var fileName = name[name.length-1];
            $('#Thumnail').text(fileName);
         });
         
         $('#selectFileBtn2').click(function (e) {
            e.preventDefault();
            $('#file4').click();

         });
         
         $('#file4').change(function(){
            var name2 = $(this).val().split('\\');
            var fileName2 = name2[name2.length-1];
            $('#Detail').text(fileName2);
         });
         
      }
      var today = new Date().toLocaleString();
      var year = today.substr(0,4);
      var month = today.substr(6,1);
      var day = today.substr(9,2);
      $("#openDate").on("change",function(){   //01/24/2020
         var openDate = $("#openDate").val();
         var openYear = openDate.substr(6,4);
         var openMonth = openDate.substr(0,2);
         var openDay = openDate.substr(3,2);
         var regDate = new Date(openYear,openMonth-1,openDay).toLocaleString();
         console.log(regDate);
         if(regDate<today){
            alert("오늘 이전의 날짜는 선택할 수 없습니다.");
            $(this).val("");
         }
         
      });
   });
      
      
      </script>

    <section>
      <div class="container pt-20 pb-20">
        <div class="esc-heading lr-line left-heading">
          <h4>사이트 관리</h4>
        </div>
        <div class="row">
          <div class="col-md-3">
            <div class="vertical-tab">
              <ul class="nav nav-tabs">
                <li><a href="${pageContext.request.contextPath}/admin/siteManagement">사이트 통계</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/admin/fundingInsert" >펀딩 등록</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/personalQuestion" >1:1 문의 내역</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/fundingRequest" >펀딩 오픈 신청 내역</a></li>
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
               <c:choose>
                  <c:when test="${!empty funding}">
                      <h4 class="text-theme-colored text-uppercase m-0">펀딩 수정</h4>
                  </c:when>
                  <c:otherwise>
                     <h4 class="text-theme-colored text-uppercase m-0">펀딩 등록</h4>
                  </c:otherwise>
               </c:choose>
                 
                  <div class="line-bottom mb-30"></div>
                  <p>다음 항목을 모두 작성해주세요.</p>
                  <form id="appointment_form" name="appointment_form" class="mt-30" method="post" action="${pageContext.request.contextPath}/admin/fundInsert?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
                    <div class="row">
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          펀딩 이름 : <input id="title" name="title" class="form-control required" type="text" required="" placeholder="펀딩 이름" aria-required="true">
                        </div>
                      </div>
                      
                      <div class="col-sm-12">
                        <div class="form-group mb-10" id="fundingListAccept">
                        <c:choose>
                        <c:when test="${empty funding}">
                           펀딩승인 목록 : <select id="mdCode" name="mdCode" class="form-control required" required="" >
                       <option value="">펀딩승인 목록</option>
                       <c:forEach items="${list}" var="list">
                       <c:if test="${list.state eq '101'}">
                       <option value="${list.memberCode}">${list.subject}</option>
                       <!-- fundingRequest.code 넘김 -->
                       <c:set value="${list.code}" var="code"/>
                       </c:if>                       
                         </c:forEach>
                    </select>
                        </c:when>
                        <c:otherwise>
                          작성자 코드 : <input type="text" id="mdCode2" name="mdCode" class="form-control required" required="" readonly="readonly" value="${funding.mdCode}">
                    </c:otherwise>
                  </c:choose>
                    
  
                        </div>
                      </div>

                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          상품명 : <input id="rewardName" name="rewardName" class="form-control required" type="text" required="" placeholder="상품명" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          상품가격 : <input id="rewardPrice" name="rewardPrice" class="form-control required" type="text" required=""  placeholder="상품가격" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          목표금액 : <input id="goalPrice" name="goalPrice" class="form-control required" type="text" required=""  placeholder="목표금액" aria-required="true">
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          <c:choose>
                           <c:when test="${!empty funding}">
                            시작일 : <input id="openDate2" name="openDate" class="form-control required date-picker" type="text" required=""  placeholder="시작일" aria-required="true" >
                           </c:when>
                           <c:otherwise>
                            시작일 : <input id="openDate" name="openDate" class="form-control required date-picker" type="text" required=""  placeholder="시작일" aria-required="true">
                           </c:otherwise>
                        </c:choose>
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                        <c:choose>

                           <c:when test="${!empty funding}">
                            마감일 : <input id="endDate2" name="endDate" class="form-control required date-picker" type="text" required=""  placeholder="마감일" aria-required="true" >
                           </c:when>
                           <c:otherwise>
                            마감일 : <input id="endDate" name="endDate" class="form-control required date-picker" type="text" required=""  placeholder="마감일" aria-required="true">
                           </c:otherwise>
                        </c:choose>
                         
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="form-group mb-10">
                          주종 : 
                          <select id="category" name="category" class="form-control required" required="" >
                       <option value="">-주종선택-</option>
                         <option value="301">탁주</option>
                       <option value="302">청주</option>
                       <option value="303">증류주</option>
                       <option value="304">과실주</option>
                       <option value="305">와인</option>
                    </select>
                           
                        </div>
                      </div>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty funding}">
                            <div class="form-group">
                  <label>썸네일 업로드</label>
                   <input name="file" class="file"   type="file" multiple data-show-upload="false" data-show-caption="true">
                   <small>이미지 파일을 첨부해 주세요</small> 
                 </div>
                 <div class="form-group">
                  <label>상세보기 업로드</label>
                   <input name="file2" class="file"   type="file" multiple data-show-upload="false" data-show-caption="true">
                   <small>이미지 파일을 첨부해 주세요</small> 
                 </div>
                        </c:when>
                        <c:otherwise>
                        <div >
                         <label>썸네일 업로드</label>
                          </div>
                          <input id="file3" name="file" class="file"    type="file" multiple data-show-upload="false" data-show-caption="true" visbility="hidden" > 
                          <small>이미지 파일을 첨부해 주세요</small> 
                         <button type="button" id="selectFileBtn1">파일 선택</button>
                         <span id="Thumnail">${funding.image}</span>
                        
                         <div >
                  <label>상세보기 업로드</label>
                   </div>
                   <input id="file4" name="file2" class="file"   type="file" multiple data-show-upload="false" data-show-caption="true" visbility="hidden"> 
                          <small>이미지 파일을 첨부해 주세요</small> 
                   <button type="button" id="selectFileBtn2">파일 선택</button>
                   <span id="Detail">${funding.image}</span>
                         </c:otherwise>
                  </c:choose>
                  
                  
                
               <div class="form-group mb-0 mt-20">
                      <input name="form_botcheck" class="form-control" type="hidden" value="">
                      <c:choose>
                  <c:when test="${!empty funding}">
                       <button type="submit" class="btn btn-dark btn-theme-colored" data-loading-text="Please wait...">펀딩 수정</button>
                  </c:when>
                  <c:otherwise>
                      <button type="submit" class="btn btn-dark btn-theme-colored" data-loading-text="Please wait...">펀딩 등록</button>
                  </c:otherwise>
               </c:choose>
               
                     
                    </div>
                    <input type="hidden" value="${code}" name="code"/>
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