-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: drugData
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

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
-- Dumping data for table `sources_category`
--

LOCK TABLES `sources_category` WRITE;
/*!40000 ALTER TABLE `sources_category` DISABLE KEYS */;
INSERT INTO `sources_category` VALUES ('CredibleMeds','Clinically-oriented','A list of clinically important drug-drug interactions.'),('DIKB','Bioinformatics- Pharmacovigilance','An evidence-focused knowledge base of pharmacokinetic PDDIs.'),('Drugbank','Bioinformatics- Pharmacovigilance','Comprehensive drug information resource.'),('NDF-RT','Clinically-oriented','PDDIs used until 2014 by the Veteran\'s Administration health care system.'),('ONC-HighPriority','Clinically-oriented','A consensus list of PDDIs that are recommended by the Office of the National Coordinator as high priority for inclusion in alerting systems.'),('ONC-NonInteruptive','Clinically-oriented','A consensus list of PDDIs that are recommended by the Office of the National Coordinator for use in non-interruptive alerts.'),('French National Formulary (Fr.)','Clinically-oriented','French National Formulary (Fr.)'),('French National Formulary (Eng. - TESTING)','Clinically-oriented','Clinically oriented drug interactions from the French National formulary translated to English by the WorldVista foundation'),('HIV','Liverpool HIV','Clinically-oriented', 'reliable, comprehensive, up-to-date, evidence-based drug-drug interaction resource about HIV.'),('HEP','Liverpool HEP','Clinically-oriented', 'reliable, comprehensive, up-to-date, evidence-based drug-drug interaction resource about HEP.');
/*!40000 ALTER TABLE `sources_category` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-29  9:52:42
