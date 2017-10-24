package com.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;
import javax.sql.rowset.CachedRowSet;
import com.sun.rowset.CachedRowSetImpl;


/**
 * DBConnection
 * @author Yifan Ning
 */

public class DBConnection {

    private static DBConnection instance;
    public Connection conn;
    
    private DBConnection() throws SQLException {
		
	try {
	    Properties prop = new Properties();
	    InputStream resourceStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("db-connection.properties"); 
	    prop.load(resourceStream);

	    String url = "jdbc:mysql://127.0.0.1:3306/";    
	    String db = prop.getProperty("database");
	    String driver = "com.mysql.jdbc.Driver";
	    String user = prop.getProperty("dbuser");
	    String pass = prop.getProperty("dbpassword");
	   
	    Class.forName(driver).newInstance();
	    this.conn = DriverManager.getConnection(url + db, user, pass);
	    
	} catch (Exception e) {
	    System.err.println("Mysql Connection Error: ");
	    e.printStackTrace();	    
	} 
    }

    public Connection getConnection() throws SQLException{
	return conn;
    }

    
    public static DBConnection getInstance() throws SQLException {
        if (instance == null) {
            instance = new DBConnection();
        } else if (instance.getConnection().isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }

    /**
     * Executes a Query
     * @param query
     * @return
     * @throws SQLException
     */
    public static CachedRowSet executeQuery(String query) throws SQLException {
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection connection = null;
	CachedRowSet rowset = null;
	
	try {		
	    connection = getInstance().getConnection();
	    pstmt = connection.prepareStatement(query);
	    rs = pstmt.executeQuery();

	    rowset = new CachedRowSetImpl();
	    rowset.populate(rs);
	    
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    if (rs != null) {
	    	try {
	    	    rs.close();
	    	} catch (SQLException e) { /* ignored */}
	    }
	    if (pstmt != null) {
	    	try {
	    	    pstmt.close();
	    	} catch (SQLException e) { /* ignored */}
	    }
	    if (connection != null) {
	    	try {
	    	    connection.close();
	    	} catch (SQLException e) { /* ignored */}
	    }
	}
	
	return rowset;	
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
