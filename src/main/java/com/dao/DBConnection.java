package main.java.com.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;


/**
 * DBConnection
 * @author Yifan Ning
 */

public abstract class DBConnection {

	
    private static Connection conn;


    public DBConnection() {
	   
    }


    protected static Connection getConnection(){
	if (conn == null){
	    return createDBInstance();
	} else
	    return conn;

    }



	/**
	 * Gets a connection to the database
	 * @return Connection
	 */
	protected static Connection createDBInstance() {


	    Properties prop = new Properties();
	    //InputStream input = null;

		
	    //System.out.println("connection url: " + url);
		
	    try {

		//input = new FileInputStream("/home/rdb20/Merged-PDDI/db-connection.properties");
		//prop.load(input);

		InputStream resourceStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("db-connection.properties"); 
		prop.load(resourceStream);
		
		String url = "jdbc:mysql://127.0.0.1:3306/";
		
		String db = prop.getProperty("database");
		String driver = "com.mysql.jdbc.Driver";
		String user = prop.getProperty("dbuser");
		String pass = prop.getProperty("dbpassword");
		url = url + db;
		Class.forName(driver).newInstance();
		conn = DriverManager.getConnection(url, user, pass);

	} catch (Exception e) {

		// error
		System.err.println("Mysql Connection Error: ");
		
		// for debugging error
		e.printStackTrace();
	    }

		if (conn == null)  {
			System.out.println("~~~~~~~~~~ can't get a Mysql connection");
		}
		
		// connection = conn;
		return conn;
	}
	
	/**
	 * Executes a Query
	 * @param query
	 * @return
	 * @throws SQLException
	 */
	public static ResultSet executeQuery(String query) throws SQLException{
		
		conn  = getConnection();
		Statement select = conn.createStatement();
		ResultSet result = select.executeQuery(query);
		
		return result;
		
	}

	/**
	 * Closes the connection to the database
	 * @throws SQLException
	 */
	protected static void closeConnection() throws SQLException{
		
		conn.close();
		
	}
	

	/*
	 * get recordset row count
	 * 
	 * static will allow you to use it independently, persay, 
	 * you don't have to init the class into an object to use this method
	 */
	protected static int getResultSetSize(ResultSet resultSet) {
		int size = -1;

		try {
			resultSet.last();
			size = resultSet.getRow();
			resultSet.beforeFirst();
		} catch(SQLException e) {
			return size;
		}

		return size;
	}


}
