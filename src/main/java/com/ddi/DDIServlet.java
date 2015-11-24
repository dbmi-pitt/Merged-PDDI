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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DBConnection;
import com.dao.SourceAttribute;

public class DDIServlet extends HttpServlet {

	//private Connection conn;
	//private Statement st;
	public DBConnection dbconnection;
	Connection conn = DBConnection.getConnection();
	//private ResultSet rs = null;
	private ResultSet rs2 = null;
	private ResultSet rs1 = null;
	private ResultSet rs3 = null;
	String s = "test: ";
	public Drug drug = new Drug();

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 * 
	 * @param request
	 *            servlet request
	 * @param response
	 *            servlet response
	 * @throws ServletException
	 *             if a servlet-specific error occurs
	 * @throws IOException
	 *             if an I/O error occurs
	 * @throws SQLException 
	 */
	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException, SQLException {

		//System.out.println("[DEBUG] DDI Servlet ......................");
		ArrayList<String> drugNames = new ArrayList<String>();
		SourceAttribute sourceattribute = new SourceAttribute();
		String[] sources = sourceattribute.getSources();
		String[] sourceExp = sourceattribute.getExamples();
		String selectedSources = "";
		String tempcategory = null;
		HashMap<String, ArrayList<String>> sourceSet = new HashMap<String, ArrayList<String>>();
		HashMap<String, String> sourceNum = new HashMap<String, String>();
		HashMap<String, String> sourceExps = new HashMap<String, String>();
		if(request.getParameterMap().containsKey("source")){
			selectedSources = (String)request.getParameter("source"); 
			System.out.println("DDIServlet:"+ selectedSources);
		}
		
		try {
			
			String selectSourceNum = "SELECT `source`,COUNT(*) AS number FROM interactions1 GROUP BY `source`";
			rs3 = dbconnection.executeQuery(selectSourceNum);
			int tempnum, i=0;
			String tempsource = null;
			while(rs3.next())
			{
				tempnum = rs3.getInt("number");
				tempsource = rs3.getString("source");
				//if()
				sourceNum.put(tempsource,Integer.toString(tempnum));
			}
			
			for(String source : sources)
			{
				sourceExps.put(source, sourceExp[i++]);
				String selectAllSourcesQuery = "select * from sources_category where source = '" + source + "'";
				rs1 = dbconnection.executeQuery(selectAllSourcesQuery);
				while(rs1.next())
				{
					tempcategory = rs1.getString("category");
					if(sourceSet.containsKey(tempcategory))
					{
						sourceSet.get(tempcategory).add(source);
					}else{
						ArrayList<String> subsource = new ArrayList<String>();
						subsource.add(source);
						sourceSet.put(tempcategory, subsource);
					}
				}
			}
			
			String selectAllDrugsQuery = "select distinct(object) from interactions1 where object not like '%4-%' order by object";
			
			//System.out.println("[INFO] DDI Servlet - execute query:" + selectAllDrugsQuery);
			

			rs2 = dbconnection.executeQuery(selectAllDrugsQuery);

			while (rs2.next()) {
			    drugNames.add(rs2.getString("object").toLowerCase());
			}
			drug.setDrugNames(drugNames);
			drug.setSourceSet(sourceSet);
			drug.setSourceNum(sourceNum);
			drug.setSourceExp(sourceExps);
			// TESTING
//			System.out.println("drug list in DDI Servlet:");
//			for (String name: drug.getDrugNames()){
//				System.out.println(name);
//			}
//			System.out.println("");

			//System.out.println("[INFO:] save drug beans to session....");

			HttpSession session = request.getSession();
			session.setAttribute("DrugBean", drug);
			/*if (dbconnection.conn != null && !dbconnection.conn.isClosed()){
				//dbconnection.closeConnection();
				try { conn.close(); } catch (SQLException logOrIgnore) {}
				try { DBConnection.select.close(); } catch (SQLException logOrIgnore) {}
			}*/

			// forward the request (not redirect)
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("DDIhome.jsp");

			//System.out.println("[INFO:] forward from DDI Servlet to DDIhome.jsp ....");

			dispatcher.forward(request, response);

		} catch (Exception e) {
			System.out.println("SQLException" + e.getMessage());
			e.printStackTrace();
		} finally {
		        if (dbconnection.select != null) try { dbconnection.select.close(); } catch (SQLException logOrIgnore) {}
		        if (dbconnection.conn != null ) try { dbconnection.closeConnection();} catch (SQLException logOrIgnore) {}
		        if (conn != null ) try { conn.close();} catch (SQLException logOrIgnore) {}
		        if (rs1 != null ) try { rs1.close();} catch (SQLException logOrIgnore) {}
		        if (rs2 != null ) try { rs2.close();} catch (SQLException logOrIgnore) {}
/*
			try {
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Failed to close connection");
			}*/
		}
	}

	// <editor-fold defaultstate="collapsed"
	// desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 * 
	 * @param request
	 *            servlet request
	 * @param response
	 *            servlet response
	 * @throws ServletException
	 *             if a servlet-specific error occurs
	 * @throws IOException
	 *             if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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
	 * @param request
	 *            servlet request
	 * @param response
	 *            servlet response
	 * @throws ServletException
	 *             if a servlet-specific error occurs
	 * @throws IOException
	 *             if an I/O error occurs
	 */
	@Override
	public void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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
