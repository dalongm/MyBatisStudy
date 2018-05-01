package com.fruitsalesplatform.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface BaseDao<T> {
	
	/**
	 * 只查询一个数据，常用于修改
	 * @param id
	 * @return
	 */
	public T get(Serializable id);
	
	/**
	 * 根据条件查询多个结果
	 * @param map
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<T> find(Map map);
	
	/**
	 * 插入，用实体作为参数
	 * @param entity
	 */
	public void insert(T entity);
	
	/**
	 * 修改，用实体作为参数
	 * @param entity
	 */
	public void update(T entity);
	
	/**
	 * 按id删除，删除一条；支持整型和字符串类型id
	 * @param id
	 */
	public void deleteById(Serializable id);
	
	/**
	 * 批量删除；支持整型和字符串类型id
	 * @param ids
	 */
	public void delete(Serializable[] ids);
	
}



