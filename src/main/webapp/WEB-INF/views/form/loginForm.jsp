<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>Login Demo - Kakao JavaScript SDK</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script>
	$(function(){
		if('${errorMessage}' != ""){
			alert('${errorMessage}');
		}
			
		
		$("#login-form").submit(function(){
			if($("#form_username_email").val()==""){
				alert("아이디를 입력해주세요");
				$("#form_username_email").focus();
				return false;
			}
			if($("#form_password").val()==""){
				alert("비밀번호를 입력해주세요");
				$("#form_password").focus();
				return false;
			}
		});
		
		$("#login-form").submit(function() {
				if($('#id').val()==""){
					alert("아이디를 입력해주세요");
					$('#id').focus();
					return false;
				}
				
				if($('#pwd').val()==""){
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
            <h4 class="text-gray mt-0 pt-5"> Login</h4>
            <hr>
            <form id="login-form" name="login-form" class="clearfix" action="${pageContext.request.contextPath}/loginCheck" method="post">
            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="form_username_email">Username/Email</label>
                  <input id="form_username_email" name="id" class="form-control" type="text">
                </div>
              </div>
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="form_password">Password</label>
                  <input id="form_password" name="pwd" class="form-control" type="password">
                </div>
              </div>
              <div class="form-group pull-right mt-10">
                <input type="submit" class="btn btn-dark btn-sm" id="login" value="Login">
              </div>
              <div class="clear text-center pt-10">
                <a class="text-theme-colored font-weight-600 font-12" href="${pageContext.request.contextPath}/searchLoginInfoForm">Forgot Your Information?</a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  </div>