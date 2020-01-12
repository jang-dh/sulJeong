<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- iamport.payment.js -->
 <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
 <script>
 $(function(){
	 var IMP = window.IMP; // 생략해도 괜찮습니다.
	 IMP.init("imp00000000"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
	 
	// IMP.certification(param, callback) 호출
	  IMP.certification({ // param
		  merchant_uid: "ORD20180131-0000011"
	  }, function (rsp) { // callback
	    if (rsp.success) {
	    	// jQuery로 HTTP 요청
	        jQuery.ajax({
	          url: "https://www.myservice.com/certifications", // 서비스 웹서버
	          method: "POST",
	          headers: { "Content-Type": "application/json" },
	          data: { imp_uid: rsp.imp_uid }
	        });
	    } else {
	    	alert("인증에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
	    }
	  });
	 
 });
 
 </script>
 
