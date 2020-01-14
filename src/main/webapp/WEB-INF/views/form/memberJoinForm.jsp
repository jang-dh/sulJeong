<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

	 <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
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
		var pop = window.open("${pageContext.request.contextPath}/identity/identityAuth", "pop","width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function jusoCallBack(roadFullAddr, addrDetail, jibunAddr) {
		//alert(1)
		// 2017년 2월 제공항목이 추가되었습니다. 원하시는 항목을 추가하여 사용하시면 됩니다. 
			//document.form.addr.value = roadFullAddr +" "+ addrDetail;
		document.form.addr.value = roadFullAddr;
	}
	
	
	$(function() {
		
		var status = '0';
		
		
		/* $("#Authenticate").click(function(){

			window.open("${pageContext.request.contextPath}/identityVerificationForm", "본인 인증", "width=500,height=600");
		}); */
		
		$("#idDuplicateCheck").click(function(){
			
			if($('#id').val()==""){
				alert("아이디를 입력해주세요");
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
						 status = '1';
					 }//오류발생했을때
				 });
			  
			  if(status == '0'){
				  alert("아이디 중복체크를 해주세요");
				  
			  }else if(status == '1'){
				  alert("회원가입에 성공하였습니다.")
			  }
		});
		
		$("#register").click(function() {
			
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
			
			if($('#name').val()==""){
				alert("성함을 입력해주세요");
				$('#name').focus();
				return false;
			}
			if($('#email').val()==""){
				alert("이메일을 입력해주세요");
				$('#email').focus();
				return false;
			}
			
			if($('#phone').val()==""){
				alert("전화번호를 입력해주세요");
				$('#phone').focus();
				return false;
			}
			
			if($('#addr').val()==""){
				alert("주소를 입력해주세요");
				$('#addr').focus();
				return false;
			}
			
		});
		
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
<body>
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
					<h4 class="text-gray pt-10 mt-0 mb-30">Don't have an Account?
						Register Now.</h4>
				</div>
				<hr>
					
				<div class="row">
					<div class="form-group col-md-6">
						<label for="form_choose_username">Choose UserID</label> <input
							id="id" name="id" class="form-control" type="text" >
					</div>
					<div class="form-group col-md-6">
						<label>아이디 중복 체크</label> <input type="button" value="중복체크"
							name="idDuplicateCheck" id="idDuplicateCheck" class="form-control" required="required">
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
					<div class="form-group col-md-6">
						<label>Name</label> <input name="name" id="name"
							class="form-control" type="text">
					</div>
					<div class="form-group col-md-6">
						<label>Email Address</label> <input name="email" id="email"
							class="form-control" type="email">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-6">
						<label>휴대폰</label> <input name="phone" id="phone"
							class="form-control" type="text">
					</div>
					<div class="form-group col-md-6">
						<label>생년월일 성인인증</label> 
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
						<label>주소 찾기</label> 
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
						id="register" name="register">Register Now</button>
				</div>
			</form>
			</c:otherwise>
			</c:choose>
			
		</div>
	</div>
</body>