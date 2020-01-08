<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
	//contextPath 얻기
	function getContextPath() {
		var hostIndex = location.href.indexOf(location.host) + location.host.length;
		return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1) );
	}

$(function(){
	$("#insertBtn").click(function(){
		if($("#contentBox").val()==""){
			alert("내용을 입력해주세요");
			$("#contentBox").focus();
			return false;
		}
		
		var contentVal = $("#contentBox").val();
		console.log(contentVal);
		
		//var allDate = {"name":nameVal, "phone":phoneVal};
		var allDate = "${_csrf.parameterName}=${_csrf.token}"+"&contentBox="+contentVal+"&code="+${detail.code};
		  $.ajax({
				 url: getContextPath() + "/contentInsert", //서버요청주소
				 type:"post", //요청방식(get|post|put:patch:delete)
				 dataType:"json", //서버가 보내온 데이터 타입(text,html,xml,json)
				 data: allDate ,//서버에게 보내는 parameter 정보
				 success:function(result){
				    $("#comments").html(result.questionCode + "| " + result.content+" | "+result.regdate)
				    $("#insertComment").hide();
					
				 } ,//성공했을대
				 error:function(err){
					 alert("답변은 한개만 등록가능합니다.");
				 }//오류발생했을때
		}); 
	});
});


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
                <li><a href="${pageContext.request.contextPath}/">fundingQuestionDetail</a></li>
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
            <h3 class="text-theme-colored mt-0 mb-20">제목 : ${detail.subject}</h3>
            <hr>
            <p>${detail.content}</p>
            <p>작성일 : ${detail.regdate}</p>

          </div>
        </div>
      </div>
      <c:if test="${empty answer}">
      <div class="container" id="insertComment">
        <div class="row">
          <div class="col-md-6 col-md-push-3">
            <div class="border-1px p-30 mb-0">
              <h5 class="text-theme-colored mt-0 pt-5">답변하기</h5>
                  <label>Message <small>*</small></label>
                  <textarea name="form_message" class="form-control required" rows="6" placeholder="답변 내용 작성" name="contentBox" id="contentBox"></textarea>
                  <input name="form_botcheck" class="form-control" type="hidden" value="" />
                  <button type="button" class="btn btn-block btn-dark btn-theme-colored btn-sm mt-20 pt-10 pb-10" data-loading-text="Please wait..." name="insertBtn" id="insertBtn" >답변 등록</button>
            </div>
          </div>
        </div>
      </div>
      </c:if>
    </section>
    
    
    <div id="comments">
      		${answer.questionCode} ${answer.content} ${answer.regdate}
    </div>


    
    
  </div>
  <!-- end main-content -->
