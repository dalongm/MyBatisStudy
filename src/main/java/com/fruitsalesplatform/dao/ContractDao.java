package com.fruitsalesplatform.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.fruitsalesplatform.entity.Contract;
import com.fruitsalesplatform.entity.ContractVo;
import com.fruitsalesplatform.entity.MiddleTab;

public interface ContractDao extends BaseDao<Contract> {
	
	@SuppressWarnings("rawtypes")
	public int count(Map map);
	@SuppressWarnings("rawtypes")
	public List<ContractVo> findContractList(Map map);
	public void insertMiddleTab(MiddleTab middleTab);
	public int deleteMiddleTabByContractId(Serializable contractId);
	public String getMaxBarCode();
}
