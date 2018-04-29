package cn.com.mybatis.po;

public class BatchDetail {
	private int id;
	private int batch_id;
	private int product_id;
	private int product_num;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBatch_id() {
		return batch_id;
	}

	public void setBatch_id(int batch_id) {
		this.batch_id = batch_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	@Override
	public String toString() {
		return "BatchDetail [id=" + id + ", batch_id=" + batch_id + ", product_id=" + product_id + ", product_num="
				+ product_num + "]";
	}

}
