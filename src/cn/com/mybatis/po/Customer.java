package cn.com.mybatis.po;

import java.io.Serializable;
import java.util.List;

/**
 * 客户Bean
 * 实现序列化操作，方便二级缓存存储在多样的存储介质当中
 */
public class Customer implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private int cus_id;
	private String username;
	private String acno;
	private String gender;
	private String phone;
	private List<Batch> batchList;

	public int getCus_id() {
		return cus_id;
	}

	public void setCus_id(int cus_id) {
		this.cus_id = cus_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAcno() {
		return acno;
	}

	public void setAcno(String acno) {
		this.acno = acno;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public List<Batch> getBatchList() {
		return batchList;
	}

	public void setBatchList(List<Batch> batchList) {
		this.batchList = batchList;
	}

	@Override
	public String toString() {
		return "Customer [cus_id=" + cus_id + ", username=" + username + ", acno=" + acno + ", gender=" + gender
				+ ", phone=" + phone + ", batchList=" + batchList + "]";
	}

}
