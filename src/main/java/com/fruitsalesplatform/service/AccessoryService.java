package com.fruitsalesplatform.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.fruitsalesplatform.entity.Accessory;

public interface AccessoryService {
	public Accessory get(Serializable id);
	@SuppressWarnings("rawtypes")
	public List<Accessory> find(Map map);
	public void insert(Accessory accessory);
	public void update(Accessory accessory);
	public void deleteById(Serializable id);
	public void delete(Serializable[] ids);
	
	/**
	 * 根据条件统计结果集数量
	 * @param map
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int count(Map map);
	
	public int deleteByFruitId(String fruitId);
}
