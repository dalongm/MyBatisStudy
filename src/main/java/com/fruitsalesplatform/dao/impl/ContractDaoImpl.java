package com.fruitsalesplatform.dao.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.fruitsalesplatform.dao.ContractDao;
import com.fruitsalesplatform.entity.Contract;
import com.fruitsalesplatform.entity.ContractVo;
import com.fruitsalesplatform.entity.MiddleTab;
@Repository
public class ContractDaoImpl extends BaseDaoImpl<Contract> implements ContractDao {

	/**
	 * 设置命名空间
	 */
	public ContractDaoImpl() {
		super.setNs("com.fruitsalesplatform.mapper.ContractMapper");
	}
	

	@SuppressWarnings("rawtypes")
	@Override
	public int count(Map map) {
		return this.getSqlSession().selectOne(this.getNs()+".count",map);
	}

	
	@SuppressWarnings("rawtypes")
	@Override
	public List<ContractVo> findContractList(Map map) {
		return this.getSqlSession().selectList(this.getNs()+".find",map);
	}

	@Override
	public void insertMiddleTab(MiddleTab middleTab) {
		this.getSqlSession().insert(this.getNs()+".insertMiddleTab",middleTab);
	}

	@Override
	public int deleteMiddleTabByContractId(Serializable contractId) {
		return this.getSqlSession().delete(this.getNs()+".deleteMiddleTabById", contractId);
	}

	@Override
	public String getMaxBarCode() {
		return this.getSqlSession().selectOne(this.getNs()+".getMaxBarCode");
	}


	@Override
	public void updateMiddleTab(MiddleTab middleTab) {
		this.getSqlSession().insert(this.getNs()+".updateMiddleTab",middleTab);
	}

}
