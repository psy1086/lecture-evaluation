<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boder.BoderDTO"%>
<%@ page import="boder.BoderDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
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

	String bodertitle = null;
	String boderhead = null;
	String bodercontent = null;
	
	if(request.getParameter("bodertitle") != null)
	{
		bodertitle= request.getParameter("bodertitle");
	}
	if(request.getParameter("boderhead") != null)
	{
		boderhead= request.getParameter("boderhead");
	}
	if(request.getParameter("bodercontent") != null)
	{
		bodercontent= request.getParameter("bodercontent");
	}
	System.out.println(bodertitle);
	System.out.println(boderhead);
	System.out.println(bodercontent);
	
	if(bodertitle == null || boderhead == null || bodercontent == null  || bodertitle.equals("") || bodercontent.equals(""))
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이안된사항이있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	BoderDAO boderDAO = new BoderDAO();
	int res = boderDAO.write(new BoderDTO(0, userID, bodertitle, boderhead, bodercontent));
	if(res == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록실패.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='main.jsp'");
		//script.println("location.href='emailSendAction.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>