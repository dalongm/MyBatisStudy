package com.fruitsalesplatform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fruitsalesplatform.entity.Retailer;
import com.fruitsalesplatform.service.RetailerService;

@Controller
public class RetailerController extends BaseController {
	@Resource
	RetailerService retailerService;
	
	@RequestMapping("/retailer/list.action")
	public String list(Model model, Retailer retailer, String startTime, String endTime) {
		Map<String, Object> map = this.retailerToMap(retailer);
		if(startTime!=null&&!startTime.equals(""))
		{
			map.put("startTime", startTime);
		}
		if(endTime!=null&&endTime.equals(""))
		{
			map.put("endTime", endTime);
		}
		List<Retailer> retailerList = retailerService.find(map);
		model.addAttribute("list", retailerList);
		model.addAttribute("currentPage", retailer.getCurrentPage());
		model.addAttribute("startPage", retailer.getStartPage());
		int countNumber = retailerService.count(map);
		model.addAttribute("countNumber", countNumber);
		int pageSize = retailer.getPageSize();
		model.addAttribute("pageSize", pageSize);
		int sumPageNumber = countNumber%pageSize==0?(countNumber/pageSize):((countNumber/pageSize)+1);;
		model.addAttribute("sumPageNumber", sumPageNumber);
		// 转向首页
		return "/retailer/retailerHome.jsp";
	}

	private Map<String, Object> retailerToMap(Retailer retailer) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", chectStringIsEempty(retailer.getName()));
		map.put("telephone", chectStringIsEempty(retailer.getTelephone()));
		map.put("address", chectStringIsEempty(retailer.getAddress()));
		map.put("status", retailer.getStatus()==-1?null:retailer.getStatus());
		map.put("createTime", chectStringIsEempty(retailer.getCreateTime()));
		map.put("startPage", retailer.getStartPage());
		map.put("pageSize", retailer.getPageSize());
		return map;
	}

	private Object chectStringIsEempty(String param) {
		return param==null?null:(param.equals("")?null:"%"+param+"%");
	}
	
}
