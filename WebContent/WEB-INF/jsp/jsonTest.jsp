<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Json Test</title>
</head>
<body>
	<textarea id="jsonMsg" rows="5" cols="30" placeholder="请输入json格式信息" ></textarea>
	<br/>
	<button onclick="submitMsg()">发送</button>
</body>
<!-- <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script> -->
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
	function submitMsg(){
		var message=$("#jsonMsg").val();
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/jsonTest.action',
			contentType:'application/json;charset=utf-8',
			data:message,
			success:function(data){
				alert("username="+data["username"]+",password="+data["password"]);
			},error:function(data){
				alert("failed");
			}
			
		});
	}
	
</script>
</html>