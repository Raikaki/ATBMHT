package model;

public class RechargeCode {
	private int id;
	private String code;
	private double price;
	private int used;
	public RechargeCode(int id, String code, double price, int used) {
		super();
		this.id = id;
		this.code = code;
		this.price = price;
		this.used = used;
	}
	
	public RechargeCode() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getUsed() {
		return used;
	}
	public void setUsed(int used) {
		this.used = used;
	}
	@Override
	public String toString() {
		return "RechargeCode [id=" + id + ", code=" + code + ", price=" + price + ", used=" + used + "]";
	}
	
}
