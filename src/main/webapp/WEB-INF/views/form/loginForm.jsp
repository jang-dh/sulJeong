<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$(function(){
		
		
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    var key = getCookie("key");
	    $("#form_username_email").val(key); 
	     
	    if($("#form_username_email").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#form_checkbox").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	     
	    $("#form_checkbox").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#form_checkbox").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#form_username_email").val(), 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#form_username_email").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#form_checkbox").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#form_username_email").val(), 7); // 7일 동안 쿠키 보관
	        }
	    });
	    
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
	
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	
	
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	
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
              <div class="checkbox pull-left mt-15">
                <label for="form_checkbox">
                  <input id="form_checkbox" name="form_checkbox" type="checkbox">
                  Remember me </label>
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