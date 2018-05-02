<%@page import="com.fruitsalesplatform.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主页</title>
<style>*{margin: 0;padding: 0;} #menuContent a{text-decoration: none; color:#ffffff;}</style>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<h3>欢迎您，${user.name}</h3>
	<%-- <%
	if(session.getAttribute("user") != null)
	{
		User user = (User)session.getAttribute("user");
		out.println("<h3>欢迎您，"+user.getName()+"</h3>");
	}
	%> --%>
</body>
</html>