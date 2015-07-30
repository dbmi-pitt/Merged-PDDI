<%@ page contentType="text/html" pageEncoding="UTF-8" session="true" isELIgnored="false" import="java.util.*,com.ddi.*,java.util.HashMap.*, java.util.ArrayList.*" %>
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
        <link href="css/flat-ui.min.css" rel="stylesheet"/>
        <link href="css/demo.css" rel="stylesheet"/>
		<script src="js/modernizr.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
		
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
			setdefaultattribute();
		}
		
		function Expandall()
		{
			
			//attribute bar disappear all
			var subattribute = document.getElementById("attributebar").getElementsByTagName("tr");
			var z;
			for(z = 0; z < subattribute.length; z++)
			{
				if(subattribute[z].style.display == "table-row"){
                    subattribute[z].style.display = "none"; 
                }
			}
			
			//attribute table show all
			var attributetable = document.getElementsByClassName("table1");
			for(var w = 0; w < 4 ; w++)
			{	subattribute = attributetable[w].getElementsByTagName("tr");
				for(z = 0; z < subattribute.length; z++)
				{
					if(subattribute[z].style.display != "table-row"){
                    	subattribute[z].style.display = "table-row";
                    	
                	}
				}
			}
			
			//change "Expand All" to "Collapse All"
			var expandalltext = document.getElementsByClassName("expandall");
			expandalltext[0].innerHTML = "Collapse all"; //table1
			expandalltext[0].setAttribute('onclick', 'CollapseAll()'); //table1
			expandalltext[1].innerHTML = "Collapse all"; //table2
			expandalltext[1].setAttribute('onclick', 'CollapseAll()'); //table2
			setdefaultattribute();
		}
		
		function CollapseAll()
		{
			
			//attribute bar disappear all
			var subattribute = document.getElementById("attributebar").getElementsByTagName("tr");
			var z;
			for(z = 1; z < subattribute.length; z++)
			{
				if(subattribute[z].style.display == "none"){
                    subattribute[z].style.display = "table-row"; 
                }
			}
			
			//attribute table show all
			var attributetable = document.getElementsByClassName("table1");
			for(var w = 0; w < 4 ; w++)
			{	subattribute = attributetable[w].getElementsByTagName("tr");
				for(z = 1; z < subattribute.length; z++)
				{
					if(subattribute[z].style.display != "none"){
                    	subattribute[z].style.display = "none";
                    	
                	}
				}
			}
			var original = getCookie("original");
			var temporiginal = original.substring(2,original.length-2);
			var originalarray = temporiginal.split(",_");
			//alert(originalarray);
			var anotherc;
			var attributebar = document.getElementById("attributebar");
			for(var j = 0;j<originalarray.length;j++)
			{
				for(w = 0; w < 4 ; w++)
				{	
					var collapseobject = attributetable[w].getElementsByClassName(originalarray[j]);
					collapseobject[0].style.display = "table-row";
				}
				var anotherc = attributebar.getElementsByClassName(originalarray[j]);
	           	anotherc[0].style.display = "none";
			}
			
			
			//change "Collapse All" to "Expand All"
			var expandalltext = document.getElementsByClassName("expandall");
			expandalltext[0].innerHTML = "Expand all"; //table1
			expandalltext[0].setAttribute('onclick', 'Expandall()'); //table1
			expandalltext[1].innerHTML = "Expand all"; //table2
			expandalltext[1].setAttribute('onclick', 'Expandall()'); //table2
			setdefaultattribute();
		}
		
		function ShowAttribute(expandbutton) {
			//alert(localStorage['defaults']);
			var tempAttribute = document.getElementById("attribute-option");
			//alert("test");
			if(tempAttribute.style.display == "none"){
				$(tempAttribute).fadeIn();
				//tempAttribute.style.display = "block";
				$(".overlay").fadeIn();
				var details = document.getElementsByName("details");
				var j;
				for(j = 0;j < details.length;j++)
				{
				
					if(details[j].style.display != "none")
					{
						details[j].style.display = "none";
					}
				}
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
			var details = document.getElementsByName("details");
			var i;
			for(i = 0; i < details.length; i++)
			{
				details[i].style.display = "none";
				//$(details[i]).animate({width: "toggle"});
			}
			
			var allcol = document.getElementsByClassName("generalhead");
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

            
            function presentTag(tablecell){
            	//var dpane      = document.getElementById('details-pane');
                //var dpanetitle = document.getElementsByClassName('title');
                //var dpanedesc  = document.getElementsByClassName('desc');
                var previousPanel = document.getElementsByName("details");
                var i;
				for(i = 0; i < previousPanel.length; i++)
				{
					previousPanel[i].style.display = "none";
				}
                
                var tempattribute = $(tablecell).attr('name');
                var whitespace = " ";
                var tempattribute1 = tempattribute.replace(" ","");
                var tempattribute2 = tempattribute1.replace(" ","");
                
                var tempsource= $(tablecell).attr("id");
                var dpane = document.getElementsByClassName(tempattribute2+tempsource);
                
                /*var newtest = tablecell.childNodes;
                var newtest1 = newtest[0].childNodes;
                var newdesc = newtest1[0].getAttribute("id");
                if(newdesc.indexOf("http") !== -1)
            	{
                	$(dpanedesc).css('word-break','break-all');
            	}else{
            		$(dpanedesc).css('word-break','normal');
            	}*/
                
                //var position = $(tablecell).offset();
                //var ycoord   = position.top - 340;
                //xcoord = position.left;

                //dpanetitle[0].innerHTML = newtitle;
                //dpanedesc[0].innerHTML = newdesc;
                //dpane[0].style.display = "block";
                //$(dpane[0]).toggle('slide', 'left', 500);
                $(dpane[0]).animate({
                width: "toggle"
            });  
                
            }
            
            
            function setdefaultattribute(){
            	
            	var attributetable = document.getElementsByClassName("table1");
				var subattribute = attributetable[0].getElementsByTagName("tr");
				var tempdefault1;
				var tempdefault2;
				var defaultset = "";
				var b = 0;
				//alert(subattribute.length);
    			for(z = 1; z < subattribute.length; z++)
    			{
    				
					//tempdefault = $(subattribute[z]).attr('class');
					//alert(tempdefault);
					if(subattribute[z].style.display != "none"){
    					
    					tempdefault1 = subattribute[z].className;
                    	defaultset += tempdefault1;
                    	defaultset += "+";
                    }
    			}
    			setCookie("defaulttest", defaultset, 1);
    			var test = getCookie("defaulttest");
    			//alert(test);
    			//localStorage['defaults'] = defaultset;
    			//alert(localStorage['defaults']);
            }
            
            function setCookie(cname,cvalue,exdays) {
                var d = new Date();
                d.setTime(d.getTime() + (exdays*60*60*1000));
                var expires = "expires=" + d.toGMTString();
                document.cookie = cname+"="+cvalue+"; "+expires;
            }

            function getCookie(cname) {
                var name = cname + "=";
                var ca = document.cookie.split(';');
                for(var i=0; i<ca.length; i++) {
                    var c = ca[i];
                    while (c.charAt(0)==' ') c = c.substring(1);
                    if (c.indexOf(name) == 0) {
                        return c.substring(name.length, c.length);
                    }
                }
                return "";
            }
        </script>
    </head>
    <body class="body1">
    <div id = "content">
    <div class="overlay" onclick = "CollapseAttribute()"></div>
        <div id="page2">
        
            <header>
            
            <% Results result = (Results)session.getAttribute("ResultBean"); %>
            <% System.out.println("drug1:" + result.getDrug1()); %>
            <% System.out.println("size of results" + result.getResults0().size()); %>
            <%
            HashMap<String, ArrayList<String>> results = new HashMap<String, ArrayList<String>>();
            HashMap<String, String> attributeSet = new HashMap<String, String>();
            HashMap<String, String> sourceSet = new HashMap<String, String>();
            String originaldefault = Arrays.toString(result.getDefaultAttributes());
            originaldefault = originaldefault.replaceAll(" ", "_");
            String[] defaultAttributes;
            String tempdefaultset = null;
            String tempnounderline;
            //get cookie
            Cookie cookie = null;
            Cookie[] cookies = null;
            cookies = request.getCookies();
            Cookie c = new Cookie("original", originaldefault);
            c.setMaxAge(24*60*60);
            response.addCookie(c);
            if( cookies != null ){
               int z = cookies.length;
               for (int i = 0; i < z; i++){
                  cookie = cookies[i];
                  String cookiename = cookie.getName();
                  if(cookiename.equals("defaulttest"))
                  {
                  	tempdefaultset = cookie.getValue();
                  }
                  if(cookiename.equals("original"))
                  {
                  	System.out.println(cookie.getValue());
                  }
                 
               }
           	}
            
            if(tempdefaultset == null)
            {
            	defaultAttributes = result.getDefaultAttributes();
            }else{
            	tempnounderline = tempdefaultset.replaceAll("_"," ");
            	tempnounderline = tempnounderline.substring(0, tempnounderline.length()-1);
            	System.out.println(tempnounderline);
            	defaultAttributes = tempnounderline.split("\\+");
            }
            
            //defaultAttributes = result.getDefaultAttributes();
            //String[] notDefaultAttributes = result.getNotDefaultAttributes();
            List defaultValid = Arrays.asList(defaultAttributes);
            //List notDefaultValid = Arrays.asList(notDefaultAttributes);
            attributeSet = result.getAttributeSet();
            sourceSet = result.getSourceSet();
            %>
            <%

%>
            

            <div id="scrollheader">

              <c:if test="${sessionScope.ResultBean.results0.size()>0 } ">
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
		     
		      
	  		
	  		
	  		<div style ="align: left">
      			<div class="left" id= "bluea"> <a href="/Merged-PDDI" id="bluea"><%="<< "%>New Search</a></div>
      		</div>
      		<div class="centered">
		        <div class="centerblock"><div class="title2">(${ResultBean.drug2} / ${ResultBean.drug1})</div></div>
		        
		    </div>
		    
		    <!--     Table 1      -->
		    <%
		    
            results = result.getResults1();
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
		    <p></p>
		      <!--<div align= "center" class="outer">-->
		      <!--<div class="inner">-->
		      
		      <!-- setup attribute option template -->
		      
      		  
		      <div class="table-container">
    		  
    		  <div class="headcol">
		      <table  class = "table1">
		      <thead>
		      <th class="longfields" style="width:210px" >
		      <div id = "bluea" style = "font-size:12px"><a onclick = "ShowAttribute(this)">+ More Available Attributes
		      </a><br>
		      <a class = "expandall" onclick = "Expandall()">Expand all
		      </a>
		      </div>
		      </th>
		      </thead>
		      <tbody>
		      <c:forEach items="${ResultBean.attributes}" var="attribute">
		      <% String tempAttribute = (String)pageContext.getAttribute("attribute");
		      attributeUpper = attributeSet.get(tempAttribute);
		      String attributetester = attributeUpper;%>
		      <tr class = "<%String fixedAttribute = attributeUpper.replaceAll(" ","_");out.print(fixedAttribute);%>" <% if(!defaultValid.contains(attributeUpper)){out.print("style='display:none' name = 'notdefaulttable'");}else{out.print(" name = 'defaultattribute'");} if(attributeUpper == "PK Mechanism"){attributeUpper = "PK(pharmacokinetic) Mechanism";}if(attributeUpper == "ddiType"){attributeUpper = "ddi(drug-drug interactions) Type";}%>>
		      <td class ="generalhead" id="<%=fixedAttribute%>" name="<%=attributetester%>" onclick = "UserDeleteAttribute(this)"><%=attributeUpper%> <img border="0" alt="W3Schools" src="images/minus.png" width="17" height="17"></td>
		      </tr>
		      </c:forEach>
		      </tbody>
		      </table>
		      </div>
		      
		      <div class="right">
		      <table class = "table1">
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
		      <tr class = "<%String fixedAttribute = attributeUpper.replaceAll(" ","_");out.print(fixedAttribute);%>"  <% if(!defaultValid.contains(attributeUpper)){out.print(" style='display:none' name = 'notdefaulttable'");}else{out.print(" name='defaultattribute'");}%>>
		      
		      <c:forEach items="${ResultBean.sourcesList}" var="sources">
		      
		      <%
		      
		      //String tempAttribute = (String)pageContext.getAttribute("attribute");
		      String tempSource = (String)pageContext.getAttribute("sources");
		      String attributeSpace;
		      ArrayList<String> valueArray = new ArrayList<String>(); 
		      testTag = drug1 + "+" + drug2 + "+" + tempAttribute + "+" + tempSource;
		      if(keySet.containsKey(tempAttribute))
		      {
		      //ArrayList<String> trueSource = (ArrayList<String>)keySet.get(tempAttribute);
		      	if(keySet.get(tempAttribute).contains(tempSource))
		      	{
		    	  	
		      		out.print("<td class='availabletd' onclick='ChangeBackgroundColor(this);presentTag(this);return false;'  name='" +attributeUpper +"' id='"+tempSource+"'><a class='pseudolink' href='#'><div id='");
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
		      		attributeSpace = attributeUpper.replaceAll(" ","");
		      		out.print("<div id='details-pane' name='details' class='"+attributeSpace+tempSource+"'style='display: none;'><img onclick = 'ClosePanel()' align='right' border='0' alt='W3Schools' src='images/close.png' width='24' height='24'><div id='verticalcenter'><h5 class='title' style='font-size:15px'>"+attributeUpper+"<br>("+tempSource+")</h5>");
		      		out.print("<div align='left' style='font-size: 12px' class='desc'>");
		      		recordNum = 0;
		    	  	for(String subValue : valueArray)
                    {
		    	  		if(subValue.contains("Â"))
		    	  		{
		    	  			subValue = subValue.replaceAll("Â", " ");
		    	  		}
		    	  		if(subValue.contains("dbmi-icode-01.dbmi.pitt.edu"))
		    	  		{
		    	  			subValue = subValue.replaceAll("http", "https");
		    	  		}
		    	  		if(subValue.contains("http"))
		    	  		{
		    	  			out.print( "<b>"+ ++recordNum + ". </b><a target=_blank href=" + subValue + ">" + subValue + "</a><br>");
		    	  			//out.print( "<li><a target=_blank href=" + subValue + ">" + subValue + "</a></li>");
		    	  		}else{
		    	  			//out.print( "<li>" + subValue + "</li>");
		    	  			out.print( "<b>"+ ++recordNum + ". </b>" + subValue + "<br>");
		    	  		}
                    }
		      		out.print("</div><br></div></div>");
		    	  	
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
		      <!-- setup details pane template -->
		      <div id="details-pane" style="display: none;">
		      <img onclick = "ClosePanel()" align="right" border="0" alt="W3Schools" src="images/close.png" width="24" height="24">
		      <div id="verticalcenter">
				<br>
				<h4>test </h4>
        		<h4 class="title"></h4>
        		<div align="left" style="font-size: 12px"class="desc"></div>
        		<br>
      		  </div>
      		  
      		  
      		  </div>
		      </tbody>
		      </table>
		      		        
      
		      </div>
		      
		      </div>
		      
		      
		      
		      <!--     Table 2      -->
		    <%
		    
            results = result.getResults0();
            drug1 = result.getDrug2();
			drug2 = result.getDrug1();
            HashMap<String, ArrayList<String>> keySet1 = new HashMap<String, ArrayList<String>>();
            for (Map.Entry entry : results.entrySet()) {
                    if (entry.getKey() != null) {
                        tempTag = (String)entry.getKey();
                        tagArray = tempTag.split("\\+");
                        if(keySet1.containsKey(tagArray[2]))
                        {
                        	keySet1.get(tagArray[2]).add(tagArray[3]);
                        }else
                        {
                        	ArrayList<String> tempsource = new ArrayList<String>();
                        	tempsource.add(tagArray[3]);
                        	keySet1.put(tagArray[2], tempsource);
                        }
            }
            }
            %>
            <p></p>
            <div class="centered">
      			
		        <div class="centerblock"><div class="title2"><%out.print("( " + drug2 + "/" + drug1 + ")");%></div></div>
		        
		    </div>
		    <p></p>
		      <!--<div align= "center" class="outer">-->
		      <!--<div class="inner">-->
		      
		      <!-- setup attribute option template -->
		      
      		  
		      <div class="table-container">
    		  
    		  <div class="headcol">
		      <table class = "table1">
		      <thead>
		      <th class="longfields" style="width:210px">
		      <div id = "bluea" style = "font-size:12px"><a onclick = "ShowAttribute(this)">+ More Available Attributes
		      </a><br>
		      <a class = "expandall" onclick = "Expandall()">Expand all
		      </a>
		      </div>
		      </th>
		      </thead>
		      <tbody>
		      <c:forEach items="${ResultBean.attributes}" var="attribute">
		      <% String tempAttribute = (String)pageContext.getAttribute("attribute");
		      attributeUpper = attributeSet.get(tempAttribute);
		      String attributetester = attributeUpper;%>
		      <tr class = "<%String fixedAttribute = attributeUpper.replaceAll(" ","_");out.print(fixedAttribute);%>" <% if(!defaultValid.contains(attributeUpper)){out.print(" style='display:none' name='notdefaulttable'");}else{out.print(" name = 'defaultattribute'");} if(attributeUpper == "PK Mechanism"){attributeUpper = "PK(pharmacokinetic) Mechanism";}if(attributeUpper == "ddiType"){attributeUpper = "ddi(drug-drug interactions) Type";}%>>
		      <td class ="generalhead" id="<%=fixedAttribute%>" name="<%="1"+attributetester%>" onclick = "UserDeleteAttribute(this)"><%=attributeUpper%> <img border="0" alt="W3Schools" src="images/minus.png" width="17" height="17"></td>
		      </tr>
		      </c:forEach>
		      </tbody>
		      </table>
		      </div>
		      
		      <div class="right">
		      <table  class = "table1">
		      <thead>
		      <c:forEach items="${ResultBean.sourcesList}" var="source">
		      <th class="longfields" id="1${source}"><a href="#" title="<%String tempSource = (String)pageContext.getAttribute("source"); out.print("1" + sourceSet.get(tempSource));if(tempSource == "ONC-HighPriority") {tempSource = tempSource.replaceAll("-","- ");}%>"  style="color:#555; text-decoration:none"><%=tempSource %></a></th>
		      </c:forEach>
		      </thead>
		      <tbody>
		      <c:forEach items="${ResultBean.attributes}" var="attribute">
		      <% 
		      String tempAttribute = (String)pageContext.getAttribute("attribute");
		      attributeUpper = attributeSet.get(tempAttribute); %>
		      <tr class = "<%String fixedAttribute = attributeUpper.replaceAll(" ","_");out.print(fixedAttribute);%>"  <% if(!defaultValid.contains(attributeUpper)){out.print(" style='display:none' name = 'notdefaulttable'");}else{out.print(" name = 'defaultattribute'");}%>>
		      
		      <c:forEach items="${ResultBean.sourcesList}" var="sources">
		      
		      <%
		      
		      //String tempAttribute = (String)pageContext.getAttribute("attribute");
		      String tempSource = (String)pageContext.getAttribute("sources");
		      String attributeSpace;
		      ArrayList<String> valueArray = new ArrayList<String>(); 
		      testTag = drug1 + "+" + drug2 + "+" + tempAttribute + "+" + tempSource;
		      if(keySet1.containsKey(tempAttribute))
		      {
		      //ArrayList<String> trueSource = (ArrayList<String>)keySet.get(tempAttribute);
		      	if(keySet1.get(tempAttribute).contains(tempSource))
		      	{
		    	  	
		      		out.print("<td class='availabletd' onclick='ChangeBackgroundColor(this);presentTag(this);return false;'  name='1" +attributeUpper +"' id='1"+tempSource+"'><a class='pseudolink' href='#'><div id='");
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
		      		attributeSpace = attributeUpper.replaceAll(" ","");
		      		out.print("<div id='details-pane' name='details' class='1"+attributeSpace+"1"+tempSource+"'style='display: none;'><img onclick = 'ClosePanel()' align='right' border='0' alt='W3Schools' src='images/close.png' width='24' height='24'><div id='verticalcenter'><h5 class='title' style='font-size:15px'>"+attributeUpper+"<br>("+tempSource+")</h5>");
		      		out.print("<div align='left' style='font-size: 12px;margin-right:15px;' class='lead'>");
		      		recordNum = 0;
		    	  	for(String subValue : valueArray)
                    {
		    	  		if(subValue.contains("Â"))
		    	  		{
		    	  			subValue = subValue.replaceAll("Â", " ");
		    	  		}
		    	  		if(subValue.contains("dbmi-icode-01.dbmi.pitt.edu"))
		    	  		{
		    	  			subValue = subValue.replaceAll("http", "https");
		    	  		}
		    	  		if(subValue.contains("http"))
		    	  		{
		    	  			out.print( "<b>"+ ++recordNum + ". </b><a target=_blank href=" + subValue + ">" + subValue + "</a><br>");
		    	  			//out.print( "<li><a target=_blank href=" + subValue + ">" + subValue + "</a></li>");
		    	  		}else{
		    	  			//out.print( "<li>" + subValue + "</li>");
		    	  			out.print( "<b>"+ ++recordNum + ". </b>" + subValue + "<br>");
		    	  		}
                    }
		      		out.print("</div><br></div></div>");
		    	  	
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
		      <!-- setup details pane template -->
		      <div id="details-pane" style="display: none;">
		      <img onclick = "ClosePanel()" align="right" border="0" alt="W3Schools" src="images/close.png" width="24" height="24">
		      <div id="verticalcenter">
				<br>
				<h4>test </h4>
        		<div class="title"></div>
        		<div align="left" style="font-size: 12px"class="desc"></div>
        		<br>
      		  </div>
      		  
      		  
      		  </div>
		      </tbody>
		      </table>
		      		        
      
		      </div>
		      
		      </div>
		      
		      
		      
		      
                        <c:forEach items="${sessionScope.ResultBean.sourcesList}" var="sources">
                            <input name="sourcesList" type="hidden" value="${sources}">
                        </c:forEach>

                    </form>

                </div>
        </header>
        
		    
            <c:if test="${ResultBean.results0.size() == 0}"><div style="text-align:center"><span class="noResults">No results for selected drugs. Click <a href="/Merged-PDDI">here</a> to search again.</span></div></c:if>
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
<h5 style = "font-size:20px">License</h5>
<div class = "lead" style = "font-size:13px">
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br/>
<span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Dataset" property="dct:title" rel="dct:type">Drug Interaction Knowledge Base (DIKB)</span> 
by <a xmlns:cc="http://creativecommons.org/ns#" href="http://www.dbmi.pitt.edu/person/richard-boyce-phd" property="cc:attributionName" rel="cc:attributionURL">Richard D. Boyce</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.
</div>

<font size="-5"  color="#999999">

<h5 style = "font-size: 13px;"><bold>MEDICAL DISCLAIMER</bold></h5>

<p class = "footerp">
<b>No advice</b>
This website contains general information about medical conditions and treatments.  The information is not advice, and should not be treated as such.

<b>Limitation of warranties</b>

The medical information on this website is provided "as is" without any representations or warranties, express or implied. Neither the author (Richard Boyce) or the University of Pittsburgh make any representations or warranties in relation to the medical information on this website.

Without prejudice to the generality of the foregoing paragraph, Neither the author (Richard Boyce) or the University of Pittsburgh warrant that:</p>

<ul>
  <li style = "margin-top: -18px;font-weight: 400">the medical information on this website will be constantly available, or available at all;</li>

  <li style = "margin-top: -4px;font-weight: 400">the medical information on this website is complete, true, accurate, up-to-date, or non-misleading.</li>
</ul>
<p class = "footerp" style = "margin-top: -18px">
<b>Professional assistance</b>

You must not rely on the information on this website as an alternative to medical advice from your doctor or other professional healthcare provider.

If you have any specific questions about any medical matter you should consult your doctor or other professional healthcare provider.
If you think you may be suffering from any medical condition you should seek immediate medical attention.
You should never delay seeking medical advice, disregard medical advice, or discontinue medical treatment because of information on this website.

<br>
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
<HR>
<div text-align = "center">
<IMG style = "float: left; margin-right: 65px;" src="images/logo.png" alt="logo.png" align="top" width = "140px" height = "140px">
<FONT SIZE="-1"><br>Copyright &#169 2015 - 2016 Richard D. Boyce<BR>All Rights Reserved<BR>
</FONT>
<br>
<br>
</div>
        </div>
        
		<div id="attribute-option" style="display:none">
		      
		      <table  id = "attributebar">
		      <thead>
		      <th class="optiontitle">
		      <div id = "bluea" style = "font-size:12px">
        		<div onclick = "CollapseAttribute()" >Available Attributes</div>
        		<div onclick = "CollapseAll()" >Collapse all</div>
        		</div>
        	  </th>
        	  </thead>
        	  <tbody>
        		<c:forEach items="${ResultBean.attributesUpper}" var="attribute">
        		<tr class="<% String tempAttribute = (String)pageContext.getAttribute("attribute");String fixedAttribute = tempAttribute.replaceAll(" ","_");out.print(fixedAttribute);%>" <%if(defaultValid.contains(tempAttribute)){out.print("style = 'display:none' name = 'defaultbar'");}else{out.print("style = 'display:table-row' name = 'notdefaultattribute'");}if(tempAttribute == "ddiType"){tempAttribute = "ddi(drug-drug interactions) Type";}if(tempAttribute == "PK Mechanism"){tempAttribute = "PK(pharmacokinetic) Mechanism";}%>><td class="generalhead">
        		<div align="right" id="<%=fixedAttribute %>" onclick = "UserDeleteAttribute(this)" style = "font-size:12px"><%=tempAttribute %>  <img border="0" alt="W3Schools" src="images/plus.png" width="14" height="14"></div>
        		</td></tr>
        		</c:forEach>
        	  </tbody>
        	  </table>
      		  
      		  </div>
      		  </div>
    </body>
    
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/main.js"></script>
    
    

</html>