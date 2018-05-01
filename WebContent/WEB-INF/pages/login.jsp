<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<link href="${pageContext.request.contextPath}/css/regcss.css"
	type="text/css" rel="stylesheet" />
<script type="text/javascript">
	function validate() {
		if (document.getElementById("username").value == "") {
			alert("用户名不能为空");
			document.getElementById("username").focus();
			return false;
		} else if (document.getElementById("password").value == "") {
			alert("密码不能为空");
			document.getElementById("password").focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div>
		<div id="form">
			<h1>用户登录</h1><br/>
			<form action="login.action" method="post" id="myform" onsubmit="return validate()">
				用户名<input type="text" name="username" id="username"
					style="width:190px;height: 26px;margin-left: 39px;"><br/>
				密码<input type="password" name="password" id="password"
					style="width:190px;height: 26px;margin-top: 8px;margin-left: 54px;"><br/>
				<input type="submit" value="登录"
					style="width: 50px;height: 30px;margin-top: 8px;" />
				<a href="registerPage.action">注册</a>
			</form>
			<!-- 显示错误信息 -->
			<c:if test="${errorMsg!=null}">
				<font color="red">${errorMsg}</font>
			</c:if>
			<!-- 显示提示 -->
			<c:if test="${noticeMsg!=null}">
				<font color="green">${noticeMsg}</font>
			</c:if>
		</div>
	</div>
</body>
</html>