<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties" %>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail" %>
<%@ page import="java.io.PrintWriter"%>

<%
	UserDAO userDAO = new UserDAO();

	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 사용 가능합니다.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}

	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked == true)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증된 회원입니다.');");
		script.println("location.href='index2.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host = "http://localhost:8092/go1/";	// 웹 주소
	String from = "andrea122245@gmail.com"; // 구글이메일계정
	String to = userDAO.getUserEmail(userID);
	String subject = "강의평가를 위한 이메일 인증 메일입니다.";
	String content = "인증을 진행하시려면 다음 링크를 눌러주세요" +
	 "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
	
	//프로퍼티 값 설정
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com"); // 구글 이메일 
	p.put("mail.smtp.prot", 465); // 구글서비스에서 제공하는 기본 포트
	p.put("mail.smtp.starttls.enalbe", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", 465);	// 구글 서비스에서 제공하는 기본 포트
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
		
	//이메일 전송 부
	try
	{
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p,auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.setRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
	}catch(Exception e)
	{
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류발생!!');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>

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
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
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
		<div class="alert alert-success mt-4" role="alert">
			이메일 인증 메일 전송이 되었습니다.
		</div>
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