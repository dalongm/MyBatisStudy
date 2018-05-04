package com.fruitsalesplatform.controller;

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
import com.fruitsalesplatform.entity.ContractVo;
import com.fruitsalesplatform.entity.Retailer;
import com.fruitsalesplatform.service.ContractService;
import com.fruitsalesplatform.service.RetailerService;
import com.mysql.jdbc.StringUtils;

@Controller
public class ContractController extends BaseController {
	@Resource
	ContractService contractService;
	
	@Resource
	RetailerService retailerService;
	
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
}
