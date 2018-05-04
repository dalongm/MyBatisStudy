package com.fruitsalesplatform.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fruitsalesplatform.entity.Commodities;
import com.fruitsalesplatform.entity.Contract;
import com.fruitsalesplatform.entity.ContractVo;
import com.fruitsalesplatform.entity.Retailer;
import com.fruitsalesplatform.service.AccessoryService;
import com.fruitsalesplatform.service.CommoditiesService;
import com.fruitsalesplatform.service.ContractService;
import com.fruitsalesplatform.service.RetailerService;
import com.mysql.jdbc.StringUtils;

@Controller
public class ContractController extends BaseController {
	@Resource
	ContractService contractService;

	@Resource
	RetailerService retailerService;

	@Resource
	CommoditiesService commoditiesService;

	@Resource
	AccessoryService accessoryService;

	@RequestMapping("/contract/list.action")
	public String list(Model model, ContractVo contractVo,String startTime, String endTime) {
		Map<String, Object> map = this.contractToMap(contractVo);
		
		if(startTime!=null&&!startTime.equals("")) {
			map.put("startTime", startTime);
		}
		
		if(endTime!=null&&!endTime.equals("")) {
			map.put("endTime", endTime);
		}
		List<ContractVo> contractList = contractService.findContractList(map);
		model.addAttribute("list", contractList.size()<1?null:contractList);
		model.addAttribute("currentPage", contractVo.getCurrentPage());
		model.addAttribute("startPage", contractVo.getStartPage());
		int countNumber = contractService.count(map);
		model.addAttribute("countNumber", countNumber);
		int pageSize =  contractVo.getPageSize();
		model.addAttribute("pageSize",pageSize);
		
		int sumPageNumber = countNumber%pageSize==0?countNumber/pageSize:(countNumber/pageSize+1);
		model.addAttribute("sumPageNumber", sumPageNumber);
		return "/contract/contractHome.jsp";
	}

	private Map<String, Object> contractToMap(ContractVo contractVo) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("barCode", chectStringIsEempty(contractVo.getBarCode()));
		map.put("retailerName", chectStringIsEempty(contractVo.getRetailerName()));
		map.put("type", contractVo.getType()==-1?null:contractVo.getType());
		map.put("startPage", contractVo.getStartPage());
		map.put("pageSize", contractVo.getPageSize());
		return map;
	}

	@RequestMapping("/contract/toAddPage.action")
	public String toAddPage() {
		return "/contract/addContract.jsp";
	}

	@RequestMapping("/contract/getAllRetailer.action")
	public @ResponseBody List<Retailer> getAllRetailer(@RequestBody String json) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", 1);
		if (!StringUtils.isNullOrEmpty(json)) {
			String name = JSONObject.parseObject(json).getString("name");
			if (!StringUtils.isNullOrEmpty(name)) {
				map.put("name", "%" + name + "%");
			}
		}
		List<Retailer> retailerList = retailerService.find(map);
		return retailerList;
	}

	//
	@RequestMapping("/contract/getAllCommodities.action")
	public @ResponseBody List<Commodities> getAllCommodities(@RequestBody String json) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (!StringUtils.isNullOrEmpty(json)) {
			String name = JSONObject.parseObject(json).getString("name");
			if (!StringUtils.isNullOrEmpty(name)) {
				map.put("name", "%" + name + "%"); // 商品名
			}
		}
		List<Commodities> retailerList = commoditiesService.find(map);
		return retailerList;
	}

	@RequestMapping("/contract/getCommoditiesAndAccessory.action")
	public @ResponseBody List<Map<String, Object>> getCommoditiesAndAccessory(String[] arrays) {
		List<Map<String, Object>> cList = new ArrayList<Map<String, Object>>();
		Map<String, Object> cMap = null;
		for (int i = 0; i < arrays.length; i++) {
			cMap = new HashMap<String, Object>();
			String fruitId = arrays[i];
			cMap.put("commodities", commoditiesService.get(fruitId));
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("fruitId", fruitId);
			cMap.put("accessory", accessoryService.find(param));
			cList.add(cMap);
		}
		return cList;
	}

	@RequestMapping("/contract/add.action")
	public String add(Model model, Contract contract, String retailerId, String[] commoditiesIdArrays,
			String[] priceArrays) {

		if(commoditiesIdArrays!=null&&priceArrays!=null)
		{
			contract.setRetailer(retailerService.get(retailerId));
			String barCode = getCode();
			contract.setBarCode(barCode);
			contract.setContractId(UUID.randomUUID().toString());
			contract.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			contractService.insert(contract,commoditiesIdArrays,priceArrays);
			model.addAttribute("resultMessage", "添加成功！合同编号为"+barCode);
		}
		return "/contract/addContract.jsp";
	}

	@RequestMapping("/contract/getContractDetail.action")
	public String getContractDetail(Model model, String contractId) {
		Contract contract = contractService.get(contractId);
		model.addAttribute("contract", contract);
		return "/contract/contractDetail.jsp";
	}
	
	private String getCode() {
		String codeHead = new SimpleDateFormat("yyyyMMdd").format(new Date());
		String barCode = "";
		String MaxBarcode = contractService.getMaxBarCode();
		if (!StringUtils.isNullOrEmpty(MaxBarcode)) {
			if(MaxBarcode.substring(0, 8).equals(codeHead))
			{
				MaxBarcode = MaxBarcode.substring(8);
			}
			else {
				MaxBarcode = "0";
			}
		}else {
			MaxBarcode="0";
		}
		int maxNumber = Integer.parseInt(MaxBarcode);
		int newNumber = maxNumber+1;
		if(newNumber<=9)
		{
			barCode=codeHead+"000"+newNumber;
		}else if(newNumber<=99)
		{
			barCode=codeHead+"00"+newNumber;
		}else if(newNumber<=999)
		{
			barCode=codeHead+"0"+newNumber;
		}else
		{
			barCode=codeHead + newNumber; // 三位以上的数字
		}
		return barCode;
	}

	@RequestMapping("/contract/delete.action")
	public String delete(Model model, ContractVo contractVo) {
		contractService.deleteById(contractVo.getContractId());
		// 构建新的查询信息
		ContractVo queryContract = new ContractVo();
		queryContract.setType(-1);
		queryContract.setStartPage(contractVo.getStartPage());
		queryContract.setCurrentPage(contractVo.getCurrentPage());
		queryContract.setPageSize(contractVo.getPageSize());
		return list(model,queryContract,null,null);
	}
	
}






