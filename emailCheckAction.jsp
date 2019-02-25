<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	UserDAO userDAO = new UserDAO();
	
	// code, userID 초기화
	String code = null;
	String userID = null;
	
	if(request.getParameter("code") != null)
	{
		code = request.getParameter("code");
	}
	
	if(session.getAttribute("userID") != null)
	{
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해 주세요.');");
		script.println("history.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String userEmail = userDAO.getUserEmail(userID);
	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false; // 사용자의 메일로 받은 코드와 비교 bool
	
	if(isRight == true)
	{
		userDAO.setUserEmailChecked(userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증완료.');");
		script.println("history.href = 'index2.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	if(isRight == false)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증실패.');");
		script.println("history.href = 'index2.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
%>