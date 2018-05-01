package com.fruitsalesplatform.test.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fruitsalesplatform.test.dao.TestDao;
import com.fruitsalesplatform.test.entity.User;
import com.fruitsalesplatform.test.service.TestService;

/**
 * Service暴露该Service实现类，以供Controller使用
 */
@Service
public class TestServiceImpl implements TestService {

	@Autowired
	private TestDao testDao;
	
	@Override
	public List<User> findUserByName(User user) {
		if(user.getName()==null||user.getName().equals(""))
		{
			return testDao.findAllUser();
		}
		else
		{
			return testDao.findUserByName(user);
		}
	}

	@Override
	public List<User> findAllUser() {
		return testDao.findAllUser();
	}

}
