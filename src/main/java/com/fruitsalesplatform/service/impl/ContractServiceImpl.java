package com.fruitsalesplatform.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fruitsalesplatform.dao.ContractDao;
import com.fruitsalesplatform.entity.Contract;
import com.fruitsalesplatform.entity.MiddleTab;
import com.fruitsalesplatform.service.ContractService;

@Service
public class ContractServiceImpl implements ContractService {

	@Autowired
	ContractDao contractDao;
	
	@Override
	public Contract get(Serializable id) {
		return contractDao.get(id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Contract> find(Map map) {
		return contractDao.find(map);
	}

	@Override
	public void insert(Contract contract) {
		contractDao.insert(contract);
	}

	@Override
	public void insertMiddleTab(MiddleTab middleTab) {
		contractDao.insertMiddleTab(middleTab);
	}

	@Override
	public void update(Contract contract) {
		contractDao.update(contract);
	}

	@Override
	public void deleteById(Serializable id) {
		contractDao.deleteById(id);
	}

	@Override
	public void deleteMiddleTabByContractId(Serializable contractId) {
		contractDao.deleteMiddleTabByContractId(contractId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int count(Map map) {
		return contractDao.count(map);
	}

	@Override
	public String getMaxBarCode() {
		return contractDao.getMaxBarCode();
	}

}
