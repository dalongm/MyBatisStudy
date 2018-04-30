package cn.com.mvc.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.mvc.model.Fruits;
import cn.com.mvc.model.ListQryModel;
import cn.com.mvc.model.MapQryModel;
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
	
	@RequestMapping("fruitsArrayTest")
	public void FruitsArray(Model model, int[] fids) {
		if(fids==null)
		{
			return;
		}
		for(int i=0;i<fids.length;i++)
		{
			System.out.println("fids["+i+"]="+fids[i]);
		}
	}
	
	@RequestMapping("fruitsListTest")
	public void FruitsList(Model model, ListQryModel listQryModel) {
		List<Fruits> fruitList = listQryModel.getFruitList();
		for(int i=0;i<fruitList.size();i++)
		{
			System.out.println("fruitList["+i+"].name="+fruitList.get(i).getName());
		}
	}
	
	@RequestMapping("fruitsMapTest")
	public void FruitsMap(Model model, MapQryModel mapQryModel)
	{
		Map<String, Object> fruitMap = mapQryModel.getFruitMap();
		for(String key:fruitMap.keySet())
		{
			System.out.println("fruitMap["+key+"]="+fruitMap.get(key));
		}
	}
}


