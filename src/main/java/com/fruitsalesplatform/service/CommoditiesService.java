package com.fruitsalesplatform.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.fruitsalesplatform.entity.Commodities;

public interface CommoditiesService {
	public Commodities get(Serializable id);
	@SuppressWarnings("rawtypes")
	public List<Commodities> find(Map map);
	public void insert(Commodities commodities);
	public void update(Commodities commodities);
	public void deleteById(Serializable id);
	public void delete(Serializable[] ids);
	
	/**
	 * 根据条件统计结果集数量
	 * @param map
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int count(Map map);
}
