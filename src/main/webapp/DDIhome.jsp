<%@page contentType="text/html" pageEncoding="UTF8" session="true" import="java.util.*,com.ddi.*" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<head>
  <title>Welcome to DDI Search</title>
  <link rel="stylesheet" type="text/css" href="css/ddistyle.css" />
  <meta charset="UTF-8">
  <script src="js/jquery-1.11.1.min.js"></script>
  <link href="css/listbox.css" rel="stylesheet" />
  <link href="css/BacktoTop.css" rel="stylesheet" />
  <link href="css/flat-ui.min.css" rel="stylesheet"/>
  <link href="css/demo.css" rel="stylesheet"/>
  <script src="js/modernizr.js"></script>
  <script src="js/listbox.js"></script>
  <script src="js/main.js"></script>

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
  <div class = "body2">
    <!-- show description dialog if it's first time visit this page -->
    <% String visit = (String) session.getAttribute("visited"); 
       if (visit == null){
       %>
    <div id="dialog-message" title="Description:">
      <p class = "lead" style = "font-size: 15px;">
	<b>Note - This free potential drug-drug information source is
	  intended for informatics and pharmacovigilance research and
	  is not a drug-drug interaction checking tool!</b> Rather, it
	  provides access to a combined dataset (available via
	  download) that merges together data from more than a dozen
	  different sources (as of January 2018) including several
	  clinically-oriented information sources, Natural Language
	  Processing (NLP) Corpora, and
	  Bioinformatics/Pharmacovigilance information sources. The
	  browsing feature of this site applies to a subset of all
	  available sources. If you want to work with the entire
	  dataset, please download the delimitted text files available
	  under the search form. Please post any questions or requests
	  to our forum
	  on <i><a href="https://forums.dikb.org/c/merged-pddi-dataset">dikb.org</a></i>
      </p>

      <p class = "lead" style = "font-size: 15px;">
	Please cite the following paper in any publications or presentations
	that present work that used data from downloaded or accessed from this
	web site.
      </p>

      <p class = "lead" style = "font-size: 15px;">
	Ayvaz S, Horn J, Hassanzadeh O, Zhu Q, Stan J, Tatonetti NP, Vilar S,
	Brochhausen M, Samwald M, Rastegar-Mojarad M, Dumontier M, Boyce RD,
	Toward a complete dataset of drug-drug interaction information from
	publicly available sources, Journal of Biomedical
	Informatics,doi:10.1016/j.jbi.2015.04.006
      </p>

    </div>


    <%  } 
	// mark the page as visited
	session.setAttribute("visited","visited");
	HashMap<String, ArrayList<String>> sourceSet = new HashMap<String, ArrayList<String>>();
	HashMap<String, String> sourceNum = new HashMap<String, String>();
	HashMap<String, String> sourceExp = new HashMap<String, String>();
	Drug drug = (Drug)session.getAttribute("DrugBean");
	sourceSet = drug.getSourceSet();
	sourceNum = drug.getSourceNum();
	sourceExp = drug.getSourceExp();
	%>

    <!-- <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span> -->


    <div id="page1">
      <header>
        <h3 class="centered" style = "font-size:37px">A tool to explore potential drug-drug interaction (PDDI) information from publicly available sources</h3>

      </header>		
      <div class="intro">
        <p class = "lead" style = "font-size:16px"> A service provided by the University of Pittsburgh <a href="http://dikb.org">Drug Interaction Knowledge Base (DIKB)</a>
	</p>

	<p class = "lead" style = "font-size: 16px;">
	  This site will help you explore potential drug-drug interaction information (PDDIs) between two prescription drugs as listed <i>from a subset</i> of publicly available sources. You may download all sources as delimited text files using links below the search form. To browse, enter the drugs you would like to search for, then select the type of sources and type of information you are interested in viewing.</p>	
      </div>

      <form name="drugForm" action="SearchServlet" method="POST">
        <div class="drugs centered">			
          <div class="stepHeader" style = "font-size: 15px">Step 1: Please choose 2 drugs to compare</div>
          <!-- <div class="stepHeader" style = "font-size: 15px">(Note: Precipitant/object roles might not be applicable. If that is the case then only pay attention to the labels 'drug 1' and 'drug 2'.)</div> -->
          <div align="center">
            <div id="drugSelection1">
              <div class="bold centered" style="font-size:16px">Drug1</div>
              <div id="parent1" style = "font-size:14px" align="left">                      
                <select name="drugList1" id="drugList1" onchange="getAvailableDrugPair();"></select>
              </div>
            </div>
	    
            <div id="drugSelection2">
              <div class="bold centered" style="font-size:16px">Drug2</div>
              <div id="parent2" style = "font-size:14px" align="left">
                <select name="drugList2" id="drugList2"></select>
              </div>
            </div>
          </div>
        </div>

        <div class="filters clear">
          <p class="centered stepHeader">Step 2: Please choose the sources for the data</p>
          <div class="centerDiv" style = "font-size:14px;">
            <%
               String tempTag = null;
               ArrayList<String> tempsources = new ArrayList<String>();
               Iterator it = sourceSet.entrySet().iterator();
               
               while (it.hasNext()) {
               Map.Entry pair = (Map.Entry)it.next();
               tempTag = (String)pair.getKey();
               out.print("<input type='checkbox' id='" + tempTag + "' value='Clinically Oriented' onchange='checkSources(this);atLeastOneSource();getAvailableDrug1();' checked><span class='bold'>"+ tempTag +"</span><br><div class='indent'>\n");
               tempsources = (ArrayList<String>)pair.getValue();
               for(String tempsource : tempsources)
               {
               if(sourceNum.containsKey(tempsource))
               {
               out.print("<input type='checkbox'  name='source' class='"+ tempTag +"' value='"+ tempsource +"' checked onchange='checkSubSources(this);atLeastOneSource();'>"+ tempsource +" ["+ sourceNum.get(tempsource) +"]  <input class='drugExample' type='submit' value='e.g. "+sourceExp.get(tempsource)+"'  onclick='changedruglist(this)'/><br>\n");
               }else
               {
               out.print("<input type='checkbox'  name='source' class='"+ tempTag +"' value='"+ tempsource +"' checked onchange='checkSubSources(this);atLeastOneSource();'>"+ tempsource +" [0]<br>\n");
               }
               }
               out.print("</div>\n");
               it.remove();
               }%>
            

            <script>
            </script>
          </div>
        </div>
        <div class="test centered">
          <div id="submitButton1"><input id="findInteractionsSubmit" class="clear regButton1" type="submit" value="List PDDI information"/></div>
          <div id="warningMessage" class="centered warning"></div>
        </div>
      </form>
    </div>

    <div class="firstpagemargin">
      <BR><BR>
      <p>
	<b style="font-size:22px">Download all merged PDDI datasets</b><br>
	<a style = "font-size:15px" href="https://dbmi-icode-01.dbmi.pitt.edu/dikb-evidence/pddi-sets/CombinedDatasetConservative.csv.bz2">More conservative</a>&nbsp;&nbsp;&nbsp;
	<a style = "font-size:15px" href="https://dbmi-icode-01.dbmi.pitt.edu/dikb-evidence/pddi-sets/CombinedDatasetNotConservative.csv.bz2">Less conservative</a>
      </p>
      <p class = "lead" style = "font-size:13px">
	More conservative is limited matches between a DrugBank and UNII record to those cases where an exact case-insensitive match was identified for both an InChI identifier and either the drug preferred term or synonym. 
	<br>
	Less conservative approach involves a match on InChI key or an exact case-insensitive match of preferred term or a synonym. The latter approach resulted in a greater number of mappings.
      </p>

      <h5><b style="font-size:22px">Funding Acknowledgements</b></h5>
      <p class = "lead" style = "font-size:13px">This project is supported by a grant from the National Library of Medicine: "Addressing gaps in clinically useful evidence on drug-drug interactions"   (R01LM011838)</p>


      <h5><b style="font-size:22px">Citations for PDDI sources </b></h5>

      <b style="font-size:15px">Eight of the sources were developed for clinical application</b>
      <ul class = "lead" style = "text-align: left; font-size: 13px;">
	<li>French National Formulary: Thesaurus des interactions medicamenteuses. ANSM.2016. URL: <a target="new" href="http://ansm.sante.fr/var/ansm_site/storage/original/application/de444ea9eb4bc084905c917c902a805f.pdf">http://ansm.sante.fr/var/ansm_site/storage/original/application/de444ea9eb4bc084905c917c902a805f.pdf</a>. English translation provided by the <a target="new" href="http://worldvista.org/">World Vista</a> organization. 
	</li>
	<li>Credimeds: a list of PDDIs thought to be clinically relevant and supported by strong scientific evidence

	  “Crediblemeds.org,” 05-Oct-2013. [Online]. Available: http://www.crediblemeds.org/.[Accessed: 05-Oct-2013].  
	</li>

	<li>
	  ONC High Priority - a list of PDDIs suggested as a high priority to alert clinicians in any care environment

	  S. Phansalkar, A. A. Desai, D. Bell, E. Yoshida, J. Doole, M. Czochanski, B. Middleton,and D. W. Bates, “High-priority drug-drug interactions for use in electronic health records,”J. Am. Med. Inform. Assoc. JAMIA, vol. 19, no. 5, pp. 735-743, Oct. 2012.
	</li>

	<li>ONC Non-interruptive - a list of PDDIs not requiring interruptive alerting in any care environment

	  S. Phansalkar, H. van der Sijs, A. D. Tucker, A. A. Desai, D. S. Bell, J. M. Teich, B. Middleton, and D. W. Bates, “Drug-drug interactions that should be non-interruptive in order to reduce alert fatigue in electronic health records,” J. Am. Med. Inform. Assoc. JAMIA, vol. 20, no. 3, pp. 489-493, May 2013.
	</li>

	<li>NDF- RT - a list of PDDIs formerly maintained by the United States Veteran’s
	  Administration (VA) for use in VA care settings

	  E. L. Olvey, S. Clauschee, and D. C. Malone, “Comparison of critical drug-drug interaction listings: the Department of Veterans Affairs medical system and standard reference compendia,” Clin. Pharmacol. Ther., vol. 87, no. 1, pp. 48-51, Jan. 2010.
	</li>

	<li>OSCAR - a list of PDDIs derived by expert consensus in the late 1990s that were more recently used in an Open Source Electronic Health Records system
	  called OSCAR.

	  N. R. Crowther, A. M. Holbrook, R. Kenwright, and M. Kenwright, “Drug interactions
	  among commonly used medications. Chart simplifies data from critical literature review,” Can. Fam. Physician Médecin Fam. Can., vol. 43, pp. 1972–1976, 1979–1981, Nov. 1997

	  Oscar-McMaster, “OSCAR Electronic Medical Record,” OSCAREMR, 2014. [Online]. Available: http://oscar-emr.com/. [Accessed: 13-Oct-2014]
	</li>

	<li>Liverpool HIV: reliable, comprehensive, up-to-date, evidence-based drug-drug interaction resource about HIV.

	  “http://www.hiv-druginteractions.org” 09-Oct-2017.
	</li>

	<li>Liverpool HEP: reliable, comprehensive, up-to-date, evidence-based drug-drug interaction resource about HEP.

	  “http://www.hep-druginteractions.org” 09-Oct-2017.
	</li>

      </ul>

      <b style="font-size:15px">Four of the sources were developed to support NLP algorithm development</b>
      <ul class = "lead" style = "text-align: left; font-size: 13px;">
	<li>DDI Corpus 2011 - the reference standard for the 2011 SemEval Challenge on drug-drug interaction NLP

	  I. Segura-Bedmar, P. Martınez, and D. Sánchez-Cisneros, “The 1st DDIExtraction-2011
	  challenge task: Extraction of Drug-Drug Interactions from biomedical texts,” 2011
	</li>

	<li>DDI Corpus 2013 the reference standard for the 2013 SemEval
	  Challenge that followed the 2011 challenge

	  I. Segura-Bedmar, P. Martınez, and M. Herrero-Zazo, “Semeval-2013 task 9: Extraction of drug-drug interactions from biomedical texts,” in Proceedings of the 7th International Workshop on Semantic Evaluation (SemEval 2013), 2013.
	</li>

	<li>PK DDI Corpus - a reference standard used to develop NLP to identify pharmacokinetic PDDIs mentioned in product labeling

	  R. Boyce, G. Gardner, and H. Harkema, “Using Natural Language Processing to Extract
	  Drug-Drug Interaction Information from Package Inserts,” in BioNLP: Proceedings of the 2012 Workshop on Biomedical Natural Language Processing, Montréal, Canada, 2012, pp.206–213.
	  <a href="http://dbmi-icode-01.dbmi.pitt.edu/dikb-evidence/package-insert-DDI-NLP-corpus.html">Download</a> 
	</li>
	
	<li>NLM CV DDI Corpus - a reference standard used to develop NLP to identify
	  PDDIs mentioned in drug product labeling affecting cardiovascular drugs

	  Johann Stan, “A Machine-Learning Approach for Drug-Drug Interaction Extraction from
	  FDA Structured Product Labels,” presented at the 2014 National Library of Medicine
	  Training Conference, Pittsburgh PA, USA, 17-Jun-2014.
	</li>
      </ul>

      <p>Five other sources were developed to support either pharmacovigilance or bioinformatics applications. </p>
      <ul  class = "lead" style = "text-align: left; font-size: 13px;">
	<li>KEGG DDI - a list provided by the Kyoto Encyclopedia of Genes and
	  Genomes (KEGG) resource of PDDIs extracted from the interaction tables of
	  Japanese product labels

	  M. Kanehisa, S. Goto, Y. Sato, M. Kawashima, M. Furumichi, and M. Tanabe, “Data,
	  information, knowledge and principle: back to metabolism in KEGG,” Nucleic Acids Res.,vol. 42, no. Database issue, pp. D199–205, Jan. 2014.

	  I. Segura-Bedmar, P. Martınez, and M. Herrero-Zazo, “Semeval-2013 task 9: Extraction of drug-drug interactions from biomedical texts,” in Proceedings of the 7th International Workshop on Semantic Evaluation (SemEval 2013), 2013.
	</li>

	<li>TWOSIDES - a list of PDDI pharmacovigilance signals derived by data mining a database of spontaneously reported adverse events

	  N. P. Tatonetti, P. P. Ye, R. Daneshjou, and R. B. Altman, “Data-driven prediction of drug effects and interactions,” Sci. Transl. Med., vol. 4, no. 125, p. 125ra31, Mar. 2012.
	</li>

	<li>DrugBank PDDIs listed in v4.0 of DrugBank

	  V. Law, C. Knox, Y. Djoumbou, T. Jewison, A. C. Guo, Y. Liu, A. Maciejewski, D. Arndt,M. Wilson, V. Neveu, A. Tang, G. Gabriel, C. Ly, S. Adamjee, Z. T. Dame, B. Han, Y. Zhou, and D. S. Wishart, “DrugBank 4.0: shedding new light on drug metabolism,” Nucleic Acids Res., vol. 42, no. Database issue, pp. D1091–1097, Jan. 2014
	</li>

	<li>DIKB - observed and predicted pharmacokinetic interactions listed in the Drug Interaction Knowledge Base

	  R. Boyce, C. Collins, J. Horn, and I. Kalet, “Computing with evidence Part II: An
	  evidential approach to predicting metabolic drug-drug interactions,” J. Biomed. Inform.,vol. 42, no. 6, pp. 990–1003, Dec. 2009
	</li>

	<li>SemMedDB - a database of subject, predicate, object relationships extracted from MEDLINE abstracts by the NLP program SemRep

	  H. Kilicoglu, D. Shin, M. Fiszman, G. Rosemblat, and T. C. Rindflesch, “SemMedDB: a
	  PubMed-scale repository of biomedical semantic predications,” Bioinformatics, vol. 28, no.23, pp. 3158–3160, Dec. 2012.
	</li>
      </ul>
      <BR>
      <h5>License</h5>
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
	<FONT SIZE="-1"><br>Copyright &#169 2015 - 2018 Richard D. Boyce and Serkan Ayvaz<BR>All Rights Reserved<BR>
	</FONT>
	<br>
	<br>
      </div>
    </div>
  </div>
  <hr>
</body>
</html>
