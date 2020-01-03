<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <body>
		<div class="row">
          <div class="col-md-6 col-md-push-3">
          <br><br>
            <form name="reg-form" class="register-form" method="post"  action="${pageContext.request.contextPath}/memberJoin">
              <div class="icon-box mb-0 p-0">
                <a href="#" class="icon icon-bordered icon-rounded icon-sm pull-left mb-0 mr-10">
                  <i class="pe-7s-users"></i>
                </a>
                <h4 class="text-gray pt-10 mt-0 mb-30">Don't have an Account? Register Now.</h4>
              </div>
              <hr>
              <p class="text-gray">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi id perspiciatis facilis nulla possimus quasi, amet qui. Ea rerum officia, aspernatur nulla neque nesciunt alias.</p>
              <div class="row">
                <div class="form-group col-md-6">
                  <label>Name</label>
                  <input name="name" class="form-control" type="text">
                </div>
                <div class="form-group col-md-6">
                  <label>Email Address</label>
                  <input name="email" class="form-control" type="email">
                </div>
              </div>
              <div class="row">
                <div class="form-group col-md-6">
                  <label>휴대폰</label>
                  <input name="phone" class="form-control" type="text">
                </div>
                <div class="form-group col-md-6">
                  <label>휴대폰 성인인증</label>
                  <input type="button" value="인증하기" name="Authenticate" class="form-control">
                </div>
              </div>
              
              <div class="row">
                 <div class="form-group col-md-6">
                  <label for="form_choose_username">Choose UserID</label>
                  <input id="form_choose_userId" name="id" class="form-control" type="text">
                </div>
                <div class="form-group col-md-6">
                  <label>아이디 중복 체크</label>
                  <input type="button" value="중복체크" name="idDuplicateCheck" class="form-control">
                </div>
              </div>
              
              <div class="row">
                <div class="form-group col-md-6">
                  <label for="form_choose_password">Choose Password</label>
                  <input id="form_choose_password" name="pwd" class="form-control" type="text">
                </div>
                <div class="form-group col-md-6">
                  <label>Re-enter Password</label>
                  <input id="form_re_enter_password" name="pwdCheck" class="form-control" type="text">
                </div>
              </div>
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="form_choose_username">이메일 수신동의(선택)</label>
                  <input id="form_choose_emailCheck" name="emailAccept" type="checkbox">
                </div>
              </div>
              <div class="form-group">
                <button class="btn btn-dark btn-lg btn-block mt-15" type="submit">Register Now</button>
              </div>
            </form>
          </div>
        </div>
       </body>