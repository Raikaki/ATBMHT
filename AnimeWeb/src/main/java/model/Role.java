package model;

import javax.security.auth.Subject;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Role {
	private int id;
	private String description;

	private List<Permission> permissions;
	public static int Base_User = 1;
	public static int Movie_Management = 2;
	public static int Blog_Management = 3;
	public static int User_Management = 4;
	public static int Financial_Management = 5;
	public static int Administrator = 6;

	static Map<Integer, String> roleMapping = new HashMap<>();
	static {

		roleMapping.put(1, "Base_User");
		roleMapping.put(2, "Movie_Management");
		roleMapping.put(3, "Blog_Management");
		roleMapping.put(4, "User_Management");
		roleMapping.put(5, "Financial_Management");
		roleMapping.put(6, "Administrator");

	}
	public Role(int id, String description) {
		super();
		this.id = id;
		this.description = description;
	}
	public Role() {
		
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

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

	@Override
	public String toString() {
		return "Role{" +
				"id=" + id +
				", description='" + description + '\'' +
				", permissions=" + permissions +
				'}';
	}
}
