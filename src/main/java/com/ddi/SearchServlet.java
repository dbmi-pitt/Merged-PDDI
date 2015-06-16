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
//import com.dao.DBConnection;
import com.ddi.Results;

public class SearchServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public ResultSet rs = null;
	public Results results = new Results();

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

		System.out.println("[DEBUG] SearchServlet ...............");
		
		HashMap<String, ArrayList<String>> searchResults= new HashMap<String, ArrayList<String>>();
		String resultTag = null; //"drug1_drug2_field_source"
		String tempTag = null;
		String drugClass1 = null;
		String drugClass2 = null;
		String tempAttribute = null;
		String filterAttribute = null;
		//ArrayList<String> temprecords = new ArrayList<String>();
		String[] attributesUpper = {"Object Drug Class", "Precipitant Drug Class", "Certainty", "Contraindication", "ddiPkEffect", "ddiPkMechanism", "ddiType", "Homepage", "Severity", 
				"Label", "URI", "Management Options", "Evidence", "Evidence Source", "Evidence Statement","Date Annotated", "Who Annotated", "Effect Concept", "Numeric Value", 
				"Pathway", "Precaution", "Research Statement Label", "Research Statement"};
		String[] attributes = {"DrugClass1", "DrugClass2", "certainty", "contrindication", "ddiPkEffect", "ddiPkMechanism", "ddiType", "homepage", "severity", 
				"label", "uri", "managementOptions", "evidence", "evidenceSource", "evidenceStatement", "dateAnnotated", "whoAnnotated", "effectConcept", "numericVal", 
				"pathway", "precaution", "researchStatementLabel", "researchStatement"};
		
		try {
			String drug1 = request.getParameter("drug1");
			String drug2 = request.getParameter("drug2");
			String[] sources = request.getParameterValues("sourcesList");
			
			String sourceQuery = "";
			
			if (sources == null) {
				sources = request.getParameterValues("source");
			}

			for (String source : sources) {
				sourceQuery += "'" + source + "'" + ", ";
			}
			sourceQuery = sourceQuery.substring(0, sourceQuery.length() - 2);
			results.setSources(sourceQuery);
			results.setSourcesList(sources);
			results.setAttributes(attributes);
			results.setAttributesUpper(attributesUpper);

			System.out.println("Drug inputs: 1>" + drug1 + "|2>" + drug2);

			if (drug1 == null && drug2 == null) {
				drug1 = request.getParameterValues("drugList1")[0];
				drug2 = request.getParameterValues("drugList2")[0];
			}

			for (String source : sources) {
			String selectAllDrugs = "select * from interactions1 where object = '"
					+ drug1
					+ "' and precipitant = '"
					+ drug2
					+ "'"
					+ " and source = '"
					+ source
					+ "' order by object, precipitant";
			
			System.out.println("[INFO] Search Servlet - execute query:" + selectAllDrugs);

			rs = DBConnection.executeQuery(selectAllDrugs);

			String drug1ID = null;
			String drug2ID = null;
			resultTag = null;
			
			while (rs.next()) {
				if (drug1ID == null)
					drug1ID = rs.getString("drug1ID");
				if (drug2ID == null)
					drug2ID = rs.getString("drug2ID");
				if(drugClass1 == null)
					drugClass1 = rs.getString("DrugClass1");
				if(drugClass2 == null)
					drugClass2 = rs.getString("DrugClass2");
				
				
				tempTag = drug1 + "+" + drug2 + "+";
				
				for(String attribute : attributes)
				{
					
					resultTag = tempTag + attribute + "+" + source;
					
					
					if(!rs.getString(attribute).contains("None"))
					{
						tempAttribute = rs.getString(attribute);
						if(tempAttribute.contains("|"))
						{
							filterAttribute = tempAttribute.replace("|","");
							System.out.println("***********"+filterAttribute);
						}else{
							filterAttribute = tempAttribute;
						}
						if((searchResults.containsKey(resultTag))||(searchResults.get(resultTag) != null))
						{
							System.out.println("_______________________________________");
							System.out.println(">>1" + searchResults.get(resultTag));
							//temprecords = (ArrayList<String>)searchResults.get(resultTag);
							if(!searchResults.get(resultTag).contains(filterAttribute))
							{
								searchResults.get(resultTag).add(filterAttribute);
							}
							
						}else
						{
							ArrayList<String> temprecords = new ArrayList<String>();
							temprecords.add(filterAttribute);
							searchResults.put(resultTag, new ArrayList<String>(temprecords));
							System.out.println(resultTag);
							System.out.println(searchResults.get(resultTag));
						}
						
						//System.out.println(searchResults.get("http://bio2rdf.org/drugbank:DB00641_http://bio2rdf.org/drugbank:DB01026_whoAnnotated_DIKB"));
					}
					
					//System.out.println(">>2" + searchResults.get(resultTag));
					//System.out.println(">>3" + searchResults.get(resultTag));
					resultTag = null;
					
				}
				System.out.println(searchResults.get("http://bio2rdf.org/drugbank:DB00641_http://bio2rdf.org/drugbank:DB01026_whoAnnotated_DIKB"));
				
				
			}
			
			
			System.out.println("[DEBUG] Search servlet, total results:" + searchResults.size());
			/*
			// sourceCSS=null;
			if (totalResults.size() > 0) {
				for (int i = 0; i < totalResults.get(0).size(); i++) {
					Boolean noSources = false;
					for (int j = 0; j < totalResults.size(); j++) {
						if (totalResults.get(j).get(i).equals("None"))
							noSources = true;
					}
					if (noSources == false)
						sourceCSS.add("goodSource displayed buttons");
					else
						sourceCSS.add("noSource buttons");
				}
			}*/

			results.setResults(searchResults);
			results.setDrug1(drug1);
			results.setDrug2(drug2);
			results.setDrug1ID(drug1ID);
			results.setDrug2ID(drug2ID);
			if(drugClass1 != null)
				results.setDrugClass1(drugClass1);
			if(drugClass2 != null)
				results.setDrugClass2(drugClass2);
			//System.out.println(searchResults.get("http://bio2rdf.org/drugbank:DB00641_http://bio2rdf.org/drugbank:DB01026_whoAnnotated_DIKB"));
			//System.out.println(results.getResults().get("http://bio2rdf.org/drugbank:DB00641_http://bio2rdf.org/drugbank:DB01026_whoAnnotated_DIKB"));
			//results.setSourceCSS(sourceCSS);
			}
			
			
			HttpSession session = request.getSession();
			session.setAttribute("ResultBean", results);
			
			System.out.println("[DEBUG] Search servlet, results in session:");
			System.out.println("[DEBUG] "+results.getDrug1()+ "|" + results.getDrug1ID());


			// forward the request (not redirect)
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("index.jsp");

			dispatcher.forward(request, response);

		} catch (Exception e) {
			System.out.println("Exception" + e.getMessage());
			e.printStackTrace();
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
	public void doPost(HttpServletRequest request,
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
