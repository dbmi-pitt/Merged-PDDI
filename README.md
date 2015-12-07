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

$ bunzip data/CombinedDatasetNotConservativeAllsources.csv.bz2

$ python scripts/parseAndMergeInSixSources.py
append object/precipitant drug class, replace assertion/evidence in dikbv1.2 to MP claims and data/statement as evidence item

Output six sources dataset: DIKB-6-sources.csv

$ mysql -u <username> -p

SET FOREIGN_KEY_CHECKS=0;

LOAD DATA LOCAL INFILE '<PATH TO>/DIKB-6-sources.csv' 
INTO TABLE drugData.interactions1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
 