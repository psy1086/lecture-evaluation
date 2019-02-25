<%@page import="likey.LikeyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="java.io.PrintWriter"%>

<%!
	public static String getCilentIP(HttpServletRequest request) // 사용자의 IP 주소 확인 함수
	{
		String ip = request.getHeader("X-FORWARDED-FOR");		//기본  ip확인
		if(ip == null || ip.length()== 0)
		{
			ip = request.getHeader("Proxy-Clinet-IP");			//프록시 확인
		}
		if(ip == null || ip.length()== 0)
		{
			ip = request.getHeader("WL-Proxy-Clinet-IP");		// WL확인
		}
		if(ip == null || ip.length()== 0)
		{
			ip = request.getRemoteAddr();						//request내 명령어, 주소가져오기
		}
		return ip;
	
	}
%>

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
	String evaluationID = null;
	String reportContent = null;	
	if(request.getParameter("evaluationID") != null)
	{
		evaluationID = request.getParameter("evaluationID");
	}

	EvaluationDAO evaluationDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userID, evaluationID, getCilentIP(request));
	System.out.println(result);
	if(result == 1)
	{
		result = evaluationDAO.like(evaluationID);
		if(result == 1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천완료.');");
			script.println("location.href='index2.jsp'");
			script.println("</script>");
			script.close();
			return;
		}else
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
		script.println("alert('이미 추천한 글입니다.");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}

%>