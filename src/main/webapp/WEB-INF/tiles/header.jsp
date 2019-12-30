<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Shopping</title>
<link rel="StyleSheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<div class="navbar navbar-default">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="${pageContext.request.contextPath}">Home</a>
  </div>
  <div class="navbar-collapse collapse navbar-responsive-collapse">
    <ul class="nav navbar-nav">
     
      <li><a href="${pageContext.request.contextPath}/user/login">Login</a></li>
      <li><a href="${pageContext.request.contextPath}/board/list">Board</a></li>
     </ul>
     <c:if test="${sessionScope.loginUser != null}">
     <ul class="nav navbar-nav navbar-right">
     	<li class="active"><a href="#">${loginUser}!</a></li>
      	<li><a href="${pageContext.request.contextPath}/user/logout" class="btn btn-danger">Logout</a></li>
     </ul>
     </c:if>
  </div>
</div>



