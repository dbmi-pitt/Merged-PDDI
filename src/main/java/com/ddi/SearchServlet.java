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
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DBConnection;
import com.dao.SourceAttribute;
//import com.dao.DBConnection;
import com.ddi.Results;

public class SearchServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public ResultSet rs = null;
	public ResultSet rs1 = null;
	public Results results = new Results();
	
	
	public void SearchServlet(){
	}
	
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
	public void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException, SQLException {

		//System.out.println("[DEBUG] SearchServlet ...............");
		
		HashMap<String, ArrayList<String>> searchResults0= new HashMap<String, ArrayList<String>> ();
		HashMap<String, ArrayList<String>> searchResults1= new HashMap<String, ArrayList<String>> ();
		HashMap<String, String> attributeSet= new HashMap<String, String>();
		HashMap<String, String> sourceSet = new HashMap<String, String>();
		String resultTag = null; //"drug1_drug2_field_source"
		String tempTag = null;
		String drugClass1 = null;
		String drugClass2 = null;
		String drug1ID = null;
		String drug2ID = null;
		String selectAllDrugs[] = new String[2];
		String tempAttribute = null;
		String filterAttribute = null;
		DBConnection dbconnection = null;
		Connection conn = DBConnection.getConnection();
		//ArrayList<String> temprecords = new ArrayList<String>();
		String[] attributesUpper = {"Object/Drug2 Class", "Precipitant/Drug1 Class", "Certainty", "Contraindication", "Effect", "PK Mechanism", "ddiType", "Homepage", "Severity", 
				"Description", "URI", "Management Options", "Evidence", "Evidence Source", "Evidence Statement","Date Annotated", "Who Annotated", "Numeric Value", 
				"Pathway", "Precaution", "Research Statement Label", "Research Statement"};
		String[] attributes = {"DrugClass1", "DrugClass2", "certainty", "contraindication", "ddiPkEffect", "ddiPkMechanism", "ddiType", "homepage", "severity", 
				"label", "uri", "managementOptions", "evidence", "evidenceSource", "evidenceStatement", "dateAnnotated", "whoAnnotated", "numericVal", 
				"pathway", "precaution", "researchStatementLabel", "researchStatement"};
		String[] testarray = SourceAttribute.getNodistinction();
		ArrayList<String> nodistinction = new ArrayList(Arrays.asList(testarray));
		SourceAttribute sourceattribute = new SourceAttribute();
		String[] defaultAttributes = sourceattribute.getDefaultAttribute();
		int ai = 0;
		for(String attribute: attributes)
		{
			attributeSet.put(attribute, attributesUpper[ai++]);
		}
		
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
			results.setAttributeSet(attributeSet);
			results.setDefaultAttributes(defaultAttributes);

			//System.out.println("Drug inputs: 1>" + drug1 + "|2>" + drug2);

			if (drug1 == null && drug2 == null) {
				drug1 = request.getParameterValues("drugList2")[0];
				drug2 = request.getParameterValues("drugList1")[0];
				
			}

			
			for(String source : sources)
			{
				String selectSourceInfo = "select * from sources_category where source = '"+ source +"'";
				rs1 = DBConnection.executeQuery(selectSourceInfo);
				
				while (rs1.next()) {
				//System.out.println(rs1.getString("description"));
				sourceSet.put(source, rs1.getString("description"));
				}
			}
			
				
				selectAllDrugs[0] = "select * from interactions1 where precipitant like '%"
						+ drug1
						+ "%' and object like '%"
						+ drug2
						+ "%'"
						+ " and source = '";
				//System.out.println(selectAllDrugs[0]);
				String tempdrug = null;
				tempdrug = drug1;
				drug1 = drug2;
				drug2 = tempdrug;
				selectAllDrugs[1] = "select * from interactions1 where precipitant like '%"
						+ drug1
						+ "%' and object like '%"
						+ drug2
						+ "%'"
						+ " and source = '";
			for(int z = 0;z < 2;z++)
			{
				tempdrug = drug1;
				drug1 = drug2;
				drug2 = tempdrug;
			for (String source : sources) {
			String tempquery = null;
			if((source.equalsIgnoreCase("Drugbank"))&&(z == 1))
			{
				tempquery = "select * from interactions1 where precipitant = '"
						+ drug2 +"' and object = '"
						+ drug1 +"' and source = 'Drugbank' UNION " + selectAllDrugs[1];
			}else{ 
				if((source.equalsIgnoreCase("NDF-RT"))&&(z == 1))
				{
				tempquery = "select * from interactions1 where precipitant like '%"
						+ drug2 +"%' and object like '%"
						+ drug1 +"%' and source = 'NDF-RT' UNION " + selectAllDrugs[1];
				}else{
					tempquery = selectAllDrugs[z];
				}
			}
			tempquery += source;
			tempquery += "' order by object, precipitant";
			//System.out.println("[INFO] Search Servlet - execute query:" + tempquery);
			
				
			rs = DBConnection.executeQuery(tempquery);
			
			
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
				
				
				if(z==0)
				{
					if(!nodistinction.contains(source))
					{
				for(String attribute : attributes)
				{
					
					resultTag = tempTag + attribute + "+" + source;
					
					
					if(!rs.getString(attribute).contains("None") && rs.getString(attribute) != "" && rs.getString(attribute).length() != 0)
					{
						
						tempAttribute = rs.getString(attribute);
						if(attribute == "researchStatementLabel")
							tempAttribute = tempAttribute.replaceAll("_", " ");
						if(tempAttribute.contains("|"))
						{
							filterAttribute = tempAttribute.replace("|","");
							//System.out.println("***********"+filterAttribute);
						}else{
							filterAttribute = tempAttribute;
						}
						if((searchResults0.containsKey(resultTag))||(searchResults0.get(resultTag) != null))
						{
							//System.out.println("_______________________________________");
							//System.out.println(">>1" + searchResults.get(resultTag));
							//temprecords = (ArrayList<String>)searchResults.get(resultTag);
							if(!searchResults0.get(resultTag).contains(filterAttribute))
							{
								searchResults0.get(resultTag).add(filterAttribute);
							}
							
						}else
						{
							ArrayList<String> temprecords = new ArrayList<String>();
							temprecords.add(filterAttribute);
							searchResults0.put(resultTag, new ArrayList<String>(temprecords));
							//System.out.println(resultTag);
							//System.out.println(searchResults.get(resultTag));
						}
						
						
					}
					
					
					if(attribute == "ddiPkEffect")
					{
						attribute = "effectConcept";
						if(!rs.getString(attribute).contains("None") && rs.getString(attribute) != "" && rs.getString(attribute).length() != 0)
						{
							tempAttribute = rs.getString(attribute);
							//filter out "|"
							if(tempAttribute.contains("|"))
							{
								filterAttribute = tempAttribute.replace("|","");
							}else{
								filterAttribute = tempAttribute;
							}
							
							//this tag already exists
							if((searchResults0.containsKey(resultTag))||(searchResults0.get(resultTag) != null))
							{
								if(!searchResults0.get(resultTag).contains(filterAttribute))
								{
									searchResults0.get(resultTag).add(filterAttribute);
								}
							}else  //this tag starts up
							{
								ArrayList<String> temprecords = new ArrayList<String>();
								temprecords.add(filterAttribute);
								searchResults0.put(resultTag, new ArrayList<String>(temprecords));
							}
						}
					}

					resultTag = null;
					
					
				}
				}
				}else
				{
					
					for(String attribute : attributes)
					{
						
						resultTag = tempTag + attribute + "+" + source;
						
						
						if(!rs.getString(attribute).contains("None") && rs.getString(attribute) != "" && rs.getString(attribute).length() != 0)
						{
							
							tempAttribute = rs.getString(attribute);
							if(attribute == "researchStatementLabel")
								tempAttribute = tempAttribute.replaceAll("_", " ");
							if(tempAttribute.contains("|"))
							{
								filterAttribute = tempAttribute.replace("|","");
								//System.out.println("***********"+filterAttribute);
							}else{
								filterAttribute = tempAttribute;
							}
							
							if((searchResults1.containsKey(resultTag))||(searchResults1.get(resultTag) != null))
							{
								//System.out.println("_______________________________________");
								//System.out.println(">>1" + searchResults.get(resultTag));
								//temprecords = (ArrayList<String>)searchResults.get(resultTag);
								if(!searchResults1.get(resultTag).contains(filterAttribute))
								{
									searchResults1.get(resultTag).add(filterAttribute);
								}
								
							}else
							{
								ArrayList<String> temprecords = new ArrayList<String>();
								temprecords.add(filterAttribute);
								searchResults1.put(resultTag, new ArrayList<String>(temprecords));
								//System.out.println(resultTag);
								//System.out.println(searchResults.get(resultTag));
							}
							
							
						}
						if(attribute == "ddiPkEffect")
						{
							attribute = "effectConcept";
							if(!rs.getString(attribute).contains("None")&& rs.getString(attribute) != ""  && rs.getString(attribute).length() != 0)
							{
								tempAttribute = rs.getString(attribute);
								//filter out "|"
								if(tempAttribute.contains("|"))
								{
									filterAttribute = tempAttribute.replace("|","");
								}else{
									filterAttribute = tempAttribute;
								}
								
								//this tag already exists
								if((searchResults1.containsKey(resultTag))||(searchResults1.get(resultTag) != null))
								{
									if(!searchResults1.get(resultTag).contains(filterAttribute))
									{
										searchResults1.get(resultTag).add(filterAttribute);
									}
								}else  //this tag starts up
								{
									ArrayList<String> temprecords = new ArrayList<String>();
									temprecords.add(filterAttribute);
									searchResults1.put(resultTag, new ArrayList<String>(temprecords));
								}
							}
						}

						resultTag = null;
						
						
					}
					
				}
				
				
			}
			}
			}
			
			//System.out.println("[DEBUG] Search servlet, total results:" + searchResults.size());
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

			results.setResults0(searchResults0);
			results.setResults1(searchResults1);
			results.setDrug1(drug1);
			
			results.setDrug2(drug2);
			results.setDrug1ID(drug1ID);
			results.setDrug2ID(drug2ID);
			results.setSourceSet(sourceSet);
			if(drugClass1 != null)
				results.setDrugClass1(drugClass1);
			if(drugClass2 != null)
				results.setDrugClass2(drugClass2);

			
			
			
			HttpSession session = request.getSession();
			session.setAttribute("ResultBean", results);
			

			RequestDispatcher dispatcher = request
					.getRequestDispatcher("index.jsp");

			dispatcher.forward(request, response);
			/*if (dbconnection.conn != null && !dbconnection.conn.isClosed()){
				try { conn.close(); } catch (SQLException logOrIgnore) {}
				try { DBConnection.select.close(); } catch (SQLException logOrIgnore) {}
			}*/
		} catch (Exception e) {
			System.out.println("Exception" + e.getMessage());
			e.printStackTrace();
		} finally {
	        if (dbconnection.select != null) try { dbconnection.select.close(); } catch (SQLException logOrIgnore) {}
	        if (dbconnection.conn != null ) try { dbconnection.conn.close();} catch (SQLException logOrIgnore) {}
	        if (dbconnection.result != null ) try { dbconnection.result.close();} catch (SQLException logOrIgnore) {}
	        if (conn != null ) try { conn.close();} catch (SQLException logOrIgnore) {}
	        if (rs != null ) try { rs.close();} catch (SQLException logOrIgnore) {}
	        if (rs1 != null ) try { rs1.close();} catch (SQLException logOrIgnore) {}
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
