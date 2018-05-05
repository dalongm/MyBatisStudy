<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
	<form action="login.action" method="post">
		账号：<input type="text" name="username"/><br/>
		密码：<input type="password" name="password"/><br/>
		<input type="submit" value="登录"/>
		
		<c:if test="${allErrors!=null}">
			<c:forEach items="${allErrors }" var="error">
				<br/><font color="red">${error.defaultMessage}</font>
			</c:forEach>
		</c:if>
		<c:if test="${errorMsg!=null}">
			<br/><font color="red">${errorMsg}</font>
		</c:if>
	</form>
</body>
</html>