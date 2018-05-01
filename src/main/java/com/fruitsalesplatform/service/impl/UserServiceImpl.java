package com.fruitsalesplatform.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fruitsalesplatform.dao.UserDao;
import com.fruitsalesplatform.entity.User;
import com.fruitsalesplatform.service.UserService;

/**
 * 添加service注释，为使能在包扫描时被扫描到
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao userDao;
	
	@Override
	public User get(Serializable id) {
		return userDao.get(id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<User> find(Map map) {
		return userDao.find(map);
	}

	@Override
	public void insert(User user) {
		userDao.insert(user);
	}

	@Override
	public void update(User user) {
		userDao.update(user);
	}

	@Override
	public void deleteById(Serializable id) {
		userDao.deleteById(id);
	}

	@Override
	public void delete(Serializable[] ids) {
		userDao.delete(ids);
	}

}
