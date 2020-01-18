<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
   $(document).ready(function () {
      var allDate = "${_csrf.parameterName}=${_csrf.token}";
      
//       $.ajax({
//          url: "${pageContext.request.contextPath}/selectVisitData", //서버요청주소
//          type : "post", //서버 요청방식(get,put, put, patch)
//          dataType :"json", //서버가 보내온 데이터 타입(text, html, xml, json)
//          data: allDate,
//          success : function (result) {
        	
        	
        	
//             var str ="오늘 사이트를 방문한 사람 수 : "+result.visit+"명";
//             var str2 ="오늘 등록한 펀딩 수 : "+result.fundingApply+"개";
//             var str3 ="오늘 사람들이 결제한 총 금액 : "+AddComma(result.purchasePrice)+"원";
//             var str4 ="오늘 사람들이 펀딩에 참여한 수 : "+result.purchaseCount+"번";
//             var str5 ="오늘 사람들이 결제 취소한 금액 : "+AddComma(result.cancelPrice)+"원";
//             $("#display").html(str);
//             $("#display2").html(str2);
//             $("#display3").html(str3);
//             $("#display4").html(str4);
//             $("#display5").html(str5);
//          }, //성공시 
//          error: function (err) {
            
//          }//실패시
//       });
      
      var  cStop = setInterval(function () {
            $.ajax({
               url: "${pageContext.request.contextPath}/selectVisitData", //서버요청주소
             type : "post", //서버 요청방식(get,put, put, patch)
             dataType :"json", //서버가 보내온 데이터 타입(text, html, xml, json)
             data: allDate,
             success : function (result) {
                var str ="오늘 사이트를 방문한 사람 수 : "+result.visit+"명";
                 var str2 ="오늘 등록한 펀딩 수 : "+result.fundingApply+"개";
                 var str3 ="오늘 사람들이 결제한 총 금액 : "+AddComma(result.purchasePrice)+"원";
                 var str4 ="오늘 사람들이 펀딩에 참여한 수 : "+result.purchaseCount+"번";
                 var str5 ="오늘 사람들이 결제 취소한 금액 : "+AddComma(result.cancelPrice)+"원";
                 $("#display").html(str);
                 $("#display2").html(str2);
                 $("#display3").html(str3);
                 $("#display4").html(str4);
                 $("#display5").html(str5);
             }, //성공시 
             error: function (err) {
                console.log(err)
                clearTimeout(cStop);
             }//실패시
         }, 30000);
      	

   
      });
      
   });
   
   function AddComma(num)
   {
   var regexp = /\B(?=(\d{3})+(?!\d))/g;
   return num.toString().replace(regexp, ',');
   }


   
   
</script>



    <section>
      <div class="container pt-20 pb-20">
        <div class="esc-heading lr-line left-heading mb-30">
          <h4>사이트 관리</h4>
        </div>
        <div class="row">
          <div class="col-md-2">
            <div class="vertical-tab">
              <ul class="nav nav-tabs">
                <li class="active"><a href="${pageContext.request.contextPath}/admin/siteManagement">사이트 통계</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/fundingInsert" >펀딩 등록</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/personalQuestion" >1:1 문의 내역</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/fundingRequest" >펀딩 오픈 신청 내역</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-9">
            <div class="tab-content">
	            <h3 id="display" class="text-theme-colored text-uppercase m-0"></h3>
	            <h3 id="display2" class="text-theme-colored text-uppercase m-0"></h3>
	            <h3 id="display3" class="text-theme-colored text-uppercase m-0"></h3>
	            <h3 id="display4" class="text-theme-colored text-uppercase m-0"></h3>
	            <h3 id="display5" class="text-theme-colored text-uppercase m-0"></h3>
	            <hr/>
	            
	            <table >
	            	<tr align="center">
	            		<td width="500" height="300">
	            			<h3>주간 방문자 수</h3>
								<div class="line-bottom mb-30"></div>
								<div style="width: 90%" class="text-center">
								  <canvas id="lineChart"<%--  height="200" width="500" --%>></canvas>
								</div>
	            		</td>
	            		<td width="500" height="300">
				            		<h3>주간 펀딩 수</h3>
							<div class="line-bottom mb-30"></div>
							<div style="width: 90%" class="text-center">
			  					<canvas id="barChart"<%--  width="500" height="200" --%>></canvas>
							</div>
	            		</td>
	            	</tr>
	            	<tr align="center">
	            		<td width="500" height="300">
	            			<h3>주간 펀딩 금액</h3>
				<div class="line-bottom mb-30"></div>
				<div style="width: 90%" class="text-center">
  					<canvas id="lineChart2"<%--  width="500" height="200" --%>></canvas>
				</div>
	            		</td>
	            		<td width="500" height="300">
	            			
				<h3>주간 펀딩 등록 수</h3>
				<div class="line-bottom mb-30"></div>
				<div style="width: 90%" class="text-center">
  					<canvas id="barChart2"<%--  width="500" height="200" --%>></canvas>
				</div>
	            		</td>
	            	</tr>
	            	
	            	
	            
	            </table>
				
				
				
				
				
				
				
				
				<h3>주간 펀딩 취소 금액</h3>
				<div style="width: 90%" class="text-center">
  					<canvas id="lineChart3"<%--  width="500" height="200" --%>></canvas>
				</div>
				

            </div>
          </div>          
        </div>
      </div>
      
    </section>
    
<script>
    $(document).ready(function() {
        // Line Chart
        //등록일 가져오기
        var regdate=new Array();
 		<c:forEach var="regdate" items="${weekData}" varStatus="state">
        	regdate.push('${regdate.regdate}');
        </c:forEach>
        regdate.splice(0,1);
 		regdate.sort();
 		
        //방문자 수
        var visit=new Array();
 		<c:forEach var="visit" items="${weekData}" varStatus="state">
    		visit.push('${visit.visit}');
    	</c:forEach>
    	visit.splice(0,1);
 		visit.reverse();	
 
 		//펀딩 수
 		var purchaseCnt = new Array();
 		<c:forEach var="purchaseCnt" items="${weekData}" varStatus="state">
			purchaseCnt.push('${purchaseCnt.purchaseCount}');
		</c:forEach>
		purchaseCnt.splice(0,1);
 		purchaseCnt.reverse();
 		
 		//펀딩 금액
 		var purchasePrice = new Array();
 		<c:forEach var="purchasePrice" items="${weekData}" varStatus="state">
 			purchasePrice.push('${purchasePrice.purchasePrice}');
		</c:forEach>
		purchasePrice.splice(0,1);
		purchasePrice.reverse();
 		
		//펀딩 등록 수
		var fundingApply = new Array();
 		<c:forEach var="fundingApply" items="${weekData}" varStatus="state">
 			fundingApply.push('${fundingApply.fundingApply}');		</c:forEach>
		fundingApply.splice(0,1);
		fundingApply.reverse();
		
		//펀딩 취소 금액
		var cancelPrice = new Array();
 		<c:forEach var="cancelPrice" items="${weekData}" varStatus="state">
 			cancelPrice.push('${cancelPrice.cancelPrice}');
		</c:forEach>
		cancelPrice.splice(0,1);
		cancelPrice.reverse();
 		
        var lineChartData = {
          labels : regdate,
          datasets : [
            {
              label: "My Second dataset",
              fillColor : "rgba(151,187,205,0.2)",
              strokeColor : "rgba(151,187,205,1)",
              pointColor : "rgba(151,187,205,1)",
              pointStrokeColor : "#fff",
              pointHighlightFill : "#fff",
              pointHighlightStroke : "rgba(151,187,205,1)",
//               data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
              data : visit
            }
          ]
      
      	};
        
        var barChartData = {
                labels : regdate,
                datasets : [
                  {
                    fillColor : "rgba(220,220,220,0.5)",
                    strokeColor : "rgba(220,220,220,0.8)",
                    highlightFill: "rgba(220,220,220,0.75)",
                    highlightStroke: "rgba(220,220,220,1)",
                    data : purchaseCnt
                  }
                 
                ]
              
            };
        
        var lineChartData2 = {
                labels : regdate,
                datasets : [
                  {
                    label: "My Second dataset",
                    fillColor : "rgba(151,187,205,0.2)",
                    strokeColor : "rgba(151,187,205,1)",
                    pointColor : "rgba(151,187,205,1)",
                    pointStrokeColor : "#fff",
                    pointHighlightFill : "#fff",
                    pointHighlightStroke : "rgba(151,187,205,1)",
//                     data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
                    data : purchasePrice
                  }
                ]
            
            	};
        
        var barChartData2 = {
                labels : regdate,
                datasets : [
                  {
                    fillColor : "rgba(220,220,220,0.5)",
                    strokeColor : "rgba(220,220,220,0.8)",
                    highlightFill: "rgba(220,220,220,0.75)",
                    highlightStroke: "rgba(220,220,220,1)",
                    data : fundingApply
                  }
                 
                ]
              
            };
        
        var lineChartData3 = {
                labels : regdate,
                datasets : [
                  {
                    label: "My Second dataset",
                    fillColor : "rgba(151,187,205,0.2)",
                    strokeColor : "rgba(151,187,205,1)",
                    pointColor : "rgba(151,187,205,1)",
                    pointStrokeColor : "#fff",
                    pointHighlightFill : "#fff",
                    pointHighlightStroke : "rgba(151,187,205,1)",
//                     data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
                    data : cancelPrice
                  }
                ]
            
            	};
        
        
        window.onload = function(){
          var chart_lineChart = document.getElementById("lineChart").getContext("2d");
          window.myLine = new Chart(chart_lineChart).Line(lineChartData, {
            responsive: true
          });
          
          var chart_barChart = document.getElementById("barChart").getContext("2d");
          window.myBar = new Chart(chart_barChart).Bar(barChartData, {
            responsive : true
          });
          
          var chart_lineChart2 = document.getElementById("lineChart2").getContext("2d");
          window.myLine = new Chart(chart_lineChart2).Line(lineChartData2, {
            responsive: true
          });
          
          var chart_barChart2 = document.getElementById("barChart2").getContext("2d");
          window.myBar = new Chart(chart_barChart2).Bar(barChartData2, {
            responsive : true
          });
          
          var chart_lineChart3 = document.getElementById("lineChart3").getContext("2d");
          window.myLine = new Chart(chart_lineChart3).Line(lineChartData3, {
            responsive: true
          });
          
        };

    

    
        
          
        
    });
</script>


    
	