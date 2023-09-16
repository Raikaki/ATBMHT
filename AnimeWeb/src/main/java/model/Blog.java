package model;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.List;


public class Blog {
	private int id;
	private String title;
	private String folder;
	private String avatar;
	private LocalDateTime createAt;
	private LocalDateTime releaseAt;
	private LocalDateTime updateAt;

	private List<CommentBlog> listComment;
	private int status;

	public Blog() {
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setStatus(int status) {
		this.status = status;
	}



	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFolder() {
		return folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}

	public LocalDateTime getReleaseAt() {
		return releaseAt;
	}

	public void setReleaseAt(LocalDateTime releaseAt) {
		this.releaseAt = releaseAt;
	}

	public LocalDateTime getUpdateAt() {
		return updateAt;
	}

	public void setUpdateAt(LocalDateTime updateAt) {
		this.updateAt = updateAt;
	}

	public List<CommentBlog> getListComment() {
		return listComment;
	}

	public void setListComment(List<CommentBlog> listComment) {
		this.listComment = listComment;
	}

	public int getStatus() {
		return status;
	}

	@Override
	public String toString() {
		return "Blog{" +
				"id=" + id +
				", title='" + title + '\'' +
				", folder='" + folder + '\'' +
				", avatar='" + avatar + '\'' +
				", createAt=" + createAt +
				", releaseAt=" + releaseAt +
				", updateAt=" + updateAt +
				", listComment=" + listComment +
				", status=" + status +
				'}';
	}

	public static void main(String[] args) throws IOException {
	}

}


