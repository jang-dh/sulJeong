<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>



<html lang="ko">
<head>
<meta name="google-site-verification" content="T4dxhCXVH740-tPr5so0BkZbv-E6sGKbjrSWm0tu94Y" />
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>휴대폰 SMS 본인 인증(무료) | SK브로드밴드</title>
<link rel="shortcut icon" type="image/x-icon" href="/img/comm/favicon.ico">
<link rel="stylesheet" href="/common/css/vin/base.css" type="text/css">
<link rel="stylesheet" href="/common/css/vin/common.css" type="text/css">
<link rel="stylesheet" href="/common/css/vin/content.css" type="text/css">
<script type="text/javascript" src="/common/js/vin/libs/jquery.min.js"></script>
<script type="text/javascript" src="/common/js/vin/common.js"></script>
<script type="text/javascript" src="/common/js/wlo/wl6.js"></script>


<script type="text/javascript">
    $(document).ready(function(){
        window.resizeTo(600, 930);
        $('#terms5').change(function(){
            var chk = $(this).is(':checked');
            if(chk){
                $(':input:radio[name=chk]').each(function(){
                    $(this).attr('checked',true);
                });
            } else {
                $(':input:radio[name=chk]').each(function(){
                    $(this).attr('checked',false);
                });
            }
        });
    }); 

    function fn_valid() {
        // 특수문자 입력불가
        var chk_etc = (/[_\`\~\!\@#$\%\^\&\*\-\=\+\\\{\}\[\]\;\:\,\>\.\?\/\<\"\']/ig);
        
        if (!isNullAndTrim($("#name"), "고객명을 입력해주세요.")) {
            return false;
        }
        if(chk_etc.test($('#name').val())){
            alert('특수문자는 사용할 수 없습니다.');
            $('#name').focus();
            return false;
        }
        if($(":input:radio[name=gender]:checked").val() == undefined )
        {
            alert("성별을 선택해주세요.");
            $(":input:radio[name=gender]").eq(0).focus();
            return false;
        }

        if (!isNullAndTrim($("#birthDay"), "생년월일을 입력해주세요.")) {
            return false;
        }       
        if (!fn_length_chk($("#birthDay"), 6, "생년월일")) {
            return false;
        }
        if (!validationDate($("#birthDay"), "생년월일")) {
            return false;
        }   
        if (!isNullAndTrim($("#phoneCorp"), "이동통신사를 입력해주세요.")) {
            return false;
        }
        var PhoneNum = $("#tel2").val();
        var hpLen = PhoneNum.length;
        $("#cell_phone2").val(PhoneNum.substring(0, hpLen-4));
        $("#cell_phone3").val(PhoneNum.substring(hpLen-4, hpLen));
                
        if (!isNullAndTrim($("#cell_phone1"), "휴대폰번호를 입력해주세요.")) {
            return false;
        }
        
     /*    if (!fn_length_chk($("#cell_phone1"), 3, "휴대폰번호")) {
            return false;
        } */
        
        if (!isNullAndTrim($("#cell_phone2"), "휴대폰번호를 입력해주세요.")) {
            return false;
        }
        if (!fn_length_chk($("#cell_phone2"), 3, "휴대폰번호")) {
            return false;
        }
        if (!isNullAndTrim($("#cell_phone3"), "휴대폰번호를 입력해주세요.")) {
            return false;
        }
        if (!fn_length_chk($("#cell_phone3"), 4, "휴대폰번호")) {
            return false;
        }       
        $('#phoneNo').val($('#cell_phone1').val()+$('#cell_phone2').val()+$('#cell_phone3').val());
        // 휴대폰 번호 유효성검사
        var reg_mobile = /(010|011|016|017|018|019)-(\d{3,4})-(\d{4})/gi;
        if(!reg_mobile.test($('#cell_phone1').val()+"-"+$('#cell_phone2').val()+"-"+$('#cell_phone3').val()))
        {
            alert("잘못 입력된 형식입니다.\n정확한 휴대폰번호를 입력해 주세요.");
            document.reqForm.phoneNo1.focus();
            return false;
        }
        var captchaText = $("#captcha-text"); 
        if (!isNullAndTrim(captchaText, "보안문자를 입력해주세요.")) {
            return false;
        }
        return true;
    }
    
    function fn_cert_popup(retUrl, popName) {
        fn_popup('/popup/BusiessPage_Popup.do?retUrl='+retUrl, popName, '550', '650', 'no', 'no');
    }
    
    /* captcha 추가 */
    /* captcha 음성으로 듣기 */
    function fn_audio() {
        var f = document.chkFrm;
        f.target = "iframe1";
        f.action = "/common/captcha/AudioCaptcha.do";
        f.submit(); 
    }
    
    /* captcha 새로고침 */
    function fn_captcha() {
        $("#iframe1").attr("src", "");
        $("#captcha_img").attr("src", "/simpleCaptcha.do?bogus="    + new Date().getMilliseconds());
    }
    
    /* captcha 유효성체크 */
    function fn_send(){
        if(fn_valid()){
            var captchaText = $("#captcha-text").val(); 
            doAjax("/CaptchaCheck_Ajax.do?captcha_text="+captchaText, "", "fn_login_captcha_callback");
        }       
    }
    
   
    /* submit */
    function fn_login_captcha_callback(data){
        if (data) {
        	doSubmit("BusinessModel","/popup/IdentifyCertNum_Ajax.do", "fn_login_captcha_callback2");
        }  else {
            alert("보안문자를 정확하게 입력하세요.");
            fn_captcha();
            
            $("#captcha-text").val('').focus();
        }   
    }
    function fn_login_captcha_callback2(data){
    	$("input[id=certNum]").val(data.certNum);
        $("#cell_phone1").val(data.cell_phone1);
        $("#cell_phone2").val(data.cell_phone2);
        $("#cell_phone3").val(data.cell_phone3);
        $("#check_1").val(data.check_1);
        $("#check_2").val(data.check_2);
        $("#check_3").val(data.check_3);
        $("#name").val(data.name);
    }
    
    // sms 본인인증
     function fn_send_sms(){
        if(fn_valid_sms()){
            doSubmit("BusinessModel", "/popup/IdentifyCheckCertNum_Proc.do", "fn_callback_sms");
        }       
    }
    
    function fn_valid_sms() {
    	  if ( $(":input:checkbox[id=terms1]:checked").val() == undefined)
          {
              alert("개인정보 이용동의에 체크해 주세요.");
              $(":input:checkbox[id=terms1]").eq(0).focus();
              return false;
          }
          if ( $(":input:checkbox[id=terms2]:checked").val() == undefined)
          {
              alert("통신사 이용약관 동의에 체크해 주세요.");
              $(":input:checkbox[id=terms2]").eq(0).focus();
              return false;
          }
          if ( $(":input:checkbox[id=terms3]:checked").val() == undefined)
          {
              alert("고유식별정보 처리 동의에 체크해 주세요.");
              $(":input:checkbox[id=terms3]").eq(0).focus();
              return false;
          }
          if ( $(":input:checkbox[id=terms4]:checked").val() == undefined)
          {
              alert("서비스 이용약관 동의에 체크해 주세요.");
              $(":input:checkbox[id=terms4]").eq(0).focus();
              return false;
          }       

        
        if (!isNullAndTrim($("#smsNum"), "인증번호를 입력해주세요.")) {
            return false;
        }       

        if (!fn_length_chk($("#smsNum"), 6, "인증번호")) {
            return false;
        }

        return true;
    }
    
    
    function fn_callback_sms(data) {
        $("#certificationYN", parent.document).val('N');
        if(data.result =="E"){          
            alert("본인 인증처리 중 데이터 에러가 발생했습니다.\n잠시 후 다시 시도해주세요.");            
        } else if(data.result == "N"){
            if(data.result_code == "KISH0001"){
                alert("분실 또는 일시정지 휴대폰 입니다.");
            } else if(data.result_code == "KISH0002"){
                alert("법인 명의의 휴대폰은 등록이 불가능 합니다.");
            } else if(data.result_code == "KISH0003"){
                alert("휴대폰 번호 또는 혹은 통신사의 정보가 맞지 않습니다.");
            } else if(data.result_code == "KISH0004"){
                alert("생년월일 또는 성별 정보가 맞지 않습니다.");
            } else if(data.result_code == "KISH0005"){
                alert("휴대폰 명의자가 맞지 않습니다.");
            } else if(data.result_code == "KISH0006"){
                alert("입력하신 정보가 맞지 않습니다.");
            } else if(data.result_code == "KISH0008"){
                alert("요금제에 제한이 있는 가입자 입니다.");
            } else if(data.result_code == "KISH0009"){
                alert("선불 휴대폰번호 입니다.");
            } else if(data.result_code == "KIST9998"){
                alert("인증번호 5회 실패시 인증이 불가능 합니다. \n나중에 다시 시도해 주세요.");
            } else if(data.result_code == "KIST9999"){
                alert("인증번호가 맞지 않습니다.");                
            } else {
                alert("본인 인증처리 중 데이터 에러가 발생했습니다.\n통신사의 일시적인 서비스 에러");
            }
            history.go(-1);
        } else {
            alert("인증이 완료되었습니다.");
            $("#certificationYN", opener.document).val('Y');    
            opener.$("#name").val($("#name").val());
            opener.$("#name").html($("#name").val());
            
            opener.$("#cell_phone1").val($("#cell_phone1").val());
            opener.$("#cell_phone2").val($("#cell_phone2").val());
            opener.$("#cell_phone3").val($("#cell_phone3").val());
            opener.nameCheck($("#name").val());
            self.close();
        }
    }
    
</script>

<script>
$(document).ready(function($) {
	doLoadingInitPopupStart();
	
});
</script>
</head>

<body class="popup" onload=";fn_pageLog('1');"
	onunload="">

	<div id="pop-wrap" tabindex=0>
		
<form id="BusinessModel" action="/popup/Identify_Popup.do" method="post" onsubmit="return false;">
        <input type="hidden" name="cpId" value="SKBM2008"> <!-- 회원사 ID -->
        <input type="hidden" name="urlCode" value="001001"> <!-- URL 코드 -->
        <input type="hidden" name="certNum" value="20200110092410432817"> <!-- 요청번호 -->
        <input type="hidden" name="date" value="20200110092410"> <!-- 요청일시 -->
        <input type="hidden" id="phoneNo" name="phoneNo" value=""> <!-- 전화번호 -->
        
        
        <input type="hidden" id="nation" name="nation" value="0"> <!-- 국적구분 -->     
        
        <!--본인인증 한페이지에서 합치는 변수 -->
        <input type="hidden" name="certNum" > 
       <!--  <input type="hidden" id="cell_phone1" name="cell_phone1">
        <input type="hidden" id="cell_phone2" name="cell_phone2">
        <input type="hidden" id="cell_phone3" name="cell_phone"> -->
        <input type="hidden" id="check_1" name="check_1" > 
        <input type="hidden" id="check_2" name="check_2" > 
        <input type="hidden" id="check_3" name="check_3"> 
        
        <article id="pop_wrap" class="win_pop">
        <header id="pop_header">
            <h1 class="pop_tit">휴대폰 본인 인증</h1>
        </header>
        <div id="pop_container">
            <!-- contents -->
            <div class="pop_contents">
                <div class="agree_box" id="uiPhoneAgree">
                    <dl>
                        <dt>
                            <span class="chk_wrap">
                                <input type="checkbox" name="chk" id="terms1"><label for="terms1">개인정보 이용동의</label>
                            </span>
                        </dt>
                        <dd><a href="#none" target="_blank" title="새 창" onclick="javascript:fn_cert_popup('/popup/Agreement_Popup','개인정보 이용동의');return false;">전문보기 &gt;</a></dd>
                    </dl>
                    <dl>
                        <dt>
                            <span class="chk_wrap">
                                <input type="checkbox" name="chk" id="terms2"><label for="terms2">통신사 이용약관 동의</label>
                            </span>
                        </dt>
                        <dd><a href="#none" target="_blank" title="새 창" onclick="javascript:fn_cert_popup('/popup/Agency_Popup','통신사 이용약관 동의');return false;">전문보기 &gt;</a></dd>
                    </dl>
                    <dl>
                        <dt>
                            <span class="chk_wrap">
                                <input type="checkbox" name="chk" id="terms3" ><label for="terms3">고유 식별 정보 처리동의</label>
                            </span>
                        </dt>
                        <dd><a href="#none" target="_blank" title="새 창" onclick="javascript:fn_cert_popup('/popup/UniqueIdenAgree_Popup','고유 식별 정보 처리동의');return false;">전문보기 &gt;</a></dd>
                    </dl>
                    <dl>
                        <dt>
                            <span class="chk_wrap">
                                <input type="checkbox" name="chk" id="terms4"><label for="terms4">서비스 이용약관 동의</label>
                            </span>
                        </dt>
                        <dd><a href="#none" target="_blank" title="새 창" onclick="javascript:fn_cert_popup('/popup/ServiceUseAgree_Popup','서비스 이용약관 동의');return false;">전문보기 &gt;</a></dd>
                    </dl>
                    <dl class="all_check">
                        <dt>
                            <span class="chk_wrap">
                                <input type="checkbox" name="all_check" id="terms5" data-check-all="#uiPhoneAgree" ><label for="terms5">전체동의</label>
                            </span>
                        </dt>
                        <dd><a href="#none" target="_blank" title="새 창" onclick="javascript:fn_cert_popup('/popup/Policy_Popup','개인정보 취급방침');return false;"><em>*</em> 개인정보 취급방침</a></dd>
                    </dl>
                </div>
                <fieldset>
                    <legend>휴대폰 인증을 위한 정보 입력 후, 발송된 인증번호를 입력하여 본인인증을 완료 합니다</legend>
                    <div class="input_form_wrap layer_inner sms_confirm tit_bg">
                        <div class="input_form_header">
                            <h2 class="tit03 titSpa_m fl titSmt_xl txt_l">휴대폰 가입정보<span class="t01_decs">본인 소유의 휴대폰 정보를 입력하세요.</span></h2>

                        </div>
                        <div class="input_form_conts">
                            <dl>
                                <dt>
                                    <label for="name">고객명</label>
                                </dt>
                                <dd>
                                    <span class="input_txt input_sec_num">
                                        <input type="text" title="고객명 입력" id="name" name="name">
                                    </span>
                                </dd>
                            </dl>
                            <dl>
                                <dt>성별</dt>
                                <dd>
                                    <div class="group_radio">
                                        <span class="rad_wrap">
                                            <input type="radio" name="gender" id="male" checked title="성별 - 남" value="0">
                                            <label for="male">남</label>
                                        </span>
                                        <span class="rad_wrap">
                                            <input type="radio" name="gender" id="female" title="성별 - 여" value="1">
                                            <label for="female">여</label>
                                        </span>
                                    </div>
                                </dd>
                            </dl>
                            <dl>
                                <dt>
                                    <label for="birthDay">생년월일</label>
                                </dt>
                                <dd>
                                    <span class="input_txt input_sec_num">
                                        <input type="text" title="생년월일 입력" id="birthDay" name="birthDay" onkeyup="javascript:checkNum('birthDay')" maxlength="8"onkeyup="checkNum('birthDay')" >
                                    </span>
                                    <span class="form_guide"> 예) 19900808</span>
                                </dd>
                            </dl>
                            <dl>
                                <dt>
                                    <label for="sel_tel_type">휴대폰 번호</label>
                                </dt>
                                <dd>
                                    <div class="input_tel">
                                        <div class="selects telecom">
                                            <select title="통신사 선택" class="ui_selectbox" data-class="select_custom" name="phoneCorp"  id="phoneCorp">
                                                <option value="">통신사</option>
                                                <option value="SKT">SKT</option>
                                                <option value="KTF">KT</option>
                                                <option value="LGT">LG U+</option>
                                                <option value="SKM">SKT 알뜰폰</option>
                                                <option value="KTM">KT 알뜰폰</option>
                                                <option value="LGM">LG U+ 알뜰폰</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="input_btn_container input_tel">
                                        <div class="selects">
                                            <select id="cell_phone1" name="cell_phone1" title="휴대폰 번호 앞자리 선택" class="ui_selectbox" data-class="select_custom">
                                                <option value="010">010</option>
                                                <option value="011">011</option>
                                                <option value="016">016</option>
                                                <option value="017">017</option>
                                                <option value="018">018</option>
                                                <option value="019">019</option>
                                            </select>
                                        </div>
                                        <span class="input_txt tel_num">
                                            <input type="text" id="tel2" name="tel2" title="휴대폰 번호 뒷 8자리 입력" maxlength="8" onkeyup="checkNum('tel2')" >
                                            <input type="hidden"  name="cell_phone2"id="cell_phone2" />
                                            <input type="hidden" name="cell_phone3" id="cell_phone3" />
                                        </span>
                                        <button type="button" class="btn gray h50" onclick="fn_send(); return false;"><span>인증번호 발송</span></button>
                                    </div>
                                </dd>
                            </dl>
                            <dl>
                                <dt>
                                    <label for="smsNum">인증번호 입력</label>
                                </dt>
                                <dd>
                                    <span class="input_txt input_sec_num">
                                        <input type="text" title="인증번호 입력" id="smsNum"  name="smsNum"  maxlength="6" onkeyup="javascript:checkNum('smsNum')">
                                    </span>
                                </dd>
                            </dl>
                            <dl>
                                <dt>
                                    <label for="sec_txt">보안문자 입력</label>
                                </dt>
                                <dd>
                                    <p class="sec_input_txt">아래 이미지의 보안문자를 입력해주세요.</p>
                                    <div class="sec_wrap">
                                        <div class="sec_view">
                                            <span class="sec_txt"><img src="/simpleCaptcha.do" alt="보안문자" id="captcha_img"></span>
                                            <div class="sec_btn_wrap">
                                                <button type="button" class="btn sound" onclick="javascript:fn_audio();"><span>음성으로 듣기</span></button>
                                                <button type="button" class="btn refresh" onclick="javascript:fn_captcha();"><span>새로고침</span></button>
                                            </div>
                                        </div>
                                        <span class="input_txt">
                                            <input type="text" title="보안문자 입력" id="captcha-text" name="answer" maxlength="5">
                                        </span>
                                    </div>
                                </dd>
                            </dl>
                        </div>
                        <div class="guide_list">
                            <ul class="bull_list min layer_min">
                                <li class="square">입력하신 정보가 가입자 본인 명의로 가입된 휴대폰이 아닐 경우 인증이 되지 않습니다.</li>
                                <li class="square">본인 명의로 가입된 휴대폰 번호의 본인확인 서비스는 하루 3번까지 이용할 수 있습니다.</li>
                                <li class="square">휴대폰 문자로 발송된 번호는 비밀번호가 아닌 본인확인을 위한 인증 번호입니다.</li>
                                <li class="square">입력하신 정보는 암호화 되어 사용되며, 본인여부 확인에만 사용됩니다.</li>
                            </ul>
                        </div>
                        <div class="input_form_footer">
                            <div class="btn_wrap narrow">
                                <button type="button" class="btn submit h60" onclick="javascript:fn_send_sms();" >
                                    <span>확인</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div><!-- //contents -->
        </div>
    </article>
    </form>
    
    <!-- captcha 음성듣기 iframe -->
    <iframe name="iframe1" style="display:none;" title="captchaIframe" id="iframe1">
        <audio autoplay>
            <source src="/audio.do" autostart="true" LOOP="true" title="보안문자 소리"><!-- For Chrome, Safari -->
            <embed src="/audio.do" autostart="true" LOOP="true" hidden="true" title="보안문자 소리"><!-- For IE -->
        </audio>
    </iframe>
    <form method="post" name="chkFrm" id="chkFrm"></form>
    <!-- captcha 음성듣기 iframe -->
    <script>
        $(function () {
            $("select").change(function () {
                $(this).removeClass("no_empty")
                if ($(this).find("option:selected").index() != 0) {
                    $(this).addClass("no_empty")
                }
            });

            vcui.require(['ui/selectbox'], function () {
                $('.ui_selectbox').vcSelectbox();
            });
        });
    </script>
    

	</div>
	
<script type="text/javascript" src="/common/js/vin/vcui.js"></script>
<script type="text/javascript" src="/common/js/vin/vcui.common-ui.js"></script>
<script type="text/javascript" src="/common/js/vin/skb.site.js"></script>
</body>
</html>
