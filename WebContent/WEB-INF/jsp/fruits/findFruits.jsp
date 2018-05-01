<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>水果列表</title>
</head>
<body>
	<form action="queryFruitsByCondition.action" method="post">
		名称：<input type="text" name="name"/>&nbsp;&nbsp;
		产地：<input type="text" name="producing_area"/><br/>
		<!-- 显示错误信息 -->
		<c:if test="${allErrors!=null}">
			<c:forEach items="${allErrors}" var="error">
				<font color="red">${error.defaultMessage}</font><br/>
			</c:forEach>
		</c:if>
		<input type="submit" value="搜索"/>
	</form>
	<h3>搜索结果</h3>
	<table width="300px;" border=1>
		<tr>
			<td>名称</td>
			<td>价格</td>
			<td>产地</td>
		</tr>
		<c:forEach items="${fruitsList}" var="fruit">
		<tr>
			<td>${fruit.name}</td>
			<td>${fruit.price}</td>
			<td>${fruit.producing_area}</td>
		</tr>
		</c:forEach>
	</table>
	<form action="fruitsArrayTest.action" method="post">
		<table width="300px;" border=1>
			<tr>
				<td>名称</td>
				<td>价格</td>
				<td>产地</td>
			</tr>
			<c:forEach items="${fruitsList}" var="fruit">
			<tr>
				<td><input type="checkbox" name="fids" value="${fruit.id}"/></td>
				<td>${fruit.name}</td>
				<td>${fruit.price}</td>
				<td>${fruit.producing_area}</td>
			</tr>
			</c:forEach>
		</table>
		<input type="submit" value="批量测试提交"/>
	</form>
	<form action="fruitsListTest.action" method="post">
		<table width="300px;" border=1>
			<tr>
				<td>名称</td>
				<td>价格</td>
				<td>产地</td>
			</tr>
			<c:forEach items="${fruitsList}" var="fruit" varStatus="status">
				<tr>
					<td><input name="fruitList[${status.index}].name" value="${fruit.name}"/></td>
					<td><input name="fruitList[${status.index}].price" value="${fruit.price}"/></td>
					<td><input name="fruitList[${status.index}].producing_area" value="${fruit.producing_area}"/></td>
				</tr>
			</c:forEach>
		</table><br/>
		<input type="submit" value="批量测试提交"/>
	</form>
	<form action="fruitsMapTest.action" method="post">
		<table width="300px;" border=1>
			<tr>
				<td>名称</td>
				<td>价格</td>
				<td>产地</td>
			</tr>
			<tr>
				<td><input name="fruitMap['name']" value="黑凤梨"/></td>
				<td><input name="fruitMap['price']" value="5.7"/></td>
				<td><input name="fruitMap['producing_area']" value="广州"/></td>
			</tr>
		</table><br/>
		<input type="submit" value="批量测试提交"/>
	</form>
</body>
</html>







