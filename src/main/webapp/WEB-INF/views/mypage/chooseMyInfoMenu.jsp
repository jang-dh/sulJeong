<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
$(function(){
	
	if("${member.emailAccept}"=="1"){
		$("#emailAccept").attr("checked", true);
	}
	
	$("#reg-form").submit(function() {
		if($('#pwd').val()==""){
			alert("비밀번호를 입력해주세요");
			$('#pwd').focus();
			return false;
		}
		
		if($('#name').val()==""){
			alert("성함을 입력해주세요");
			$('#name').focus();
			return false;
		}
		
		if($('#phone').val()==""){
			alert("전화번호를 입력해주세요");
			$('#phone').focus();
			return false;
		}
		if($('#email').val()==""){
			alert("이메일을 입력해주세요");
			$('#email').focus();
			return false;
		}
		
		if($('#addr').val()==""){
			alert("주소를 입력해주세요");
			$('#addr').focus();
			return false;
		}
		
		if($('input:checkbox[id=emailAccept]').is(':checked') == true){
			$("#emailAccept").val("1");
		}else{
			$("#emailAccept").val("0");
		}
	});
	
	$("#membership_withdrawal").click(function() {
		var con = confirm("정말로 탈퇴하시겠습니까?");
		
		if(con){
			if($('#id2').val()==""){
				alert("아이디를 입력해주세요");
				$('#id2').focus();
				return false;
			}
			
			if($('#pwd2').val()==""){
				alert("비밀번호를 입력해주세요");
				$('#pwd2').focus();
				return false;
			}
				
				var idVal = $("#id2").val()
				var pwdVal = $("#pwd2").val();
				
				var allDate = "${_csrf.parameterName}=${_csrf.token}"+"&id="+idVal +"&pwd="+pwdVal;
				  $.ajax({
						 url: "${pageContext.request.contextPath}/membershipWithdrawal", //서버요청주소
						 type:"post", //요청방식(get|post|put:patch:delete)
						 dataType:"json", //서버가 보내온 데이터 타입(text,html,xml,json)
						 data: allDate ,//서버에게 보내는 parameter 정보
						 success:function(result){
							alert("회원탈퇴 하셨습니다. 메인페이지로 이동합니다.");
						    location.href='${pageContext.request.contextPath}';
						 } ,//성공했을대
						 error:function(err){
							 alert("비밀번호를 확인해 주세요.");
						 }//오류발생했을때
					 }); 
			  
			
		}else{
			return false;
		}
	});
	
	
});	
</script>

<ul id="myTab" class="nav nav-tabs boot-tabs">
	<li class="active"><a href="#home" data-toggle="tab">내 정보 수정</a></li>
	<li><a href="#profile" data-toggle="tab">회원 탈퇴</a></li>
</ul>
<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade in active" id="home">
		<div id="content">
			<div class="row">
				<div class="col-md-6 col-md-push-3">
					<br>
					<br>
					<form name="reg-form" class="register-form" method="post" id="reg-form"
						action="${pageContext.request.contextPath}/mypage/changeMyInfo">
						<!-- 스프링 security 4에선 POST 전송시무조건 csrt 를 보내야 한다. (GET은 안보내도 됨)-->
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
						<div class="icon-box mb-0 p-0">
							<a href="#"
								class="icon icon-bordered icon-rounded icon-sm pull-left mb-0 mr-10">
								<i class="pe-7s-users"></i>
							</a>
							<h4 class="text-gray pt-10 mt-0 mb-30">내 정보 수정</h4>
						</div>
						<hr>
						<div class="row">
							<div class="form-group col-md-12">
								<label>UserID</label> <input name="id" id="id"
									class="form-control" type="text" value="${member.id}" readonly>
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-6">
								<label for="form_choose_password">Choose Password</label> <input
									id="pwd" name="pwd" class="form-control" type="password">
							</div>
							<div class="form-group col-md-6">
								<label>Re-enter Password</label> <input id="pwdCheck"
									name="pwdCheck" class="form-control" type="password">
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-12">
								<label for="form_choose_username">Name</label> <input id="name"
									name="name" class="form-control" type="text"
									value="${member.name}">
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-12">
								<label>휴대폰</label> <input name="phone" id="phone"
									class="form-control" type="text" value="${member.phone}">
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-12">
								<label>Email Address</label> <input name="email" id="email"
									class="form-control" type="email" value="${member.email}">
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-6">
								<label for="form_choose_password">주소</label> <input id="addr"
									name="addr" class="form-control" type="text"
									value="${member.addr}">
							</div>
							<div class="form-group col-md-6">
								<label>주소 찾기</label> <input id="addr" name="addr"
									class="form-control" type="button" value="나의 주소지 찾기">
							</div>
						</div>


						<div class="row">
							<div class="form-group col-md-12">
								<label for="form_choose_username">이메일 수신동의(선택)</label>
								 <input id="emailAccept" name="emailAccept" type="checkbox" value="">
							</div>
						</div>
						<div class="form-group">
							<button class="btn btn-border btn-theme-colored btn-lg btn-block mt-15" type="submit" id="register">Register Now</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="tab-pane fade" id="profile">
		<div id="content">
			<div class="row">
				<div class="col-md-6 col-md-push-3">
					<br>
					<br>
						<!-- 스프링 security 4에선 POST 전송시무조건 csrt 를 보내야 한다. (GET은 안보내도 됨)-->
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
						<div class="icon-box mb-0 p-0">
							<a href="#"
								class="icon icon-bordered icon-rounded icon-sm pull-left mb-0 mr-10">
								<i class="pe-7s-users"></i>
							</a>
							<h4 class="text-gray pt-10 mt-0 mb-30">본인 확인</h4>
						</div>
						<hr>
						<div class="row">
							<div class="form-group col-md-12">
								<label>UserID</label> 
								<input name="id" id="id2" class="form-control" type="text" value="${member.id}" readonly>
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-12">
								<label for="form_choose_password">Check Password</label> 
								<input id="pwd2" name="pwd" class="form-control" type="password">
							</div>
						</div>

						<div class="form-group">
							<button class="btn btn-border btn-theme-colored btn-lg btn-block mt-15" type="button" id="membership_withdrawal">membership withdrawal</button>
						</div>
				</div>
			</div>
		</div>
	</div>
</div>
