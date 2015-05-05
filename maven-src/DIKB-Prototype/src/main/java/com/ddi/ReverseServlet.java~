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
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author chrismartin
 */
public class ReverseServlet extends HttpServlet {

    
    private Connection conn;
    private Statement st;
    private ResultSet rs=null;
    
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
        response.setContentType("text/html;charset=UTF-8");
        
        Results results = new Results(); 
        
        try{
            
            String drug1 = request.getParameter("drug1");
            String drug2 = request.getParameter("drug2");

            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:mysql://192.95.16.175:3306/drugData","drugUser", "wzG5VCLqC5tH8GzM");
            st = conn.createStatement();
            
            String selectAllDrugs = "select * from interactions1 where object = '" + drug2 + "' and precipitant = '"+ drug1+"'" + " order by object, precipitant";
            rs = st.executeQuery(selectAllDrugs);
            
            ArrayList<ArrayList> totalResults = new ArrayList<ArrayList>();
            
            while(rs.next()){
                ArrayList<String> temp = new ArrayList<String>();
                temp.add(rs.getString("object"));
                temp.add(rs.getString("precipitant"));
                temp.add(rs.getString("certainty"));
                temp.add(rs.getString("label"));
                temp.add(rs.getString("source"));
                totalResults.add(temp);
            }
            
            results.setResults(totalResults);
            results.setDrug1(drug2);
            results.setDrug2(drug1);

                        
            HttpSession session = request.getSession();
            session.setAttribute("ResultBean", results);
            
        // forward the request (not redirect)
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");;
            dispatcher.forward(request, response);
                        
        }
        catch(Exception e){
            System.out.println("SQLException" + e.getMessage());
            e.printStackTrace();
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
