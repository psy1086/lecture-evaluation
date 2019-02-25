<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>강의평가</title>
	<!-- 부트스트랩 CSS 추가 -->
	<link rel="stylesheet" href="./css/bootstrap.css">
</head>
<body>
<%
	String userID = null;

	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인')");
		script.println("location.href='index2.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>  
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index2.jsp">강의평가 웹 사이트</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
				<span class="navbar-toggler-icon"></span>
			</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index2.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원관리</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null)
	{
%>						
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	}
	else
	{
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./index2.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" class="form-control mr-sm-2" name="search" placeholder="내용을 입력하세요">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	
	<section class="container mt-3" style="max-width:560px;">
		<div class="alert alert-warning mt-4" role="alrer">
			이메일 주소 인증을 하셔야 합니다. 메일 인증을 하시겠습니까?
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">인증</a>
	</section>
	
	
	
	<footer class="bg-dark mt-4 p-5 text-conter" style="color:#FFFFFF;">
		Copyright &copy; 2018 Park
	</footer>
	<!-- 제이쿼리 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- popper 추가 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 추가 -->

	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>