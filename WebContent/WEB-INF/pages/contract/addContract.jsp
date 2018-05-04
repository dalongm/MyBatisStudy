<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新建购销合同</title>
<style type="text/css">
	* {
		margin: 0;
		padding: 0;
	}
	
	.btn {background-color:#173e65;color:#ffffff;width:70px;}
	
	.btn-div{text-align: center;}
	
	.info{border: 1px solid #CCC;}
	
	.c{
		border-style: solid;
		width:240px;
		height:300px;
		margin:4 23 0 23;
		border-radius:5;
		display:block;
		background:#fff;
		margin:10% auto;
		text-align: center;
	}
	
	.retailerMask{
		width:100%;
		height:100%;
		position:absolute;
		background:rgba(0,0,0,.3);
		display:none;
	}
	
	#retailerList p{
		text-align: center;
	}
	
</style>
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
	
	function cancelEdit(){
		$(".retailerMask").css("display","none");
	}
	
	function checkAddContract(){
	}

	function changeType(){
		var type=$("#indexType").val();
		$("#type").val(type);
	}
	

	function addRetailer(name){
		$("#retailerList").html(""); //清空信息
		var message="";
		if(name!=null){
			message="{'name':'"+name+"'}";
		}else{
			message="{'name':''}";
		}
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/contract/getAllRetailer.action',
			contentType:'application/json;charset=utf-8',
			data:message,
			success:function(data){
				for(var i=0;i<data.length;i++){
					var oldHtml = $("#retailerList").html();
					var info="<p onclick=\"selectRetailer('" + data[i].retailerId + "','"
						+data[i].name + "','" + data[i].telephone+"','" + data[i].address + "')\">"
						+data[i].name + "</p>";
					$("#retailerList").html(oldHtml + info);
				}
				$(".retailerMask").css("display", "block");
			},
			error:function(data){alert("通信异常！")}
		});
	}
	
	function searchRetailer(){
		addRetailer($("#retailerName").val());
	}
	
	function addFruits(){}
	
	function selectRetailer(retailerId, name, telephone, address){
		$("#retailerId").val(retailerId);
		$("#retailer_name").html("姓名："+name);
		$("#retailer_telephone").html("联系电话："+telephone);
		$("#retailer_address").html("送货地址："+address);
		$(".retailerMask").css("display","none"); // 关闭零售商选择框
		$("#retailer_info").css("display","block"); // 显示零售商信息
	}
</script>
</head>
<body>
	<div class="retailerMask">
		<div class="c">
			<div style="background-color: #173e65;height:20px;color:#fff;font-size:12px;padding-left:7px;">
				零售商信息<font style="float:right;padding-right: 10px;max-height: 220px;" onclick="cancelEdit()">x</font>
			</div>
			<input id="retailerName" width="width:20%"/>
			<button class="btn btn-div" onclick="searchRetailer()">查询</button>
			<div id="retailerList" style="border:5px solid #CCC;overflow-y:scroll;margin:10px;">
				<!-- 放置查询到的用户信息 -->	
			</div>
		</div>
	</div>
	<form id="addContractForm" action="add.action" method="post" onsubmit="checkAddContract()")>
		合同编码：<input type="text" name="barcode" style="width: 120px;"
				value="系统自动生成" readonly="readonly"/><br/>
		类型:<select name="indexType" onchange="changeType()">
				<option value="1">省外</option>
				<option value="0">省内</option>
			</select> 
			<input type="hidden" name="type" id="type" value="0" /><br/>
			<div class="info">
				零售商信息：
				<input type="button" value="关联" class="btn btn-div" onclick="addRetailer(null)" style="float:right"><br/>
				<div id="retailer_info" style="display:none">
					<p id="retailer_name"></p>
					<p id="retailer_telephone"></p>
					<p id="retailer_address"></p>
					<input name="retailerId" id="retailerId" type="hidden"/>
				</div>
			</div>
			<div class="info">
				货物信息：
				<input type="button" class="btn btn-div" value="添加" onclick="addFruits()" style="float:right"><br/>
			</div>
		<input type="submit" value="提交" class="btn"/>
	</form>
</body>
</html>









