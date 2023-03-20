package dbcontext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil implements DatabaseInfor {
	private static DBUtil instance;

	public DBUtil() {

	}

	public Connection getConnection() throws Exception {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url, user, pass);
		return con;
	}

	public static DBUtil getInstance() {
		if (instance == null) {
			instance = new DBUtil();
		}
		return instance;
	}

	public static void closeConnection(Connection connection) throws SQLException {
		if (connection != null) {
			connection.close();
		}
	}
}
