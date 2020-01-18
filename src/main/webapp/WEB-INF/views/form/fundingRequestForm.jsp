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


