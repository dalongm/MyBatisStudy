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
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
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
	
	
	function addContract(){
		var url="${pageContext.request.contextPath}/contract/toAddPage.action";
		window.open(url,"创建合同","height=700,width=700,scrollbars=yes");
	}
	
	
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
		if(len==0){
			alert("请选择附属品！");
			return;
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
	
	function submitform(id){
		$.ajax({  
            type: "POST",   //提交的方法
            url:"add.action", //提交的地址  
            data:$('#addAccessoryForm').serialize(),// 序列化表单值  
            async: false,  
            error: function(request) {  //失败的话
                 alert("Connection error");  
            },  
            success: function(data) {  //成功
                 //alert(data);  //就将返回的数据显示出来
                 //var url="${pageContext.request.contextPath}/accessory/list.action?fruitId="+id;
                 window.location.href="list.action?fruitId="+id; 
            }  
         });
	}
	
	function getContractDetail(id){
		var url = "${pageContext.request.contextPath}/contract/getContractDetail.action?contractId="+id;
		window.open(url,"合同详情","height=700,width=700,scrollbars=yes");
	}
	
	function editContract(id){
		var url = "${pageContext.request.contextPath}/contract/editContract.action?contractId="+id;
		window.open(url,"合同详情","height=700,width=700,scrollbars=yes");
	}
	
	function deleteContract(contractId, barCode){
		if(window.confirm("你确定要删除编号为"+barCode+"的合同信息吗？")){
			$("#dContractId").val(contractId);
			$("#dStartPage").val($("#startPage").val());
			$("#dCurrentPage").val($("#currentPage").val());
			$("#dPageSize").val($("#pageSize").val());
			// $("#deleteForm").submit(); // 提交表单
			// window.location.href="list.action?type=-1"; 
			// 使用ajax提交表单，防止刷新重复提交
			$.ajax({  
	            type: "POST",   //提交的方法
	            url:"delete.action", //提交的地址  
	            data:$('#deleteForm').serialize(),// 序列化表单值  
	            async: false,  
	            error: function(request) {  //失败的话
	                 alert("Connection error");  
	            },  
	            success: function(data) {  //成功
	                 //alert(data);  //就将返回的数据显示出来
	                 //var url="${pageContext.request.contextPath}/accessory/list.action?fruitId="+id;
	                 window.location.href="list.action?type=-1"; 
	            }  
	         }); 
		}
	}
	
</script>
</head>
<body onload="init()">
	<%@ include file="../menu.jsp" %><br/>
	<form id="listForm" action="list.action" method="post">
		合同号：<input type="text" name="name" style="width: 120px" value="${commodities.name }" /> 
		零售商：<input	type="text" name="locality" style="width: 120px" value="${commodities.locality }" /> 
		类型：    <select name="indexType" onchange="changeType()">
					<option value="-1" selected="selected">全部</option>
					<option value="1">省外</option>
					<option value="0">省内</option>
			   </select> 
				<input type="hidden" name="type" id="type" value="-1" /> 
		创建日期：<input type="datetime-local" name="startTime" value="${startTime}" /> 
			   - <input type="datetime-local" name="endTime" value="${endTime}" /> 
				<input type="submit" value="搜索" style="background-color: #173e65; color: #ffffff; width: 70px;"><br />

		<!-- 显示错误信息 -->
		<c:if test="${errorMsg!=null}">
			<font color="red">${errorMsg}</font>
			<br />
		</c:if>
		<input type="hidden" name="startPage" id="startPage" value="${startPage}" /> 
		<input type="hidden" name="currentPage"	id="currentPage" value="${currentPage}" /> 
		<input type="hidden" name="pageSize" id="pageSize" value="${pageSize}" /> 
		<input type="hidden" name="sumPageNumber" id="sumPageNumber" value="${sumPageNumber}" /> 
		<input type="hidden" name="countNumber"	id="countNumber" value="${countNumber}" />
	</form>
	
	<hr style="margin-top: 10px;" />
	<button onclick="addContract()" style="background-color:#173e65;color:#ffffff;width:70px;">添加</button>
	
	<c:if test="${list!=null}">
		<table style="margin-top: 10px;width:700px;text-align: center;" border=1>
			<tr>
				<th>序号</th><th>合同编号</th><th>零售商</th>
				<th>类型</th><th>创建日期</th><th>操作</th>
			</tr>
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td>${status.index+1}</td><td>
					<a href="#" onclick="getContractDetail('${item.contractId}')">${item.barCode}</a></td>
					<td>${item.retailerName }</td>
					<td>
						<c:if test="${item.type==1 }">
							<font color="blue">省外</font>
						</c:if>
						<c:if test="${item.type==0 }">
							<font color="green">省内</font>
						</c:if>
					</td>
					
					<td>${item.createTime }</td>
					<td>
						<a onclick="editContract('${item.contractId}')">编辑</a>
						<a onclick="deleteContract('${item.contractId}','${item.barCode}')">删除</a>
						<form id="deleteForm" action="delete.action" method="post">
							<input type="hidden" name="contractId" id="dContractId"/>
							<input type="hidden" name="startPage" id="dStartPage"/>
							<input type="hidden" name="currentPage" id="dCurrentPage"/>
							<input type="hidden" name="pageSize" id="dPageSize"/>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<c:if test="${list==null }"><b>搜索结果为空！</b></c:if>
	<div style="margin-top: 10px;">
		<a onclick="toPrePage()">上一页</a>
		<a onclick="toNextPage()">下一页</a> 
		<input type="text" id="pageNumber" style="width: 50px;" />
		<button onclick="toLocationPage()">go</button>
		<div id="pageInfo"></div>
	</div>
</body>
</html>









