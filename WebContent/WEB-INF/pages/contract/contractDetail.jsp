<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>合同详情</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
	function printpage(){
		document.getElementById("p").style.display="none";
		window.print();
		document.getElementById("p").style.display="block";
	}
</script>
</head>
<body>
	<h2 style="text-align: center">购销合同</h2>
	<div style="float:right;font-size:10px;">创建日期：${contract.createTime}</div>
	合同编码：<b style="color:blue">${contract.barCode}</b><br/>
	类型：<c:if test="${contract.type==0}">省内</c:if><c:if test="${contract.type==1}">省外</c:if><br/><hr/>
	<div class="info">零售商信息：<br/>
		姓名：${contract.retailer.name}<br/>
		联系电话：${contract.retailer.telephone}<br/>
		送货地址：${contract.retailer.address}<br/>
	</div><hr/>
	<div class="info">货物信息：<br/>
		<c:if test="${contract.commoditiesList!=null}">
			<table style="width:510px;text-align: center;" border=1>
				<tr>
					<th>名称</th><th>价格</th><th>产地</th><th>附属品</th><th>数量</th>
				</tr>
				<c:forEach items="${contract.commoditiesList}" var="item">
				<tr>
					<td>${item.name }</td>
					<td>${item.price }元/斤</td>
					<td>${item.locality }</td>
					<td>
						<c:if test="${item.accessoryList!=null }">
							<c:if test="${item.accessoryList[0]==null }">无</c:if>
							<c:forEach items="${item.accessoryList}" var="accessoryItem">
								${accessoryItem.name}:${accessoryItem.price}元</br>
							</c:forEach>
						</c:if>
					</td>
					<td>${item.number}斤</td>
				</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
	<button id="p" onclick="printpage()">打印</button>
</body>
</html>









