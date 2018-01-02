### Merged PDDI - Version 1.0 ###

Potential drug-drug interaction information from publicly
available sources (Code to prototype the new Drug Interaction Knowledge Base)

A service provided by the University of Pittsburgh Drug Interaction Knowledge Base (DIKB) with grant funding from the National Library of Medicine (R01LM011838).

NOTE: A different code repository holds the code for extracting, translating, and loading the data from the various sources: https://github.com/dbmi-pitt/public-PDDI-analysis 

### Repository layout:

- data : The potential drug-drug interaction data that has been merged into a single data model. The SQL files are needed to create and load the database. The Bzip'ed tab-delimited (TSV) files are for folks to download

- scripts : scripts for post-processing merged data

- src : the web application code

- pom.xml : the Maven build configuration script

NOTE: Edit ./src/main/resources/source-attribute.properties to configure the specific sources selectable from the front page of the web site and the specific rows shown on the results page.

### Technologies used:

Java Servlet, JSP, JSTL, Ajax, Jquery, SQL

### Compatible Platforms:

Chrome, Firefox, Safari, IE9

### deploy prototype:

(1) requirements (http://www.tutorialspoint.com/maven/maven_environment_setup.htm):

Java JDK (oracle) >= 1.7
Maven 3.3.1
Versions for tomcat, JSP, JSP-EL: http://tomcat.apache.org/whichversion.html
MySQL >= 5.1

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
$ sudo cp target/Merged-PDDI.war <path to tomcat>/webapps/

(4) access prototype at : http://localhost:8080/Merged-PDDI
