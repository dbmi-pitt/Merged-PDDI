<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" import="java.util.*,com.ddi.*,java.util.HashMap.*, java.util.ArrayList.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/ddistyle.css" />
        <title>Drug Interaction Search Results</title>
        <script>
            function toggleVisible(toggleClass){
	        var ddiFirst = 'no'
                var elements = document.getElementsByClassName(toggleClass);
                for (var i = 0; i < elements.length; i++) {
                    if(elements[i].style.display == "none"){
                        elements[i].style.display = "block";
                    }
                    else{
                        elements[i].style.display = "none";
                    }
                }
                var button = "#" + toggleClass + "Button";
                $(button).toggleClass("displayed");
            }
            
            <!-- function hideStuff(){ -->
            <!--     var stuffToHide = document.getElementsByClassName('hide'); -->
            <!--     for (var i = 0; i < stuffToHide.length; i++) { -->
            <!--         stuffToHide[i].style.display = "none"; -->
            <!--     } -->
            <!-- } -->

            function hideStuff(){

                var stuffToHide = document.getElementsByClassName("showAll");

                for (var i = 0; i < stuffToHide.length; i++) {
		    var lineName = stuffToHide[i].className; 
	            var buttonName = lineName.replace("showAll ","");
		    
                    var button = buttonName + "Button";

		    var buttonEle = document.getElementById(button);

		    if (buttonEle != null) {
		        var buttonClass = buttonEle.className;	    
		        if (buttonClass = "noSource buttons") {
			    stuffToHide[i].style.display = "none";
	            }}
	        }

            }

            
            function showAllData(){
                var stuffToShow = document.getElementsByClassName('showAll');
                for(var i=0; i < stuffToShow.length; i++){
                    stuffToShow[i].style.display = "block";
                }
                var buttons = document.getElementsByClassName('buttons');
                for(var i=0; i < stuffToShow.length; i++){
                    $(buttons[i]).addClass('displayed');
                }
            }
        </script>
    </head>
    <body onload="hideStuff();">
        <div id="page">
        
            <header>
            
            <%  Results result = (Results)session.getAttribute("ResultBean");
            %>
            
            <% System.out.println("drug1:" + result.getDrug1()); %>
            <br>
            <% System.out.println("size of results" + result.getResults().size()); %>
            <%
            HashMap<String, ArrayList<String>> results = new HashMap<String, ArrayList<String>>();
            results = result.getResults();
            String tempTag;
            String[] tagArray;
            String drug1 = result.getDrug1();
            String drug2 = result.getDrug2();
            HashMap<String, ArrayList<String>> keySet = new HashMap<String, ArrayList<String>>();
            for (Map.Entry entry : results.entrySet()) {
                    if (entry.getKey() != null) {
                        tempTag = (String)entry.getKey();
                        tagArray = tempTag.split("_");
                        if(keySet.containsKey(tagArray[2]))
                        {
                        	keySet.get(tagArray[2]).add(tagArray[3]);
                        }else
                        {
                        	ArrayList<String> tempsource = new ArrayList<String>();
                        	tempsource.add(tagArray[3]);
                        	keySet.put(tagArray[2], tempsource);
                        }
            }
            }
            %>
            
            <br>

            <div id="scrollheader">

              <c:if test="${sessionScope.ResultBean.results.size()>0 } ">
                    <h2 class="centered">Search Results</h2>
                    <h3 class="centered">Drugs Searched</h3>
                    <p class="centered">Drug 1: <a href="${ResultBean.results.get(0).get(0)}" target="_blank"><c:out value="${ResultBean.drug1}"></c:out></a> - <c:out value="${ResultBean.drug1ID}"></c:out></p>  
                    <p class="centered">Drug 2: <a href="${ResultBean.results.get(0).get(3)}" target="_blank"><c:out value="${ResultBean.drug2}"></c:out></a> - <c:out value="${ResultBean.drug2ID}"></c:out></p>
                  </c:if>
	      <!-- list search condition been selected -->

              <p class="left">&nbsp;&nbsp; <a href="/Merged-PDDI" class="title2"><%="<< " %>New Search</a></p></br>

                    <form name="drugForm" action="SearchServlet" method="POST">
		      <table>
			<tr>
			  <td class="general">
			    drug 1 as Object
			  </td>
			  <td class="general">
			    drug 2 as Precipitant
			  </td>
			  <td class="general">
			  </td>
			</tr>
			<tr>
			  <td class="general">
                            <input name="drug2" value="${ResultBean.drug1}" readonly="readonly">
			  </td>
			  <td class="general">
                            <input name="drug1" value="${ResultBean.drug2}" readonly="readonly">
			  </td>
			  <td class="general"><div id="submitButton"><input class="clear regButton" type="submit" value="Reverse Object/Precipitant"/></div>
			  </td>
			</tr>

		      </table>
		      
		      <h1 align="center">Catalog</h1>
		      <div class="outer">
		      <div class="inner">
		      <table>
		      <tr>
		      <td class="longfields">
		      </td>
		      <c:forEach items="${ResultBean.attributesUpper}" var="attributesUpper">
		      <td class="longfields">${attributesUpper}</td>
		      </c:forEach>
		      </tr>
		      
		      <c:forEach items="${ResultBean.sourcesList}" var="sources">
		      <tr>
		      <td class="general">${sources}</td>
		      <c:forEach items="${ResultBean.attributes}" var="attribute">
		      
		      <%
		      String tempAttribute = (String)pageContext.getAttribute("attribute");
		      String tempSource = (String)pageContext.getAttribute("sources");
		      if(keySet.containsKey(tempAttribute))
		      {
		      //ArrayList<String> trueSource = (ArrayList<String>)keySet.get(tempAttribute);
		      	if(keySet.get(tempAttribute).contains(tempSource))
		      	{
		    	  	out.print("<td class='availabletd'><a href='#"+ tempAttribute + "'>Click</a></td>");
		      	}else
		      	{
		    	  out.print("<td class='general'></td>");
		      	}
		      }else
		      {
		    	  out.print("<td class='general'></td>");
		      }
		      //if(keySet.get(tempA).equals("Drugbank")) {out.print("Click");}
		      %>
		      </c:forEach>
		      </tr>
		      </c:forEach>
		      </table>
		      </div>
		      </div>
                        <c:forEach items="${sessionScope.ResultBean.sourcesList}" var="sources">
                            <input name="sourcesList" type="hidden" value="${sources}">
                        </c:forEach>

                    </form>

                </div>
        </header>
        <br>
        <hr>
        <br>
		    
            <c:if test="${ResultBean.results.size() == 0}"><span class="noResults">No results for selected drugs. Click <a href="/Merged-PDDI">here</a> to search again.</span></c:if>
			<c:if test="${ResultBean.drugClass1 != null}">
			<div class = "title1">Object Drug Class</div><br>
			<blockquote>
			<p>${ResultBean.drugClass1}</p>
			</blockquote>
			</c:if>
			<c:if test="${ResultBean.drugClass2 != null}">
			<div class = "title1">Precipitant Drug Class</div><br>
			<blockquote><p>${ResultBean.drugClass2}</p></blockquote>
			
			</c:if>
            <%
            String testTag;
            int s = 0;
            int a = 0;
            ArrayList<String> valueArray = new ArrayList<String>();
            for(String tempAttribute : result.getAttributes())
            {
            	a = 0;
            	for(String tempSource : result.getSourcesList())
            	{
            		s = 0;
            		testTag = drug1 + "_" + drug2 + "_" + tempAttribute + "_" + tempSource;
            		if(results.containsKey(testTag))
            		{
            			if(a == 0)
            			{
            				a++;
            				//out.print("</p><hr class='clear'>" );
            				out.print("<div class='title1'><a name='" + tempAttribute + "'>" + tempAttribute + "</a></div><br>");
            				
            			}
            			if(s == 0)
            			{
            				s++;
            				out.print("<blockquote>");
            				out.print("<div class='title2'>" + tempSource + "</div><br>");
            			}
            			valueArray = (ArrayList<String>)results.get(testTag);
            			
                        
                        for(String subValue : valueArray)
                        {
                            out.print(subValue + "<br>");
                            
                        }
                        out.print("</blockquote>");
            		}
            	}
            }%>

            <p class="whiteText">Leave this here for CSS purposes</p>
        </div>
    </body>
</html>