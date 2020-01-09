<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<body>
		<table>
			<tr>
				<td>작성자</td>
				<td>작성일</td>
			</tr>
			<tr>
				<td colspan="2">제목</td>
			</tr>
			<tr>
				<td colspan="2">내용</td>
			</tr>
			<tr>
				<td colspan="2">답변</td>
			</tr>
			
			<c:forEach items="fundingQuestion" var="fundingQuestion">
			<tr>
				<td>${fundingQuestion.id}</td>
				<td>${fundingQuestion.regdate}</td>
			</tr>
			<tr>
				<td colspan="2">${fundingQuestion.subject}</td>
			</tr>
			<tr>
				<td colspan="2">${fundingQuestion.content}</td>
			</tr>
			<tr>
				<td colspan="2">${fundingQuestion.fundingAnswer.content}</td>
			</tr>
			</c:forEach>
		</table>
	<input type="text"><input type="button" value="답변등록"><br><br>
	<input type="button" value="리스트로 돌아가기">
</body>