package database;

import java.util.List;
import java.util.stream.Collectors;

import org.jdbi.v3.core.Jdbi;

import Log.Log;
import model.Account;

public class JDBiConnector {
	static Jdbi jdbi;

	public static Jdbi me() {
		if (jdbi == null)
			makeConnect();
		return jdbi;
	}

	private static void makeConnect() {

		jdbi = Jdbi.create(DataSource.ds);

	}

	public static boolean insert(Log log) {
		return me().withHandle(handle -> {
			return handle.execute(
					"INSERT INTO `logs` (`level`, `user`, `ip`, `src`, `content`, `status`) VALUES (?,?,?,?,?,?)",
					log.getLevel(), log.getUserId(), log.getIp(), log.getSrc(), log.getContent(), log.getStatus());
		}) == 1;
	}

	public static void main(String[] args) {

	}

}
