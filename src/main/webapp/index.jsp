<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" import="java.util.*,com.ddi.*,java.util.HashMap.*, java.util.ArrayList.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/ddistyle.css" />
        
        <!-- Hover Panel -->
        <link rel="stylesheet" type="text/css" media="all" href="css/HoverPanel.css">
        
        <!-- Back to Top -->
        <link rel="stylesheet" href="css/BacktoTop.css">
		<script src="js/modernizr.js"></script>
		
        <title>Drug Interaction Search Results</title>
        <script>
		// Specify the normal table row background color
		//   and the background color for when the mouse 
		//   hovers over the table row.

		var TableBackgroundNormalColor = "#ffffff";
		var TableBackgroundMouseoverColor = "#9999ff";
		

		function ChangeBackgroundColor(row) {
			var allcol = document.getElementsByClassName("generalhead");
			var i;
			//restore background color
			for(i = 0; i < allcol.length; i++)
			{
				allcol[i].style.backgroundColor = "#ffffff";
			}
			var allrow = document.getElementsByClassName("longfields");
			for(i = 0; i < allrow.length; i++)
			{
				allrow[i].style.backgroundColor = "#ededed";
			}
			var allavailable = document.getElementsByClassName("availabletd");
			for(i = 0; i < allavailable.length; i++)
			{
				allavailable[i].style.backgroundColor = "#D5EBD1";
			}
			//set new background color
			row.style.backgroundColor = "rgba(112, 147, 216, 0.5)";
			var tempcol = $(row).attr('id');
			var thecol = document.getElementById(tempcol);
			$(thecol).css('background', 'rgba(112, 147, 216, 0.5)');
			var temprow = $(row).attr('name');
			var therow = document.getElementsByName(temprow);
			$(therow[0]).css('background', 'rgba(112, 147, 216, 0.5)');
			
		}
		
		
		function UserDeleteAttribute(deleterow) {
			
			var attributename = $(deleterow).attr('id');
			var deleteall = document.getElementsByClassName(attributename);
			var j;
			for(j = 0; j < deleteall.length; j++)
			{
				if(deleteall[j].style.display == "none"){
                    deleteall[j].style.display = "table-row";
                }
                else{
                    deleteall[j].style.display = "none";
                }
			}
		}
		
		
		function ShowAttribute(expandbutton) {
			
			var tempAttribute = document.getElementById("attribute-option");
			//alert("test");
			if(tempAttribute.style.display == "none"){
				$(tempAttribute).fadeIn();
				//tempAttribute.style.display = "block";
				$(".overlay").fadeIn();
				var details = document.getElementById("details-pane");
				if(details.style.display == "block")
				{
					details.style.display = "none";
					var allcol = document.getElementsByClassName("generalhead");
					var i;
					//restore background color
					for(i = 0; i < allcol.length; i++)
					{
						allcol[i].style.backgroundColor = "#ffffff";
					}
					var allrow = document.getElementsByClassName("longfields");
					for(i = 0; i < allrow.length; i++)
					{
						allrow[i].style.backgroundColor = "#ededed";
					}
					var allavailable = document.getElementsByClassName("availabletd");
					for(i = 0; i < allavailable.length; i++)
					{
						allavailable[i].style.backgroundColor = "#D5EBD1";
					}
				}
			}else{
				tempAttribute.style.display = "none";
				
			}
		}
		
		function CollapseAttribute() {
			var tempAttribute = document.getElementById("attribute-option");
			$(tempAttribute).fadeOut();
			//tempAttribute.style.display = "none";
			var toggle = document.getElementsByClassName("overlay");
			$(toggle[0]).fadeOut();
			//toggle[0].style.display = "none";
			var titles = document.getElementsByClassName("title");
			var details = document.getElementById("details-pane");
			//if(titles[0].innerHTML != null)
				//details.style.display = "block";
		}
		
		
		function ClosePanel()  {
			var details = document.getElementById("details-pane");
			details.style.display = "none";
			var allcol = document.getElementsByClassName("generalhead");
			var i;
			//restore background color
			for(i = 0; i < allcol.length; i++)
			{
				allcol[i].style.backgroundColor = "#ffffff";
			}
			var allrow = document.getElementsByClassName("longfields");
			for(i = 0; i < allrow.length; i++)
			{
				allrow[i].style.backgroundColor = "#ededed";
			}
			var allavailable = document.getElementsByClassName("availabletd");
			for(i = 0; i < allavailable.length; i++)
			{
				allavailable[i].style.backgroundColor = "#D5EBD1";
			}
		}
		
		/*
        function toggleVisible(toggleClass){
	        var ddiFirst = 'no'
                var elements = document.getElementsByClassName(toggleClass);
                for (var i = 0; i < elements.length; i++) {
                    if(elements[i].style.display == "none"){
                        elements[i].style.display = "table-row";
                    }
                    else{
                        elements[i].style.display = "none";
                    }
                }
                var button = "#" + toggleClass + "Button";
                $(button).toggleClass("displayed");
            }*/
            
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
            
            function presentTag(tablecell){
            	var dpane      = document.getElementById('details-pane');
                var dpanetitle = document.getElementsByClassName('title');
                var dpanedesc  = document.getElementsByClassName('desc');
                
                var newtitle   = $(tablecell).attr('name');
                newtitle += "<br>(";
                newtitle += $(tablecell).attr("id");
                newtitle += ")";
                var newtest = tablecell.childNodes;
                var newtest1 = newtest[0].childNodes;
                var newdesc = newtest1[0].getAttribute("id");
                if(newdesc.indexOf("http") !== -1)
            	{
                	$(dpanedesc).css('word-break','break-all');
            	}else{
            		$(dpanedesc).css('word-break', 'normal');
            	}
                
                //var position = $(tablecell).offset();
                //var ycoord   = position.top - 340;
                //xcoord = position.left;

                dpanetitle[0].innerHTML = newtitle;
                dpanedesc[0].innerHTML = newdesc;
                dpane.style.display = "block";
                dpane.style.top = "9%";
                
            }
        </script>
    </head>
    <body onload="hideStuff();">
    <div class="overlay" onclick = "CollapseAttribute()"></div>
        <div id="page2">
        
            <header>
            
            <%  Results result = (Results)session.getAttribute("ResultBean");%>
            <% System.out.println("drug1:" + result.getDrug1()); %>
            <% System.out.println("size of results" + result.getResults().size()); %>
            <%
            HashMap<String, ArrayList<String>> results = new HashMap<String, ArrayList<String>>();
            HashMap<String, String> attributeSet = new HashMap<String, String>();
            HashMap<String, String> sourceSet = new HashMap<String, String>();
            String[] defaultAttributes = result.getDefaultAttributes();
            //String[] notDefaultAttributes = result.getNotDefaultAttributes();
            List defaultValid = Arrays.asList(defaultAttributes);
            //List notDefaultValid = Arrays.asList(notDefaultAttributes);
            attributeSet = result.getAttributeSet();
            sourceSet = result.getSourceSet();
            results = result.getResults();
            String attributeUpper, tempTag, testTag = null;
            int recordNum = 0;
            String[] tagArray;
            String drug1 = result.getDrug1();
            String drug2 = result.getDrug2();
            HashMap<String, ArrayList<String>> keySet = new HashMap<String, ArrayList<String>>();
            for (Map.Entry entry : results.entrySet()) {
                    if (entry.getKey() != null) {
                        tempTag = (String)entry.getKey();
                        tagArray = tempTag.split("\\+");
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
            
            

            <div id="scrollheader">

              <c:if test="${sessionScope.ResultBean.results.size()>0 } ">
                    <h2 class="centered">Search Results</h2>
                    <h3 class="centered">Drugs Searched</h3>
                    <p class="centered">Drug 1: <a href="${ResultBean.results.get(0).get(0)}" target="_blank"><c:out value="${ResultBean.drug1}"></c:out></a> - <c:out value="${ResultBean.drug1ID}"></c:out></p>  
                    <p class="centered">Drug 2: <a href="${ResultBean.results.get(0).get(3)}" target="_blank"><c:out value="${ResultBean.drug2}"></c:out></a> - <c:out value="${ResultBean.drug2ID}"></c:out></p>
                  </c:if>
	      <!-- list search condition been selected -->

              

                    <form name="drugForm" action="SearchServlet" method="POST">
		    <div align= "center">
		    <table align="center" hidden>
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
		     </div>
		     
		      
	  		
	  		<br>
	  		<div class="centered">
      			<div class="left"> <a href="/Merged-PDDI" class="title3"><%="<< " %>New Search</a></div>
		        <div class="centerblock"><div class="title2">(${ResultBean.drug1} / ${ResultBean.drug2})</div></div>
		        <div id="submitButton"><input class="clear regButton" type="submit" value="Reverse Object/Precipitant"/></div>
		    </div>
		    <p></p>
		      <!--<div align= "center" class="outer">-->
		      <!--<div class="inner">-->
		      
		      <!-- setup attribute option template -->
		      
      		  
		      <div class="table-container">
    		  
    		  <div class="headcol">
		      <table>
		      <thead>
		      <th class="longfields" style="width:173px" onclick = "ShowAttribute(this)">+ More Available Attributes (Expand all)</th>
		      </thead>
		      <tbody>
		      <c:forEach items="${ResultBean.attributes}" var="attribute">
		      <% String tempAttribute = (String)pageContext.getAttribute("attribute");
		      attributeUpper = attributeSet.get(tempAttribute);
		      String attributetester = attributeUpper;%>
		      <tr class = "<%String fixedAttribute = attributeUpper.replaceAll(" ","_");out.print(fixedAttribute);%>" <% if(!defaultValid.contains(attributeUpper)){out.print("style='display:none'");} if(attributeUpper == "PK Mechanism"){attributeUpper = "PK<sup>1</sup> Mechanism";}if(attributeUpper == "ddiType"){attributeUpper = "ddi<sup>2</sup> Type";}%>>
		      <td class ="generalhead" id="<%=fixedAttribute%>" name="<%=attributetester%>" onclick = "UserDeleteAttribute(this)"><%=attributeUpper%> <img border="0" alt="W3Schools" src="images/minus.png" width="17" height="17"></td>
		      </tr>
		      </c:forEach>
		      </tbody>
		      </table>
		      </div>
		      
		      <div class="right">
		      <table>
		      <thead>
		      <c:forEach items="${ResultBean.sourcesList}" var="source">
		      <th class="longfields" id="${source}"><a href="#" title="<%String tempSource = (String)pageContext.getAttribute("source"); out.print(sourceSet.get(tempSource));if(tempSource == "ONC-HighPriority") {tempSource = tempSource.replaceAll("-","- ");}%>"  style="color:#555; text-decoration:none"><%=tempSource%></a></th>
		      </c:forEach>
		      </thead>
		      <tbody>
		      <c:forEach items="${ResultBean.attributes}" var="attribute">
		      <% 
		      String tempAttribute = (String)pageContext.getAttribute("attribute");
		      attributeUpper = attributeSet.get(tempAttribute);%>
		      <tr class = "<%String fixedAttribute = attributeUpper.replaceAll(" ","_");out.print(fixedAttribute);%>"  <% if(!defaultValid.contains(attributeUpper)){out.print("style='display:none'");}%>>
		      
		      <c:forEach items="${ResultBean.sourcesList}" var="sources">
		      
		      <%
		      
		      //String tempAttribute = (String)pageContext.getAttribute("attribute");
		      String tempSource = (String)pageContext.getAttribute("sources");
		      ArrayList<String> valueArray = new ArrayList<String>(); 
		      testTag = drug1 + "+" + drug2 + "+" + tempAttribute + "+" + tempSource;
		      if(keySet.containsKey(tempAttribute))
		      {
		      //ArrayList<String> trueSource = (ArrayList<String>)keySet.get(tempAttribute);
		      	if(keySet.get(tempAttribute).contains(tempSource))
		      	{
		    	  	
		      		out.print("<td class='availabletd' onclick='ChangeBackgroundColor(this)' onmousedown='presentTag(this)'  name='" +attributeUpper +"' id='"+tempSource+"'><a class='pseudolink' href='#'><div id='");
		      		valueArray = (ArrayList<String>)results.get(testTag);
		      		recordNum = 0;
		    	  	for(String subValue : valueArray)
                    {
		    	  		if(subValue.contains("http"))
		    	  		{
		    	  			out.print( "<b>"+ ++recordNum + ". </b><a target=_blank href=" + subValue + ">" + subValue + "</a><br>");
		    	  			//out.print( "<li><a target=_blank href=" + subValue + ">" + subValue + "</a></li>");
		    	  		}else{
		    	  			//out.print( "<li>" + subValue + "</li>");
		    	  			out.print( "<b>"+ ++recordNum + ". </b>" + subValue + "<br>");
		    	  		}
                    }
		      		out.print("' name='" + attributeUpper + "' class='" + tempSource + "' ><bold>Click</bold></div></a>");
		    	  	
		    	  	out.print("</td>");
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
		      </tbody>
		      </table>
		      		        
      
		      </div>
		      <!-- setup details pane template -->
		      <div id="details-pane" style="display: none;">
		      <img onclick = "ClosePanel()" align="right" border="0" alt="W3Schools" src="images/close.png" width="24" height="24">
		      <div id="verticalcenter">
				<br>
        		<h4 class="title"></h4>
        		<div align="left" style="font-size: 12px"class="desc"></div>
        		<br>
      		  </div>
      		  </div>
		      </div>
		      
		      
                        <c:forEach items="${sessionScope.ResultBean.sourcesList}" var="sources">
                            <input name="sourcesList" type="hidden" value="${sources}">
                        </c:forEach>

                    </form>

                </div>
        </header>
        
        <br>
        	<div style="text-align:center" class = "abbreviation"><sup>1</sup> PK = pharmacokinetic;     <sup>2</sup> ddi = drug-drug interactions;</div>
        	
        <br>
		    
            <c:if test="${ResultBean.results.size() == 0}"><div style="text-align:center"><span class="noResults">No results for selected drugs. Click <a href="/Merged-PDDI">here</a> to search again.</span></div></c:if>
			<!--  
			<c:if test="${ResultBean.drugClass1 != 'None'}">
			<div class = "title1">Object Drug Class</div><br>
			<blockquote>
			<p>${ResultBean.drugClass1}</p>
			</blockquote>
			</c:if>
			<c:if test="${ResultBean.drugClass2 != 'None'}">
			<div class = "title1">Precipitant Drug Class</div><br>
			<blockquote><p>${ResultBean.drugClass2}</p></blockquote>
			</c:if>
			-->

            
        </div>

        
        <a href="#0" class="cd-top">Top</a>
        
        <div class="secondpagemargin">
        <BR>
<h3>License</h3>

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br/>
<span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Dataset" property="dct:title" rel="dct:type">Drug Interaction Knowledge Base (DIKB)</span> 
by <a xmlns:cc="http://creativecommons.org/ns#" href="http://www.dbmi.pitt.edu/person/richard-boyce-phd" property="cc:attributionName" rel="cc:attributionURL">Richard D. Boyce</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.


<BR>
<font size="-2" color="#999999">
<p>

<h3>MEDICAL DISCLAIMER</h3>

<b>No advice</b>
This website contains general information about medical conditions and treatments.  The information is not advice, and should not be treated as such.

<b>Limitation of warranties</b>

The medical information on this website is provided "as is" without any representations or warranties, express or implied. Neither the author (Richard Boyce) or the University of Pittsburgh make any representations or warranties in relation to the medical information on this website.

Without prejudice to the generality of the foregoing paragraph, Neither the author (Richard Boyce) or the University of Pittsburgh warrant that:

<ul>
  <li>the medical information on this website will be constantly available, or available at all; or</li>

  <li>the medical information on this website is complete, true, accurate, up-to-date, or non-misleading.</li>
</ul>

<b>Professional assistance</b>

You must not rely on the information on this website as an alternative to medical advice from your doctor or other professional healthcare provider.

If you have any specific questions about any medical matter you should consult your doctor or other professional healthcare provider.

If you think you may be suffering from any medical condition you should seek immediate medical attention.

You should never delay seeking medical advice, disregard medical advice, or discontinue medical treatment because of information on this website.

<BR>
<b>Liability</b>
<BR>
Nothing in this medical disclaimer will limit any of our liabilities in any way that is not permitted under applicable law, or exclude any of our liabilities that may not be excluded under applicable law.
<BR>
<b>About this medical disclaimer</b>
<BR>
We created this <a href="http://www.freenetlaw.com/free-medical-disclaimer/">medical disclaimer</a> with the help of a Contractology precedent available at www.freenetlaw.com.
    Premium templates available from Contractology include <a href="http://www.contractology.com/precedents/non-disclosure-agreement.html">confidential disclosure agreement forms</a>.

</p>
</font>
<a href="#0" class="cd-top">Top</a>
<P><HR>
<span style="width: 60px"></span> 
<BR><IMG src="images/logo.jpg" alt="logo.jpg" align="bottom">
<FONT SIZE="-1"><P>Copyright &#169 Copyright (C) 2015 - 2016 Richard D. Boyce<BR>All Rights Reserved<BR>
</FONT>
        </div>
		<div id="attribute-option" style="display:none">
		      
		      <table>
		      <thead>
		      <th class="optiontitle" onclick = "CollapseAttribute()">
        		Available Attributes<br>(Collapse all)
        	  </th>
        	  </thead>
        	  <tbody>
        		<c:forEach items="${ResultBean.attributesUpper}" var="attribute">
        		<tr class="<% String tempAttribute = (String)pageContext.getAttribute("attribute");String fixedAttribute = tempAttribute.replaceAll(" ","_");out.print(fixedAttribute);%>" <%if(defaultValid.contains(tempAttribute)){out.print("style = 'display:none'");}else{out.print("style = 'display:table-row'");}if(tempAttribute == "ddiType"){tempAttribute = "ddi<sup>2</sup> Type";}if(tempAttribute == "PK Mechanism"){tempAttribute = "PK<sup>1</sup> Mechanism";}%>><td class="generalhead">
        		<div align="right" id="<%=fixedAttribute %>" onclick = "UserDeleteAttribute(this)" style = "font-size:12px"><%=tempAttribute %>  <img border="0" alt="W3Schools" src="images/plus.png" width="14" height="14"></div>
        		</td></tr>
        		</c:forEach>
        	  </tbody>
        	  </table>
      		  
      		  </div>
    </body>
    
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">
/*
$(function(){
  $('.thumbs div').on('mousedown', function(e){
    var dpane      = $('#details-pane');
    var dpanetitle = $('.title');
    var dpanedesc  = $('.desc');
    var newtitle   = $(this).attr('name');
    newtitle += " (";
    newtitle += $(this).attr("class");
    newtitle += ")";
    var newdate    = $(this).attr('name');
    var newdesc    = $(this).parent().next('meta.desc').attr('content');
    if(newdesc.includes("http"))
	{
		dpanedesc.css('word-break','break-all');
	}else{
		dpanedesc.css('word-break', 'normal');
	}
    
    var position = $(this).offset();
    var imgwidth = $(this).attr('id');
    
    
    dpanetitle.html(newtitle);
    dpanedesc.html(newdesc);
    
    dpane.css({'top': '27%', 'display': 'block'});
    
  }).on('mouseout', function(e){
    
  });
  
  $('#details-pane').on('mouseover', function(e){
    $(this).css('display','block');
  });
  $('#details-pane').on('mouseout', function(e){

    var e = e.toElement || e.relatedTarget;
    if (e.parentNode == this || e.parentNode.parentNode == this || e.parentNode.parentNode.parentNode == this || e == this || e.nodeName == 'IMG') {
      return;
    }

  });
});*/
</script>

</html>