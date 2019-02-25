<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.invalidate(); // 클라이어트내 모든 세션정보 파괴
%>
<script>
	location.href="index2.jsp";
</script>