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
import org.springframework.web.bind.annotation.RequestMapping;

import com.fruitsalesplatform.entity.Accessory;
import com.fruitsalesplatform.service.AccessoryService;

@Controller
public class AccessoryController extends BaseController {

	@Resource
	AccessoryService accessoryService;

	@RequestMapping("/accessory/list.action")
	public String list(Model model, Accessory accessory) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fruitId", accessory.getFruitId());
		List<Accessory> accessoryList = accessoryService.find(map);
		model.addAttribute("fruitId", accessory.getFruitId());
		model.addAttribute("list", accessoryList.size() < 1 ? null : accessoryList);
		model.addAttribute("sumPrice", SumPrice(accessoryList));
		return "/accessory/accessoryHome.jsp";
	}

	@RequestMapping("/accessory/add.action")
	public String add(Model model, Accessory accessory) {
		accessory.setAccessoryId(UUID.randomUUID().toString());
		accessory.setFruitId(accessory.getFruitId());
		accessory.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		accessoryService.insert(accessory);
		// 重新刷新列表
		return list(model, accessory);
	}

	// 删除一个数据
	@RequestMapping("/accessory/delete.action")
	public String delete(Model model, Accessory accessory) {
		accessoryService.deleteById(accessory.getAccessoryId());
		// 重新刷新列表
		return list(model, accessory);
	}

	// 批量删除
	@RequestMapping("/accessory/deleteList.action")
	public String deleteList(Model model, String[] arrays, Accessory accessory) {
		accessoryService.delete(arrays);
		return list(model,accessory);
	}

	private double SumPrice(List<Accessory> accessoryList) {
		double sum = 0.0;
		for (Accessory accessory : accessoryList) {
			sum += accessory.getPrice();
		}
		return sum;
	}

}
