package com.fruitsalesplatform.dao.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;

import com.fruitsalesplatform.dao.BaseDao;

public abstract class BaseDaoImpl<T> extends SqlSessionDaoSupport implements BaseDao<T> {

	@Autowired
	@Override
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		super.setSqlSessionFactory(sqlSessionFactory);
	}

	private String ns;

	public String getNs() {
		return ns;
	}

	public void setNs(String ns) {
		this.ns = ns;
	}

	@Override
	public T get(Serializable id) {
		return this.getSqlSession().selectOne(ns + ".get", id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<T> find(Map map) {
		List<T> oList = this.getSqlSession().selectList(ns + ".find", map);
		return oList;
	}

	@Override
	public void insert(T entity) {
		this.getSqlSession().insert(ns+".insert", entity);
	}

	@Override
	public void update(T entity) {
		this.getSqlSession().update(ns+".update", entity);
	}

	@Override
	public void deleteById(Serializable id) {
		this.getSqlSession().delete(ns + ".deleteById", id);
	}

	@Override
	public void delete(Serializable[] ids) {
		this.getSqlSession().delete(ns + ".delete", ids);
	}

}
