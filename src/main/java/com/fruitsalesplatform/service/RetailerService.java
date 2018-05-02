package com.fruitsalesplatform.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.fruitsalesplatform.entity.Retailer;

public interface RetailerService {
	public Retailer get(Serializable id);
	@SuppressWarnings("rawtypes")
	public List<Retailer> find(Map map);
	public void insert(Retailer retailer);
	public void update(Retailer retailer);
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
