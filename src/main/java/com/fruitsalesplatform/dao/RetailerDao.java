package com.fruitsalesplatform.dao;

import java.util.Map;

import com.fruitsalesplatform.entity.Retailer;

/**
 * retailer DAO
 */
public interface RetailerDao extends BaseDao<Retailer> {
	
	/**
	 * 统计数目
	 * @param map
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int count(Map map);
}
