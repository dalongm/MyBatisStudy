package com.fruitsalesplatform.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fruitsalesplatform.entity.Commodities;
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
	public String list(Model model, ContractVo contractVo) {
		return "/contract/contractHome.jsp";
	}
	
	@RequestMapping("/contract/toAddPage.action")
	public String toAddPage()
	{
		return "/contract/addContract.jsp";
	}
	
	@RequestMapping("/contract/getAllRetailer.action")
	public @ResponseBody List<Retailer> getAllRetailer(@RequestBody String json)
	{
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("status", 1);
		if(!StringUtils.isNullOrEmpty(json)) {
			String name = JSONObject.parseObject(json).getString("name");
			if(!StringUtils.isNullOrEmpty(name)) {
				map.put("name", "%"+name+"%");
			}
		}
		List<Retailer> retailerList = retailerService.find(map);
		return retailerList;
	}
	// 
	@RequestMapping("/contract/getAllCommodities.action")
	public @ResponseBody List<Commodities> getAllCommodities(@RequestBody String json)
	{
		Map<String,Object> map = new HashMap<String,Object>();
		if(!StringUtils.isNullOrEmpty(json)) {
			String name = JSONObject.parseObject(json).getString("name");
			if(!StringUtils.isNullOrEmpty(name)) {
				map.put("name", "%"+name+"%"); // 商品名
			}
		}
		List<Commodities> retailerList = commoditiesService.find(map);
		return retailerList;
	}
	
	@RequestMapping("/contract/getCommoditiesAndAccessory.action")
	public @ResponseBody List<Map<String,Object>> getCommoditiesAndAccessory(String[] arrays)
	{
		List<Map<String,Object>> cList = new ArrayList<Map<String,Object>>();
		Map<String,Object> cMap = null;
		for(int i=0;i<arrays.length;i++) {
			cMap = new HashMap<String, Object>();
			String fruitId = arrays[i];
			cMap.put("commodities", commoditiesService.get(fruitId));
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("fruitId", fruitId);
			cMap.put("accessory", accessoryService.find(param));
			cList.add(cMap);
		}
		return cList;
	}
	
}
