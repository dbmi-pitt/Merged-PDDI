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
 * @author cwm24
 */



public class SearchServlet extends HttpServlet {

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
        
        Results results = new Results();    
        
        try{
            String drug1 = request.getParameter("drug2");
            String drug2 = request.getParameter("drug1");
            
            String[] sources = request.getParameterValues("sourcesList");
            
            String sourceQuery = "";
            
            if(sources == null){
                sources = request.getParameterValues("source");
            }

            for(String source: sources){
                sourceQuery += "'" + source + "'" + ", ";
            }
            sourceQuery = sourceQuery.substring(0, sourceQuery.length()-2);

            results.setSources(sourceQuery);
            results.setSourcesList(sources);
            
            if(drug1==null && drug2==null){
                drug1 = request.getParameterValues("drugList1")[0];
                drug2 = request.getParameterValues("drugList2")[0];
            }

            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:mysql://192.95.16.175:3306/drugData","drugUser", "wzG5VCLqC5tH8GzM");
            st = conn.createStatement();
            
            String selectAllDrugs = "select * from interactions1 where object = '" + drug1 + "' and precipitant = '"+ drug2+"'" 
                    + " and source in (" + sourceQuery + ") order by object, precipitant";
            rs = st.executeQuery(selectAllDrugs);
            
            ArrayList<ArrayList> totalResults = new ArrayList<>();
            ArrayList<String> sourceCSS = new ArrayList<>();
            
            String drug1ID = null;
            String drug2ID = null;
            
            while(rs.next()){
                if(drug1ID==null) drug1ID = rs.getString("drug1ID");
                if(drug2ID==null) drug2ID = rs.getString("drug2ID");
                ArrayList<String> temp = new ArrayList<String>();
                temp.add(rs.getString("drug1"));
                temp.add(rs.getString("object"));
                temp.add(rs.getString("drug1ID"));
                temp.add(rs.getString("drug2"));
                temp.add(rs.getString("precipitant"));
                temp.add(rs.getString("drug2ID"));
                temp.add(rs.getString("certainty"));
                temp.add(rs.getString("contrindication"));
                temp.add(rs.getString("dateAnnotated"));
                temp.add(rs.getString("ddiPkEffect"));
                temp.add(rs.getString("ddiPkMechanism"));
                temp.add(rs.getString("effectConcept"));
                temp.add(rs.getString("homepage"));
                temp.add(rs.getString("label"));
                temp.add(rs.getString("numericVal"));
                temp.add(rs.getString("pathway"));
                temp.add(rs.getString("precaution"));
                temp.add(rs.getString("severity"));
                temp.add(rs.getString("uri"));
                temp.add(rs.getString("whoAnnotated"));
                temp.add(rs.getString("source"));
                temp.add(rs.getString("ddiType"));
                temp.add(rs.getString("evidence"));
                temp.add(rs.getString("evidenceSource"));
                temp.add(rs.getString("evidenceStatement"));
                temp.add(rs.getString("researchStatementLabel"));
                temp.add(rs.getString("researchStatement"));
                temp.add(rs.getString("DrugClass1"));
                temp.add(rs.getString("DrugClass2"));
                totalResults.add(temp);
            }
            
//            sourceCSS=null;
            if(totalResults.size()>0){
                for(int i=0; i<totalResults.get(0).size(); i++){
                    Boolean noSources=false;
                    for(int j=0; j<totalResults.size(); j++){
                        if(totalResults.get(j).get(i).equals("None")) noSources=true;
                    }
                    if(noSources==false) sourceCSS.add("goodSource");
                    else sourceCSS.add("noSource");
                }
            }

            
            results.setResults(totalResults);
            results.setDrug1(drug1);
            results.setDrug2(drug2);
            results.setDrug1ID(drug1ID);
            results.setDrug2ID(drug2ID);
            results.setSourceCSS(sourceCSS);
                        
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
