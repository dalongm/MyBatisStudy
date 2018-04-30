package cn.com.mvc.controller;

import java.util.ArrayList;
import java.util.List;

import cn.com.mvc.model.Fruits;

public class FruitsService {

	public List<Fruits> queryFruitsList() {
		List<Fruits> fruitsList = new ArrayList<Fruits>();

		Fruits apple = new Fruits();
		apple.setName("红富士苹果");
		apple.setPrice(2.3);
		apple.setProducing_area("山东");

		Fruits banana = new Fruits();
		banana.setName("香蕉");
		banana.setPrice(1.5);
		banana.setProducing_area("上海");

		fruitsList.add(apple);
		fruitsList.add(banana);
		return fruitsList;
	}
}
