<%-- 
    Document   : index
    Created on : Apr 10, 2015, 8:55:58 AM
    Author     : cwm24
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/ddistyle.css" />
        <title>Drug Interaction Search Results</title>
        <script>
            function toggleVisible(toggleClass){
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
            
            function hideStuff(){
                var stuffToHide = document.getElementsByClassName('hide');
                for (var i = 0; i < stuffToHide.length; i++) {
                    stuffToHide[i].style.display = "none";
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
                <div id="scrollheader">
                    <c:if test="${ResultBean.results.size()>0}">
                    <h2 class="centered">Search Results</h2>
                    <h3 class="centered">Drugs Searched</h3>
                    <p class="centered">Drug 1: <a href="${ResultBean.results.get(0).get(0)}" target="_blank"><c:out value="${ResultBean.drug1}"></c:out></a> - <c:out value="${ResultBean.drug1ID}"></c:out></p>  
                    <p class="centered">Drug 2: <a href="${ResultBean.results.get(0).get(3)}" target="_blank"><c:out value="${ResultBean.drug2}"></c:out></a> - <c:out value="${ResultBean.drug2ID}"></c:out></p>
                    </c:if>
                    <p class="centered">Sources: ${ResultBean.sources}</p>
                    <form name="drugForm" action="SearchServlet" method="POST">
                        <input name="drug1" type="hidden" value="${ResultBean.drug1}">
                        <input name="drug2" type="hidden" value="${ResultBean.drug2}">
                        <c:forEach items="${ResultBean.sourcesList}" var="sources">
                            <input name="sourcesList" type="hidden" value="${sources}">
                        </c:forEach>
                        <div id="submitButton"><input class="clear regButton" type="submit" value="Reverse Object/Precipitant"/></div>
                    </form>
                        <p class="centered">Click <a href="/DDI">here</a> to search for 2 new drugs</p>
                </div>
                <div id="dataButtons">
                    <div id="legend" class="centered">
                        <img src="images/dataNotSelected.png"> Data available but not shown                        
                        <img src="images/dataSelected.png"> Data available and shown
                        <br>
                        <img src="images/noDataNotSelected.png"> No data available and not shown
                        <img src="images/noDataSelected.png"> No data available but shown
                    </div>
                    <c:if test="${ResultBean.sourceCSS.size()>0}">
                        <div class="centered">
                            <div class="buttonRow">
                                <button id="certaintyButton" class="${ResultBean.sourceCSS.get(6)} displayed buttons" onclick="toggleVisible('certainty')">Certainty</button>
                                <button id="contraindicationButton" class="${ResultBean.sourceCSS.get(7)} displayed buttons" onclick="toggleVisible('contraindication')">Contraindication</button>
                                <button id="ddiPkEffectButton" class="${ResultBean.sourceCSS.get(9)} displayed buttons" onclick="toggleVisible('ddiPkEffect')">ddiPkEffect</button>
                                <button id="ddiPkMechanismButton" class="${ResultBean.sourceCSS.get(10)} displayed buttons" onclick="toggleVisible('ddiPkMechanism')">ddiPkMechanism</button>
                                <button id="ddiTypeButton" class=" buttons ${ResultBean.sourceCSS.get(21)}"​ onclick="toggleVisible('ddiType')">ddiType</button>
                                <button id="HomepageButton" class="${ResultBean.sourceCSS.get(12)} buttons" onclick="toggleVisible('Homepage')">Homepage</button>
                                <br>
                            </div>
                            <div class="buttonRow">
                                <button id="severityButton" class="${ResultBean.sourceCSS.get(17)} displayed buttons" onclick="toggleVisible('severity')">Severity</button>
                                <button id="labelButton" class="${ResultBean.sourceCSS.get(13)} buttons" onclick="toggleVisible('label')">Label</button>
                                <button id="sourceButton" class="${ResultBean.sourceCSS.get(20)} buttons" onclick="toggleVisible('source')">Source</button>
                                <button id="uriButton" class="${ResultBean.sourceCSS.get(18)} buttons" onclick="toggleVisible('uri')">URI</button>
                                <button id="managementOptionsButton" class="${ResultBean.sourceCSS.get(27)} buttons" onclick="toggleVisible('managementOptions')">Management Options</button>
                                
                                <br>
                            </div>
                            <div class="buttonRow">
                                <button id="dateAnnotatedButton" class="${ResultBean.sourceCSS.get(8)} displayed buttons" onclick="toggleVisible('dateAnnotated')">Date Annotated</button>
                                <button id="whoAnnotatedButton" class="${ResultBean.sourceCSS.get(19)} displayed buttons" onclick="toggleVisible('whoAnnotated')">Who Annotated</button>
                                <button id="effectConceptButton" class="${ResultBean.sourceCSS.get(11)} buttons" onclick="toggleVisible('effectConcept')">Effect Concept</button>
                                <button id="numericValButton" class="${ResultBean.sourceCSS.get(14)} buttons" onclick="toggleVisible('numericVal')">Numeric Value</button>
                                <button id="pathwayButton" class="${ResultBean.sourceCSS.get(15)} buttons" onclick="toggleVisible('pathway')">Pathway</button>
                                <button id="precautionButton" class="${ResultBean.sourceCSS.get(16)} buttons" onclick="toggleVisible('precaution')">Precaution</button>
                                <br>
                            </div>
                            <div class="buttonRow">
                                <button id="evidenceButton" class="${ResultBean.sourceCSS.get(22)} buttons" onclick="toggleVisible('evidence')">Evidence</button>
                                <button id="evidenceSourceButton" class="${ResultBean.sourceCSS.get(23)} displayed buttons" onclick="toggleVisible('evidenceSource')">Evidence Source</button>
                                <button id="evidenceStatementButton" class="${ResultBean.sourceCSS.get(24)} buttons" onclick="toggleVisible('evidenceStatement')">Evidence Statement</button>
                                <button id="researchStatementLabelButton" class="${ResultBean.sourceCSS.get(25)} buttons" onclick="toggleVisible('researchStatementLabel')">Research Statement Label</button>
                                <button id="researchStatementButton" class="${ResultBean.sourceCSS.get(26)} buttons" onclick="toggleVisible('researchStatement')">Research Statement</button>
                                <br>
                            </div>
                        <button id="showAllData" class="regButton" onclick="showAllData();">Show all Data</button>
                    </div>
                </c:if>
            </div>
        </header>
        <hr>
            <c:if test="${ResultBean.results.size() == 0}"><span class="noResults">No results for selected drugs. Click <a href="/DDI">here</a> to search again.</span></c:if>
            
            <c:forEach items= "${ResultBean.results}" var="results">
                <div class="results xtraPadding">
                    <div id="data">
                    <p class="showAll DrugClass1"><span class="bold">Object Drug Class - </span> ${results.get(27)}</p>
                    <p class="showAll DrugClass2"><span class="bold">Precipitant Drug Class - </span> ${results.get(28)}</p>
                    <p class="showAll certainty"><span class="bold">Certainty - </span> ${results.get(6)}</p>
                    <p class="showAll severity"><span class="bold">Severity - </span> ${results.get(17)}</p>
                    <p class="showAll hide label"><span class="bold">Label - </span> ${results.get(13)}</p>
                    <p class="showAll hide source"><span class="bold">Source - </span> ${results.get(20)}</p>
                    <p class="showAll whoAnnotated"><span class="bold">Who Annotated  - </span> ${results.get(19)}</p>
                    <p class="showAll dateAnnotated"><span class="bold">Date Annotated - </span> ${results.get(8)}</p>
                    <c:if test="${results.get(12).length() < 5}">
                        <p class="showAll hide Homepage"><span class="bold">Homepage - </span>${results.get(12)}</p>
                    </c:if>
                    <c:if test="${results.get(12).length() > 4}">
                        <p class="showAll hide Homepage"><span class="bold">Homepage - </span><a href="${results.get(12)}" target="_blank"> ${results.get(12)}</a></p>
                    </c:if>
                    <p class="showAll contraindication"><span class="bold">Contraindication - </span> ${results.get(7)}</p>
                    <p class="showAll ddiPkEffect"><span class="bold">ddiPkEffect - </span> ${results.get(9)}</p>
                    <p class="showAll ddiPkMechanism"><span class="bold">ddiPkMechanism - </span> ${results.get(10)}</p>
                    <p class="showAll hide ddiType"><span class="bold">ddiType - </span> ${results.get(21)}</p>
                    <p class="showAll hide managementOptions"><span class="bold">Management Options - </span> ${results.get(27)}</p>
                    <p class="showAll hide effectConcept"><span class="bold">Effect Concept - </span> ${results.get(11)}</p>
                    <p class="showAll hide numericVal"><span class="bold">Numeric Value  - </span> ${results.get(14)}</p>
                    <p class="showAll hide pathway"><span class="bold">Pathway - </span> ${results.get(15)}</p>
                    <p class="showAll hide precaution"><span class="bold">Precaution - </span> ${results.get(16)}</p>
                    <p class="showAll hide uri"><span class="bold">URI- </span> ${results.get(18)}</p>
                    <p class="showAll hide evidence"><span class="bold">Evidence - </span> ${results.get(22)}</p>
                    <p class="showAll hide evidenceStatement"><span class="bold">Evidence Statement - </span> ${results.get(24)}</p>
                    <c:if test="${results.get(23).length() < 5}">
                        <c:set var="evidenceSource" scope="session" value="${results.get(23)}" />
                        <p class="showAll evidenceSource"><span class="bold">Evidence Source- </span>${results.get(23)}</p>
                    </c:if>
                    <c:if test="${results.get(23).length() > 4}">
                        <p class="showAll evidenceSource"><span class="bold">Evidence Source- </span><a href="${results.get(23)}" target="_blank">  ${results.get(23)}</a></p>
                    </c:if>
                    <p class="showAll hide researchStatementLabel"><span class="bold">Research Statement Label - </span> ${results.get(25)}</p>
                    <p class="showAll hide researchStatement"><span class="bold">Research Statement  - </span> ${results.get(26)}</p>
                    </div>
                    <div id="comments" class="centered">
                        <h4>Comments about this interaction</h4>
                        <div id="existingComment">
                            <p class="comment">
                                <span class="bold">User: </span>Jacky Ramsey<br>
                                <span class="bold">Email: </span>jmr205@pitt.edu<br>
                                <span class="bold">Date: </span>03/15/2015<br>
                                <span class="bold">Comment: </span>Information about the XXXX is not complete.  Consider adding this additional information:<br>
                            </p>
                            <p class="comment">
                                <span class="bold">User: </span>Maggie Shipley<br>
                                <span class="bold">Email: </span>mas111@pitt.edu<br>
                                <span class="bold">Date: </span>04/1/2015<br>
                                <span class="bold">Comment: </span>This source also has additional information about XXXX: <br>
                            </p>
                        </div>
                        <div id="newComment">
                            <p class="bold">Leave a Comment</p>
                            <form class="xtraPadding">
                                <label>
                                    <p>User: <input type="text" name="user" placeholder="Your Username" required max="50"></p>
                                </label>
                                <label>
                                    <p>Email: <input type="email" name="email" placeholder="yourEmail@email.com" required max="75"></p>
                                </label>
                                <label>
                                    <p>Comment: <textarea name="comment" required placeholder="Your Comment"></textarea></p>
                                </label>
                                <button class="regButton xtraPadding" name="submitComment">Submit Comment</button>
                            </form>
                        </div>
                    </div>
                    <hr class="clear">
                </div>
            </c:forEach>
            <p class="whiteText">Leave this here for CSS purposes</p>
        </div>
    </body>
</html>
