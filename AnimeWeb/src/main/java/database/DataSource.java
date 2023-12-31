package database;

import java.sql.Connection;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.List;


import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;


public class DataSource {
//	private static final String DB_URL = "jdbc:mysql://34.126.138.48/animeweb";
	private static final String DB_URL = "jdbc:mysql://localhost/animeweb";
	private static final String USER = "root";
	private static final String PASS = "hcdat1232580";
	private static final HikariConfig config = new HikariConfig();
	private static final String CLASS_NAME = "com.mysql.cj.jdbc.Driver";
	static HikariDataSource ds;
	

	static {

		config.setJdbcUrl(DB_URL);
		config.setUsername(USER);
		config.setPassword(PASS);
		config.setDriverClassName(CLASS_NAME);
		config.setMinimumIdle(100);
		config.setMaximumPoolSize(1000);
		config.setConnectionTimeout(50000);
		config.addDataSourceProperty("cachePrepStmts", "true");
		config.addDataSourceProperty("prepStmtCacheSize", "250");
		config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
		config.setIdleTimeout(Long.MAX_VALUE);
		ds = new HikariDataSource(config);

	}
	
	private DataSource() {
	}

	public static void closeConnection() {
		ds.close();
	}

	public static Connection getConnection() throws SQLException {

		return ds.getConnection();
	}

	public static void main(String[] args) throws SQLException {
		getConnection();
	}


}