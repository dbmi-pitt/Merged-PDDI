<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" import="java.util.*,com.ddi.*" %>
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
            
            <br>

            <div id="scrollheader">

              <c:if test="${sessionScope.ResultBean.results.size()>0 } ">
                    <h2 class="centered">Search Results</h2>
                    <h3 class="centered">Drugs Searched</h3>
                    <p class="centered">Drug 1: <a href="${ResultBean.results.get(0).get(0)}" target="_blank"><c:out value="${ResultBean.drug1}"></c:out></a> - <c:out value="${ResultBean.drug1ID}"></c:out></p>  
                    <p class="centered">Drug 2: <a href="${ResultBean.results.get(0).get(3)}" target="_blank"><c:out value="${ResultBean.drug2}"></c:out></a> - <c:out value="${ResultBean.drug2ID}"></c:out></p>
                  </c:if>

	      <!-- list search condition been selected -->

              <p class="left">New Search &nbsp;&nbsp; <a href="/DIKB-Prototype">DIKB-Prototype/SearchServlet</a></p> 

                    <form name="drugForm" action="SearchServlet" method="POST">
		      <table>
			<tr>
			  <td>
			    drug 1 as Object
			  </td>
			  <td>
			    drug 2 as Precipitant
			  </td>
			  <td>
			  </td>
			</tr>
			<tr>
			  <td>
                            <input name="drug1" value="${ResultBean.drug1}" readonly="readonly">
			  </td>
			  <td>
                            <input name="drug2" value="${ResultBean.drug2}" readonly="readonly">
			  </td>
			  <td><div id="submitButton"><input class="clear regButton" type="submit" value="Reverse Object/Precipitant"/></div>
			  </td>
			</tr>

		      </table>
		      <p class="centered">Sources: ${ResultBean.sources}</p>
                        <c:forEach items="${sessionScope.ResultBean.sourcesList}" var="sources">
                            <input name="sourcesList" type="hidden" value="${sources}">
                        </c:forEach>

                    </form>

                </div>
                <div id="dataButtons">
                    <div id="legend" class="centered">
                         <img src="images/dataNotSelected.png"> data available (click to show)                        
                        <img src="images/dataSelected.png"> data available (click to hide)
                        <br><br>
                        <img src="images/noDataNotSelected.png"> data not available (click to annotate)
                        <img src="images/noDataSelected.png"> unavailable data (click to hide)
                    </div>
                    <c:if test="${ResultBean.sourceCSS.size()>0}">
                      <div class="centered">
                        <div class="buttonRow">
                          <button id="certaintyButton" class="${ResultBean.sourceCSS.get(6)}" onclick="toggleVisible('certainty')">Certainty</button>
                          <button id="contraindicationButton" class="${ResultBean.sourceCSS.get(7)}" onclick="toggleVisible('contraindication')">Contraindication</button>
                          <button id="ddiPkEffectButton" class="${ResultBean.sourceCSS.get(9)}" onclick="toggleVisible('ddiPkEffect')">ddiPkEffect</button>
                          <button id="ddiPkMechanismButton" class="${ResultBean.sourceCSS.get(10)}" onclick="toggleVisible('ddiPkMechanism')">ddiPkMechanism</button>
                          <button id="ddiTypeButton" class=" ${ResultBean.sourceCSS.get(21)}"​ onclick="toggleVisible('ddiType')">ddiType</button>
                          <button id="HomepageButton" class="${ResultBean.sourceCSS.get(12)}" onclick="toggleVisible('Homepage')">Homepage</button>
                          <br>
                        </div>
                        <div class="buttonRow">
                          <button id="severityButton" class="${ResultBean.sourceCSS.get(17)} " onclick="toggleVisible('severity')">Severity</button>
                          <button id="labelButton" class="${ResultBean.sourceCSS.get(13)}" onclick="toggleVisible('label')">Label</button>
                          <button id="sourceButton" class="${ResultBean.sourceCSS.get(20)}" onclick="toggleVisible('source')">Source</button>
                          <button id="uriButton" class="${ResultBean.sourceCSS.get(18)}" onclick="toggleVisible('uri')">URI</button>
                          <button id="managementOptionsButton" class="${ResultBean.sourceCSS.get(27)}" onclick="toggleVisible('managementOptions')">Management Options</button>
                                
                          <br>
                        </div>
                            <div class="buttonRow">
                                <button id="dateAnnotatedButton" class="${ResultBean.sourceCSS.get(8)}" onclick="toggleVisible('dateAnnotated')">Date Annotated</button>
                                <button id="whoAnnotatedButton" class="${ResultBean.sourceCSS.get(19)}" onclick="toggleVisible('whoAnnotated')">Who Annotated</button>
                                <button id="effectConceptButton" class="${ResultBean.sourceCSS.get(11)}" onclick="toggleVisible('effectConcept')">Effect Concept</button>
                                <button id="numericValButton" class="${ResultBean.sourceCSS.get(14)}" onclick="toggleVisible('numericVal')">Numeric Value</button>
                                <button id="pathwayButton" class="${ResultBean.sourceCSS.get(15)}" onclick="toggleVisible('pathway')">Pathway</button>
                                <button id="precautionButton" class="${ResultBean.sourceCSS.get(16)}" onclick="toggleVisible('precaution')">Precaution</button>
                                <br>
                            </div>
                            <div class="buttonRow">
                                <button id="evidenceButton" class="${ResultBean.sourceCSS.get(22)}" onclick="toggleVisible('evidence')">Evidence</button>
                                <button id="evidenceSourceButton" class="${ResultBean.sourceCSS.get(23)}" onclick="toggleVisible('evidenceSource')">Evidence Source</button>
                                <button id="evidenceStatementButton" class="${ResultBean.sourceCSS.get(24)}" onclick="toggleVisible('evidenceStatement')">Evidence Statement</button>
                                <button id="researchStatementLabelButton" class="${ResultBean.sourceCSS.get(25)}" onclick="toggleVisible('researchStatementLabel')">Research Statement Label</button>
                                <button id="researchStatementButton" class="${ResultBean.sourceCSS.get(26)}" onclick="toggleVisible('researchStatement')">Research Statement</button>
                                <br>
                            </div>
                        <button id="showAllData" class="regButton" onclick="showAllData();">Show all Data</button>
                    </div>
                </c:if>
            </div>
        </header>
        <hr>
            <c:if test="${ResultBean.results.size() == 0}"><span class="noResults">No results for selected drugs. Click <a href="/DIKB-Prototype">here</a> to search again.</span></c:if>
	    <c:set var="ddiFirst" value="yes" scope="session"  />
            
            <c:forEach items= "${ResultBean.results}" var="results">
                <div class="results xtraPadding">
                  <div id="data">

		    
		    <p class="showAll DrugClass1"><span class="bold">Object Drug Class - </span> ${results.get(27)}</p>
		    
		    
                    <p class="showAll DrugClass2"><span class="bold">Precipitant Drug Class - </span> ${results.get(28)}</p>

                    <p class="showAll certainty"><span class="bold">Certainty - </span> ${results.get(6)}</p> 

		    
                    <p class="showAll severity"><span class="bold">Severity - </span> ${results.get(17)}</p>
		    
		    
                    <p class="showAll label"><span class="bold">Label - </span> ${results.get(13)}</p>
		    
		    
                    <p class="showAll source"><span class="bold">Source - </span> ${results.get(20)}</p>
		    
		    
                    <p class="showAll whoAnnotated"><span class="bold">Who Annotated  - </span> ${results.get(19)}</p>
		    
		    
                    <p class="showAll dateAnnotated"><span class="bold">Date Annotated - </span> ${results.get(8)}</p>
		    
                    
                      <p class="showAll Homepage"><span class="bold">Homepage - </span>${results.get(12)}</p>
                                 
		    
                    <p class="showAll contraindication"><span class="bold">Contraindication - </span> ${results.get(7)}</p>
		    
                    <p class="showAll ddiPkEffect"><span class="bold">ddiPkEffect - </span> ${results.get(9)}</p>
		    
                    <p class="showAll ddiPkMechanism"><span class="bold">ddiPkMechanism - </span> ${results.get(10)}</p>
		    
                    <p class="showAll ddiType"><span class="bold">ddiType - </span> ${results.get(21)}</p>
		    
                    <p class="showAll managementOptions"><span class="bold">Management Options - </span> ${results.get(27)}</p>
		    
                    <p class="showAll effectConcept"><span class="bold">Effect Concept - </span> ${results.get(11)}</p>
		    
                    <p class="showAll numericVal"><span class="bold">Numeric Value  - </span> ${results.get(14)}</p>
		    
                    <p class="showAll pathway"><span class="bold">Pathway - </span> ${results.get(15)}</p>
		    
                    <p class="showAll precaution"><span class="bold">Precaution - </span> ${results.get(16)}</p>
		    
                    <p class="showAll uri"><span class="bold">URI- </span> ${results.get(18)}</p>
		    
                    <p class="showAll evidence"><span class="bold">Evidence - </span> ${results.get(22)}</p>
		    
                    <p class="showAll evidenceStatement"><span class="bold">Evidence Statement - </span> ${results.get(24)}</p>

                    
                        <c:set var="evidenceSource" scope="session" value="${results.get(23)}" />
                        <p class="showAll evidenceSource"><span class="bold">Evidence Source- </span>${results.get(23)}</p>
                    
                    
                        <!-- <p class="showAll evidenceSource"><span class="bold">Evidence Source- </span><a href="${results.get(23)}" target="_blank">  ${results.get(23)}</a></p> -->
		    
                    <p class="showAll researchStatementLabel"><span class="bold">Research Statement Label - </span> ${results.get(25)}</p>
		    
                    <p class="showAll researchStatement"><span class="bold">Research Statement  - </span> ${results.get(26)}</p>
                    </div>
                    <!-- <div id="comments" class="centered"> -->
                    <!--     <h4>Comments about this interaction</h4> -->
                    <!--     <div id="existingComment"> -->
                    <!--         <p class="comment"> -->
                    <!--             <span class="bold">User: </span>Jacky Ramsey<br> -->
                    <!--             <span class="bold">Email: </span>jmr205@pitt.edu<br> -->
                    <!--             <span class="bold">Date: </span>03/15/2015<br> -->
                    <!--             <span class="bold">Comment: </span>Information about the XXXX is not complete.  Consider adding this additional information:<br> -->
                    <!--         </p> -->
                    <!--         <p class="comment"> -->
                    <!--             <span class="bold">User: </span>Maggie Shipley<br> -->
                    <!--             <span class="bold">Email: </span>mas111@pitt.edu<br> -->
                    <!--             <span class="bold">Date: </span>04/1/2015<br> -->
                    <!--             <span class="bold">Comment: </span>This source also has additional information about XXXX: <br> -->
                    <!--         </p> -->
                    <!--     </div> -->
                    <!--     <div id="newComment"> -->
                    <!--         <p class="bold">Leave a Comment</p> -->
                    <!--         <form class="xtraPadding"> -->
                    <!--             <label> -->
                    <!--                 <p>User: <input type="text" name="user" placeholder="Your Username" required max="50"></p> -->
                    <!--             </label> -->
                    <!--             <label> -->
                    <!--                 <p>Email: <input type="email" name="email" placeholder="yourEmail@email.com" required max="75"></p> -->
                    <!--             </label> -->
                    <!--             <label> -->
                    <!--                 <p>Comment: <textarea name="comment" required placeholder="Your Comment"></textarea></p> -->
                    <!--             </label> -->
                    <!--             <button class="regButton xtraPadding" name="submitComment">Submit Comment</button> -->
                    <!--         </form> -->
                    <!--     </div> -->
                    <!-- </div> -->
                    <hr class="clear">
                </div>
            </c:forEach>



            <p class="whiteText">Leave this here for CSS purposes</p>
        </div>
    </body>
</html>
