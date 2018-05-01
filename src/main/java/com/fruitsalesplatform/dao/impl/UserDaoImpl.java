package com.fruitsalesplatform.dao.impl;

import org.springframework.stereotype.Repository;

import com.fruitsalesplatform.dao.UserDao;
import com.fruitsalesplatform.entity.User;

/**
 * 添加repository注释，为使能在包扫描时被扫描到
 */
@Repository
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {

	/**
	 * 设置命名空间 
	 */
	public UserDaoImpl() {
		super.setNs("com.fruitsalesplatform.mapper.UserMapper");
	}
}
