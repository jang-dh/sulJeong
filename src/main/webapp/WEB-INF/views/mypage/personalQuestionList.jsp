<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h1>personalQuestionList.jsp 입니다</h1>

<c:forEach items="${list}" var="list">
 \${list.content} = ${list.content}
 \${list.subject} = ${list.subject}
 \${list.regdate} = ${list.regdate}
 \${list.state} = ${list.state}

</c:forEach>
