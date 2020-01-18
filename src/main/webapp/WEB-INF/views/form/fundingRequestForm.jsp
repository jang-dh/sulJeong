<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	function checkValid() {
		var f = window.document.writeForm;

		if (f.subject.value == "") {
			alert("펀딩 주제를 입력해주세요.");
			f.subject.focus();
			return false;
		}
		if (f.file.value == "") {
			alert("파일을 업로드 해주세요.");
			return false;
		}
		return true;
	}
</script>


<body>
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">펀딩오픈 신청하기</h2>
						 <ol class="breadcrumb text-left mt-10 white">
							<!--<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Causes Grid</li> -->
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section>
      <div class="container">
        <div class="row">
          <div class="col-md-8 col-md-offset-2">
            <div id="accordion1" class="panel-group accordion transparent">
              <div class="panel">
                <div class="panel-title"> <a data-parent="#accordion1" data-toggle="collapse" href="#accordion11" class="collapse" aria-expanded="true"> <span class="open-sub"></span> <strong>Q. 펀딩 등록시 제출해야할 서류 확인 하셨나요?</strong></a> </div>
                <div id="accordion11" class="panel-collapse collapse" role="tablist" aria-expanded="true">
                  <div class="panel-content">
                    <p align="center"><a href="http://localhost:8000/controller/noticeDetail/893"> 펀딩 등록 제출 서류 보러가기 </a></p> 
                  </div>
                </div>
              </div>
              <div class="panel">
                <div class="panel-title"> <a class="collapsed" data-parent="#accordion1" data-toggle="collapse" href="#accordion12" aria-expanded="false"> <span class="open-sub"></span> <strong>Q. 제출 서류 확인 사항 확인 하셨나요?</strong></a> </div>
                <div id="accordion12" class="panel-collapse collapse" role="tablist" aria-expanded="false" style="height: 0px;">
                  <div class="panel-content">
                    <p align="center"><a href="http://localhost:8000/controller/noticeDetail/898"> 제출 서류 확인 사항 보러가기 </a></p>
                  </div>
                </div>
              </div>
              <div class="panel">
                <div class="panel-title"> <a data-parent="#accordion1" data-toggle="collapse" href="#accordion13" class="collapsed" aria-expanded="false"> <span class="open-sub"></span> <strong>Q. 리워드펀딩 노하우 보고가세요!</strong></a> </div>
                <div id="accordion13" class="panel-collapse collapse" role="tablist" aria-expanded="false">
                  <div class="panel-content">
                    <p><div class="visual-youtube">
				        <iframe id="reward-youtube" width="343" height="193" src="https://www.youtube.com/embed/BL5kDSNuv1o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				      </div></p> 
                    
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
          
	<div class="row">
		<div class="col-md-6 col-md-push-3">
			<div data-example-id="basic-forms" class="bs-example mb-30">
				<form name="writeForm"
					action="${pageContext.request.contextPath}/fundingInsert?${_csrf.parameterName}=${_csrf.token}"
					method="post" onSubmit='return checkValid()' enctype="multipart/form-data">
					<div class="form-group mt-30">
						<label for="exampleInputEmail2">펀딩 주제</label>
						<input type="text" placeholder="제목" id="subject" name="subject" class="form-control">
					</div>
					<div class="form-group mt-10">
						<label for="exampleInputFile2">파일 첨부</label>
						<input type="file" id="file" name="file">
					</div>
					<br>
					<button class="btn btn-gray btn-transparent btn-theme-colored btn-lg pull-right mb-30" type="submit">신청</button>
				</form>
			</div>
		</div>
	</div>
</body>


