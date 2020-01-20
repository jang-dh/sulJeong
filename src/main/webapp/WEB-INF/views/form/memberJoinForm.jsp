<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">
	var popAuthEmail = null;
	var emailAuthResult=null;
	
	function goPopup() {
		//경로는 시스템에 맞게 수정하여 사용
		//호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 
		//호출하게 됩니다. 
		var pop = window.open("${pageContext.request.contextPath}/juso/jusoPopup", "pop","width=570,height=420, scrollbars=yes, resizable=yes");
		//** 2017년 5월 모바일용 팝업 API 기능 추가제공 **/ 
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 
		// 실제 주소검색 URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다. 
		// var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	
	function goAuthPopup() {
		var popAuth = window.open("${pageContext.request.contextPath}/identity/identityAuth", "pop","width=570,height=420, scrollbars=yes, resizable=yes");
	}
	
	function emailAuthPopup() {
		popAuthEmail = window.open("${pageContext.request.contextPath}/identity/emailAuth", "pop","width=570,height=420, scrollbars=yes, resizable=yes");
		//popAuthEmail.document.getElementById("childEmailAuth").value = document.getElementById('childEmailAuth').value;
	}

	function jusoCallBack(roadFullAddr, addrDetail, jibunAddr) {
		//alert(1)
		// 2017년 2월 제공항목이 추가되었습니다. 원하시는 항목을 추가하여 사용하시면 됩니다. 
			//document.form.addr.value = roadFullAddr +" "+ addrDetail;
		document.form.addr.value = roadFullAddr;
	}
	
	
	$(function() {
		var pattern_num = /[0-9]/;	// 숫자 

    	var pattern_eng = /[a-zA-Z]/;	// 문자 

    	var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자

    	var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크
    	
    	var pattern_check = /-/;

		var status = '0'; //아이디 중복체크 상태변수
		var authStatus = '3';//성인인증 상태변수
		var flage = false; // 비밀번호 일치 여부
		var emailStatus = 'false'; //이메일 수신 동의 여부
		
		$("#idDuplicateCheck").click(function(){
			
			if($('#id').val()==""){
				alert("아이디를 입력해주세요");
				$('#id').focus();
				return false;
			}
			
			if(pattern_kor.test($('#id').val()) || pattern_spc.test($('#id').val())){
				alert("한글이나 특수문자는 사용할 수 없습니다.");
				$('#id').val("");
				$('#id').focus();
				return false;
			}
			
			if($("#id").val().length < 6){
				alert("6글자 이상 입력해주세요");
				$('#id').focus();
				return false;
			}
			
			var idVal = $("#id").val()
			
			var allDate = "${_csrf.parameterName}=${_csrf.token}"+"&id="+idVal;
			  $.ajax({
					 url: "${pageContext.request.contextPath}/idDuplicateCheck", //서버요청주소
					 type:"post", //요청방식(get|post|put:patch:delete)
					 dataType:"json", //서버가 보내온 데이터 타입(text,html,xml,json)
					 data: allDate ,//서버에게 보내는 parameter 정보
					 success:function(result){
						 alert("중복된 ID 입니다.");
						 $("#id").val("");
						 $("#id").focus();
						 status = '0';
					 } ,//성공했을대
					 error:function(err){
						 $("#idDuplicateCheck").val("중복체크완료");
						 $("#id").attr('readonly','readonly');
						 status = '1';
					 }//오류발생했을때
				 });
			  
		});
		
		$('#pwdCheck').keyup(function(){
			  if($('#pwdCheck').val()!=$('#pwd').val()){
			    $('#pwdEqualCheck').text('');
			    $('#pwdEqualCheck').html("암호가 일치하지 않습니다. 다시 확인해주세요.").css("color","red"); 
			    flage = false;
			  }else{
			    $('#pwdEqualCheck').text('');
			    $('#pwdEqualCheck').html("암호가 일치합니다.").css("color","blue");
			    flage = true;
			  }
		});
		
		$("#register").click(function() {
			if($('#name').val()==""){
				alert("성함을 입력해주세요");
				$('#name').focus();
				return false;
			}
			
			if(pattern_spc.test($('#name').val()) || pattern_num.test($('#name').val())){
				alert("이름에는 특수문자나 숫자를 입력할 수 없습니다.");
				$('#name').focus();
				return false;
			}
			
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
			
			if($('#pwd').val().length<8){
				 alert('비밀번호는 특수문자 포함 8글자 이상 작성해주세요');
				 $('#pwd').focus();
				return false;
			 }
			
			if(!pattern_spc.test($('#pwd').val())){
				alert('비밀번호는 특수문자 포함 8글자 이상 작성해주세요');
				 $('#pwd').focus();
				return false;
			}
			
			
			if($('#email').val()==""){
				alert("이메일을 입력해주세요");
				$('#email').focus();
				return false;
			}
			
			if($('#emailCheckStatus').val()=='false'){
				emailStatus = 'false';
				alert("이메일 인증 후 회원가입 가능");
				return false;
			}
			
			if($('#phone').val()==""){
				alert("전화번호를 입력해주세요");
				$('#phone').focus();
				return false;
			}
			
			if(pattern_check.test($('#phone').val()) || pattern_spc.test($('#phone').val()) || pattern_eng($('#phone').val())){
				alert("숫자만 입력가능합니다.");
				$('#phone').focus();
				return false;
			}
			
			if($('#addr').val()==""){
				alert("주소를 입력해주세요");
				$('#addr').focus();
				return false;
			}
			
			
			
			if($('#hidden').val()=='true'){
			    authStatus = '4';
			}
			
			if($('#emailCheckStatus').val()=='true'){
			    emailStatus = 'true';
			}
			
			
			 if(status == '0'){
				  alert("아이디 중복체크를 해주세요");
				  return false;
			  }else if(flage == false){
				  alert("비밀번호 일치 여부 확인해주세요.");
				  return false;
			  }else if(emailStatus == 'false'){
				  alert("이메일 인증 후 회원가입 가능");
				  return false;
			  }else if(authStatus == '3'){
				  alert("성인인증을 해주시기 바랍니다.");
				  return false;
			  }
			  
			 
		});
		
		$("#emailCheck").click(function() {
			
			if($("#email").val()==""){
				alert("이메일을 입력해주세요.")
				return false;
			}
			
			var emailVal = $("#email").val()
			var allDate = "${_csrf.parameterName}=${_csrf.token}"+"&email="+emailVal;
			
			  $.ajax({
					 url: "${pageContext.request.contextPath}/member/auth", //서버요청주소
					 type:"post", //요청방식(get|post|put:patch:delete)
					 dataType:"text", //서버가 보내온 데이터 타입(text,html,xml,json)
					 data: allDate ,//서버에게 보내는 parameter 정보
					 success:function(result){
						 //alert(result);
						 $("#hidden2").val(result);
						 emailAuthPopup();
					 } ,//성공했을대
					 error:function(err){
						alert("실패")
						emailStatus = 'false';
					 }//오류발생했을때
				 });
		})
	});

	function CheckForm(join) {
		if ($('input:checkbox[id=emailAccept]').is(':checked') == false) {
			$('[id=emailAccept]').attr('value', '0');
		}

		if ($('input:checkbox[id=emailAccept]').is(':checked') == true) {
			$('[id=emailAccept]').attr('value', '1');
		}
	};
</script>
<section>
	<div class="row">
		<div class="col-md-6 col-md-push-3">
			<br>
			<br>
			<c:choose>
			<c:when test="${result==false}">
				<h3>성인인증 실패로 회원가입을 할 수 없습니다.</h3>
				<div class="form-group">
					<button class="btn btn-dark btn-lg btn-block mt-15" type="submit" id="register" name="register" onclick="location.href='${pageContext.request.contextPath}/'">메인 페이지로 가기</button>
				</div>
			</c:when>
			
			<c:otherwise>
			<form name="form" id="reg-form" class="register-form" method="post"
				action="${pageContext.request.contextPath}/memberJoin"
				onsubmit="return CheckForm(this)">
				<!-- 스프링 security 4에선 POST 전송시무조건 csrt 를 보내야 한다. (GET은 안보내도 됨)-->
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}">
				<div class="icon-box mb-0 p-0">
					<a href="#"
						class="icon icon-bordered icon-rounded icon-sm pull-left mb-0 mr-10">
						<i class="pe-7s-users"></i>
					</a>
					<h4 class="text-gray pt-10 mt-0 mb-30">회원가입</h4>
				</div>
				<hr>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label>성함</label> <input name="name" id="name"
							class="form-control" type="text">
					</div>
				</div>
					
				<div class="row">
					<div class="form-group col-md-6">
						<label for="form_choose_username">아이디</label> <input
							id="id" name="id" class="form-control" type="text" placeholder="6글자 이상 작성해주세요" >
					</div>
					<div class="form-group col-md-6">
						<label> &nbsp;</label> <input type="button" value="중복체크"
							name="idDuplicateCheck" id="idDuplicateCheck" class="form-control" required="required">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label for="form_choose_password">비밀번호</label> <input
							id="pwd" name="pwd" class="form-control" type="password" placeholder="특수문자 포함 8글자 이상 작성해주세요">
					</div>
					<div class="form-group col-md-6">
						<label>비밀번호 재확인</label> <input id="pwdCheck"
							name="pwdCheck" class="form-control" type="password" placeholder="특수문자 포함 8글자 이상 작성해주세요">
					</div>
					<div class="form-group col-md-12" id="pwdEqualCheck">비밀번호 확인 </div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label>이메일 주소</label> 
						<input name="email" id="email" class="form-control" type="email">
					</div>
					<div class="form-group col-md-6">
						<label> &nbsp;</label> 
						<input name="emailCheck" id="emailCheck" class="form-control" type="button" value="이메일 인증">
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label>핸드폰 번호</label> <input name="phone" id="phone"
							class="form-control" type="text" placeholder="ex) 01012341234">
					</div>
					<div class="form-group col-md-6">
						<label> &nbsp;</label> 
						<input type="button" value="성인인증" name="Authenticate" id="Authenticate" onClick="goAuthPopup();" class="form-control" required="required">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label for="form_choose_password">주소</label> 
						<input id="addr"
							name="addr" class="form-control" type="text">
					</div>
					<div class="form-group col-md-6">
						<label> &nbsp;</label> 
						<input id="addrBtn" name="addrBtn" class="form-control" type="button" onClick="goPopup();" value="나의 주소지 찾기">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">
						<label for="form_choose_username">이메일 수신동의(선택)</label> <input
							id="emailAccept" name="emailAccept" type="checkbox" value="">
					</div>
				</div>
				<div class="form-group">
					<button class="btn btn-dark btn-lg btn-block mt-15" type="submit"
						id="register" name="register">등록하기</button>
				</div>
			</form>
			
			<input type="hidden" id="hidden" name="hidden">
					<input type="hidden" id="hidden2" name="hidden2">
					<input type="text" id="emailCheckStatus" name="emailCheckStatus">
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</section>