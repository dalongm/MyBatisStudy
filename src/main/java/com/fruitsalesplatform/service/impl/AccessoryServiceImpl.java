package com.fruitsalesplatform.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fruitsalesplatform.dao.AccessoryDao;
import com.fruitsalesplatform.entity.Accessory;
import com.fruitsalesplatform.service.AccessoryService;

@Service
public class AccessoryServiceImpl implements AccessoryService {

	@Autowired
	AccessoryDao accessoryDao;
	
	@Override
	public Accessory get(Serializable id) {
		return accessoryDao.get(id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Accessory> find(Map map) {
		// TODO Auto-generated method stub
		return accessoryDao.find(map);
	}

	@Override
	public void insert(Accessory accessory) {
		accessoryDao.insert(accessory);
	}

	@Override
	public void update(Accessory accessory) {
		accessoryDao.update(accessory);
	}

	@Override
	public void deleteById(Serializable id) {
		accessoryDao.deleteById(id);
	}

	@Override
	public void delete(Serializable[] ids) {
		accessoryDao.delete(ids);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int count(Map map) {
		return accessoryDao.count(map);
	}

	@Override
	public int deleteByFruitId(String fruitId) {
		return accessoryDao.deleteByFruitId(fruitId);
	}
	
}
