<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
$(function(){
	$("#loginGoBtn").hide();
	$("#find").click(function(){
		if($("#name1").val()==""){
			alert("성함을 입력해주세요");
			$("#name1").focus();
			return false;
		}
		if($("#phone1").val()==""){
			alert("핸드폰 번호를 입력해주세요");
			$("#phone1").focus();
			return false;
		}
		
		var nameVal = $("#name1").val()
		var phoneVal = $("#phone1").val();
		
		var allDate = "${_csrf.parameterName}=${_csrf.token}"+"&name="+nameVal +"&phone="+phoneVal;
		  $.ajax({
				 url: "findId", //서버요청주소
				 type:"post", //요청방식(get|post|put:patch:delete)
				 dataType:"json", //서버가 보내온 데이터 타입(text,html,xml,json)
				 data: allDate ,//서버에게 보내는 parameter 정보
				 success:function(result){
				    //$("#showId").html(result.name+"님의 아이디는 "+result.id+"입니다.")
				    $("#login-form").hide();
				    var str="";
					$.each(result, function(index, item){
						str+=item.name+"님의 아이디는 "+item.id+"입니다.<br>";
					});
					
					$("#showId").html(str);
					$("#loginGoBtn").show();
					
					
				 } ,//성공했을대
				 error:function(err){
					 $("#showId").html("입력하신 정보의 아이디는 존재하지 않습니다.")
				 }//오류발생했을때
			 }); 
	  });
	
	 $("#findPWD").click(function(){
		if($('#name').val()==""){
			alert("성함을 입력해주세요");
			$('#name').focus();
			return false;
		}
		if($('#phone').val()==""){
			alert("핸드폰 번호를 입력해주세요");
			$('#phone').focus();
			return false;
		}
		
		if($('#email').val()==""){
			alert("이메일을 입력해주세요");
			$('#email').focus();
			return false;
		}
		
	  }); 
	 
	 if(${result>0}){
			alert("임시 비밀번호를 이메일로 전송하였습니다.")
		}else if(${result==0}){
			alert("입력 정보를 다시 확인해주세요");
			$('#name').focus();
			return false;
		}
	
});




</script>

<body>

<ul id="myTab" class="nav nav-tabs boot-tabs">
  <li class="active"><a href="#home" data-toggle="tab">아이디 찾기</a></li>
  <li><a href="#profile" data-toggle="tab">비밀번호 찾기</a></li>
</ul>

<div id="myTabContent" class="tab-content">
  <div class="tab-pane fade in active" id="home">
    <div class="main-content">
	<section>
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-md-push-3">
            <h4 class="text-gray mt-0 pt-5"> 아이디 찾기</h4>
            <hr>
            <form id="login-form" name="login-form" class="clearfix" action="${pageContext.request.contextPath}/loginCheck" method="post">
            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="form_username_email">Name</label>
                  <input id="name1" name="name1" class="form-control" type="text">
                </div>
              </div>
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="form_password">Phone</label>
                  <input id="phone1" name="phone1" class="form-control" type="text" >
                </div>
               <div class="form-group pull-right mt-10">
                <button type="button" class="btn btn-dark btn-sm" id="find" value="Login">찾기</button>
              </div>
              </div>
              
            </form>
            <div id="showId">
            	
              </div>
              </p>
              </p>
              <a id="loginGoBtn" href="${pageContext.request.contextPath}/login" class="btn btn-dark btn-circled">로그인</a>
          </div>
        </div>
      </div>
    </section>
  </div>
  </div>
  <div class="tab-pane fade" id="profile">
  	<div class="main-content">
	<section>
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-md-push-3">
            <h4 class="text-gray mt-0 pt-5"> 비밀번호 찾기</h4>
            <hr>
            <form id="login-form" name="login-form" class="clearfix" action="${pageContext.request.contextPath}/pwdCheck" method="post">
            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="form_username_email">id</label>
                  <input id="name" name="id" class="form-control" type="text">
                </div>
              </div>
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="form_password">Phone</label>
                  <input id="phone" name="phone" class="form-control" type="text" >
                </div>
                
                <div class="form-group col-md-12">
                  <label for="form_password">email</label>
                  <input id="email" name="email" class="form-control" type="text" >
                </div>
                
               <div class="form-group pull-right mt-10">
                <button type="submit" class="btn btn-dark btn-sm" id="findPWD" value="Login">찾기</button>
              </div>
              </div>
              <!-- <div id="showId2">
                
              </div> -->
            </form>
          </div>
        </div>
      </div>
    </section>
  </div>
  </div>
</div> 

</body>


