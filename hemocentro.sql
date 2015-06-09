-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: localhost    Database: hemocentro
-- ------------------------------------------------------
-- Server version	5.5.38

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
-- Table structure for table `tb_blood_stock`
--

DROP TABLE IF EXISTS `tb_blood_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_blood_stock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `qnt_A_pos` int(11) unsigned DEFAULT NULL,
  `qnt_A_neg` int(11) unsigned DEFAULT NULL,
  `qnt_B_pos` int(11) unsigned DEFAULT NULL,
  `qnt_B_neg` int(11) unsigned DEFAULT NULL,
  `qnt_AB_pos` int(11) unsigned DEFAULT NULL,
  `qnt_AB_neg` int(11) unsigned DEFAULT NULL,
  `qnt_O_pos` int(11) unsigned DEFAULT NULL,
  `qnt_O_neg` int(11) unsigned DEFAULT NULL,
  `id_institute` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_institute` (`id_institute`),
  CONSTRAINT `tb_blood_stock_ibfk_1` FOREIGN KEY (`id_institute`) REFERENCES `tb_institute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_blood_stock`
--

LOCK TABLES `tb_blood_stock` WRITE;
/*!40000 ALTER TABLE `tb_blood_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_blood_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_blood_type`
--

DROP TABLE IF EXISTS `tb_blood_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_blood_type` (
  `id` int(11) NOT NULL,
  `blood_type` varchar(10) NOT NULL,
  `rh` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_blood_type`
--

LOCK TABLES `tb_blood_type` WRITE;
/*!40000 ALTER TABLE `tb_blood_type` DISABLE KEYS */;
INSERT INTO `tb_blood_type` VALUES (1,'A',''),(2,'A','\0'),(3,'B',''),(4,'B','\0'),(5,'AB',''),(6,'AB','\0'),(7,'O',''),(8,'O','\0');
/*!40000 ALTER TABLE `tb_blood_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_donation`
--

DROP TABLE IF EXISTS `tb_donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_donation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `qnt_blood` int(11) unsigned NOT NULL,
  `blood_type` int(11) NOT NULL,
  `donation_date` date NOT NULL,
  `hospital` int(11) unsigned DEFAULT NULL,
  `cpf` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital` (`hospital`),
  CONSTRAINT `tb_donation_ibfk_1` FOREIGN KEY (`hospital`) REFERENCES `tb_hospital` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_donation`
--

LOCK TABLES `tb_donation` WRITE;
/*!40000 ALTER TABLE `tb_donation` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_giver`
--

DROP TABLE IF EXISTS `tb_giver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_giver` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `adress` varchar(45) NOT NULL,
  `phone1` int(11) DEFAULT NULL,
  `phone2` int(11) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `blood_type` int(11) NOT NULL,
  `cpf` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `blood_type` (`blood_type`),
  CONSTRAINT `tb_giver_ibfk_1` FOREIGN KEY (`blood_type`) REFERENCES `tb_blood_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_giver`
--

LOCK TABLES `tb_giver` WRITE;
/*!40000 ALTER TABLE `tb_giver` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_giver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_institute`
--

DROP TABLE IF EXISTS `tb_institute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_institute` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cnpj` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_institute`
--

LOCK TABLES `tb_institute` WRITE;
/*!40000 ALTER TABLE `tb_institute` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_institute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_type`
--

DROP TABLE IF EXISTS `tb_user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(23) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_type`
--

LOCK TABLES `tb_user_type` WRITE;
/*!40000 ALTER TABLE `tb_user_type` DISABLE KEYS */;
INSERT INTO `tb_user_type` VALUES (1,'administrator'),(2,'employed');
/*!40000 ALTER TABLE `tb_user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(23) NOT NULL,
  `name` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `encryp_password` varchar(80) NOT NULL,
  `salt` varchar(10) NOT NULL,
  `user_type` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id` (`unique_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `user_type` (`user_type`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
INSERT INTO `tb_users` VALUES (39,'557633641170e8.83239823','Usuario padrao','usuario@hemocentro.com.br','Al/zfI75lxB8kQI4ZH2uYeu5kftjYTA3ZDI4ZTQ4','ca07d28e48',2,'user'),(40,'5576339ad8f747.18888660','Administrador padrao','admin@hemocentro.com.br','C2RqD4rZsWxnPT3PzhcIUMLsp7swZDJmNGIwYmNj','0d2f4b0bcc',1,'admin');
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-08 22:19:11
