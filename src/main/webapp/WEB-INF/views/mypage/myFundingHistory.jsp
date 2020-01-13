<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">

	$(function(){
		$("input[value=후원취소]").click(function(){
			$("#deleteForm").attr("action", "${pageContext.request.contextPath}/purchase/delete");
			$("#deleteForm").submit();
		})
	})
</script>
  <!-- Start main-content-->
  <div class="main-content">
    <!-- Section: inner-header -->
    <section class="inner-header divider layer-overlay overlay-dark-8" data-bg-img="http://placehold.it/1920x1280">
      <div class="container pt-90 pb-40">
        <!-- Section Content -->
        <div class="section-conte<nt">
          <div class="row"> 
            <div class="col-md-6">
              <h2 class="text-white font-36">펀딩 내역</h2>
              <ol class="breadcrumb text-left mt-10 white">
                <li><a href="${pageContext.request.contextPath}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}">Pages</a></li>
                <li class="active">Funding Cart</li>
              </ol>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="container pt-70 pb-40">
        <div class="section-content">
          <div class="row">
            <div class="col-md-10 col-md-offset-1">
              <table class="table table-striped table-bordered tbl-shopping-cart">
                <thead>
                  <tr>
                    <th>펀딩일자</th>
                    <th>펀딩 명칭</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>합계</th>
                    <th>주문상세</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="purchase" varStatus="status">
                  <tr class="cart_item">
                    <td class="product-thumbnail"><a href="#">${purchase.purchaseDate} <img alt="member" src="http://placehold.it/320x360"></a></td>
                    <td class="product-name"><a class="text-theme-colored" href="#">${funding_Code}</a>
                      <ul class="variation">
                        <li class="product-title">${funding.title}<span>${funding.title}</span></li>
                      </ul></td>
                    <td class="product-price"><span class="amount"><fmt:formatNumber>${purchase.price}</fmt:formatNumber>원</span></td>
                    <td class="product-quantity"><!-- <div class="quantity buttons_added"> -->
                    	${purchase.qty}개
                        <!-- <input type="button" class="minus" value="-">
                        <input type="number" size="4" class="input-text qty text" title="Qty" value="1" name="quantity" min="1" step="1">
                        <input type="button" class="plus" value="+"> -->
                      <!-- </div> --></td>
                    <td class="product-subtotal"><span class="amount"><fmt:formatNumber>${purchase.price * purchase.qty}</fmt:formatNumber>원</span></td>
                    <td>
	                    <form name="deleteForm" method="post" id="deleteForm">
	                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                    	<input type="hidden" name="code" value="${purchase.code}">
	                    	<input type="button" class="remove" value="후원취소">
	                    </form>
	                    <ul>
	                    	<li class="deliver">택배 회사 : ${purchase.deliveryNumber }</li>
	                    	<li class="courier">송장 번호 : ${purchase.courier }</li>
	                    </ul>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
            <div class="col-md-10 col-md-offset-1 mt-30">
              <div class="row">
                <div class="col-md-6">
                  <h4>받는사람 정보</h4>
                  <form class="form" action="#">
                    <table class="table no-border">
                      <tbody>
                        <tr>
                          <td><select class="form-control">
                              <option>Select Country</option>
                              <option>Australia</option>
                              <option>UK</option>
                              <option>USA</option>
                            </select></td>
                        </tr>
                        <tr>
                          <td><input type="text" class="form-control" placeholder="State/country" value=""></td>
                        </tr>	
                        <tr>
                          <td><input type="text" class="form-control" placeholder="Postcod/zip" value=""></td>
                        </tr>
                        <tr>
                          <td><button type="button" class="btn btn-default">Update Totals</button></td>
                        </tr>
                      </tbody>
                    </table>
                  </form>
                </div>
                <div class="col-md-6">
                  <h4>후원 금액 총계</h4>
                  <table class="table table-bordered">
                    <tbody>
                      <tr>
                        <td>Cart Subtotal</td>
                        <td>$180.00</td>
                      </tr>
                      <tr>
                        <td>Shipping and Handling</td>
                        <td>$70.00</td>
                      </tr>
                      <tr>
                        <td>Order Total</td>
                        <td>$250.00</td>
                      </tr>
                    </tbody>
                  </table>
                  <a class="btn btn-default">Proceed to Checkout</a> </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  <!-- end main-content -->

  </div>
  
 