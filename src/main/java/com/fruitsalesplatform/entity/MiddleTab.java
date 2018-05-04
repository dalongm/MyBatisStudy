package com.fruitsalesplatform.entity;

public class MiddleTab {
	private String middleId;
	private String contractId;
	private String fruitId;
	private Double number;

	public String getMiddleId() {
		return middleId;
	}

	public void setMiddleId(String middleId) {
		this.middleId = middleId;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public String getFruitId() {
		return fruitId;
	}

	public void setFruitId(String fruitId) {
		this.fruitId = fruitId;
	}

	public Double getNumber() {
		return number;
	}

	public void setNumber(Double number) {
		this.number = number;
	}

	@Override
	public String toString() {
		return "MiddleTab [middleId=" + middleId + ", contractId=" + contractId + ", fruitId=" + fruitId + ", number="
				+ number + "]";
	}

}
