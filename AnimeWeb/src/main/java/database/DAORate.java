package database;

import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class DAORate {
	public DAORate() {

	}
	public static double getAVGRate(int idMovie){
		String query="select FORMAT(avg(score), 1) from rates_movie where idMovie=:idMovie;";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("idMovie",idMovie).mapTo(Double.class).findFirst().orElse(0.0);
		});
	}
	public static int getRate(int idUser, int idMovie) {
		Jdbi me = JDBiConnector.me();
		String query = "select score from rates_movie where idMovie=:idMovie and idUser=:idUser";
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("idMovie", idMovie).bind("idUser", idUser).mapTo(Integer.class).findOne().orElse(0);
		});
	}

	public static void voteMovie(int idUser, int idMovie, int score) {
		Jdbi me = JDBiConnector.me();
		String query = "INSERT INTO `rates_movie` (`idMovie`, `idUser`, `score`, `voteAt`) VALUES(:idMovie,:idUser,:score,NOW())";
		me.withHandle(handle -> {
			return handle.createUpdate(query).bind("idMovie", idMovie).bind("idUser", idUser).bind("score", score).execute();
		});
	}

	public static boolean updateVote(int idUser, int idMovie, int score) {
		String query = "update rates_movie set score=:score where idMovie=:idMovie and idUser=:idUser";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createUpdate(query).bind("score", score).bind("idMovie", idMovie).bind("idUser", idUser).execute();
		}) == 1;
	}


	public static void main(String[] args) {
		System.out.println(getRate(1,94));
	}
}
