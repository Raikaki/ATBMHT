package model;

import java.util.HashMap;
import java.util.Map;

public class TypeUser {

	public static int Base_User = 1;
	public static int Google_User = 2;
	public static int Facebook_User = 3;
	public int id;
	public String description;
	
	public TypeUser(int id, String description) {
		super();
		this.id = id;
		this.description = description;
	}
	
	public TypeUser() {
		super();
	}

	static Map<Integer, String> TypeMapping = new HashMap<>();
	static {

		TypeMapping.put(1, "Base User");
		TypeMapping.put(2, "Google User");
		TypeMapping.put(3, "Facebook User");

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

	public static String getTypebyId(int id) {
		return TypeMapping.get(id);
	}

	@Override
	public String toString() {
		return "TypeUser [id=" + id + ", description=" + description + "]";
	}

	
	

}
