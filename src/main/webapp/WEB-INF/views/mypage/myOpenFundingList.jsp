<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	//fetchList 제어
	let isEnd = false;
	let flag = true;
	
	//contextPath 얻기
	function getContextPath() {
		var hostIndex = location.href.indexOf(location.host) + location.host.length;
		return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1) );
	}
	
	//동적으로 추가된 data-countdown에 이벤트 주기
	function init() { 
		$('.data-countdown').not('.initialized').each(function() { 
			var ac = $(this).addClass('initialized'); 
  		});
		
		$('[data-countdown]').each(function() {
			var $this = $(this), finalDate = $(this).data('countdown');
			$this.countdown(finalDate,function(event) {
				$this.html(event.strftime('%D 일 %H:%M:%S'));
			});
		});
	} 
	
	$(function() {
		//현재 url
		var curUrl = location.href;
		
		//스크롤 시
		$(window).scroll(function() {
			let $window = $(this);
            let scrollTop = $window.scrollTop();
            let windowHeight = $window.height();
            let documentHeight = $(document).height();
            
            if(scrollTop + windowHeight + 30 > documentHeight){
            	if(flag)
	            	fetchList();
            }
		});
		//fetchList();
	});
	//jquery End
	
	//리스트 덧붙이기
	let fetchList = function() {
		flag = false;
		
		if(isEnd == true)
			return;
		
		//현재 요소 개수
		var listCnt = $(".thumb").length;
		
		$.ajax({
			url : getContextPath() + "/myOpenFunding/fetchList",
			type : "get",
			dataType : "json",
			data : {code: '${mdCode}', listCnt : listCnt},
			success : function(result) {
				setTimeout(function() {
					flag = true;
				}, 500);
				
				let resultLength = result.length;
				if(resultLength < 3)
					isEnd = true;
				$.each(result, function(index, item) {
					renderList(false, item);
				})
			},
			error : function(err) {
				alert("오류 발생");
			}
		});
		//ajax End
	}
	//fetchList End
	
	let renderList = function(mode, item) {
		var per = Math.floor(item.stackPrice / item.goalPrice * 100);
		var perStyle = per;
		if(per > 100)
			perStyle = 100; 

		let html = '<div class="col-sm-7 col-md-4 wow fadeIn">';
		html += '<div class="causes bg-silver-light maxwidth500 mb-30">';
		html += '<div class="thumb">';
		html += '<a href="${pageContext.request.contextPath}/mypage/myOpenFunding/' + item.code + '">';
		html += '<img src="${pageContext.request.contextPath}/resources/images/funding/Thumnail_' + item.image +'" alt="" class="img-fullwidth" width="328" height="370">' ;
		html += '</a>';
		html += '</div>';
		html += '<div class="causes-details border-1px bg-white clearfix p-15 pb-30">';
		html += '<h4 class="font-16 text-uppercase">';
		html += '<a href="${pageContext.request.contextPath}/mypage/myOpenFunding/' + item.code + '">' + item.title + '</a>';
		if (item.fundingState == '502')
			html += '<span class="label label-default">진행예정</span>';
		else if (item.fundingState == '503')
			html += '<span class="label label-success">달성성공</span>';
		else
			html += '<span class="label label-warning">달성실패</span>';
		html += '</h4>';
		html += '<ul class="list-inline font-weight-600 font-14 clearfix mb-5">';
		html += '<li class="pull-left font-weight-400 text-black-333 pr-0">달성금액:';
		html += '<span class="text-theme-colored font-weight-700">' + item.stackPrice.toLocaleString() + '원</span>';
		html += '</li><br>';
		html += '<li class="pull-right font-weight-400 text-black-333 pr-0">목표금액:';
		html += '<span class="text-theme-colored font-weight-700">' + item.goalPrice.toLocaleString() + '원</span>';
		html += '</li>';
		html += '</ul>';
		html += '<div class="progress-item mt-5">';
		html += '<div class="progress mb-0">';
		html += '<div data-percent="' + per + '" class="progress-bar appeared" style="width: ' + perStyle + '%;">';
		html += '<span class="percent">0</span><span class="percent">' + per + '%</span>';
		html += '</div>';
		html += '</div>';
		html += '</div>';
		html += '<div class="pull-left font-weight-400 text-black-333 pr-0">';
		html += '<strong>펀딩종료까지 </strong>';
		html += '</div>';
		html += '<div class="text-center" data-countdown="' + item.endDate + '"></div>';
		html += '<br><i class="fa fa-heart faa-pulse animated"></i> <span class="text-theme-colored font-weight-700">' + item.cnt + '</span>';
		html += '</div>';
		html += '</div>';
		html += '</div>';
		
		if(mode)
            $("#list-funding").prepend(html);
        else
            $("#list-funding").append(html);
        
		init();
	}
</script>


<!-- Start main-content -->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">

		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">내가 만든 펀딩</h2>
						 <ol class="breadcrumb text-left mt-10 white">
							<!--<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Causes Grid</li>-->
						</ol> 
					</div>
				</div>
			</div>
		</div>
	</section><br><br>

	<!-- Section: Causes -->
	<section>
		<div class="container pt-0 pb-40">
			<div class="section-content">
				<div class="row multi-row-clearfix" id="list-funding" >
					<c:forEach items="${myOpenFundingList}" var="fundingList" varStatus="status">
						<div class="col-sm-7 col-md-4" >
							<div class="causes bg-silver-light maxwidth500 mb-30">
								<div class="thumb">
									<a href="${pageContext.request.contextPath}/mypage/myOpenFunding/${fundingList.code}">
									<img src="${pageContext.request.contextPath}/resources/images/funding/Thumnail_${fundingList.image}" alt="" class="img-fullwidth" width="328" height="370"></a>
								</div>
								<div class="causes-details border-1px bg-white clearfix p-15 pb-30">
									<h4 class="font-16 text-uppercase">
										<a href="${pageContext.request.contextPath}/mypage/myOpenFunding/${fundingList.code}">${fundingList.title}</a>
										<c:choose>
											<c:when test="${fundingList.fundingState == 502}">
												<span class="label label-default">진행예정</span>
											</c:when>
											<c:when test="${fundingList.fundingState == 503}">
												<span class="label label-success">달성성공</span>
											</c:when>
											<c:when test="${fundingList.fundingState == 504}">
												<span class="label label-warning">달성실패</span>
											</c:when>
										</c:choose>
									</h4>
									<ul class="list-inline font-weight-600 font-14 clearfix mb-5">
										<li class="pull-left font-weight-400 text-black-333 pr-0">달성금액:
											<span class="text-theme-colored font-weight-700"><fmt:formatNumber>${fundingList.stackPrice}</fmt:formatNumber>원</span>
										</li>
										<li class="pull-right font-weight-400 text-black-333 pr-0">목표금액:
											<span class="text-theme-colored font-weight-700"><fmt:formatNumber>${fundingList.goalPrice}</fmt:formatNumber>원</span>
										</li>
									</ul>
									<div class="progress-item mt-5">
										<div class="progress mb-0">
											<c:set var="per" value="${fundingList.stackPrice/fundingList.goalPrice *100}"/>
												<c:if test="${per > 100}">
													<c:set var="per" value="100"/>
												</c:if>
											<div data-percent="${fundingList.stackPrice/fundingList.goalPrice *100}" class="progress-bar appeared" style="width: ${per}%;">
												<span class="percent">0</span><span class="percent"><fmt:formatNumber value="${fundingList.stackPrice / fundingList.goalPrice}" type="percent"/></span>
											</div>
										</div>
									</div>
									<div class="pull-left font-weight-400 text-black-333 pr-0">
										<strong>펀딩종료까지 </strong>
									</div>
									<div class="text-center" data-countdown="${fundingList.endDate}"></div>
									<script type="text/javascript">
										$(document).ready(function() {
											$('[data-countdown]').each(function() {
												var $this = $(this), finalDate = $(this).data('countdown');
												$this.countdown(finalDate,function(event) {
													$this.html(event.strftime('%D 일 %H:%M:%S'));
												});
											});
										});
									</script>
									<br><i class="fa fa-heart faa-pulse animated"></i> <span class="text-theme-colored font-weight-700">${fundingList.cnt}</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
</div>
<!-- end main-content -->