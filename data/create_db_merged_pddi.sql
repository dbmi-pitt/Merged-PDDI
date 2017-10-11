CREATE DATABASE merged_pddi;
USE merged_pddi;
SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `interactions1`
--

DROP TABLE IF EXISTS `interactions1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interactions1` (
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
  PRIMARY KEY (`interactionID`),
  KEY `source` (`source`)
) ENGINE=InnoDB AUTO_INCREMENT=19745650 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sources_category`
--

DROP TABLE IF EXISTS `sources_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sources_category` (
  `source` varchar(256) DEFAULT NULL,
  `category` varchar(256) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  KEY `source_idx` (`source`),
  CONSTRAINT `source` FOREIGN KEY (`source`) REFERENCES `interactions1` (`source`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- load data for table `sources_category`
--

LOCK TABLES `sources_category` WRITE;
/*!40000 ALTER TABLE `sources_category` DISABLE KEYS */;
INSERT INTO `sources_category` VALUES ('CredibleMeds','Clinically-oriented','A list of clinically important drug-drug interactions.'),('DIKB','Bioinformatics- Pharmacovigilance','An evidence-focused knowledge base of pharmacokinetic PDDIs.'),('Drugbank','Bioinformatics- Pharmacovigilance','Comprehensive drug information resource.'),('NDF-RT','Clinically-oriented','PDDIs used until 2014 by the Veteran\'s Administration health care system.'),('ONC-HighPriority','Clinically-oriented','A consensus list of PDDIs that are recommended by the Office of the National Coordinator as high priority for inclusion in alerting systems.'),('ONC-NonInteruptive','Clinically-oriented','A consensus list of PDDIs that are recommended by the Office of the National Coordinator for use in non-interruptive alerts.'),('French National Formulary (Fr.)','Clinically-oriented','French National Formulary (Fr.)'),('French National Formulary (Eng. - TESTING)','Clinically-oriented','Clinically oriented drug interactions from the French National formulary translated to English by the WorldVista foundation'),('Liverpool HIV','Clinically-oriented', 'reliable, comprehensive, up-to-date, evidence-based drug-drug interaction resource about HIV.'),('Liverpool HEP','Clinically-oriented', 'reliable, comprehensive, up-to-date, evidence-based drug-drug interaction resource about HEP.');

SET FOREIGN_KEY_CHECKS=1;
