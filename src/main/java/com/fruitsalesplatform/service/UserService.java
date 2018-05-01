package com.fruitsalesplatform.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.fruitsalesplatform.entity.User;

/**
 * 接口说明参见BaseDao注释
 */
public interface UserService {
	public User get(Serializable id);
	@SuppressWarnings("rawtypes")
	public List<User> find(Map map);
	public void insert(User user);
	public void update(User user);
	public void deleteById(Serializable id);
	public void delete(Serializable[] ids);
}
