<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>零售商管理</title>
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
	.mask, .addMask{
		width:100%;
		height:100%;
		position:absolute;
		background:rgba(0,0,0,.3);
		display:none;
	}
</style>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script type="text/javascript">
	function init() {
		var countNumber = document.getElementById("countNumber").value;
		var sumPage = document.getElementById("sumPageNumber").value;
		var currentPage = document.getElementById("currentPage").value;
		var info="一共<font color='blue'>"+countNumber+"</font>条数据，"+
		"共<font color='blue'>"+sumPage+"</font>页，"+
		"当前第<font color='blue'>"+currentPage+"</font>页";
		document.getElementById("pageInfo").innerHTML=info;
	}
	function toPrePage(){
		var currentPageObject = document.getElementById("currentPage");
		var currentPage = parseInt(currentPageObject.value);
		if(currentPage==1){
			alert("数据已到顶！");
		}else{
			currentPageObject.value = currentPage -1;
			var pageSize= parseInt(document.getElementById("pageSize").value);
			var startPageObject = document.getElementById("startPage");
			startPageObject.value = parseInt(startPageObject.value)-pageSize;
			document.getElementById("listForm").submit();
		}
	}
	function toNextPage(){
		var currentPageObject = document.getElementById("currentPage");
		var currentPage = parseInt(currentPageObject.value);
		var sumPage = parseInt(document.getElementById("sumPageNumber").value)
		if(currentPage>=sumPage){
			alert("数据已到底！");
		}else{
			currentPageObject.value = currentPage + 1;
			var pageSize= parseInt(document.getElementById("pageSize").value);
			var startPageObject = document.getElementById("startPage");
			startPageObject.value = parseInt(startPageObject.value)+pageSize;
			document.getElementById("listForm").submit();
		}
	}
	function toLocationPage(){
		var pageNumber = document.getElementById("pageNumber").value;
		var currentPageObject = document.getElementById("currentPage");
		var currentPage = parseInt(currentPageObject.value);
		if(pageNumber==null||pageNumber==""){
			alert("请输入要跳转的页数！");
		}
		else{
			pageNumber=parseInt(pageNumber);
			var sumPage=parseInt(document.getElementById("sumPageNumber").value);
			if(pageNumber<1){
				alert("数据已到顶！");
			}else if(pageNumber>sumPage)
			{
				alert("数据已到底！");
			}
			else{
				currentPageObject.value = pageNumber;
				var pageSize = parseInt(document.getElementById("pageSize").value);
				var startPageObject=document.getElementById("startPage");
				if(pageNumber>currentPage){
					startPageObject.value=parseInt(startPageObject.value)+pageSize;
				}else if(pageNumber<currentPage){
					startPageObject.value=parseInt(startPageObject.value)-pageSize;
				}
				document.getElementById("listForm").submit();
			}
		}
		
	}
	
	function editCommodities(id){
		var message="{'id':'"+id+"'}";
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/commodities/editCommodities.action',
			contentType:'application/json;charset=utf-8',
			data:message, // 数据格式是json
			success:function(data){
				$("#editName").val(data["name"]);
				$("#editPrice").val(data["price"]);
				$("#editLocality").val(data["locality"]);
				$("#fruitId").val(data["fruitId"]);
				// 显示弹出框
				$(".mask").css("display","block");
				$("#eStartPage").val($("#startPage").val());
				$("#eCurrentPage").val($("#currentPage").val());
				$("#ePageSize").val($("#pageSize").val());
			}
		})
	}
	
	function cancelEdit(){
		$(".mask").css("display","none");
	}
	
	function deleteCommodities(id){
		$("#dFruitId").val(id); // 向form中引入id
		// 将分页信息引入
		$("#dStartPage").val($("#startPage").val());
		$("#dCurrentPage").val($("#currentPage").val());
		$("#dPageSize").val($("#pageSize").val());
		$("#deleteForm").submit(); // 提交表单
	}
	
	function showAddMask(flag){
		if(flag=="true"){
			$(".addMask").css("display","block");
		}else{
			$(".addMask").css("display","none");
		}
	}
	
</script>
</head>
<body onload="init()">
	<%@ include file="../menu.jsp"%><br />
	<form id="listForm" action="list.action" method="post">
		名称：<input type="text" name="name" style="width: 120px" value="${commodities.name }" /> 
		产地：<input	type="text" name="locality" style="width: 120px" value="${commodities.locality }" /> 
		价格：<input	type="number" name="startPrice" id="price1" min="0.0" step="0.1" value="${startPrice}" />
			- <input	type="number" name="endPrice" id="price2" min="0.0" step="0.1" value="${endPrice}" /><br/><br/>
		创建日期：<input type="datetime-local" name="startTime" value="${startTime}" /> 
			   - <input type="datetime-local" name="endTime" value="${endTime}" /> 
				<input type="submit" value="搜索" style="background-color: #173e65; color: #ffffff; width: 70px;"><br />

		<!-- 显示错误信息 -->
		<c:if test="${errorMsg}">
			<font color="red">${errorMsg}</font>
			<br />
		</c:if>
		<input type="hidden" name="startPage" id="startPage" value="${startPage}" /> 
		<input type="hidden" name="currentPage"	id="currentPage" value="${currentPage}" /> 
		<input type="hidden" name="pageSize" id="pageSize" value="${pageSize}" /> 
		<input type="hidden" name="sumPageNumber" id="sumPageNumber" value="${sumPageNumber}" /> 
		<input type="hidden" name="countNumber"	id="countNumber" value="${countNumber}" />
		
	</form>
	
	<div class="addMask">
		<div class="c">
			<div style="background-color:#173e65;height: 20px;color:#fff;font-size: 12px;padding-left:7px;">
				添加信息<font style="float:right;padding-right:10px;" onclick="showAddMask('false')">x</font>
			</div>
			<form id="addForm" action="add.action" method="post">
				名称：<input type="text" id="addName" name="name" style="width:120px;"/><br/>
				价格：<input type="number" id="addPrice" name="price" min="0.0" step="0.01" style="width:120px;"/><br/>
				产地：<input type="text" id="addLocality" name="locality" style="width:120px;"/><br/>
				<input type="submit" value="添加" style="background-color: #173e65;color:#ffffff;width:70px;"/>
			</form>
		</div>
	</div>
	<div class="mask">
		<div class="c">
			<div style="background-color:#173e65;height: 20px;color:#fff;font-size: 12px;padding-left:7px;">
				修改信息<font style="float:right;padding-right:10px;" onclick="cancelEdit()">x</font>
			</div>
			<form id="editForm" action="edit.action" method="post">
				名称：<input type="text" id="editName" name="name" style="width:120px;"/><br/>
				价格：<input type="number" id="editPrice" name="price" min="0.0" step="0.01" style="width:120px;"/><br/>
				产地：<input type="text" id="editLocality" name="locality" style="width:120px;"/><br/>
				<input type="hidden" name="fruitId" id="fruitId"/>
				<input type="hidden" name="status" id="editStatus"/>
				<input type="hidden" name="startPage" id="eStartPage"/>
				<input type="hidden" name="currentPage" id="eCurrentPage"/>
				<input type="hidden" name="pageSize" id="ePageSize"/>
				<input type="submit" value="提交" style="background-color: #173e65;color:#ffffff;width:70px;"/>
			</form>
		</div>
	</div>
	<hr style="margin-top: 10px;" />
	
	<button onclick="showAddMask('true')" style="background-color:#173e65;color:#ffffff;width:70px;">添加</button>
	
	<c:if test="${list!=null}">
		<table style="margin-top: 10px; width: 700px; text-align: center;"
			border=1>
			<tr>
				<th>序号</th>
				<th>名称</th>
				<th>价格</th>
				<th>产地</th>
				<th>创建日期</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${item.name}</td>
					<td>${item.price}</td>
					<td>${item.locality}</td>
					<td>${item.createTime}</td>
					<td>
						<a onclick="editCommodities('${item.fruitId}')">编辑</a>
						<a onclick="deleteCommodities('${item.fruitId}')">删除</a>
						<form id="deleteForm" action="delete.action" method="post">
							<input type="hidden" name="fruitId" id="dFruitId"/>
							<input type="hidden" name="startPage" id="dStartPage"/>
							<input type="hidden" name="currentPage" id="dCurrentPage"/>
							<input type="hidden" name="pageSize" id="dPageSize"/>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	
	<c:if test="${list==null}">
		<b>搜索结果为空！</b>
	</c:if>
	<div style="margin-top: 10px;">
		<a onclick="toPrePage()">上一页</a>
		<a onclick="toNextPage()">下一页</a> 
		<input type="text" id="pageNumber" style="width: 50px;" />
		<button onclick="toLocationPage()">go</button>
		<div id="pageInfo"></div>
	</div>
</body>
</html>









