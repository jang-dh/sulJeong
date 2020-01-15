<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html dir="ltr" lang="en">
<!-- -----카카오----- -->
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>



<!-- -----카카오----- -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#logout").click(function(){
			$("#logoutSubmit").submit();
		});
	});

</script>

<head>
<sec:authentication var="principal" property="principal" />
    <!-- Meta Tags -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="description" content="HelpingPro - Nonprofit, Crowdfunding & Charity HTML5 Template" />
    <meta name="keywords" content="charity,crowdfunding,nonprofit,orphan,Poor,funding,fundrising,ngo,children" />
    <meta name="author" content="ThemeMascot" />

    <!-- Page Title -->
    <title>술:정(井)</title>

    <!-- Favicon and Touch Icons -->
    <link href="${pageContext.request.contextPath}/resources/images/favicon.png" rel="shortcut icon" type="image/png">
    <link href="${pageContext.request.contextPath}/resources/images/apple-touch-icon.png" rel="apple-touch-icon">
    <link href="${pageContext.request.contextPath}/resources/images/apple-touch-icon-72x72.png" rel="apple-touch-icon"
        sizes="72x72">
    <link href="${pageContext.request.contextPath}/resources/images/apple-touch-icon-114x114.png" rel="apple-touch-icon"
        sizes="114x114">
    <link href="${pageContext.request.contextPath}/resources/images/apple-touch-icon-144x144.png" rel="apple-touch-icon"
        sizes="144x144">

    <!-- Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/css-plugin-collections.css" rel="stylesheet" />
    <!-- CSS | menuzord megamenu skins -->
    <link id="menuzord-menu-skins"
        href="${pageContext.request.contextPath}/resources/css/menuzord-skins/menuzord-rounded-boxed.css"
        rel="stylesheet" />
    <!-- CSS | Main style file -->
    <link href="${pageContext.request.contextPath}/resources/css/style-main.css" rel="stylesheet" type="text/css">
    <!-- CSS | Preloader Styles -->
    <link href="${pageContext.request.contextPath}/resources/css/preloader.css" rel="stylesheet" type="text/css">
    <!-- CSS | Custom Margin Padding Collection -->
    <link href="${pageContext.request.contextPath}/resources/css/custom-bootstrap-margin-padding.css" rel="stylesheet"
        type="text/css">
    <!-- CSS | Responsive media queries -->
    <link href="${pageContext.request.contextPath}/resources/css/responsive.css" rel="stylesheet" type="text/css">
    <!-- CSS | Style css. This is the file where you can place your own custom css code. Just uncomment it and use it. -->
    <!-- <link href="css/style.css" rel="stylesheet" type="text/css"> -->

    <!-- CSS | Theme Color -->
    <link href="${pageContext.request.contextPath}/resources/css/colors/theme-skin-red.css" rel="stylesheet"
        type="text/css">

    <!-- external javascripts -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/chart.js"></script>
    <!-- JS | jquery plugin collection for this theme -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-plugin-collection.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body class="">
    <div id="wrapper">
        <!-- preloader -->
        <div id="preloader">
            <div id="spinner">
                <img class="floating" src="${pageContext.request.contextPath}/resources/images/preloaders/13.png"
                    alt="">
                <h5 class="line-height-50 font-18 ml-15">Loading...</h5>
            </div>
            <div id="disable-preloader" class="btn btn-default btn-sm">Disable Preloader</div>
        </div>

        <!-- Header -->
        <header id="header" class="header">
            <div class="header-nav">
                <div class="header-nav-wrapper navbar-scrolltofixed bg-lightest">
                    <div class="container">
                        <nav id="menuzord-right" class="menuzord default bg-lightest">
                            <a class="menuzord-brand pull-left flip xs-pull-center mt-20 pt-5 mt-sm-10 pt-sm-0"
                                href="${pageContext.request.contextPath}">
                                <img src="${pageContext.request.contextPath}/resources/images/logo-wide.png" alt="">
                            </a>
                            <ul class="menuzord-menu">
                            <!-- ---카카오---- -->
								<li>
									<div id="kakao-add-channel-button"></div>
									<script type='text/javascript'>
									  //<![CDATA[
									    // 사용할 앱의 JavaScript 키를 설정해 주세요.
									    Kakao.init('c4c64b0fa5dfd1841cf29f48be1a0d91');
									    // 카카오톡 채널 추가 버튼을 생성합니다.
									    Kakao.Channel.createAddChannelButton({
									      container: '#kakao-add-channel-button',
									      channelPublicId: '_RgGlxb' // 채널 홈 URL에 명시된 id로 설정합니다.
									    });
									  //]]>
									</script>
								</li>
                             <!-- ---카카오---- -->
                                <li>
                                    <a href="${pageContext.request.contextPath}/funding">펀딩</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/introduce">서비스 소개</a>
                                </li>
                                <li>

                                    <a id="a" href="${pageContext.request.contextPath}/notice">공지사항</a>

                                    <c:if test="${empty pageContext.request.userPrincipal}">
	                                <li><a href="${pageContext.request.contextPath}/login">로그인</a>
	                                </li>
	                                <li><a href="${pageContext.request.contextPath}/join">회원가입</a>
                                    </li>
	                                </c:if>
	                                <c:if test="${not empty pageContext.request.userPrincipal}">


                                <li>
                                    <a class="icon icon-dark icon-bordered icon-circled icon-border-effect effect-circled"
                                        href="#">
                                        <i class="fa fa-user"></i>
                                    </a>
                                    <div class="megamenu" style="width:fit-content; left:auto;">
                                        <div class="megamenu-row">

                                            <h3><a href="${pageContext.request.contextPath}/mypage/myInfoMenu">${principal.name}님 ></a></h3>

                                        </div>
                                        <div class="megamenu-row">
                                            <div class="col4">
                                                <div class="icon-box" style="margin-bottom:0px;">
                                                    <a class="icon" href="${pageContext.request.contextPath}/mypage/fundingHistory" style="margin-bottom:0px;">
                                                        <i class="fa fa-diamond"></i>
                                                    </a>
                                                    <h5 class="icon-box-title">펀딩내역</h5>
                                                </div>
                                            </div>
                                            <div class="col4">
                                                <div class="icon-box" style="margin-bottom:0px;">
                                                    <a class="icon" href="${pageContext.request.contextPath}/mypage/likes" style="margin-bottom:0px;">
                                                        <i class="fa fa-heart faa-pulse animated-hover"></i>
                                                    </a>
                                                    <h5 class="icon-box-title">좋아요</h5>
                                                </div>
                                            </div>
                                            <div class="col4">
                                                <div class="icon-box" style="margin-bottom:0px;">
                                                    <a class="icon" href="${pageContext.request.contextPath}/mypage/myOpenFunding" style="margin-bottom:0px;">
                                                        <i class="fa fa-heart"></i>
                                                    </a>
                                                    <h5 class="icon-box-title">내가 만든 펀딩</h5>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="megamenu-row">
                                        	<div class="col4">
                                                <div class="icon-box" style="margin-bottom:0px;">
                                                    <a class="icon" href="${pageContext.request.contextPath}/mypage/fundingQuestion" style="margin-bottom:0px;">
                                                        <i class="fa fa-comments"></i>
                                                    </a>
                                                    <h5 class="icon-box-title">펀딩문의</h5>
                                                </div>
                                            </div>
                                            <div class="col4">
                                                <div class="icon-box" style="margin-bottom:0px;">
                                                    <a class="icon" href="${pageContext.request.contextPath}/mypage/myQuestion" style="margin-bottom:0px;">
                                                        <i class="fa fa-envelope faa-horizontal animated-hover"></i>
                                                    </a>
                                                    <h5 class="icon-box-title"> 1:1 문의</h5>
                                                </div>
                                            </div>
                                            <!-- 관리자 권한이 있을 때만 보임 -->
                                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                            <div class="col4">
                                                <div class="icon-box" style="margin-bottom:0px;">
                                                    <a class="icon" href="${pageContext.request.contextPath}/admin/siteManagement" style="margin-bottom:0px;">
                                                        <i class="fa fa-cog"></i>
                                                    </a>
                                                    <h5 class="icon-box-title">&nbsp;&nbsp;관리자</h5>
                                                </div>
                                            </div>
                                            </sec:authorize>
                                        </div>
                                        
    	
    
                                        <div class="megamenu-row">
                                       	 <form id="logoutSubmit" action="${pageContext.request.contextPath}/logout" method="post">
                                       	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <input type="button" class="btn" id="logout" value="로그아웃"/>
                                         </form>
                                        </div>
                                    </div>
                                </li>
								</c:if>
                                <li><a href="${pageContext.request.contextPath}/fundingOpenRequest" style="padding:0px;"><button
                                            class="btn btn-border btn-theme-colored btn-lg">펀딩 오픈 신청하기</button></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            
        </header>