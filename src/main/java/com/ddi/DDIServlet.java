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
public class DDIServlet extends HttpServlet {

	private Connection conn;
	private Statement st;
	//private ResultSet rs = null;
	private ResultSet rs2 = null;
	String s = "test: ";

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
	 */
	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[DEBUG] DDI Servlet ......................");

		Drug drug = new Drug();
		ArrayList<String> drugNames = new ArrayList<String>();

		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			//String connectionURL = "jdbc:mysql://localhost:3306/drugData?";
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/drugData", "root", "5bboys");
			st = conn.createStatement();

			String selectAllDrugs = "select distinct(object) from interactions1 where object not like '%4-%' order by object";
			
			System.out.println("[INFO] DDI Servlet - execute query:" + selectAllDrugs);
			
			rs2 = st.executeQuery(selectAllDrugs);
			

			while (rs2.next()) {
				drugNames.add(rs2.getString("object").toLowerCase());
			}
			drug.setDrugNames(drugNames);
			
			// TESTING
//			System.out.println("drug list in DDI Servlet:");
//			for (String name: drug.getDrugNames()){
//				System.out.println(name);
//			}
//			System.out.println("");

			System.out.println("[INFO:] save drug beans to session....");

			HttpSession session = request.getSession();
			session.setAttribute("DrugBean", drug);

			// forward the request (not redirect)
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("DDIhome.jsp");

			System.out.println("[INFO:] forward from DDI Servlet to DDIhome.jsp ....");
			
			dispatcher.forward(request, response);

		} catch (Exception e) {
			System.out.println("SQLException" + e.getMessage());
			e.printStackTrace();
		} finally {

			try {
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Failed to close connection");
			}
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
		processRequest(request, response);
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
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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
