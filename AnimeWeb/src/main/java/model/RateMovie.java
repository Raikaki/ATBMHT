package model;

import java.time.LocalDateTime;

public class RateMovie {
	private int idMovie;
	private int idUser;
	private double score;
	private LocalDateTime voteAt;

	public RateMovie() {
	}

	public int getIdMovie() {
		return idMovie;
	}

	public void setIdMovie(int idMovie) {
		this.idMovie = idMovie;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public LocalDateTime getVoteAt() {
		return voteAt;
	}

	public void setVoteAt(LocalDateTime voteAt) {
		this.voteAt = voteAt;
	}
}
