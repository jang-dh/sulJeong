<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<script type="text/javascript">
	
	function checkValid() {
	    var f = window.document.writeForm;
			
		if ( f.subject.value == "") {
		    alert( "펀딩 주제를 입력해주세요." );
		    f.subject.focus();
			return false;
	    }
		if ( f.file.value == "" ) {
			alert( "파일을 업로드 해주세요." );
			return false;
		}
		
	    return true;
	}
	
	
	</script>


<body>
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay overlay-dark-8"
		data-bg-img="http://placehold.it/1920x1280">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">펀딩오픈 신청하기</h2>
						<!-- <ol class="breadcrumb text-left mt-10 white">
							<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Causes Grid</li>
						</ol> -->
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<div class="row">
		<div class="col-md-6 col-md-push-3">
			<div data-example-id="basic-forms" class="bs-example mb-30">
				<form name="writeForm" action="${pageContext.request.contextPath}/fundingInsert?${_csrf.parameterName}=${_csrf.token}" method="post" onSubmit='return checkValid()' enctype="multipart/form-data">
					<div class="form-group">
					<br><br>
						<label for="exampleInputEmail2">펀딩 주제</label> 
						<input type="text" placeholder="Funding Subject" id="subject" name="subject" class="form-control">
						<!-- <textarea class="form-control"rows="3"></textarea> -->
					</div>

					<div class="form-group">
						<label for="exampleInputFile2">File input</label> 
						<input type="file" id="file" name="file">
					</div>
					
					<button class="btn btn-default" type="submit">Submit</button><br><br>
				</form>
			</div>
		</div>
	</div>
</body>


