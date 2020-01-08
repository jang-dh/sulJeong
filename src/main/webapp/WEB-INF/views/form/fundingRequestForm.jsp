<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<script type="text/javascript">
	
	function checkValid() {
	    var f = window.document.writeForm;
			
		if ( f.modelNum.value == "") {
		    alert( "모델번호를 입력해 주세요." );
		    f.modelNum.focus();
			return false;
	    }
		if ( f.modelName.value == "" ) {
			alert( "모델이름을 입력해 주세요." );
			f.modelName.focus();
			return false;
		}
		if ( f.price.value == "" ) {
			alert( "가격을 입력해 주세요." );
			f.price.focus();
			return false;
		}
		if ( f.description.value == "" ) {
	        alert( "상품 설명을 입력해 주세요." );
	        f.description.focus();
	        return false;
	    }
		if ( f.password.value == "" ) {
	        alert( "비밀번호를 입력해 주세요" );
	        f.password.focus();
	        return false;
	    }
		
	    return true;
	}
	</script>


<body>
	
	<div class="row">
		<div class="col-md-6 col-md-push-3">
			<div data-example-id="basic-forms" class="bs-example mb-30">
			<h2>펀딩 오픈 신청하기</h2><p>
				<form name="writeForm" action="${pageContext.request.contextPath}/fundingInsert?${_csrf.parameterName}=${_csrf.token}" method="post" onSubmit='return checkValid()' enctype="multipart/form-data">
					<div class="form-group">
						<label for="exampleInputEmail2">펀딩 주제</label> 
						<input type="text" placeholder="Funding Subject" id="subject" name="subject" class="form-control">
						<!-- <textarea class="form-control"rows="3"></textarea> -->
					</div>

					<div class="form-group">
						<label for="exampleInputFile2">File input</label> 
						<input type="file" id="file" name="file">
					</div>
					
					<button class="btn btn-default" type="submit">Submit</button>
				</form>
			</div>
		</div>
	</div>
</body>


