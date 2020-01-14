<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- 카카오 지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4c64b0fa5dfd1841cf29f48be1a0d91&libraries=services"></script>


<!-- 카카오 지도 -->

      <!-- Start main-content -->
  <div class="main-content">
  
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="${pageContext.request.contextPath}/resources/images/main/slider-main.jpg">
      <div class="container pt-90 pb-40">
        <!-- Section Content -->
        <div class="section-content">
          <div class="row"> 
            <div class="col-md-6">
              <h2 class="text-white font-36">서비스 소개</h2>
              <ol class="breadcrumb text-left mt-10 white">
                <!-- <li><a href="#"></a></li>
                <li><a href="#"></a></li>
                <li class="active"></li> -->
              </ol>
            </div>
          </div>
        </div>
      </div>      
    </section>

    <!-- Section: -->
    <section>
      <div class="container pt-70 pb-40">
        <div class="section-content">
          <div class="row">
            <div class="col-md-8">
              <h3 class="text-uppercase font-28 letter-space-3 mt-0">술:정(井)에서는 <span class="text-theme-colored">누구나</span> 투자받고 투자하면서<br> 함께 성장합니다.</h3>
              <h5 class="text-uppercase font-weight-400">사람들은 자신이 지지하는 기업에 투자합니다. 한 사람 한 사람의 투자가 모여 기업은 성장합니다.<br/>
              여기, 기업 하나가 출발선에 있습니다. 그는 자신의 가치를 증명하고 사람들이 그의 가치를 알아봅니다.<br/> 서로 지지하고 소통하고 공유하면서 더 많은 사람들이 그를 알아봅니다.
              그렇게 기업은 성장합니다.<br/> 또 다른 기업들이 용기를 얻고 출발선에 섭니다. 사람들의 지지를 받는 기업은 성장합니다.<br/>
              세상에 자신만의 가치를 품은 기업들이 많아집니다. 세상이 조금 더 나아집니다.<br/><b>와디즈에서 퍼옴</b> </h5>

            <!--   <div class="row">
                <div class="col-md-6">
                  <p>Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut mole stie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermen. </p>
                </div>
                <div class="col-md-6">
                  <p>Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut mole stie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermen. </p>
                </div>
              </div> -->
            </div>
            <div class="col-md-4">
              <div class="thumb">
                <img alt="" src="${pageContext.request.contextPath}/resources/images/introduce/Penguins.jpg" class="img-fullwidth">
              </div>
            </div>
          </div>
          
        </div>
      </div>
    </section>

    <!-- Divider: Mission -->
    <section class="divider parallax layer-overlay overlay-deep" data-bg-img="http://placehold.it/1920x1280">
      <div class="container pt-40 pb-60">
        <div class="row text-justify">
          <div class="col-md-6">
            <h3 class="line-bottom">리워드 펀딩이란?</h3>
            <p>리워드형 펀딩은 자금이 필요한 메이커가 펀딩을 통해 자금을 모집하여 제작하며 리워드가 완성되면 펀딩에 참여한 서포터에게 제공하는 방식입니다.
				메이커는 프로젝트 진행중 서포터에게 받은 피드백을 보상품 제작에 반영하거나 프로젝트 홍보에 도움을 준 서포터들을 위해 이벤트를 진행하는 등
				펀딩하는 서포터와 제품/서비스를 만드는 메이커간의 긴밀한 소통이 이루어지는 점이 특징입니다.</p>
          </div>
          <div class="col-md-6">
            <h3 class="line-bottom">전통주란?</h3>
            <p>전통주는 우리술, 한주(韓酒), 한국술 등으로 불릴 수 있는 우리 고유의 식문화입니다. 우리는 삼국, 고려, 조선시대부터 다양한 종류의 전통술을 빚어왔고, 
            	‘밥 대신 먹는다’고 할 정도로 한국인에게는 아주 뜻깊은 주류입니다. 지금 우리나라에는 2,000종이 넘는 전통주가 유통되고 있습니다. 
            	하지만 수많은 종류에도 불구하고 전통주는 아직 우리에게 친숙하지 않은 것이 현실입니다. 술에 대한 이해가 부족하면 선뜻 접근하기 힘든 우리술, 
            	그렇다 해서 모르고 놓치기엔 너무나도 맛있고, 의미 있는 술입니다. 우리나라 전통주, 이젠 술:정(井)과 함께 알아가봐요!</p>
          </div>
          <h3 class="line-bottom">술:정(井) 찾아오시는 길</h3>
          <div class="col-md-6" id="map" style="width:100%;height:350px;"></div>
          
        </div>
      </div>
    </section>

    <!-- Gallery Grid 4 -->
    <section>
      <div class="container pb-70">
        <div class="section-title text-center">
          <div class="row">
            <div class="col-md-8 col-md-offset-2">
              <h2 class="text-uppercase line-bottom-center mt-0">전통주 <span class="text-theme-colored">Gallery</span></h2>
              <div class="title-flaticon">
                <i class="flaticon-charity-alms"></i>
              </div>
            </div>
          </div>
        </div>
        <div class="section-content">
          <div class="row">
            <div class="col-md-12">
            
              <div class="gallery-isotope grid-4 gutter-small clearfix" data-lightbox="gallery">
                <!-- Portfolio Item Start -->
				<!-- 전통주 사진 뿌리기 4x3 12개 -->
                <c:forEach begin="1" end="12" var="i"> 
                <div class="gallery-item">
                  <div class="thumb">
                    <img alt="project" src="${pageContext.request.contextPath}/resources/images/introduce/liquor${(i%4)+1}.jpg" class="img-fullwidth">
                    <div class="overlay-shade"></div>
                    <div class="icons-holder">
                      <div class="icons-holder-inner">
                        <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                          <a href="${pageContext.request.contextPath}/resources/images/introduce/liquor${(i%4)+1}.jpg"  data-lightbox-gallery="gallery"><i class="fa fa-picture-o"></i></a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                
                
                </c:forEach>
                <!-- Portfolio Item End -->

              </div>
              <!-- End Portfolio Gallery Grid -->
                          
            </div>
          </div>
        </div>
      </div>
    </section>  
    
<script>
         var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
             mapOption = {
                 center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                 level: 3 // 지도의 확대 레벨
             };  
         
         // 지도를 생성합니다    
         var map = new kakao.maps.Map(mapContainer, mapOption); 
         
         // 주소-좌표 변환 객체를 생성합니다
         var geocoder = new kakao.maps.services.Geocoder();
         
         // 주소로 좌표를 검색합니다 ${requestScope.gym.addr}
         geocoder.addressSearch('삼평동 대왕판교로 670', function(result, status) {
         
             // 정상적으로 검색이 완료됐으면 
              if (status === kakao.maps.services.Status.OK) {
         
                 var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
         
                 // 결과값으로 받은 위치를 마커로 표시합니다
                 var marker = new kakao.maps.Marker({
                     map: map,
                     position: coords
                 });
         
                 // 인포윈도우로 장소에 대한 설명을 표시합니다
                 var infowindow = new kakao.maps.InfoWindow({
                     content: '<div style="width:150px;text-align:center;padding:6px 0;">술:정(井)</div>'
                 });
                 infowindow.open(map, marker);
         
                 // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                 map.setCenter(coords);
             } 
         });    
</script>

  </div>
  <!-- end main-content -->
