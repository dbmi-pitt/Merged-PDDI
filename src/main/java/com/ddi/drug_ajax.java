/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main.java.com.ddi;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.dao.DBConnection;

public class drug_ajax extends HttpServlet {

    private ResultSet rs=null;
    public String testresult = "";
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        
        String result = "";
        try{
            
            String drug1 = request.getParameter("drug");            
            
            String selectAllDrugs = "select distinct(precipitant) from interactions1 where object = '" + drug1 + "' order by precipitant ASC";

            rs = DBConnection.executeQuery(selectAllDrugs);
            
            result += "[";
            
            while(rs.next()){
                result += "\"" + rs.getString("precipitant").toLowerCase() + "\", ";
            }
            
	    if (result.length() > 2)
		result = result.substring(0, result.length()-2);
	    else 
		result = "['No results']";
            
            result += "]";
                                    
        }
        catch(Exception e){
            result += "]";
            System.out.println("SQLException" + e.getMessage());
            e.printStackTrace();
        }        
        
        try {
        	testresult = result;
	    PrintWriter out = response.getWriter();
            out.write(result);
	}
	catch (Exception e){
	    
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
        processRequest(request, response);
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
        processRequest(request, response);
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
