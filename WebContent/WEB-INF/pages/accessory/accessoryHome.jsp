<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	* {
		margin: 0;
		padding: 0;
	}
	
	#menuContent a {
		text-decoration: none;
		color: #ffffff;
	}
	.c{
		border-style: solid;
		width:200px;
		height:130px;
		margin:4 23 0 23;
		border-radius:5;
		display:block;
		background:#fff;
		margin:10% auto;
	}
	.addAccessoryMask {
		width:100%;
		height:100%;
		position:absolute;
		background:rgba(0,0,0,.3);
		display:none;
	}
</style>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script type="text/javascript">
	function showAddAccessory(flag){
		if(flag=="true"){
			$(".addAccessoryMask").css("display","block");
		}else{
			$(".addAccessoryMask").css("display","none");
		}
	}
	
	function checkAll(obj){
		var isCheck = obj.checked;
		var checkList = document.getElementsByName("arrays");
		for(var i=0;i<checkList.length;i++){
			checkList[i].checked=isCheck;
		}
	}
	
	function deleteAccessory(){
		var myArray = new Array();
		var len = 0;
		var fruitId = document.getElementById("aFruitId").value;
		var arrays = document.getElementsByName("arrays");
		for(var i=0;i<arrays.length;i++){
			if(arrays[i].checked){
				myArray[len++] = arrays[i].value;
			}
		}
		
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/accessory/deleteList.action',
			data:{"arrays":myArray,"fruitId":fruitId},
			traditional:true,
			success:function(data){
				alert("删除成功！");
				//location.assign('${pageContext.request.contextPath}/accessory/list.action')
				location.reload();
			}
		});
	}
	
</script>
</head>
<body>
	<button onclick="showAddAccessory('true')" style="background-color: #173e65;color:#ffffff;width:70px">
		添加
	</button>
	<button onclick="deleteAccessory()" style="background-color: #173e65;color:#ffffff;width:70px">
		删除
	</button>
	<c:if test="${list!=null}">
		<table style="margin-top:10px;width:400px;text-align: center;" border=1>
			<tr>
				<th><input type="checkbox" onclick="checkAll(this)"/></th>
				<th>名称</th>
				<th>价格</th>
				<th>创建日期</th>
			</tr>
			
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td><input type="checkbox" name="arrays" value="${item.accessoryId}"/></td>
					<td>${item.name}</td><td>${item.price}</td>
					<td>${item.createTime}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<div class="addAccessoryMask">
		<div class="c">
			<div style="background-color:#173e65;height: 20px;color:#fff;font-size: 12px;padding-left:7px;">
				添加附属品信息
				<font style="float:right;padding-right:10px;" onclick="showAddAccessory('false')">x</font>
			</div>
			<form id="addAccessoryForm" action="add.action" method="post" onsubmit="checkAddAccessory()">
				名称：<input type="text" id="addAccessoryName" name="name" style="width:120px"/><br/>
				价格：<input type="number" min="0.0" step="0.01" id="addAccessoryPrice" name="price" style="width:120px"/><br/>
				<input type="hidden" id="aFruitId" name="fruitId" value="${fruitId}"/>
				<input type="submit" value="添加" style="background-color:#173e65;color:#ffffff;width:70px;"/>
			</form>
		</div>
	</div>
</body>
</html>









