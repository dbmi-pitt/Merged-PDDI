### Merged PDDI - Version 1.0 ###

Potential drug-drug interaction information from publicly
available sources (Code to prototype the new Drug Interaction Knowledge Base)

A service provided by the University of Pittsburgh Drug Interaction Knowledge Base (DIKB)

### Repository layout:

design: mockup ppt
data: 6 sources dataset in CSV, schema drugData in SQL
scripts: python script purpose for merge new mappings (ex. drug classes)

maven-src: prototype in maven (Merged-PDDI)
netbeans-src: prototype in netbeans (original version from IS team)

### Techs:

Java Servlet, JSP, JSTL, Ajax, Jquery, SQL

### Compatible Platforms:

Chrome, Firefox, Safari, IE9


### deploy prototype:

(1) requirements (http://www.tutorialspoint.com/maven/maven_environment_setup.htm):

Java JDK (oracle) > 1.6
Maven 3.3.1
Versions for tomcat, JSP, JSP-EL: http://tomcat.apache.org/whichversion.html
MySQL 5.1

Linux:
$ sudo apt-get install mysql-server
$ sudo apt-get install maven
$ sudo apt-get install tomcat7

(2) setup database

$ Mysql -u {$DB_USERNAME} -p {$DB_SCHEMA} < data/drugData.sql

create a db config file at "Merged-PDDI/src/main/resources/db-connection.properties"

database={$DB_SCHEMA}
dbuser={$DB_USERNAME}
dbpassword={$DB_PASSWORD}


(3) use maven compile and deploy to tomcat

$ mvn clean compile war:war
$ sudo cp target/Merged-PDDI /var/lib/tomcat6/webapps/
$ sudo service tomcat6 restart

(4) access prototype at : http://localhost:8080/Merged-PDDI

Tips:
maven to eclipse: mvn eclipse:eclipse
STS(based on eclipse 3.2) can be editor of prototype (shared with domeo)

(5) mapping assertion and evidence item from dikbv1.2 to MP claims and data or statement

1. unzip dataset

$ bunzip data/CombinedDatasetNotConservativeAllsources.csv.bz2

2. (OPTIONAL) filter dataset to 6 specified sources

$ python scripts/parseAndMergeInSixSources.py
append object/precipitant drug class, replace assertion/evidence in dikbv1.2 to MP claims and data/statement as evidence item

Output six sources dataset: DIKB-6-sources.csv

3. load combined tsv dataset into mysql
 
Enable load local infile in mysql
mysql -u root -p --local-infile=1 "Merged-PDDI" --show-warnings

LOAD DATA LOCAL INFILE '/home/rdb20/Merged-PDDI/data/postprocessed-dataset-not-conservative.tsv' 
INTO TABLE interactions1 FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@drug1, @object, @drug2, @precipitant, @certainty, @contraindication, @dateAnnotated, @ddiPkEffect, @ddiPkMechanism, @effectConcept, @homepage, @label, @numericVal, @objectUri, @pathway, @precaution, @precipUri, @severity, @uri, @whoAnnotated, @source, @ddiType, @evidence, @evidenceSource, @evidenceStatement, @researchStatementLabel, @researchStatement, @DrugClass1, @DrugClass2, @drug1ID, @drug2ID)
set drug1=@drug1, object=@object, drug1ID=@drug1ID, drug2=@drug2, precipitant=@precipitant, drug2ID=@drug2ID,certainty=@certainty, contraindication=@contraindication, dateAnnotated=@dateAnnotated, ddiPkEffect=@ddiPkEffect, ddiPkMechanism=@ddiPkMechanism, effectConcept=@effectConcept, homepage=@homepage , label=@label, numericVal=@numericVal, pathway=@pathway, precaution=@precaution, severity=@severity, uri=@uri, whoAnnotated=@whoAnnotated, source=@source, ddiType=@ddiType, evidence=@evidence, evidenceSource=@evidenceSource, evidenceStatement=@evidenceStatement, researchStatementLabel=@researchStatementLabel, researchStatement=@researchStatement, managementOptions=@managementOptions, DrugClass1=@DrugClass1, DrugClass2=@DrugClass2, objectUri=@objectUri, precipUri=@precipUri;

REFERENCE:
(1) header of combined data set
drug1   object  drug2   precipitant     certainty       contraindication        dateAnnotated   ddiPkEffect     ddiPkMechanism  effectConcept   homepage        label   numericVal      objectUri       pathway precaution      precipUri       severity        uri     whoAnnotated    source  ddiType evidence        evidenceSource  evidenceStatement       researchStatementLabel  researchStatement       DrugClass1      DrugClass2      drug1ID drug2ID

(2) database table interactions1 headers:
  `interactionID` int(11) NOT NULL AUTO_INCREMENT,
  `drug1` varchar(256) DEFAULT NULL,
  `object` varchar(256) DEFAULT NULL,
  `drug1ID` varchar(50) DEFAULT NULL,
  `drug2` varchar(256) DEFAULT NULL,
  `precipitant` varchar(256) DEFAULT NULL,
  `drug2ID` varchar(50) DEFAULT NULL,
  `certainty` varchar(256) DEFAULT NULL,
  `contraindication` varchar(256) DEFAULT NULL,
  `dateAnnotated` varchar(256) DEFAULT NULL,
  `ddiPkEffect` varchar(256) DEFAULT NULL,
  `ddiPkMechanism` varchar(256) DEFAULT NULL,
  `effectConcept` varchar(256) DEFAULT NULL,
  `homepage` varchar(256) DEFAULT NULL,
  `label` varchar(650) DEFAULT NULL,
  `numericVal` varchar(256) DEFAULT NULL,
  `pathway` varchar(256) DEFAULT NULL,
  `precaution` varchar(256) DEFAULT NULL,
  `severity` varchar(256) DEFAULT NULL,
  `uri` varchar(256) DEFAULT NULL,
  `whoAnnotated` varchar(256) DEFAULT NULL,
  `source` varchar(256) DEFAULT NULL,
  `ddiType` varchar(256) DEFAULT NULL,
  `evidence` varchar(256) DEFAULT NULL,
  `evidenceSource` varchar(256) DEFAULT NULL,
  `evidenceStatement` varchar(3800) DEFAULT NULL,
  `researchStatementLabel` varchar(256) DEFAULT NULL,
  `researchStatement` varchar(256) DEFAULT NULL,
  `managementOptions` varchar(3800) DEFAULT NULL,
  `DrugClass1` varchar(256) DEFAULT NULL,
  `DrugClass2` varchar(256) DEFAULT NULL,
  `objectUri` varchar(256) NOT NULL,
  `precipUri` varchar(256) NOT NULL,


4. Truncate table
SET FOREIGN_KEY_CHECKS=0;

TRUNCATE table interactions1;
SELECT * FROM `Merged-PDDI`.interactions1;

SET FOREIGN_KEY_CHECKS=1;