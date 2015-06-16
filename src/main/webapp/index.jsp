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
            String tempTag, testTag = null;
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

              <p class="left" align="center">&nbsp;&nbsp; <a href="/Merged-PDDI" class="title2"><%="<< " %>New Search</a></p></br>

                    <form name="drugForm" action="SearchServlet" method="POST">
		    <div align= "center">
		    <table align="center">
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
		     </div>
		     
		      
	  
      
		      <p align = "center" class="title2">(${ResultBean.drug1} / ${ResultBean.drug2})</p>
		      <!--<div align= "center" class="outer">-->
		      <!--<div class="inner">-->
		      <div class="table-container">
    		  <div class="headcol">
		      <table>
		      <thead>
		      <th class="longfields"></th>
		      </thead>
		      <tbody>
		      <c:forEach items="${ResultBean.attributesUpper}" var="attribute">
		      <tr>
		      <td class="generalhead">${attribute}</td>
		      </tr>
		      </c:forEach>
		      </tbody>
		      </table>
		      </div>
		      
		      <div class="right">
		      <table>
		      <thead>
		      
		      <c:forEach items="${ResultBean.sourcesList}" var="source">
		      <th class="longfields">${source}</th>
		      </c:forEach>
		      </thead>
		      <tbody>
		      <c:forEach items="${ResultBean.attributes}" var="attribute">
		      <tr>
		      
		      <c:forEach items="${ResultBean.sourcesList}" var="sources">
		      
		      <%
		      
		      String tempAttribute = (String)pageContext.getAttribute("attribute");
		      String tempSource = (String)pageContext.getAttribute("sources");
		      ArrayList<String> valueArray = new ArrayList<String>(); 
		      testTag = drug1 + "+" + drug2 + "+" + tempAttribute + "+" + tempSource;
		      if(keySet.containsKey(tempAttribute))
		      {
		      //ArrayList<String> trueSource = (ArrayList<String>)keySet.get(tempAttribute);
		      	if(keySet.get(tempAttribute).contains(tempSource))
		      	{
		    	  	out.print("<td class='availabletd'><div class='thumbs'><a class='pseudolink' href='#'><div id='100' name='" + tempAttribute + "' class='" + tempSource + "' ><bold>Available</bold></div></a>");
		    	  	valueArray = (ArrayList<String>)results.get(testTag);
		    	  	out.print("<meta class='desc' content='");
		    	  	recordNum = 0;
		    	  	for(String subValue : valueArray)
                    {
		    	  		out.print(++recordNum + ". " + subValue + "<br>");
                    }
		    	  	out.print("'></div></td>");
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
		      <!-- setup details pane template -->
      <div id="details-pane" style="display: none;">
        <h4 class="title"></h4>
        <p align = "left" class="desc"></p>
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
		    
            <c:if test="${ResultBean.results.size() == 0}"><span class="noResults">No results for selected drugs. Click <a href="/Merged-PDDI">here</a> to search again.</span></c:if>
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

            <p class="whiteText">Leave this here for CSS purposes</p>
        </div>
        
        <a href="#0" class="cd-top">Top</a>
        
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/main.js"></script>
		<script type="text/javascript">
$(function(){
  $('.thumbs div').on('mouseover', function(e){
    var dpane      = $('#details-pane');
    var dpanetitle = $('#details-pane .title');
    var dpanedesc  = $('#details-pane .desc');
    var newtitle   = $(this).attr('name');
    newtitle += " (";
    newtitle += $(this).attr("class");
    newtitle += ")";
    var newdate    = $(this).attr('name');
    var newdesc    = $(this).parent().next('meta.desc').attr('content');
    if(newdesc.includes("http"))
	{
		dpanedesc.css('word-break','break-all');
		//alert("success");
	}else{
		dpanedesc.css('word-break', 'normal');
	}
    
    var position = $(this).offset();
    var imgwidth = $(this).attr('id');
    if(position.top / $(window).height() >= 0.5) {
      var ycoord   = position.top - 340;
    } else {
      var ycoord   = position.top - 200;
    }
    //var ycoord   = position.top - 340;
    //xcoord = position.left;
    if(position.left / $(window).width() >= 0.5) {
      var xcoord = position.left - 400;//250;
      // details pane is 530px fixed width
      // if the img position is beyond 50% of the page, we move the pane to the left side
    } else {
      var xcoord = position.left - 400//200;
    }
    
    dpanetitle.html(newtitle);
    dpanedesc.html(newdesc);
    
    dpane.css({ 'left': xcoord, 'top': ycoord, 'display': 'block'});
    
  }).on('mouseout', function(e){
    $('#details-pane').css('display','none');
  });
  
  // when hovering the details pane keep displayed, otherwise hide
  $('#details-pane').on('mouseover', function(e){
    $(this).css('display','block');
  });
  $('#details-pane').on('mouseout', function(e){
    //this is the original element the event handler was assigned to
    var e = e.toElement || e.relatedTarget;
    if (e.parentNode == this || e.parentNode.parentNode == this || e.parentNode.parentNode.parentNode == this || e == this || e.nodeName == 'IMG') {
      return;
    }
    $(this).css('display','none');
    //console.log(e.nodeName)
  });
});
</script>
    </body>
</html>