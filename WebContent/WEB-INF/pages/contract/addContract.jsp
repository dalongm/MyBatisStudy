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
	
	.c2{
		border-style: solid;
		width:480px;
		height:300px;
		margin:4 23 0 23;
		border-radius:5;
		display:block;
		background:#fff;
		margin:10% auto;
		text-align: center;
	}
	
	.retailerMask,.commoditiesMask{
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
		$(".commoditiesMask").css("display","none");
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
	
	function selectRetailer(retailerId, name, telephone, address){
		$("#retailerId").val(retailerId);
		$("#retailer_name").html("姓名："+name);
		$("#retailer_telephone").html("联系电话："+telephone);
		$("#retailer_address").html("送货地址："+address);
		$(".retailerMask").css("display","none"); // 关闭零售商选择框
		$("#retailer_info").css("display","block"); // 显示零售商信息
	}
	
	function searchCommodities(){
		addFruits($("#commoditiesName").val());
	}
	
	function addFruits(name){
		var message="";
		if(name!=null){
			message="{'name':'"+name+"'}";
		}else{
			message="{'name':''}";
		}
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/contract/getAllCommodities.action',
			contentType:'application/json;charset=utf-8',
			data:message,
			success:function(data){
				var tableHead="<tr>"+
				"<th><input type='checkbox' onclick='checkAll(this)'></th>"+
				"<th>名称</th><th>价格</th><th>产地</th>"+
				"</tr>";
				
				$("#commoditiesList").html(tableHead); // 清空列表，添加table标题头
				
				for(var i=0;i<data.length;i++){
					var oldHtml = $("#commoditiesList").html();
					
					var info="<tr>"+
					"<td><input type='checkbox' name='arrays' value='"+data[i].fruitId+"'></td>"+
					"<td>"+data[i].name+"</td>"+
					"<td>"+data[i].price+"</td>"+
					"<td>"+data[i].locality+"</td>"+
					"</tr>";
					$("#commoditiesList").html(oldHtml + info);
				}
				// 添加table头和尾
				var table="<table style='width:375px;text-align:center;' border=1>"+
					$("#commoditiesList").html()+"</table>";
				$("#commoditiesList").html(table);
				$(".commoditiesMask").css("display", "block");
			},
			error:function(data){alert("通信异常！")}
		});
	}
	
	function checkAll(obj){
		var isCheck = obj.checked;
		var checkList=document.getElementsByName("arrays");//获取所有check选项
		for(var i=0;i<checkList.length;i++){
			checkList[i].checked = isCheck;
		}
	}
	
	function selectCommodities(){
		$("#commodities_info").html(""); // 将原来的信息清空
		var myArray = new Array();
		var len = 0;
		var arrays=document.getElementsByName("arrays");
		for(var i=0;i<arrays.length;i++){
			if(arrays[i].checked){
				myArray[len++] = arrays[i].value;
			}
		}
		
		
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/contract/getCommoditiesAndAccessory.action',
			data:{"arrays":myArray},
			traditional:true,
			success:function(data){
				var tableHead="<tr>"+
				"<th>名称</th><th>价格</th><th>产地</th><th>附属品</th><th>数量</th>"+
				"</tr>";
				$("#commodities_info").html(tableHead);
				for(var i=0;i<data.length;i++){
					var commodities = data[i].commodities;
					var accessory = data[i].accessory;
					var accessoryStr="";
					for(var j=0;j<accessory.length;j++){
						accessoryStr += accessory[j].name+":"+accessory[j].price+"元";
						if(j!=accessory.length-1){
							accessoryStr += "<br/>";
						}
					}
					// 赋值语句，右边为三元表达式
					accessoryStr = accessoryStr==""?"无":accessoryStr;
					var oldHtml = $("#commodities_info").html();
					var info = "<tr>"+
						"<td>"+commodities.name+"</td>"+
						"<td>"+commodities.price+"元/斤</td>"+
						"<td>"+commodities.locality+"</td>"+
						"<td>"+accessoryStr+"</td>"+
						"<td><input type='number' min='0.0' step='0.01' style='width:50px' name='priceArrays'/>斤</td>"+
						"</tr><input type='hidden' name='commoditiesIdArray' value='"+commodities.fruitId+"'/>";
					$("#commodities_info").html(oldHtml+info);
				}
				
				// 添加table头和尾
				$("#commodities_info").html("<table style='width=510px;text-align:center;' border=1>"+
					$("#commodities_info").html()+"</table>");
				$(".commoditiesMask").css("display","none");
				$("#commodities_info").css("display","block");
			},error:function(data){alert("通信异常！")}
		});
	}
</script>
</head>
<body>
	<div class="retailerMask">
		<div class="c">
			<div style="background-color: #173e65;height:20px;color:#fff;font-size:12px;padding-left:7px;">
				零售商信息<font style="float:right;padding-right: 10px;" onclick="cancelEdit()">x</font>
			</div>
			<input id="retailerName" width="width:20%"/>
			<button class="btn btn-div" onclick="searchRetailer()">查询</button>
			<div id="retailerList" style="border:5px solid #CCC;overflow-y:scroll;margin:10px;max-height: 220px;">
				<!-- 放置查询到的用户信息 -->	
			</div>
		</div>
	</div>
	<div class="commoditiesMask">
		<div class="c2">
			<div style="background-color: #173e65;height:20px;color:#fff;font-size:12px;padding-left:7px;">
				水果信息<font style="float:right;padding-right: 10px;" onclick="cancelEdit()">x</font>
			</div>
			<input id="commoditiesName" width="width:20%"/>
			<button class="btn btn-div" onclick="searchCommodities()">查询</button>
			<div id="commoditiesList" style="border:5px solid #CCC;overflow-y:scroll;margin:10px; max-height: 220px;">
				<!-- 放置查询到的水果信息 -->	
			</div>
			<button class="btn" onclick="selectCommodities()">确定</button>
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
				<div id="commodities_info" style="display:none">
					
				</div>
			</div>
		<input type="submit" value="提交" class="btn"/>
	</form>
</body>
</html>









