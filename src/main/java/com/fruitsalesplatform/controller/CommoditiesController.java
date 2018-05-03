package com.fruitsalesplatform.controller;

import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fruitsalesplatform.entity.Commodities;
import com.fruitsalesplatform.service.CommoditiesService;

@Controller
public class CommoditiesController extends BaseController {
	
	@Resource
	CommoditiesService commoditiesService;
	
	
	@RequestMapping("/commodities/list.action")
	public String list(Model model, Commodities commodities, 
			@RequestParam(defaultValue="0.0") double startPrice,
			@RequestParam(defaultValue="0.0") double endPrice,
			String startTime, String endTime) {
		Map<String, Object> map = this.CommoditiesToMap(commodities);
		if(startTime!=null&&!startTime.equals("")) {
			map.put("startTime", startTime);
		}
		if(endTime!=null&&!endTime.equals("")) {
			map.put("endTime", endTime);
		}
		if(startPrice>0.0) {
			map.put("startPrice", startPrice);
		}
		if(endPrice>0.0) {
			map.put("endPrice", endPrice);
		}
		
		List<Commodities> commoditiesList = commoditiesService.find(map);
		
		// 搜索条件回显
		model.addAttribute("commodities", commodities);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("startPrice", startPrice);
		model.addAttribute("endPrice", endPrice);
		
		model.addAttribute("list", commoditiesList.size()<1?null:commoditiesList);
		model.addAttribute("currentPage", commodities.getCurrentPage());
		model.addAttribute("startPage", commodities.getStartPage());
		
		int countNumber = commoditiesService.count(map);
		model.addAttribute("countNumber", countNumber);
		int pageSize = commodities.getPageSize();
		model.addAttribute("pageSize", pageSize);
		int sumPageNumber = countNumber%pageSize==0?(countNumber/pageSize):(countNumber/pageSize + 1);
		model.addAttribute("sumPageNumber", sumPageNumber);
		// 转向货物信息首页
		return "/commodities/commoditiesHome.jsp";
	}

	@RequestMapping("/commodities/editCommodities.action")
	public @ResponseBody Commodities editCommodities(@RequestBody String json) {
		String id = JSONObject.parseObject(json).getString("id");
		return commoditiesService.get(id);
	}
	
	@RequestMapping("/commodities/edit.action")
	public String edit(Model model, Commodities commodities) {
		commoditiesService.update(commodities);
		Commodities queryCommodities = new Commodities();
		queryCommodities.setStartPage(commodities.getStartPage());
		queryCommodities.setCurrentPage(commodities.getCurrentPage());
		queryCommodities.setPageSize(commodities.getPageSize());
		return list(model, queryCommodities, 0.0, 0.0, null, null);
	}
	
	@RequestMapping("/commodities/add.action")
	public String add(Model model, Commodities commodities) {
		commodities.setFruitId(UUID.randomUUID().toString());
		commodities.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		commoditiesService.insert(commodities);
		return list(model, new Commodities(), 0.0, 0.0, null, null);
	}
	
	@RequestMapping("/commodities/delete.action")
	public String delete(Model model, Commodities commodities) {
		commoditiesService.deleteById(commodities.getFruitId());
		Commodities queryCommodities = new Commodities();
		queryCommodities.setStartPage(commodities.getStartPage());
		queryCommodities.setCurrentPage(commodities.getCurrentPage());
		queryCommodities.setPageSize(commodities.getPageSize());
		return list(model, queryCommodities, 0.0, 0.0, null, null);
	}
	
	private Map<String, Object> CommoditiesToMap(Commodities commodities) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", chectStringIsEempty(commodities.getName()));
		map.put("locality", chectStringIsEempty(commodities.getLocality()));
		map.put("createTime", chectStringIsEempty(commodities.getCreateTime()));
		map.put("startPage", commodities.getStartPage());
		map.put("pageSize", commodities.getPageSize());
		return map;
	}
	
}
