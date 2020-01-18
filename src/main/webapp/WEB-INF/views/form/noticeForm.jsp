<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Start main-content -->
<div class="main-content">

	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay"
		data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">공지사항 등록</h2>
						<ol class="breadcrumb text-left mt-10 white">
							<%-- <li><a href="${pageContext.request.contextPath}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/notice">Notice</a></li>
                <li class="active">Update</li> --%>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Section: Job Apply Form -->
	<section class="divider">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-push-2">
					<div class="border-1px p-30 mb-0">
						<!-- <h3 class="text-theme-colored mt-0 pt-5">공지사항 등록</h3>
              <hr> -->
						<p>다음 사항을 작성해주세요</p>
						<form id="job_apply_form" name="job_apply_form"
							action="${pageContext.request.contextPath}/insert?${_csrf.parameterName}=${_csrf.token}"
							method="post" enctype="multipart/form-data">
							<div class="form-group">
								<label>제목 <small>*</small></label> <input name="subject"
									type="text" placeholder="제목을 입력하세요" required=""
									class="form-control">
							</div>

							<div class="form-group">
								<label>내용 <small>*</small></label>
								<textarea name="content" class="form-control required" rows="5"
									placeholder="내용을 입력해 주세요"></textarea>
							</div>
							<div class="form-group">
								<label>파일 업로드</label> <input name="file" class="file"
									type="file" multiple data-show-upload="false"
									data-show-caption="true"> <small>Maximum upload
									file size: 12 MB</small>
							</div>
							<div class="form-group">
								<input name="form_botcheck" class="form-control" type="hidden"
									value="" />
								<button type="submit"
									class="btn btn-block btn-dark btn-theme-colored btn-sm mt-20 pt-10 pb-10"
									data-loading-text="Please wait...">등록하기</button>
							</div>
						</form>
						<!-- Job Form Validation-->

					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<!-- end main-content -->