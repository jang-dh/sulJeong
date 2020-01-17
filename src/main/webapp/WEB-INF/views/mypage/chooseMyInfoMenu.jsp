<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	function goPopup() {
		//경로는 시스템에 맞게 수정하여 사용
		//호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 
		//호출하게 됩니다. 
		var pop = window.open(
				"${pageContext.request.contextPath}/juso/jusoPopup", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
		//** 2017년 5월 모바일용 팝업 API 기능 추가제공 **/ 
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 
		// 실제 주소검색 URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다. 
		// var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}

	function jusoCallBack(roadFullAddr, addrDetail, jibunAddr) {
		//alert(1)
		// 2017년 2월 제공항목이 추가되었습니다. 원하시는 항목을 추가하여 사용하시면 됩니다. 
		//document.form.addr.value = roadFullAddr +" "+ addrDetail;
		document.form.addr.value = roadFullAddr;
	}

	function emailAuthPopup() {
		popAuthEmail = window.open(
				"${pageContext.request.contextPath}/identity/emailAuth", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
		//popAuthEmail.document.getElementById("childEmailAuth").value = document.getElementById('childEmailAuth').value;
	}

	$(function() {

		var flage = false; // 비밀번호 일치 여부
		var emailStatus = 'false'; //이메일 수신 동의 여부

		if ("${member.emailAccept}" == "1") {
			$("#emailAccept").attr("checked", true);
		}

		$('#pwdCheck').keyup(
				function() {
					if ($('#pwdCheck').val() != $('#pwd').val()) {
						$('#pwdEqualCheck').text('');
						$('#pwdEqualCheck').html("암호가 일치하지 않습니다. 다시 확인해주세요.")
								.css("color", "red");
						flage = false;
					} else {
						$('#pwdEqualCheck').text('');
						$('#pwdEqualCheck').html("암호가 일치합니다.").css("color",
								"blue");
						flage = true;
					}
				});

		$("#reg-form")
				.submit(
						function() {

							var pattern_num = /[0-9]/; // 숫자 
							var pattern_eng = /[a-zA-Z]/; // 문자 
							var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
							var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크

							var pattern_check = /-/;

							if ($('#pwd').val() == "") {
								alert("비밀번호를 입력해주세요");
								$('#pwd').focus();
								return false;
							}

							if ($('#pwd').val().length < 8) {
								alert('비밀번호는 특수문자 포함 8글자 이상 작성해주세요');
								$('#pwd').focus();
								return false;
							}

							if (!pattern_spc.test($('#pwd').val())) {
								alert('비밀번호는 특수문자 포함 8글자 이상 작성해주세요');
								$('#pwd').focus();
								return false;
							}

							if ($('#name').val() == "") {
								alert("성함을 입력해주세요");
								$('#name').focus();
								return false;
							}

							if (pattern_spc.test($('#name').val())
									|| pattern_num.test($('#name').val())) {
								alert("이름에는 특수문자나 숫자를 입력할 수 없습니다.");
								$('#name').focus();
								return false;
							}

							if ($('#phone').val() == "") {
								alert("전화번호를 입력해주세요");
								$('#phone').focus();
								return false;
							}

							if (pattern_check.test($('#phone').val())
									|| pattern_spc.test($('#phone').val())
									|| pattern_eng.test($('#phone').val())
									|| pattern_kor.test($('#phone').val())) {
								alert("전화번호는 숫자만 입력가능합니다.");
								$('#phone').focus();
								return false;
							}

							if ($('#email').val() == "") {
								alert("이메일을 입력해주세요");
								$('#email').focus();
								return false;
							}

							if ($('#addr').val() == "") {
								alert("주소를 입력해주세요");
								$('#addr').focus();
								return false;
							}

							if (flage == false) {
								alert("비밀번호 일치 여부 확인해주세요");
								return false;
							}

							if ($('#emailCheckStatus').val() == 'true') {
								emailStatus = 'true';
							}

							if ($('input:checkbox[id=emailAccept]').is(
									':checked') == true) {
								$("#emailAccept").val("1");
							} else {
								$("#emailAccept").val("0");
							}

							if ($('#email').val() == '${member.email}') {
								emailStatus = 'true';
							}

							if (flage == false) {
								alert("비밀번호 일치 여부 확인해주세요.");
								return false;
							} else if (emailStatus == 'false') {
								alert("이메일 인증 후 회원수정이 가능합니다.");
								return false;
							}

						});

		$("#membership_withdrawal")
				.click(
						function() {
							var con = confirm("정말로 탈퇴하시겠습니까?");

							if (con) {
								if ($('#id2').val() == "") {
									alert("아이디를 입력해주세요");
									$('#id2').focus();
									return false;
								}

								if ($('#pwd2').val() == "") {
									alert("비밀번호를 입력해주세요");
									$('#pwd2').focus();
									return false;
								}

								var idVal = $("#id2").val()
								var pwdVal = $("#pwd2").val();

								var allDate = "${_csrf.parameterName}=${_csrf.token}"
										+ "&id=" + idVal + "&pwd=" + pwdVal;
								$
										.ajax({
											url : "${pageContext.request.contextPath}/membershipWithdrawal", //서버요청주소
											type : "post", //요청방식(get|post|put:patch:delete)
											dataType : "json", //서버가 보내온 데이터 타입(text,html,xml,json)
											data : allDate,//서버에게 보내는 parameter 정보
											success : function(result) {
												alert("회원탈퇴 하셨습니다. 메인페이지로 이동합니다.");
												location.href = '${pageContext.request.contextPath}';
											},//성공했을대
											error : function(err) {
												alert("비밀번호를 확인해 주세요.");
											}//오류발생했을때
										});

							} else {
								return false;
							}
						});

		$("#emailCheck").click(
				function() {

					var emailVal = $("#email").val()
					var allDate = "${_csrf.parameterName}=${_csrf.token}"
							+ "&email=" + emailVal;

					$.ajax({
						url : "${pageContext.request.contextPath}/member/auth", //서버요청주소
						type : "post", //요청방식(get|post|put:patch:delete)
						dataType : "text", //서버가 보내온 데이터 타입(text,html,xml,json)
						data : allDate,//서버에게 보내는 parameter 정보
						success : function(result) {
							//alert(result);
							$("#hidden2").val(result);
							emailAuthPopup();
						},//성공했을대
						error : function(err) {
							alert("실패")
							emailStatus = 'false';
						}//오류발생했을때
					});
				})

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
					<br> <br>
					<form name="form" class="register-form" method="post" id="reg-form"
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
								<label>아이디</label> <input name="id" id="id" class="form-control"
									type="text" value="${member.id}" readonly>
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-6">
								<label for="form_choose_password">비밀번호</label> <input id="pwd"
									name="pwd" class="form-control" type="password"
									placeholder="특수문자 포함 8글자 이상 작성해주세요">
							</div>
							<div class="form-group col-md-6">
								<label>비밀번호 재확인</label> <input id="pwdCheck" name="pwdCheck"
									class="form-control" type="password"
									placeholder="특수문자 포함 8글자 이상 작성해주세요">
							</div>
							<div class="form-group col-md-6" id="pwdEqualCheck">비밀번호 확인</div>
						</div>

						<div class="row">
							<div class="form-group col-md-12">
								<label for="form_choose_username">성함</label> <input id="name"
									name="name" class="form-control" type="text"
									value="${member.name}">
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-12">
								<label>휴대폰</label> <input name="phone" id="phone"
									class="form-control" type="text" value="${member.phone}"
									placeholder="ex) 01012341234">
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-6">
								<label>이메일 주소</label> <input name="email" id="email"
									class="form-control" type="email" value="${member.email}">
							</div>
							<div class="form-group col-md-6">
								<label>인증하기</label> <input name="emailCheck" id="emailCheck"
									class="form-control" type="button" value="Email Address 인증">
							</div>
						</div>

						<div class="row">
							<div class="form-group col-md-6">
								<label for="form_choose_password">주소</label> <input id="addr"
									name="addr" class="form-control" type="text"
									value="${member.addr}">
							</div>
							<div class="form-group col-md-6">
								<label>주소 찾기</label> <input id="addrBtn" name="addrBtn"
									class="form-control" type="button" onClick="goPopup();"
									value="나의 주소지 찾기">
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<label for="form_choose_username">이메일 수신동의(선택)</label> <input
									id="emailAccept" name="emailAccept" type="checkbox" value="">
							</div>
						</div>
						<div class="form-group">
							<button
								class="btn btn-border btn-theme-colored btn-lg btn-block mt-15"
								type="submit" id="register">수정하기</button>
						</div>
					</form>
				</div>
				<input type="hidden" id="hidden2" name="hidden2"> <input
					type="hidden" id="emailCheckStatus" name="emailCheckStatus">
			</div>
		</div>
	</div>
	<div class="tab-pane fade" id="profile">
		<div id="content">
			<div class="row">
				<div class="col-md-6 col-md-push-3">
					<br> <br>
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
							<label>아이디</label> <input name="id" id="id2" class="form-control"
								type="text" value="${member.id}" readonly>
						</div>
					</div>

					<div class="row">
						<div class="form-group col-md-12">
							<label for="form_choose_password">비밀번호 확인</label> <input
								id="pwd2" name="pwd" class="form-control" type="password">
						</div>
					</div>
					<div class="form-group">
						<button
							class="btn btn-border btn-theme-colored btn-lg btn-block mt-15"
							type="button" id="membership_withdrawal">회원 탈퇴하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>