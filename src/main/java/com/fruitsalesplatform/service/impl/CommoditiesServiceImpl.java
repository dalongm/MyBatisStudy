package com.fruitsalesplatform.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fruitsalesplatform.dao.CommoditiesDao;
import com.fruitsalesplatform.entity.Commodities;
import com.fruitsalesplatform.service.CommoditiesService;

@Service
public class CommoditiesServiceImpl implements CommoditiesService {

	@Autowired
	CommoditiesDao commoditiesDao;
	
	@Override
	public Commodities get(Serializable id) {
		return commoditiesDao.get(id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Commodities> find(Map map) {
		return commoditiesDao.find(map);
	}

	@Override
	public void insert(Commodities commodities) {
		commoditiesDao.insert(commodities);
	}

	@Override
	public void update(Commodities commodities) {
		commoditiesDao.update(commodities);
	}

	@Override
	public void deleteById(Serializable id) {
		commoditiesDao.deleteById(id);
	}

	@Override
	public void delete(Serializable[] ids) {
		commoditiesDao.delete(ids);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int count(Map map) {
		return commoditiesDao.count(map);
	}
	
}
