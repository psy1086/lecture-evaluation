<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="boder.BoderDTO" %>
<%@ page import="boder.BoderDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
	request.setCharacterEncoding("UTF-8");
	String boderhead = "전체";
	String search = "";
	int pageNumber = 0;
	
	if(request.getParameter("boderhead")!= null)
	{
		boderhead = request.getParameter("boderhead");
	}
	if(request.getParameter("search")!= null)
	{
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber")!= null)
	{
		try
		{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));	
		}catch(Exception e)
		{
			System.out.println("검색페이지 오류");
		}
		
	}
	
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
		script.println("location.href='userLogin.jsp';");
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
					<a class="nav-link" href="index2.jsp">Main</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">Menu</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null)
	{
%>						
						<a class="dropdown-item" href="userLogin.jsp">Login</a>
<%
	}
	else
	{
%>
						<a class="dropdown-item" href="userLogoutAction.jsp">Logout</a>
						<a class="dropdown-item" href="main.jsp">Boder</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./main.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" class="form-control mr-sm-2" name="search" placeholder="내용을 입력하세요">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	
	<section class="container">
		<form method="get" action="./main.jsp" class="form-inline mt-3">
			<select name="boderhead" class="form-control mx-1 mt-2"> <!-- 말머리 -->
				<option value="전체">전체</option>
				<option value="전공" <% if(boderhead.equals("전공")) out.println("selected"); %>>전공</option>
				<option value="교양" <% if(boderhead.equals("교양")) out.println("selected"); %>>교양</option>
				<option value="기타" <% if(boderhead.equals("기타")) out.println("selected"); %>>기타</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을입력하세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>	
<%
	ArrayList<BoderDTO> boderList = new ArrayList<BoderDTO>();
	boderList = new BoderDAO().getList(boderhead, search, pageNumber);
	if(boderList != null)
		for(int i = 0; i < boderList.size(); i++)
		{
			if(i == 5) break;
			BoderDTO boder = boderList.get(i);		
%>
		<div class="card dg-light mt-3">
			<div class="cadr-header bg-light">
				<div class="row">
					<div class="col-8 text-left">말머리 : &nbsp;<small><%= boder.getBoderhead() %></small></div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="cadr-title">
					<%= boder.getBodertitle() %>
				</h5>
				<p class="card-text"><%= boder.getBodercontent() %></p>
				<div class="row">
				<div class="col-9 text-left">
						
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('삭제하시겠습니까?')" href="./boderdeleteAction.jsp?boderID=<%= boder.getBoderID() %>">삭제</a>
					</div>
				</div>
			</div>
		</div>
<% }
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<!--  이전 -->
		<li class="page-item"> 	
<%
	if(pageNumber <= 0)
	{
%>
			<a class="page-link disabled">이전</a>
<%
	} else {	
%>
			<a class="page-link" href="./main.jsp?boderhead=<%= URLEncoder.encode(boderhead,"UTF-8")%>
			&search=<%= URLEncoder.encode(search,"UTF-8") %>
			&pageNumber=<%= pageNumber - 1%>">이전</a> 
<%
	}
%>
		</li>
		<!--  다음 -->
		<li>
		
<%
	if(boderList.size() < 6)
	{
%>
			<a class="page-link disabled">다음</a>
<%
	} else {	
%>
			<a class="page-link" href="./main.jsp?boderhead=<%= URLEncoder.encode(boderhead,"UTF-8")%>
			&search=<%= URLEncoder.encode(search,"UTF-8") %>
			&pageNumber=<%= pageNumber + 1%>">다음</a> 
<%
	}
%>
		</li>
	</ul>
	
	<!-- 등록하기 -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="modal" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">게시글 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="ture">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./boderRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>제목</label>
								<input type="text" name="bodertitle" class="form-control" maxlength="40">
							</div>
							<div class="form-group col-sm-6">
								<label>말머리</label>
								<select name="boderhead" class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="bodercontent" class="form-control" maxlength="2000" style="height:180px;">
							</textarea>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">등록</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 신고하기 -->	
	<div class="modal fade" id="reportModal" tabindex="-1" role="modal" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="ture">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2000" style="height:180px;">
							</textarea>
						</div>			
						<div class="modal-footer">
							<button type="submit" class="btn btn-danger">등록</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
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