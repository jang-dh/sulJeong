<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	$(function() {
		let isEnd = false;
		let listCount = $(".thumb").length;
		var curUrl = location.href;
		
		//정렬 조건 변경 시
		$("[name=order]").on("change", function() {
			$("#mailchimp-subscription-form").submit();
		});
		//
		
		//스크롤 시
		$(window).scroll(function() {
			let $window = $(this);
            let scrollTop = $window.scrollTop();
            let windowHeight = $window.height();
            let documentHeight = $(document).height();
            
            if(scrollTop + windowHeight + 30 > documentHeight){
            	console.log(listCount);
            	console.log(curUrl);
            	var curParams = curUrl.split('category/')[1];
        		
            }
		});
		//fetchList();
	});
	//jquery End
	
	//리스트 덧붙이기
	let fetchList = function() {
		if(isEnd == true)
			return ;
		
		//현재 요소 개수
		var listCount = $(".thumb").length;

		//현재 url
		var curUrl = location.href;
		var curParams = curUrl.split('category')[1];
		
		//현재 페이지의 검색 조건
		var categoryCode = '0';
		var order = null;
		var where = null;
		var val = null;
		if(curParams == '')
			categoryCode = '0';
		else if(curParams.startWith('3'))
			categoryCode = curParams.substring(0, 3);
	//fetchList End
	}
</script>


<!-- Start main-content -->
<div class="main-content">
	<!-- Section: inner-header -->
	<section class="inner-header divider layer-overlay overlay-dark-8"
		data-bg-img="http://placehold.it/1920x1280">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">내가 만든 펀딩</h2>
						<!-- <ol class="breadcrumb text-left mt-10 white">
							<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Causes Grid</li>
						</ol> -->
					</div>
				</div>
			</div>
		</div>
	</section><br><br>

	<!-- Section: Causes -->
	<section>
		<div class="container pt-0 pb-40">
			<div class="section-content">
				<div class="row multi-row-clearfix">
					 <c:forEach items="${myOpenFundingList}" var="fundingList" varStatus="status"> 
						<div class="col-sm-6 col-md-3">
							<div class="causes bg-silver-light maxwidth500 mb-30">
								<div class="thumb">
									<a href="${pageContext.request.contextPath}/mypage/myOpenFunding/${fundingList.code}"><img
										src="http://placehold.it/320x240" alt="" class="img-fullwidth"></a>
								</div>
								<div
									class="causes-details border-1px bg-white clearfix p-15 pb-30">
									<h4 class="font-16 text-uppercase">
										<a href="${pageContext.request.contextPath}/mypage/myOpenFunding/${fundingList.code}">${fundingList.title}</a>
									</h4>
									<ul class="list-inline font-weight-600 font-14 clearfix mb-5">
										<li class="pull-left font-weight-400 text-black-333 pr-0">달성금액:
											<span class="text-theme-colored font-weight-700">${fundingList.stackPrice}</span>
										</li>
										<li class="pull-right font-weight-400 text-black-333 pr-0">목표금액:
											<span class="text-theme-colored font-weight-700">${fundingList.goalPrice}</span>
										</li>
									</ul>
									<div class="progress-item mt-5">
										<div class="progress mb-0">
											<div data-percent="${fundingList.stackPrice/fundingList.goalPrice *100}"
												class="progress-bar appeared"
												style="width: ${fundingList.stackPrice/fundingList.goalPrice *100}%;">
												<span class="percent">0</span><span class="percent">${fundingList.stackPrice/fundingList.goalPrice *100}%</span>
											</div>
										</div>
									</div>
									<div class="pull-left font-weight-400 text-black-333 pr-0">
										<strong>펀딩종료 </strong>
									</div>
									<div class="bg-light text-center"
										data-countdown="${fundingList.endDate}"></div>
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