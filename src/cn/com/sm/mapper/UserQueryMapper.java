package cn.com.sm.mapper;

import cn.com.sm.po.User;

public interface UserQueryMapper {
	public User findUserById(int id) throws Exception;
}
