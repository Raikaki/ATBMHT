package model;

import java.time.LocalDateTime;

public class Producer {
	private int id;
	private String name;
	private String description;
	private int status;
	private LocalDateTime createAt;
	private String statusString;
	public Producer(int id, String name, String description) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
	}
	public Producer() {
		super();
	}
	public Producer(int id, String name) {
		super();
		this.id = id;
		this.name = name;
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
		this.statusString = Status.statusMapping.get(status);
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}

	public String getStatusString() {
		return statusString;
	}

	public void setStatusString(String statusString) {
		this.statusString = statusString;
	}

	@Override
	public String toString() {
		return "Producer{" +
				"id=" + id +
				", name='" + name + '\'' +
				", description='" + description + '\'' +
				", status=" + status +
				'}';
	}
}
