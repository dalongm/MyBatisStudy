package com.fruitsalesplatform.dao;

import java.util.Map;

import com.fruitsalesplatform.entity.Accessory;

public interface AccessoryDao extends BaseDao<Accessory> {
	@SuppressWarnings("rawtypes")
	public int count(Map map);
	
	public int deleteByFruitId(String fruitId);
}
