<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;

	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다')");
		script.println("location.href='index2.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	if(request.getParameter("userID") != null)
	{
		userID= request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null)
	{
		userPassword= request.getParameter("userPassword");
	}
	
	if(userID == null || userPassword == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이안된사항이있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword);
	if(result == 1)
	{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='index2.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	else if(result == 0)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호 오류')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	else if(result == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ID오류')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	else if(result == -2)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB오류')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>