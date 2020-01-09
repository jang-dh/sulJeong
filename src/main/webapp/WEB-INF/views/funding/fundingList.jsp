<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
				$this.html(event.strftime('%D 일'));
			});
		});
	} 
	
	$(function() {
		//현재 url
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

		//현재 url
		var curUrl = location.href;
		var curParams = curUrl.split('category/')[1];

		//현재 페이지의 검색 조건
		var categoryCode = 0;
		var order = null;
		var where = null;
		var val = null;
		if(curParams.startsWith('3')){
			categoryCode = parseInt(curParams.substring(0, 3));
			curParams = curParams.substring(3, curParams.length);
		}
		
		if(curParams.startsWith('?')){
			var params = curParams.split('&');
			order = params[0].split('?order=')[1];
			where = params[1].split('where=')[1];
			val = params[2].split('val=')[1];
		}
		$.ajax({
			url : getContextPath() + "/funding/fetchList",
			type : "get",
			dataType : "json",
			data : {categoryCode : categoryCode, order : order, where : where, val : val, listCnt : listCnt},
			success : function(result) {
				setTimeout(function() {
					flag = true;
				}, 500);
				
				let resultLength = result.length;
				if(resultLength < 4)
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
		var per = item.stackPrice / item.goalPrice * 100;
		let html = '<div class="col-sm-6 col-md-3 wow fadeIn">';
		html += '<div class="causes bg-silver-light maxwidth500 mb-30">';
		html += '<div class="thumb">';
		html += '<a href="${pageContext.request.contextPath}/funding/' + item.code + '">';
		html += '<img src="http://placehold.it/320x240" alt="" class="img-fullwidth">';
		html += '</a>';
		html += '</div>';
		html += '<div class="causes-details border-1px bg-white clearfix p-15 pb-30">';
		html += '<h4 class="font-16 text-uppercase">';
		html += '<a href="${pageContext.request.contextPath}/funding/' + item.code + '">' + item.title + '</a>';
		html += '</h4>';
		html += '<ul class="list-inline font-weight-600 font-14 clearfix mb-5">';
		html += '<li class="pull-left font-weight-400 text-black-333 pr-0">달성금액:';
		html += '<span class="text-theme-colored font-weight-700">' + item.stackPrice + '</span>';
		html += '</li>';
		html += '<li class="pull-right font-weight-400 text-black-333 pr-0">목표금액:';
		html += '<span class="text-theme-colored font-weight-700">' + item.goalPrice + '</span>';
		html += '</li>';
		html += '</ul>';
		html += '<div class="progress-item mt-5">';
		html += '<div class="progress mb-0">';
		html += '<div data-percent="' + per + '" class="progress-bar appeared" style="width: ' + per + '%;">';
		html += '<span class="percent">0</span><span class="percent">' + per + '%</span>';
		html += '</div>';
		html += '</div>';
		html += '</div>';
		html += '<div class="pull-left font-weight-400 text-black-333 pr-0">';
		html += '<strong>펀딩종료까지 </strong>';
		html += '</div>';
		html += '<div class="text-center" data-countdown="' + item.endDate + '"></div>';
		html += '<a href="' + item.code + '" class="btn btn-default btn-theme-colored mt-10 font-16 btn-sm">펀딩하기 <i class="flaticon-charity-make-a-donation font-16 ml-5"></i>';
		html += '</a>';
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
	<section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
		<div class="container pt-90 pb-40">
			<!-- Section Content -->
			<div class="section-content">
				<div class="row">
					<div class="col-md-6">
						<h2 class="text-white font-36">펀딩</h2>
						<!-- <ol class="breadcrumb text-left mt-10 white">
							<li><a href="#">Home</a></li>
							<li><a href="#">Pages</a></li>
							<li class="active">Causes Grid</li>
						</ol> -->
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container pt-40 pb-0">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="${pageContext.request.contextPath}/funding/category/">
							<img class="media-object" width="60" src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="${pageContext.request.contextPath}/funding/category/">전체보기</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="${pageContext.request.contextPath}/funding/category/301">
							<img class="media-object" width="60" src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="${pageContext.request.contextPath}/funding/category/301">탁주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="${pageContext.request.contextPath}/funding/category/302">
							<img class="media-object" width="60" src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="${pageContext.request.contextPath}/funding/category/302">청주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="${pageContext.request.contextPath}/funding/category/303">
							<img class="media-object" width="60" src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="${pageContext.request.contextPath}/funding/category/303">증류주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="${pageContext.request.contextPath}/funding/category/304">
							<img class="media-object" width="60" src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="${pageContext.request.contextPath}/funding/category/304">과실주</a>
							</h5>
						</div>
					</div>
				</div>
				<div class="form-group col-md-1">
					<div class="media">
						<a class="flip" href="${pageContext.request.contextPath}/funding/category/305">
							<img class="media-object" width="60" src="http://placehold.it/70x80" alt="">
						</a>
						<div class="media-body">
							<h5 class="media-heading product-title mb-0">
								<a href="${pageContext.request.contextPath}/funding/category/305">와인</a>
							</h5>
						</div>
					</div>
				</div>
			</div>
			<div class="container pt-30 pb-0">
				<div class="col-md-5"></div>
				<form id="mailchimp-subscription-form" class="newsletter-form" novalidate="true" action="">
					<div class="form-group col-md-2">
						<select class="form-control" name="order">
							<option>정렬</option>
							<option value="likes">인기순</option>
							<option value="lastest">마감임박순</option>
							<option value="newest">최신오픈순</option>
						</select>
					</div>
					<div class="form-group col-md-2">
						<select class="form-control" name="where">
							<option>선택</option>
							<option value="md_name">판매자 이름</option>
							<option value="title">펀딩명</option>
						</select>
					</div>
					<div class="form-group col-md-3">
						<div class="input-group">
							<input type="email" value="" name="val" class="form-control input-lg font-16" data-height="45px" id="mce-EMAIL-footer" style="height: 45px;"> 
							<span class="input-group-btn">
								<button data-height="45px" class="btn btn-colored btn-theme-colored btn-xs m-0 font-14" type="submit" style="height: 45px;">검색</button>
							</span>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>

	<!-- Section: Causes -->
	<section>
		<div class="container pt-0 pb-40">
			<div class="section-content">
				<div class="row multi-row-clearfix" id="list-funding">
					<c:forEach items="${list}" var="fundingList" varStatus="status">
						<div class="col-sm-6 col-md-3">
							<div class="causes bg-silver-light maxwidth500 mb-30">
								<div class="thumb">
									<a href="${pageContext.request.contextPath}/funding/${fundingList.code}">
									<img src="http://placehold.it/320x240" alt="" class="img-fullwidth"></a>
								</div>
								<div class="causes-details border-1px bg-white clearfix p-15 pb-30">
									<h4 class="font-16 text-uppercase">
										<a href="${pageContext.request.contextPath}/funding/${fundingList.code}">${fundingList.title}</a>
									</h4>
									${fundingList.member.name}
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
											<div data-percent="${fundingList.stackPrice/fundingList.goalPrice *100}" class="progress-bar appeared" style="width: ${fundingList.stackPrice/fundingList.goalPrice *100}%;">
												<span class="percent">0</span><span class="percent">${fundingList.stackPrice / fundingList.goalPrice * 100}%</span>
											</div>
										</div>
									</div>
									<div class="pull-left font-weight-400 text-black-333 pr-0">
										<strong>펀딩종료까지 </strong>
									</div>
									<div class="bg-light text-center" data-countdown="${fundingList.endDate}"></div>
									<script type="text/javascript">
										$(document).ready(function() {
											$('[data-countdown]').each(function() {
												var $this = $(this), finalDate = $(this).data('countdown');
												$this.countdown(finalDate,function(event) {
													$this.html(event.strftime('%D 일'));
												});
											});
										});
									</script>
									<a href="${pageContext.request.contextPath}/funding/${fundingList.code}" class="btn btn-default btn-theme-colored mt-10 font-16 btn-sm">펀딩하기
										<i class="flaticon-charity-make-a-donation font-16 ml-5"></i>
									</a>
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