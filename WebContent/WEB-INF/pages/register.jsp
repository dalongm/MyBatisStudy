<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
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
		}else if (document.getElementById("password").value !=document.getElementById("password2").value) {
			alert("两次密码不一致");
			document.getElementById("password2").focus();
			return false;
		}else if (document.getElementById("name").value == "") {
			alert("姓名不能为空");
			document.getElementById("name").focus();
			return false;
		}else if (document.getElementById("telephone").value == ""||
				!(/^1[34578]\d{9}$/.test(document.getElementById("telephone").value))) {
			alert("手机号格式有误");
			document.getElementById("telephone").focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div id="content">
		<div id="form">
			<h1>用户注册</h1><br/>
			<form action="register.action" method="post" id="myform" onsubmit="return validate()">
				用户名<input type="text" name="username" id="username"
					style="width:190px;height: 26px;margin-left: 39px;"><br/>
				密码<input type="password" name="password" id="password"
					style="width:190px;height: 26px;margin-top: 8px;margin-left: 54px;"><br/>
				密码验证<input type="password" name="password2" id="password2"
					style="width:190px;height: 26px;margin-top: 8px;margin-left: 54px;"><br/>
				姓名<input type="text" name="name" id="name"
					style="width:190px;height: 26px;margin-top: 8px;margin-left: 54px;"><br/>
				手机号<input type="text" name="telephone" id="telephone"
					style="width:190px;height: 26px;margin-top: 8px;margin-left: 54px;"><br/>
				<input type="submit" value="注册"
					style="width: 50px;height: 30px;margin-top: 8px;" />
				<a href="toLogin.action">返回登录</a>
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