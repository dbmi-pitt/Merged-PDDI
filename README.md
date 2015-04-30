DIKB-Prototype (Code to prototype the new Drug Interaction Knowledge Base)

### Repository layout:

design: mockup ppt
data: 6 sources dataset in CSV, schema drugData in SQL
scripts: python script purpose for merge new mappings (ex. drug classes)

maven-src: prototype in maven 
netbeans-src: prototype in netbeans (original version from IS team)

### Techs:

Java Servlet, JSP, JSTL, Ajax, Jquery, SQL


### depoly prototype:

(1) requirements (http://www.tutorialspoint.com/maven/maven_environment_setup.htm):

Java JDK (oracle) > 1.6
Maven 3.3.1
Versions for tomcat, JSP, JSP-EL: http://tomcat.apache.org/whichversion.html
MySQL 5.1

(2) setup database

Mysql -u root -p drugData < data/drugData.sql

(3) use maven compile and deploy to tomcat

$ mvn clean compile war:war
$ sudo cp target/DIKB-Prototype /var/lib/tomcat6/webapps/
$ sudo service tomcat6 restart

(4) access prototype at : http://localhost:8080/DIKB-Prototype