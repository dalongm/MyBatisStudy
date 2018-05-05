package com.fruitsalesplatform.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fruitsalesplatform.dao.ContractDao;
import com.fruitsalesplatform.entity.Contract;
import com.fruitsalesplatform.entity.ContractVo;
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
	public List<ContractVo> findContractList(Map map) {
		return contractDao.findContractList(map);
	}

	@Override
	public void insertMiddleTab(MiddleTab middleTab) {
		contractDao.insertMiddleTab(middleTab);
	}

	@Override
	public void deleteById(Serializable id) {
		contractDao.deleteMiddleTabByContractId(id);
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

	@Override
	public void insert(Contract contract, String[] commoditiesIdArrays, String[] priceArrays) {
		contractDao.insert(contract);
		// 保存中间信息
		for(int i=0;i<commoditiesIdArrays.length;i++) {
			MiddleTab middleTab = new MiddleTab();
			middleTab.setMiddleId(UUID.randomUUID().toString());
			middleTab.setContractId(contract.getContractId());
			middleTab.setFruitId(commoditiesIdArrays[i]);
			Double number = Double.parseDouble((priceArrays==null||priceArrays.length-1<i||priceArrays[i]==null||priceArrays[i].equals(""))?"0":priceArrays[i]);
			middleTab.setNumber(number);
			this.insertMiddleTab(middleTab);
		}
	}

	@Override
	public void updateMiddleTab(MiddleTab middleTab) {
		contractDao.updateMiddleTab(middleTab);
	}

	@Override
	public void update(Contract contract, String[] commoditiesIdArrays, String[] priceArrays) {
		contractDao.update(contract);
		contractDao.deleteMiddleTabByContractId(contract.getContractId());
		// 保存中间信息
		for(int i=0;i<commoditiesIdArrays.length;i++) {
			MiddleTab middleTab = new MiddleTab();
			middleTab.setMiddleId(UUID.randomUUID().toString());
			middleTab.setContractId(contract.getContractId());
			middleTab.setFruitId(commoditiesIdArrays[i]);
			Double number = Double.parseDouble((priceArrays==null||priceArrays.length-1<i||priceArrays[i]==null||priceArrays[i].equals(""))?"0":priceArrays[i]);
			middleTab.setNumber(number);
			this.insertMiddleTab(middleTab);
		}
	}

}
