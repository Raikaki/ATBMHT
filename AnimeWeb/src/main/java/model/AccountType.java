package model;

public class AccountType {


	public int id;
	public String description;
	
	public AccountType(int id, String description) {
		super();
		this.id = id;
		this.description = description;
	}
	
	public AccountType() {
		super();
	}

	
	
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	

	@Override
	public String toString() {
		return "TypeUser [typeid=" + id + ", description=" + description + "]";
	}

	
	

}
