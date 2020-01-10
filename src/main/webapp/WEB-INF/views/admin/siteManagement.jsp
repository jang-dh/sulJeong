<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>    

<c:set var="data" value="15"/>
<script type="text/javascript">
   $(document).ready(function () {
      var allDate = "${_csrf.parameterName}=${_csrf.token}";
      $.ajax({
         url: "${pageContext.request.contextPath}/selectVisitData", //서버요청주소
         type : "post", //서버 요청방식(get,put, put, patch)
         dataType :"text", //서버가 보내온 데이터 타입(text, html, xml, json)
         data: allDate,
         success : function (result) {
            var str ="일일 사이트 방문자 수 : "+result+"명";
            $("#display").html(str);
         }, //성공시 
         error: function (err) {
            alert(err+"오류발생");
         }//실패시
      });
      setInterval(function () {
            $.ajax({
               url: "${pageContext.request.contextPath}/selectVisitData", //서버요청주소
             type : "post", //서버 요청방식(get,put, put, patch)
             dataType :"text", //서버가 보내온 데이터 타입(text, html, xml, json)
             data: allDate,
             success : function (result) {
                var str ="일일 사이트 방문자 수 : "+result+"명";
                $("#display").html(str);
             }, //성공시 
             error: function (err) {
                alert(err+"오류발생");
             }//실패시
         }, 30000);
      

   
      });
      
   });
</script>



    <section>
      <div class="container pt-20 pb-20">
        <div class="esc-heading lr-line left-heading">
          <h4>사이트 관리</h4>
        </div>
        <div class="row">
          <div class="col-md-3">
            <div class="vertical-tab">
              <ul class="nav nav-tabs">
                <li class="active"><a href="siteManagement">사이트 통계</a></li>
                <li><a href="fundingInsert" >펀딩 등록</a></li>
                <li><a href="personalQuestion" >1:1 문의 내역</a></li>
                <li><a href="fundingRequest" >펀딩 오픈 신청 내역</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-9">
            <div class="tab-content">
            <h3 id="display" class="text-theme-colored text-uppercase m-0"></h3>
            <hr/>
				<h3>주간 방문자 수</h3> 
				<div style="width: 90%" class="text-center">
				  <canvas id="lineChart" height="450" width="600"></canvas>
				</div>

            </div>
          </div>          
        </div>
      </div>
      
    </section>
    
<script>
    $(document).ready(function() {
        // Line Chart
        var regdate=new Array();
        var visit=new Array();
 		<c:forEach var="regdate" items="${weekData}" varStatus="state">
        	regdate.push('${regdate.regdate}');
        </c:forEach>
 		regdate.sort();
 		<c:forEach var="visit" items="${weekData}" varStatus="state">
    		visit.push('${visit.visit}');
    	</c:forEach>
 		visit.reverse();	
 		
        var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
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
        window.onload = function(){
          var chart_lineChart = document.getElementById("lineChart").getContext("2d");
          window.myLine = new Chart(chart_lineChart).Line(lineChartData, {
            responsive: true
          });
        };

    });


</script>
    
	