package cn.com.mvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.mvc.model.Fruits;
import cn.com.mvc.service.FruitsService;
import cn.com.mvc.service.FruitsServiceImpl;

@Controller
@RequestMapping("query")
public class FindControllerTest {
	
	private FruitsService fruitsService = new FruitsServiceImpl();
	
	@RequestMapping("queryFruitsByCondition")
	public String queryFruitsByCondition(Model model, Fruits fruits)
	{
		List<Fruits> findList = null;
		if(fruits==null||((fruits.getName()==null||fruits.getName().equals(""))&&(fruits.getProducing_area()==null||fruits.getProducing_area().equals("")))) {
			findList = fruitsService.queryFruitsList();
		}
		else
		{
			findList = fruitsService.queryFruitsByCondition(fruits);
		}
		model.addAttribute("fruitsList", findList);
		return "/fruits/findFruits";
	}
}
