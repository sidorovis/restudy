package dataChanger;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

public class DBAdapter {
	private static Connection connection = null;
	private static PreparedStatement pstmt = null;
	private static ResultSet resultSet = null;

	public static Connection getConnection() throws SQLException, IOException {
		Properties props = new Properties();
		FileInputStream in = new FileInputStream("database.properties");
		props.load(in);
		in.close();

		String drivers = props.getProperty("jdbc.drivers");
		if (drivers != null)
			System.setProperty("jdbc.drivers", drivers);

		String url = props.getProperty("jdbc.url");
		String username = props.getProperty("jdbc.username");
		String password = props.getProperty("jdbc.password");

		return DriverManager.getConnection(url, username, password);
	}

	public static ArrayList<Object[]> loadDB() {
		ArrayList<Object[]> cells = new ArrayList<Object[]>();
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement("select * from quests;");
			resultSet = pstmt.executeQuery();
			while (resultSet.next()) {
				cells.add(new Object[] { resultSet.getObject("id"),
						resultSet.getObject("task"),
						resultSet.getObject("description"),
						resultSet.getObject("variants"),
						resultSet.getObject("solve"),
						resultSet.getObject("level") });
			}
		} catch (Exception e) {
			return null;
		} finally {
			try {
				resultSet.close();
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cells;
	}

	public static boolean addQuest(Object[] objects) {
		try {
			connection = getConnection();
			String query = "insert into quests(id, task, description, variants, solve, level) values(?, ?, ?, ?, ?, ?)";
			pstmt = connection.prepareStatement(query);
			pstmt.setObject(1, objects[0]);
			pstmt.setObject(2, objects[1]);
			pstmt.setObject(3, objects[2]);
			pstmt.setObject(4, objects[3]);
			pstmt.setObject(5, objects[4]);
			pstmt.setObject(6, objects[5]);
			pstmt.executeUpdate();
		} catch (Exception e) {
			return false;
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	public static boolean removeQuest(Object[] objects) {
		try {
			connection = getConnection();
			String query = "delete from quests where id=? AND task=? AND description=? AND variants=? AND solve=? AND level=?";
			pstmt = connection.prepareStatement(query);
			pstmt.setObject(1, objects[0]);
			pstmt.setObject(2, objects[1]);
			pstmt.setObject(3, objects[2]);
			pstmt.setObject(4, objects[3]);
			pstmt.setObject(5, objects[4]);
			pstmt.setObject(6, objects[5]);
			pstmt.executeUpdate();
		} catch (Exception e) {
			return false;
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	public static boolean removeAll() {
		try {
			connection = getConnection();
			String query = "delete from quests";
			pstmt = connection.prepareStatement(query);
			pstmt.executeUpdate();
		} catch (Exception e) {
			return false;
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	public static boolean modifyQuest(int column, Object data, Object compare) {
		try {
			connection = getConnection();
			String query;
			switch (column) {
			case 1:
				query = "update quests set task = ? where id = ? ";
				break;
			case 2:
				query = "update quests set description = ? where id = ? ";
				break;
			case 3:
				query = "update quests set variants = ? where id = ? ";
				break;
			case 4:
				query = "update quests set solve = ? where id = ? ";
				break;
			case 5:
				query = "update quests set level = ? where id = ? ";
				break;
			default:
				query = "update quests set task = ? where id = ? ";
				break;
			}
			pstmt = connection.prepareStatement(query);
			pstmt.setObject(1, data);
			pstmt.setObject(2, compare);
			pstmt.executeUpdate();
		} catch (Exception e) {
			return false;
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
}
