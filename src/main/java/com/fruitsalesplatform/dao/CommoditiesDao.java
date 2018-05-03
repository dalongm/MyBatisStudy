package com.fruitsalesplatform.dao;

import java.util.Map;

import com.fruitsalesplatform.entity.Commodities;

public interface CommoditiesDao extends BaseDao<Commodities> {
	@SuppressWarnings("rawtypes")
	public int count(Map map);
}
