package model;

import database.DAOCommentMovie;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.Period;

import java.util.List;

public class CommentMovie {
	private int id;
	private int idMovie;
	private int parentId;
	private String content;
	private int userComment;
	private int userReply;
	private LocalDateTime commentAt;
	private int status;
	private int isActive;
	private List<CommentMovie> replyComment;
	private Account accountComment;
	private Account accountReply;
	private DAOCommentMovie daoCommentMovie;
	private String diffTime;
	private boolean availableReply;

	public CommentMovie() {
		daoCommentMovie = new DAOCommentMovie();

	}

	public String getDiffTime() {
		return diffTime;
	}

	public void setDiffTime(String diffTime) {
		this.diffTime = diffTime;
	}

	public int getIdMovie() {
		return idMovie;
	}

	public void setIdMovie(int idMovie) {
		this.idMovie = idMovie;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getUserComment() {
		return userComment;
	}

	public void setUserComment(int userComment) {
		this.userComment = userComment;
	}

	public int getUserReply() {
		return userReply;
	}

	public void setUserReply(int userReply) {
		this.userReply = userReply;
	}

	public LocalDateTime getCommentAt() {
		return commentAt;
	}

	public void setCommentAt(LocalDateTime commentAt) {
		this.commentAt = commentAt;
		this.diffTime = getDiferrentTime();

	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
		this.availableReply = isAvailableReply();
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public List<CommentMovie> getReplyComment() {
		return replyComment;
	}

	public void setReplyComment(List<CommentMovie> replyComment) {
		this.replyComment = replyComment;
	}

	public Account getAccountComment() {
		return accountComment;
	}

	public void setAccountComment(Account accountComment) {
		this.accountComment = accountComment;
	}

	public Account getAccountReply() {
		return accountReply;
	}

	public void setAccountReply(Account accountReply) {
		this.accountReply = accountReply;
	}
	public String getDiferrentTime(){
		LocalDateTime now = LocalDateTime.now();

		Period period = Period.between(commentAt.toLocalDate(), now.toLocalDate());
		int year = period.getYears();
		int month = period.getMonths();
		int day = period.getDays();
		if(year>0){
			return year+" năm trước ";
		}
		if(month>0){
			return month+" tháng trước ";
		}
		if(day>0){
			return day+" ngày trước ";
		}
		Duration duration = Duration.between(commentAt,now);
		long hour = duration.toHours();
		long minute = duration.toMinutes();
		long second = duration.toSeconds();
		if(hour>0){
			return hour+" giờ trước ";
		}
		if(minute>0){
			return minute+" phút trước ";
		}
		if(second>0){
			return second+" giây trước ";
		}
		return "Vừa mới đây";
	}
	public List<CommentMovie> fiveReply(){
		return daoCommentMovie.getCommentMovie(idMovie,0,5,true,id);
	}


	public boolean isAvailableReply() {

		return daoCommentMovie.availableCommentToRender(idMovie,0,true,id)!=0;
	}

	public void setAvailableReply(boolean availableReply) {
		this.availableReply = availableReply;
	}

	@Override
	public String toString() {
		return "CommentMovie{" +
				"id=" + id +
				", content='" + content + '\'' +
				", userComment=" + userComment +

				", commentAt=" + commentAt +
				", accountComment=" + accountComment +
				",getDiferrentTime"+getDiferrentTime()+
				'}';
	}

	public static void main(String[] args) throws NoSuchFieldException {

	}
}
