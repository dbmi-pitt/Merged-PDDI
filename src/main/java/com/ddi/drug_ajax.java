/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ddi;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DBConnection;

public class drug_ajax extends HttpServlet {

    private ResultSet rs=null;
    public String testresult = "";
    public DBConnection dbconnection;
	Connection conn = dbconnection.getConnection();
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws SQLException 
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        
        String result = "";
        try{
            
            String drug1 = request.getParameter("drug"); 
            String sources = (String)request.getParameter("source"); 
            String selectAllDrugs;
            //selectAllDrugs = "select distinct(precipitant) from interactions1 where `source` in ('source') and object = '" + drug1 + "' order by precipitant ASC";
            if(sources.length()!=0)
            {
            	sources = sources.substring(0,sources.length()-1);
            	selectAllDrugs = "select distinct(precipitant) from interactions1 where `source` in (" + sources + ") and object like '%" + drug1 + "%' order by precipitant ASC";
            }else
            {
            	selectAllDrugs = "select distinct(precipitant) from interactions1 where `source` in ('source') and object = '" + drug1 + "' order by precipitant ASC";
            	//System.out.println(selectAllDrugs);
            }
            //System.out.println("drug_ajax" + sources);
            
            //String selectAllDrugs = "select distinct(precipitant) from interactions1 where `source` in (" + sources + ") and object = '" + drug1 + "' order by precipitant ASC";

            rs = dbconnection.executeQuery(selectAllDrugs);
            
            result += "[";
            
            while(rs.next()){
                result += "\"" + rs.getString("precipitant").toLowerCase() + "\", ";
            }
            
	    if (result.length() > 2)
		result = result.substring(0, result.length()-2);
	    else 
		result = "[\"\"";
            
            result += "]";
                                    
        }
        catch(Exception e){
            result += "]";
            System.out.println("SQLException" + e.getMessage());
            e.printStackTrace();
        }        
        /*if (dbconnection.conn != null && !dbconnection.conn.isClosed()){
			//dbconnection.closeConnection();
        	try { conn.close(); } catch (SQLException logOrIgnore) {}
        	try { DBConnection.select.close(); } catch (SQLException logOrIgnore) {}
		}*/
        try {
        	testresult = result;
        	System.out.println(result);
	    PrintWriter out = response.getWriter();
            out.write(result);
	}
	catch (Exception e){
		e.printStackTrace();
	}finally {
        if (dbconnection.select != null) try { dbconnection.select.close(); } catch (SQLException logOrIgnore) {}
        if (dbconnection.conn != null ) try { dbconnection.closeConnection();} catch (SQLException logOrIgnore) {}
        if (conn != null ) try { conn.close();} catch (SQLException logOrIgnore) {}
        if (rs != null ) try { rs.close();} catch (SQLException logOrIgnore) {}
    	}
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
