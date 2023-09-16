package model;

public class ChapterMovie {
	private int id;
	private int idMovie;
	private int index;
	private int opening;
	private String name;

	public ChapterMovie() {
		super();
	}

	public int getIdMovie() {
		return idMovie;
	}

	public void setIdMovie(int idMovie) {
		this.idMovie = idMovie;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getOpening() {
		return opening;
	}

	public void setOpening(int opening) {
		this.opening = opening;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "ChapterMovie{" +
				"id=" + id +
				", idMovie=" + idMovie +
				", index=" + index +
				", opening=" + opening +
				", name='" + name + '\'' +
				'}';
	}
}
