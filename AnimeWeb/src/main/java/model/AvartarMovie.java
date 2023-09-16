package model;

public class AvartarMovie {
	private int id;
	private String name;
	public AvartarMovie(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	public AvartarMovie() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "AvartarMovie [id=" + id + ", name=" + name + "]";
	}
	
}
