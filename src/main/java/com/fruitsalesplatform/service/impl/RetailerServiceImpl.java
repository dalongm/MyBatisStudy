package com.fruitsalesplatform.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fruitsalesplatform.dao.RetailerDao;
import com.fruitsalesplatform.entity.Retailer;
import com.fruitsalesplatform.service.RetailerService;

/**
 * 暴露service
 */
@Service
public class RetailerServiceImpl implements RetailerService {

	@Autowired
	RetailerDao retailerDao;
	
	@Override
	public Retailer get(Serializable id) {
		return retailerDao.get(id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Retailer> find(Map map) {
		return retailerDao.find(map);
	}

	@Override
	public void insert(Retailer retailer) {
		retailerDao.insert(retailer);
	}

	@Override
	public void update(Retailer retailer) {
		retailerDao.update(retailer);
	}

	@Override
	public void deleteById(Serializable id) {
		retailerDao.deleteById(id);
	}

	@Override
	public void delete(Serializable[] ids) {
		retailerDao.delete(ids);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int count(Map map) {
		return retailerDao.count(map);
	}

}
