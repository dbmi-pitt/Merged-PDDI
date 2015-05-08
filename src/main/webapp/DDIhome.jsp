<%@page contentType="text/html" pageEncoding="UTF-8" session="true" import="java.util.*,com.ddi.*" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<!DOCTYPE html>
    <head>
        <title>Welcome to DDI Search</title>
        <link rel="stylesheet" type="text/css" href="css/ddistyle.css" />
        <meta charset="UTF-8">
        <script src="js/jquery-1.11.1.min.js"></script>
        <link href="css/listbox.css" rel="stylesheet" />
        <script src="js/listbox.js"></script>

	<!-- references for dialog -->
	<link rel="stylesheet" href="css/jquery-dialog-ui.css">
	<script src="js/jquery-ui.js"></script>

	<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script> -->

 <script>
  $(function() {
    $( "#dialog-message" ).dialog({
      modal: true,
      buttons: {
        Ok: function() {
          $( this ).dialog( "close" );
        }
      }
    });
  });
  </script>


    </head>
    <body>

      <div id="dialog-message" title="Description:">

	<!-- <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span> -->

	<p>This site provides access (via download and search) to publicly available sources of potential drug-drug interaction (PDDI) information that were identified using a comprehensive and broad search.
	</p>

	<p>
	The combined dataset (available via download) merges together fourteen different sources including 5 clinically-oriented information sources, 4 Natural Language Processing (NLP) Corpora, and 5 Bioinformatics/Pharmacovigilance information sources. The search interface below allows access to a subset of 6 data sources.
	</p>

	<p>
	  As a comprehensive PDDI source, the merged dataset might benefit the
	  pharmacovigilance text mining community by making it possible to compare
	  the representativeness of NLP corpora for PDDI text extraction tasks,
	  and specifying elements that can be useful for future PDDI extraction
	  purposes.
	</p>

	<p>
	  Please see the bottom of this page for how to cite individual sources.
	  Please cite the following paper in any publications or presentations
	  that present work that used data from downloaded or accessed from this
	  web site.
	</p>

      </div>

      <div id="page">
            <header>
                    <h1 class="centered">Potential drug-drug interaction information from publicly available sources</h1>

            </header>		
            <div class="intro">
                <p> A service provided by the University of Pittsburgh Drug
Interaction Knowledge Base (DIKB)
		</p>
		<p>
		  Welcome to the DDI Search Engine. The engine will help you locate interactions between two prescription drugs. Below, enter the drugs you would like to search for, then select the type of sources and type of information you are interested in viewing.</p>	
            </div>

            <form name="drugForm" action="SearchServlet" method="POST">
            <div class="drugs centered">			
                <p class="stepHeader">Step 1: Please choose 2 drugs to compare</p>
                <div id="drugSelection1">
                    <h4 class="bold centered">Drug 1 - Object</h4>
                    <select name="drugList1" id="drugList1" onchange="getAvailablePrecipitants();">
                        <c:forEach items="${sessionScope.DrugBean.drugNames}" var = "dn">
                            <option value="${dn}">${dn}</option>
                        </c:forEach>
                        </select>
                    <script>
                        $(function(){
                            $('select[id="drugList1"]').listbox({
                                searchbar: true // enable a search bar to filter & search items
                            });
                        });
                        
                     	// get list of drug 2 based on drug 1
                        var calledOnce = false;
                        function getAvailablePrecipitants(){
                            var currentSelectedDrug = $('select[id="drugList1"]').val();
                            $.get( "drug_ajax", {drug: currentSelectedDrug} )   
                                .done(function( data ) {
                                    var ajaxData = data + "";
                                    var drug2List = ajaxData.split(",");
                                    $('select[id="drugList2"]').empty();
                                    for(var i=0; i < drug2List.length; i++){
                                         $('select[id="drugList2"]').append($('<option>').text(drug2List[i]).attr('value', drug2List[i]));
                                    }
                                    if(calledOnce){
                                        $(".lbjs")[1].remove();
                                    }
                                    $(function(){
                                        $('select[id="drugList2"]').listbox({
                                            searchbar: true // enable a search bar to filter & search items
                                        });
                                    });
                                    calledOnce = true;
                                });
                        }
                        
                        
                    </script>
                </div>
                <div id="drugSelection2">
                    <h4 class="bold centered">Drug 2 - Precipitant</h4>
                    <select name="drugList2" id="drugList2"></select>
                </div>
            </div>

            <div class="filters clear">
                <p class="centered stepHeader">Step 2: Please choose the sources for the data</p>
                <div class="centerDiv">
                    <input type="checkbox" id="CO-cat" value="Clinically Oriented" onchange="checkSources('CO-cat');atLeastOneSource();" checked><span class="bold">Clinically Oriented</span><br>
                    <div class="indent">
                        <input type="checkbox" name="source" id="COsource1" value="CredibleMeds" checked onchange="atLeastOneSource();">CredibleMeds<br>
                        <input type="checkbox" name="source" id="COsource2" value="NDF-RT" checked onchange="atLeastOneSource();">NDF-RT<br>
                        <input type="checkbox" name="source" id="COsource3" value="ONC-HighPriority" checked onchange="atLeastOneSource();">ONC-HighPriority<br>
                        <input type="checkbox" name="source" id="COsource4" value="ONC-NonInteruptive" checked onchange="atLeastOneSource();">ONC-NonInteruptive<br>
                    </div>
                    <input type="checkbox" id="BioPharm-cat" value="Bioinformatics-Pharmacovigilance" onchange="checkSources('BioPharm-cat');atLeastOneSource();" checked><span class="bold">Bioinformatics-Pharmacovigilance</span><br>
                    <div class="indent">
                        <input type="checkbox" name="source" id="BPsource1" value="DIKB" checked onchange="atLeastOneSource();">DIKB<br>
                        <input type="checkbox" name="source" id="BPsource2" value="Drugbank" checked onchange="atLeastOneSource();">Drugbank<br>
                    </div>
                    <script>
                        function checkSources(category){
                            var catCheckStatus = document.getElementById(category).checked;
                            if(category == "CO-cat"){
                                if(catCheckStatus == true){
                                    document.getElementById('COsource1').checked = true;
                                    document.getElementById('COsource2').checked = true;
                                    document.getElementById('COsource3').checked = true;
                                    document.getElementById('COsource4').checked = true;
                                }
                                if(catCheckStatus == false){
                                    document.getElementById('COsource1').checked = false;
                                    document.getElementById('COsource2').checked = false;
                                    document.getElementById('COsource3').checked = false;
                                    document.getElementById('COsource4').checked = false;
                                }
                            }
                            if(category == "BioPharm-cat"){
                                if(catCheckStatus == true){
                                    document.getElementById('BPsource1').checked = true;
                                    document.getElementById('BPsource2').checked = true;
                                }
                                if(catCheckStatus == false){
                                    document.getElementById('BPsource1').checked = false;
                                    document.getElementById('BPsource2').checked = false;
                                }
                            }
                        }
                        
                        function atLeastOneSource(){
                            var sources = document.getElementsByName('source');
                            var oneIsChecked = false;
                            var submitButton = document.getElementById('findInteractionsSubmit');
                            for(var i=0; i < sources.length; i++){
                                if(sources[i].checked){
                                    oneIsChecked = true;
                                }
                            }
                            if(oneIsChecked == true){
                                submitButton.removeAttribute('disabled');
                                document.getElementById('warningMessage').removeChild(document.getElementById('warningMessage').childNodes[0]);
                            }
                            else{
                                submitButton.setAttribute('disabled', 'disabled');
                                var message = document.createTextNode("At least one source must be checked!");
                                document.getElementById('warningMessage').appendChild(document.createElement("p").appendChild(message));
                            }
                        }
                    </script>
                </div>
            </div>
                <div class="test centered">
                    <div id="submitButton"><input id="findInteractionsSubmit" class="clear regButton" type="submit" value="Find Interactions"/></div>
                    <div id="warningMessage" class="centered warning"></div>
                </div>
            </form>
        </div>


<BR><BR>
<h3>Citations for PDDI sources </h3>

<b>Five of the sources were developed for clinical application</b>

<p>Credimeds: a list of PDDIs thought to be clinically relevant and supported by strong scientific evidence

 “Crediblemeds.org,” 05-Oct-2013. [Online]. Available: http://www.crediblemeds.org/.[Accessed: 05-Oct-2013].  
</p>

<p>
ONC High Priority - a list of PDDIs suggested as a high priority to alert clinicians in any care environment

S. Phansalkar, A. A. Desai, D. Bell, E. Yoshida, J. Doole, M. Czochanski, B. Middleton,and D. W. Bates, “High-priority drug-drug interactions for use in electronic health records,”J. Am. Med. Inform. Assoc. JAMIA, vol. 19, no. 5, pp. 735-743, Oct. 2012.
</p>

<p>ONC Non-interruptive - a list of PDDIs not requiring interruptive alerting in any care environment

S. Phansalkar, H. van der Sijs, A. D. Tucker, A. A. Desai, D. S. Bell, J. M. Teich, B. Middleton, and D. W. Bates, “Drug-drug interactions that should be non-interruptive in order to reduce alert fatigue in electronic health records,” J. Am. Med. Inform. Assoc. JAMIA, vol. 20, no. 3, pp. 489-493, May 2013.
</p>

<p>NDF- RT - a list of PDDIs formerly maintained by the United States Veteran’s
Administration (VA) for use in VA care settings

E. L. Olvey, S. Clauschee, and D. C. Malone, “Comparison of critical drug-drug interaction listings: the Department of Veterans Affairs medical system and standard reference compendia,” Clin. Pharmacol. Ther., vol. 87, no. 1, pp. 48-51, Jan. 2010.
</p>

<p>OSCAR - a list of PDDIs derived by expert consensus in the late 1990s that were more recently used in an Open Source Electronic Health Records system
called OSCAR.

N. R. Crowther, A. M. Holbrook, R. Kenwright, and M. Kenwright, “Drug interactions
among commonly used medications. Chart simplifies data from critical literature review,” Can. Fam. Physician Médecin Fam. Can., vol. 43, pp. 1972–1976, 1979–1981, Nov. 1997

Oscar-McMaster, “OSCAR Electronic Medical Record,” OSCAREMR, 2014. [Online]. Available: http://oscar-emr.com/. [Accessed: 13-Oct-2014]
</p>


<b>Four of the sources were developed to support NLP algorithm development</b>

<p>DDI Corpus 2011 - the reference standard for the 2011 SemEval Challenge on drug-drug interaction NLP

I. Segura-Bedmar, P. Martınez, and D. Sánchez-Cisneros, “The 1st DDIExtraction-2011
challenge task: Extraction of Drug-Drug Interactions from biomedical texts,” 2011
</p>

<p>DDI Corpus 2013 the reference standard for the 2013 SemEval
Challenge that followed the 2011 challenge

I. Segura-Bedmar, P. Martınez, and M. Herrero-Zazo, “Semeval-2013 task 9: Extraction of drug-drug interactions from biomedical texts,” in Proceedings of the 7th International Workshop on Semantic Evaluation (SemEval 2013), 2013.
</p>

<p>PK DDI Corpus - a reference standard used to develop NLP to identify pharmacokinetic PDDIs mentioned in product labeling
<a href="http://dbmi-icode-01.dbmi.pitt.edu/dikb-evidence/package-insert-DDI-NLP-corpus.html">Download</a> 

R. Boyce, G. Gardner, and H. Harkema, “Using Natural Language Processing to Extract
Drug-Drug Interaction Information from Package Inserts,” in BioNLP: Proceedings of the 2012 Workshop on Biomedical Natural Language Processing, Montréal, Canada, 2012, pp.206–213.
</p>
 
<p>NLM CV DDI Corpus - a reference standard used to develop NLP to identify
PDDIs mentioned in drug product labeling affecting cardiovascular drugs

Johann Stan, “A Machine-Learning Approach for Drug-Drug Interaction Extraction from
FDA Structured Product Labels,” presented at the 2014 National Library of Medicine
Training Conference, Pittsburgh PA, USA, 17-Jun-2014.
</p>

<b>Five other sources were developed to support either pharmacovigilance or bioinformatics applications. </b>

<p>KEGG DDI - a list provided by the Kyoto Encyclopedia of Genes and
Genomes (KEGG) resource of PDDIs extracted from the interaction tables of
Japanese product labels

M. Kanehisa, S. Goto, Y. Sato, M. Kawashima, M. Furumichi, and M. Tanabe, “Data,
information, knowledge and principle: back to metabolism in KEGG,” Nucleic Acids Res.,vol. 42, no. Database issue, pp. D199–205, Jan. 2014.

I. Segura-Bedmar, P. Martınez, and M. Herrero-Zazo, “Semeval-2013 task 9: Extraction of drug-drug interactions from biomedical texts,” in Proceedings of the 7th International Workshop on Semantic Evaluation (SemEval 2013), 2013.
</p>

<p>TWOSIDES - a list of PDDI pharmacovigilance signals derived by data mining a database of spontaneously reported adverse events

N. P. Tatonetti, P. P. Ye, R. Daneshjou, and R. B. Altman, “Data-driven prediction of drug effects and interactions,” Sci. Transl. Med., vol. 4, no. 125, p. 125ra31, Mar. 2012.
</p>

<p>DrugBank PDDIs listed in v4.0 of DrugBank

V. Law, C. Knox, Y. Djoumbou, T. Jewison, A. C. Guo, Y. Liu, A. Maciejewski, D. Arndt,M. Wilson, V. Neveu, A. Tang, G. Gabriel, C. Ly, S. Adamjee, Z. T. Dame, B. Han, Y. Zhou, and D. S. Wishart, “DrugBank 4.0: shedding new light on drug metabolism,” Nucleic Acids Res., vol. 42, no. Database issue, pp. D1091–1097, Jan. 2014
</p>

<p>DIKB - observed and predicted pharmacokinetic interactions listed in the Drug Interaction Knowledge Base

R. Boyce, C. Collins, J. Horn, and I. Kalet, “Computing with evidence Part II: An
evidential approach to predicting metabolic drug-drug interactions,” J. Biomed. Inform.,vol. 42, no. 6, pp. 990–1003, Dec. 2009
</p>

<p>SemMedDB - a database of subject, predicate, object relationships extracted from MEDLINE abstracts by the NLP program SemRep

H. Kilicoglu, D. Shin, M. Fiszman, G. Rosemblat, and T. C. Rindflesch, “SemMedDB: a
PubMed-scale repository of biomedical semantic predications,” Bioinformatics, vol. 28, no.23, pp. 3158–3160, Dec. 2012.
</p>

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

<P><HR>
<span style="width: 60px"></span> 
<FONT SIZE="-1"><P>Copyright &#169 Copyright (C) 2014 - 2015 Richard D. Boyce<BR>All Rights Reserved<BR>
</FONT>


    </body>
</html>
