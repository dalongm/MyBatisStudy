package cn.com.mvc.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.mvc.model.Fruits;
import cn.com.mvc.model.ListQryModel;
import cn.com.mvc.model.MapQryModel;
import cn.com.mvc.service.FruitsService;
import cn.com.mvc.service.FruitsServiceImpl;
import cn.com.mvc.validator.group.FruitsGroup1;

@Controller
@RequestMapping("query")
public class FindControllerTest {
	
	private FruitsService fruitsService = new FruitsServiceImpl();
	
	/**
	 * @param model
	 * @param fruits
	 * @param bingingResult
	 * @Validated和BindingResult成对出现，并且在形参中出现的顺序是固定的
	 * @return
	 */
	@RequestMapping("queryFruitsByCondition")
	public String queryFruitsByCondition(Model model, @Validated(value=FruitsGroup1.class) Fruits fruits, BindingResult bingingResult)
	{
		List<ObjectError> allErrors = null;
		if(bingingResult.hasErrors())
		{
			allErrors = bingingResult.getAllErrors();
			for (ObjectError objectError : allErrors) {
				System.out.println(objectError.getDefaultMessage());
			}
		}
		
		List<Fruits> findList = null;
		// 如果fruits或查询条件为空，默认查询所有数据
		if(fruits==null||((fruits.getName()==null||fruits.getName().equals(""))&&(fruits.getProducing_area()==null||fruits.getProducing_area().equals("")))) {
			findList = fruitsService.queryFruitsList();
		}
		// 如果fruits并且查询条件不为空，按条件查询
		else
		{
			findList = fruitsService.queryFruitsByCondition(fruits);
		}
		model.addAttribute("allErrors", allErrors);
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


