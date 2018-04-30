package cn.com.mvc.service;

import java.util.ArrayList;
import java.util.List;

import cn.com.mvc.model.Fruits;

public class FruitsServiceImpl implements FruitsService {

	public List<Fruits> fruitsList = null;

	private List<Fruits> init() {
		if (fruitsList == null) {
			fruitsList = new ArrayList<Fruits>();

			Fruits apple = new Fruits();
			apple.setId(1);
			apple.setName("红富士苹果");
			apple.setPrice(2.3);
			apple.setProducing_area("山东");

			Fruits banana = new Fruits();
			banana.setId(2);
			banana.setName("香蕉");
			banana.setPrice(1.5);
			banana.setProducing_area("上海");

			fruitsList.add(apple);
			fruitsList.add(banana);
		}
		return fruitsList;
	}

	@Override
	public List<Fruits> queryFruitsList() {
		init();
		return fruitsList;
	}

	@Override
	public Fruits queryFruitById(Integer id) {
		init();
		Fruits f=null;
		for(int i=0;i<fruitsList.size();i++)
		{
			f = fruitsList.get(i);
			if(f.getId()==id) {
				return f;
			}
		}
		return null;
	}

	@Override
	public List<Fruits> queryFruitsByCondition(Fruits fruits) {
		init();
		String name = fruits.getName();
		String area = fruits.getProducing_area();
		List<Fruits> queryList = new ArrayList<Fruits>();
		Fruits f;
		for(int i=0;i<fruitsList.size();i++)
		{
			f = fruitsList.get(i);
			if(name!=null&&!name.equals("")&&f.getName().contains(name)||(area!=null&&!area.equals("")&&f.getProducing_area().contains(area))) {
				queryList.add(f);
			}
		}
		return queryList.size()>0?queryList:null;
	}

}
