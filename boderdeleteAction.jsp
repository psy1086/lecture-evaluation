<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="boder.BoderDAO" %>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="java.io.PrintWriter"%>

<%
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
	
	request.setCharacterEncoding("UTF-8");
	String boderID = null;	
	if(request.getParameter("boderID") != null)
	{
		boderID = request.getParameter("boderID");
	}

	BoderDAO boderDAO = new BoderDAO();
	
	if(userID.equals(boderDAO.getUserID(boderID)))
	{
		int result = new BoderDAO().delete(boderID);
		if(result == 1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제완료.');");
			script.println("location.href='main.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		else
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류!!!');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}
	}else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('작성자만 삭제 가능합니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
%>