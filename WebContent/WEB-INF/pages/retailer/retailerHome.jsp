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
	.mask{
		width:100%;
		height:100%;
		position:absolute;
		background:rgba(0,0,0,.3);
		display:none;
	}
</style>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script type="text/javascript">
	function changeStatus() {
		var status = document.getElementById("indexStatus").value;
		document.getElementById("status").value = status;
	}
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
	function editRetailer(id){
		var message="{'id':'"+id+"'}";
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/retailer/editRetailer.action',
			contentType:'application/json;charset=utf-8',
			data:message, // 数据格式是json
			success:function(data){
				$("#editName").val(data["name"]);
				$("#editTelephone").val(data["telephone"]);
				$("#editAddress").val(data["address"]);
				$("#retailerId").val(data["retailerId"]);
				$("#editStatus").val(data["status"]);
				$("#eStatus").val(data["status"]);
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
	
	function changeEditStatus() {
		var status = document.getElementById("eStatus").value;
		document.getElementById("editStatus").value = status;
	}
	
	function deleteRetailer(id){
		$("#dRetailerId").val(id); // 向form中引入id
		// 将分页信息引入
		$("#dStartPage").val($("#startPage").val());
		$("#dCurrentPage").val($("#currentPage").val());
		$("#dPageSize").val($("#pageSize").val());
		$("#deleteForm").submit(); // 提交表单
	}
</script>
</head>
<body onload="init()">
	<%@ include file="../menu.jsp"%><br />
	<form id="listForm" action="list.action" method="post">
		姓名：<input type="text" name="name" style="width: 120px" /> 
		手机：<input	type="text" name="telephone" style="width: 120px" /> 
		地址：<input	type="text" name="address" style="width: 120px" /><br /> <br />
		状态：<select name="indexStatus" onchange="changeStatus()">
				<option value="-1" selected="selected">全部</option>
				<option value="1">启动</option>
				<option value="0">停用</option>
			</select> 
		<input type="hidden" name="status" id="status" value="-1" /> 
		创建日期：<input type="text" name="createTime" /> 
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
	<div class="mask">
		<div class="c">
			<div style="background-color:#173e65;height: 20px;color:#fff;font-size: 12px;padding-left:7px;">
				修改信息<div style="fload:right;padding-right:10px;" onclick="cancelEdit()">x</div>
			</div>
			<form id="editForm" action="edit.action" method="post">
				姓名：<input type="text" id="editName" name="name" style="width:120px;"/><br/>
				手机：<input type="text" id="editTelephone" name="telephone" style="width:120px;"/><br/>
				地址：<input type="text" id="editAddress" name="address" style="width:120px;"/><br/>
				状态：<select id="eStatus" onchange="changeEditStatus()">
					<option value="1">启用</option>
					<option value="0">停用</option>
				</select><br/>
				<input type="hidden" name="retailerId" id="retailerId"/>
				<input type="hidden" name="status" id="editStatus"/>
				<input type="hidden" name="startPage" id="eStartPage"/>
				<input type="hidden" name="currentPage" id="eCurrentPage"/>
				<input type="hidden" name="pageSize" id="ePageSize"/>
				<input type="submit" value="提交" style="background-color: #173e65;color:#ffffff;width:70px;"/>
			</form>
		</div>
	</div>
	<hr style="margin-top: 10px;" />
	<c:if test="${list!=null}">
		<table style="margin-top: 10px; width: 700px; text-align: center;"
			border=1>
			<tr>
				<th>序号</th>
				<th>姓名</th>
				<th>手机号</th>
				<th>地址</th>
				<th>状态</th>
				<th>创建日期</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${item.name}</td>
					<td>${item.telephone}</td>
					<td>${item.address}</td>
					<td><c:if test="${item.status==1}">
							<font color="blue">启用</font>
						</c:if> <c:if test="${item.status==0}">
							<font color="red">停用</font>
						</c:if></td>
					<td>${item.createTime}</td>
					<td>
						<a onclick="editRetailer('${item.retailerId}')">编辑</a>
						<a onclick="deleteRetailer('${item.retailerId}')">删除</a>
						<form id="deleteForm" action="delete.action" method="post">
							<input type="hidden" name="retailerId" id="dRetailerId"/>
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









