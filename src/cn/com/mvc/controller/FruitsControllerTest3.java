package cn.com.mvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.com.mvc.model.Fruits;
import cn.com.mvc.service.FruitsService;
import cn.com.mvc.service.FruitsServiceImpl;


/**
 * 注解的Handler类
 * 使用@Controller来标识它是一个控制器
 */
@Controller
public class FruitsControllerTest3 {

	private FruitsService fruitsService = new FruitsServiceImpl();

	/**
	 * 商品查询列表
	 * @RequestMapping实现对queryFruitsList方法和url进行映射，
	 * 一个方法对应一个url，一般建议url和方法写成一样 
	 */
	@RequestMapping("/queryFruitsList")
	public ModelAndView queryFruitsList()
	{
		List<Fruits> fruitsList = fruitsService.queryFruitsList();
		
		ModelAndView modelAndView = new ModelAndView();
		
		// 相当于request的setAttribut，在JSP页面中通过fruitsList获取数据
		modelAndView.addObject("fruitsList", fruitsList);
		// 指定视图
		modelAndView.setViewName("/fruits/fruitsList");
		return modelAndView;
	}
	
	
}

