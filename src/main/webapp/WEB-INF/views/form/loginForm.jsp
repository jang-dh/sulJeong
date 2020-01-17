<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	$(function() {
		if ('${errorMessage}' != "") {
			alert('${errorMessage}');
		}

		$("#login-form").submit(function() {
			if ($("#form_username_email").val() == "") {
				alert("아이디를 입력해주세요");
				$("#form_username_email").focus();
				return false;
			}
			if ($("#form_password").val() == "") {
				alert("비밀번호를 입력해주세요");
				$("#form_password").focus();
				return false;
			}
		});

		$("#login-form").submit(function() {
			if ($('#id').val() == "") {
				alert("아이디를 입력해주세요");
				$('#id').focus();
				return false;
			}

			if ($('#pwd').val() == "") {
				alert("비밀번호를 입력해주세요");
				$('#pwd').focus();
				return false;
			}
		});
	});
</script>
<div class="main-content">
	<section>
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-push-3">
					<h4 class="text-gray mt-0 pt-5">로그인</h4>
					<hr>
					<form id="login-form" name="login-form" class="clearfix" action="${pageContext.request.contextPath}/loginCheck" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<div class="row">
							<div class="form-group col-md-12">
								<label for="form_username_email">아이디</label> 
								<input id="form_username_email" name="id" class="form-control" type="text">
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<label for="form_password">비밀번호</label> 
								<input id="form_password" name="pwd" class="form-control" type="password">
							</div>
						</div>
						<div class="form-group pull-right mt-10">
							<input type="submit" class="btn btn-dark btn-sm" id="login" value="로그인">
						</div>
						<div class="clear pt-15">
							<a class="text-theme-colored font-weight-600 font-12" href="${pageContext.request.contextPath}/searchLoginInfoForm">
								아이디/비밀번호를 잊으셨나요?
							</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>