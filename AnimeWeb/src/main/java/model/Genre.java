package model;

public class Genre {
	private int id;
	private String description;
	private int status;
	public Genre() {
		super();
	}
	public Genre(int id) {
		super();
		this.id = id;
	}
	public Genre(int id, String description) {
		super();
		this.id = id;
		this.description = description;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Genre [id=" + id + ", description=" + description + "]";
	}
	
}
