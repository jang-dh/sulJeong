<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
$(function(){
	$("#insertBtn").click(function(){
		if($("#contentBox").val()==""){
			alert("내용을 입력해주세요");
			$("#contentBox").focus();
			return false;
		}
		
		var contentVal = $("#contentBox").val();
		
		//var allDate = {"name":nameVal, "phone":phoneVal};
		var allDate = "${_csrf.parameterName}=${_csrf.token}"+"&content="+contentVal;
		  $.ajax({
				 url: "contentInsert", //서버요청주소
				 type:"post", //요청방식(get|post|put:patch:delete)
				 dataType:"json", //서버가 보내온 데이터 타입(text,html,xml,json)
				 data: allDate ,//서버에게 보내는 parameter 정보
				 success:function(result){
				    $("#comments").html(result.content+" | "+result.regdate)
					
				 } ,//성공했을대
				 error:function(err){
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
      
      <hr>
      
      <h3> 댓글 ajax</h3>
      <input type="text" name="content" id="contentBox" value=""> <p>
      <button type="button" name="insert" id="insertBtn" >등록</button>
       
      <div id="comments">
      
      </div>
    </section>


    
    
  </div>
  <!-- end main-content -->
