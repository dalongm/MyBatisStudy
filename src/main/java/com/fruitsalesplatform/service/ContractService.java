package com.fruitsalesplatform.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.fruitsalesplatform.entity.Contract;
import com.fruitsalesplatform.entity.MiddleTab;

public interface ContractService {
	public Contract get(Serializable id);
	@SuppressWarnings("rawtypes")
	public List<Contract> find(Map map);
	public void insert(Contract contract);
	public void insertMiddleTab(MiddleTab middleTab);
	public void update(Contract contract);
	public void deleteById(Serializable id);
	public void deleteMiddleTabByContractId(Serializable id);
	
	/**
	 * 根据条件统计结果集数量
	 * @param map
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int count(Map map);
	
	/**
	 * 获取数据库最大编号
	 * @return
	 */
	public String getMaxBarCode();
}
