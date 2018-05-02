package com.fruitsalesplatform.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.fruitsalesplatform.dao.RetailerDao;
import com.fruitsalesplatform.entity.Retailer;

/**
 * 暴露DAO
 */
@Repository
public class RetailerDaoImpl extends BaseDaoImpl<Retailer> implements RetailerDao {
	
	public RetailerDaoImpl() {
		super.setNs("com.fruitsalesplatform.mapper.RetailerMapper");
	}
	
	/**  
	 * 实现接口自己的方法
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public int count(Map map) {
		return this.getSqlSession().selectOne(this.getNs()+".count",map);
	}

}
