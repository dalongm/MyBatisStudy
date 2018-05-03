package com.fruitsalesplatform.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.fruitsalesplatform.dao.AccessoryDao;
import com.fruitsalesplatform.entity.Accessory;

@Repository
public class AccessoryDaoImpl extends BaseDaoImpl<Accessory> implements AccessoryDao {

	public AccessoryDaoImpl() {
		super.setNs("com.fruitsalesplatform.mapper.AccessoryMapper");
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public int count(Map map) {
		return this.getSqlSession().selectOne(this.getNs()+".count", map);
	}

	@Override
	public int deleteByFruitId(String fruitId) {
		return this.getSqlSession().delete(this.getNs()+".deleteByFruitId", fruitId);
	}

}
