-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: animeweb
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_roles`
--

DROP TABLE IF EXISTS `account_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_roles` (
  `idUser` int DEFAULT NULL,
  `idrole` int DEFAULT NULL,
  KEY `accroleidUser` (`idUser`),
  KEY `accroleid` (`idrole`),
  CONSTRAINT `accroleid` FOREIGN KEY (`idrole`) REFERENCES `roles` (`idrole`),
  CONSTRAINT `accroleidUser` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_roles`
--

LOCK TABLES `account_roles` WRITE;
/*!40000 ALTER TABLE `account_roles` DISABLE KEYS */;
INSERT INTO `account_roles` VALUES (1,4),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(14,2);
/*!40000 ALTER TABLE `account_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_types`
--

DROP TABLE IF EXISTS `account_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_types` (
  `typeId` int NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_types`
--

LOCK TABLES `account_types` WRITE;
/*!40000 ALTER TABLE `account_types` DISABLE KEYS */;
INSERT INTO `account_types` VALUES (1,'base User'),(2,'google User'),(3,'facebook User'),(4,'quản lý');
/*!40000 ALTER TABLE `account_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(240) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Password` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avatar` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `typeId` int DEFAULT NULL,
  `isActive` int DEFAULT NULL,
  `joinDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `FullName` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `PhoneNumber` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  KEY `acctype` (`typeId`),
  CONSTRAINT `acctype` FOREIGN KEY (`typeId`) REFERENCES `account_types` (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'admin','ZvniDNSIriVuH6j9pEQZHQey9e4=','maganeckji@gmail.com','/anime-main/storage/avatarUser/defaultavatar.jpg',1,1,'2023-03-01 11:09:11',NULL,NULL),(2,'20130305','w0XhvSyORlI2Y0t4WS2uGK8m7oA=','20130305@st.hcmuaf.edu.vn','/anime-main/storage/avatarUser/defaultavatar.jpg',2,1,'2023-03-01 11:09:11',NULL,NULL),(3,'yaemiko27092002','5ZPmVKY7bSZQUbtKgxxjMxgEfZo=','yaemiko27092002@gmail.com','/anime-main/storage/avatarUser/defaultavatar.jpg',2,1,'2023-03-01 11:09:11',NULL,NULL),(4,'maganeckji','s1vnwLwzlss2HgVikMjM6wjtL9Y=','maganeckji@gmail.com','/anime-main/storage/avatarUser/defaultavatar.jpg',2,1,'2023-03-01 11:09:11',NULL,NULL),(5,'Phúc An Nguyễn Nhật','x4cwHr6w7Ql0KImOVkw2Vl5isYY=','goblinslayer27092002@gmail.com','/anime-main/storage/avatarUser/defaultavatar.jpg',2,1,'2023-03-01 11:09:11',NULL,NULL),(6,'longga123','bNMMUOKxEWb0uSpsT8YvA/+fPj8=','leminhlongit@gmail.com','/anime-main/storage/avatarUser/defaultavatar.jpg',1,1,'2023-03-01 11:09:11',NULL,NULL),(7,'locga123','bNMMUOKxEWb0uSpsT8YvA/+fPj8=','loclaambroae123@gmail.com',NULL,1,0,'2023-03-01 11:09:11',NULL,NULL),(8,'haoga123','bNMMUOKxEWb0uSpsT8YvA/+fPj8=','ngokinh169@gmail.com',NULL,1,1,'2023-03-01 11:09:11',NULL,NULL),(9,'concac1234','bNMMUOKxEWb0uSpsT8YvA/+fPj8=','sieunhancuongphongdo1@gmail.com',NULL,1,1,'2023-03-01 11:09:11',NULL,NULL),(10,'ditconme123','bNMMUOKxEWb0uSpsT8YvA/+fPj8=','locdaula123@gmail.com',NULL,1,1,'2023-03-01 11:09:11',NULL,NULL),(11,'ocococ123456','s3uykSWz3ziOYtNWDDQyz+yTmR4=','20130309@st.hcmuaf.edu.vn',NULL,1,1,'2023-03-01 11:09:11',NULL,NULL),(12,'linhchauhoa0404','s3uykSWz3ziOYtNWDDQyz+yTmR4=','linhchauhoa0404@gmail.com',NULL,1,1,'2023-03-01 11:09:11',NULL,NULL),(13,'linhchauhoa113','s3uykSWz3ziOYtNWDDQyz+yTmR4=','20130305@st.hcmuaf.edu.vn','/anime-main/storage/avatarUser/defaultavatar.jpg',1,1,'2023-03-01 11:09:11',NULL,NULL),(14,'nguyennhatlinh123','s3uykSWz3ziOYtNWDDQyz+yTmR4=','goblinslayer27092002@gmail.com','/anime-main/storage/avatarUser/defaultavatar.jpg',1,1,'2023-03-01 11:25:05','Nguyễn Nhật Linh','0974321561');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_facebook`
--

DROP TABLE IF EXISTS `accounts_facebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_facebook` (
  `idFacebook` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Username` varchar(240) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `idUser` int DEFAULT NULL,
  `Email` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idFacebook`),
  KEY `FK__blogComme__UserN__44FF419As` (`idUser`),
  CONSTRAINT `FK__blogComme__UserN__44FF419As` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_facebook`
--

LOCK TABLES `accounts_facebook` WRITE;
/*!40000 ALTER TABLE `accounts_facebook` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_facebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_google`
--

DROP TABLE IF EXISTS `accounts_google`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_google` (
  `idGoogle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Username` varchar(240) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `idUser` int DEFAULT NULL,
  `Email` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idGoogle`),
  KEY `FK__blogComme__UserN__44FF419Asa` (`idUser`),
  CONSTRAINT `FK__blogComme__UserN__44FF419Asa` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_google`
--

LOCK TABLES `accounts_google` WRITE;
/*!40000 ALTER TABLE `accounts_google` DISABLE KEYS */;
INSERT INTO `accounts_google` VALUES ('102171743969144076968','Phúc An Nguyễn Nhật',5,'goblinslayer27092002@gmail.com'),('107409601924003064725','20130305',2,'20130305@st.hcmuaf.edu.vn'),('113222806438638623277','maganeckji',4,'maganeckji@gmail.com'),('115321105266146591150','yaemiko27092002',3,'yaemiko27092002@gmail.com');
/*!40000 ALTER TABLE `accounts_google` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avts_movie`
--

DROP TABLE IF EXISTS `avts_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avts_movie` (
  `idavt` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`idavt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avts_movie`
--

LOCK TABLES `avts_movie` WRITE;
/*!40000 ALTER TABLE `avts_movie` DISABLE KEYS */;
/*!40000 ALTER TABLE `avts_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_comments`
--

DROP TABLE IF EXISTS `blog_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_comments` (
  `idBlog` int DEFAULT NULL,
  `idCmt` int NOT NULL AUTO_INCREMENT,
  `mess` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `idUser` int DEFAULT NULL,
  `dateCmt` datetime DEFAULT CURRENT_TIMESTAMP,
  `isActive` int NOT NULL,
  PRIMARY KEY (`idCmt`),
  KEY `FK__blogComme__idBlo__440B1D61` (`idBlog`),
  KEY `FK__blogComme__UserN__44FF419A` (`idUser`),
  CONSTRAINT `FK__blogComme__idBlo__440B1D61` FOREIGN KEY (`idBlog`) REFERENCES `blogs` (`idBlog`),
  CONSTRAINT `FK__blogComme__UserN__44FF419A` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_comments`
--

LOCK TABLES `blog_comments` WRITE;
/*!40000 ALTER TABLE `blog_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `idBlog` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `folder` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `datePost` datetime DEFAULT CURRENT_TIMESTAMP,
  `avt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dayDebut` datetime DEFAULT NULL,
  `isActive` int DEFAULT NULL,
  PRIMARY KEY (`idBlog`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chapters_movie`
--

DROP TABLE IF EXISTS `chapters_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapters_movie` (
  `idMovie` int NOT NULL,
  `stt` int NOT NULL,
  `opening` int DEFAULT NULL,
  PRIMARY KEY (`idMovie`,`stt`),
  CONSTRAINT `chaptervsmovie` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapters_movie`
--

LOCK TABLES `chapters_movie` WRITE;
/*!40000 ALTER TABLE `chapters_movie` DISABLE KEYS */;
/*!40000 ALTER TABLE `chapters_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `idUser` int DEFAULT NULL,
  `idMovie` int DEFAULT NULL,
  `timefollow` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `FK__follow__UserName__49C3F6B7` (`idUser`),
  CONSTRAINT `FK__follow__UserName__49C3F6B7` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `idGenre` int NOT NULL AUTO_INCREMENT,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`idGenre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `idLog` int NOT NULL AUTO_INCREMENT,
  `level` int DEFAULT NULL,
  `user` int DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `src` varchar(100) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`idLog`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (5,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-24 15:22:42',0),(6,0,1,'10.51.77.200','LoginServlet','Login sucess','2023-02-24 15:23:31',0),(7,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-25 14:59:39',0),(8,0,2,'0:0:0:0:0:0:0:1','Login Google','Login with Google Success','2023-02-25 14:59:48',0),(9,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet',NULL,'2023-02-25 18:25:48',0),(10,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet','Đăng kí thành công','2023-02-25 18:28:37',0),(11,1,8,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:28:47',0),(12,1,8,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:29:22',0),(13,1,8,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:29:25',0),(14,1,6,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:29:37',0),(15,1,8,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:30:39',0),(16,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet','Đăng kí thành công','2023-02-25 18:33:12',0),(17,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:33:49',0),(18,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:34:26',0),(19,1,9,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:35:05',0),(20,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet','Đăng kí thành công','2023-02-25 18:36:21',0),(21,1,10,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:36:41',0),(22,1,10,'0:0:0:0:0:0:0:1','LoginServlet','login fail','2023-02-25 18:36:58',0),(23,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-25 18:37:23',0),(24,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet','Đăng kí thành công','2023-02-25 18:39:44',0),(25,0,11,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-25 18:39:55',0),(26,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet','Đăng kí thành công','2023-02-25 19:36:39',0),(27,0,12,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-25 19:36:46',0),(28,0,12,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-25 19:41:46',0),(29,0,3,'0:0:0:0:0:0:0:1','Login Google','Login with Google Success','2023-02-28 13:57:53',0),(30,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet','Đăng kí thành công','2023-02-28 14:16:06',0),(31,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet',NULL,'2023-02-28 14:16:47',0),(32,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:17:00',0),(33,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:17:46',0),(34,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:18:58',0),(35,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:19:47',0),(36,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:20:38',0),(37,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','error captcha','2023-02-28 14:20:43',0),(38,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:22:04',0),(39,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:23:47',0),(40,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:31:53',0),(41,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:33:32',0),(42,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:34:56',0),(43,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:36:44',0),(44,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:38:26',0),(45,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:40:54',0),(46,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:41:33',0),(47,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','error captcha','2023-02-28 14:42:12',0),(48,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:42:53',0),(49,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','error captcha','2023-02-28 14:42:56',0),(50,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:43:54',0),(51,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','error captcha','2023-02-28 14:43:58',0),(52,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 14:50:57',0),(53,0,13,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 15:04:10',0),(54,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 15:04:27',0),(55,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 15:47:48',0),(56,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','error captcha','2023-02-28 16:38:06',0),(57,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 17:01:21',0),(58,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 17:02:38',0),(59,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 17:07:43',0),(60,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 17:25:47',0),(61,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','error captcha','2023-02-28 17:25:50',0),(62,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 17:27:50',0),(63,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-02-28 17:30:02',0),(64,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:15:09',0),(65,0,2,'0:0:0:0:0:0:0:1','Login Google','Login with Google Success','2023-03-01 10:15:29',0),(66,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:16:46',0),(67,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:22:58',0),(68,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:28:00',0),(69,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:31:45',0),(70,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:39:26',0),(71,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:42:23',0),(72,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:44:11',0),(73,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:45:48',0),(74,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:46:32',0),(75,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:47:19',0),(76,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:52:08',0),(77,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:54:42',0),(78,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 10:56:09',0),(79,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 11:00:33',0),(80,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 11:02:06',0),(81,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-01 11:05:31',0),(82,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet',NULL,'2023-03-01 11:23:36',0),(83,0,-1,'0:0:0:0:0:0:0:1','RegisterServlet','Đăng kí thành công','2023-03-01 11:25:05',0),(84,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 09:54:59',0),(85,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 10:35:24',0),(86,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 13:23:01',0),(87,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 14:21:19',0),(88,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 14:24:19',0),(89,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 14:25:57',0),(90,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 15:05:57',0),(91,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 15:09:40',0),(92,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 15:16:58',0),(93,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 16:41:49',0),(94,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 21:49:44',0),(95,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 21:54:22',0),(96,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 21:57:33',0),(97,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 21:59:57',0),(98,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 22:02:39',0),(99,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 22:07:22',0),(100,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 22:07:35',0),(101,1,-1,'0:0:0:0:0:0:0:1','LoginServlet','error captcha','2023-03-02 22:07:37',0),(102,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 22:08:32',0),(103,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 22:09:03',0),(104,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 22:09:22',0),(105,0,1,'0:0:0:0:0:0:0:1','LoginServlet','Login sucess','2023-03-02 22:12:34',0);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_avts`
--

DROP TABLE IF EXISTS `movie_avts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_avts` (
  `idMovie` int DEFAULT NULL,
  `idavt` int DEFAULT NULL,
  KEY `movieavtid` (`idMovie`),
  KEY `idavtmovie` (`idavt`),
  CONSTRAINT `idavtmovie` FOREIGN KEY (`idavt`) REFERENCES `avts_movie` (`idavt`),
  CONSTRAINT `movieavtid` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_avts`
--

LOCK TABLES `movie_avts` WRITE;
/*!40000 ALTER TABLE `movie_avts` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_avts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_comments`
--

DROP TABLE IF EXISTS `movie_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_comments` (
  `idComment` int NOT NULL AUTO_INCREMENT,
  `idUser` int DEFAULT NULL,
  `mess` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `idMovie` int DEFAULT NULL,
  `timecomment` datetime DEFAULT CURRENT_TIMESTAMP,
  `isActive` int NOT NULL,
  PRIMARY KEY (`idComment`),
  KEY `FK__comment__idMovie__46E78A0C` (`idMovie`),
  KEY `FK__comment__UserNam__47DBAE45` (`idUser`),
  CONSTRAINT `FK__comment__idMovie__46E78A0C` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`),
  CONSTRAINT `FK__comment__UserNam__47DBAE45` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_comments`
--

LOCK TABLES `movie_comments` WRITE;
/*!40000 ALTER TABLE `movie_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_genres` (
  `idMovie` int DEFAULT NULL,
  `idGenre` int DEFAULT NULL,
  KEY `movieid` (`idMovie`),
  KEY `idgenre` (`idGenre`),
  CONSTRAINT `idgenre` FOREIGN KEY (`idGenre`) REFERENCES `genres` (`idGenre`),
  CONSTRAINT `movieid` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genres`
--

LOCK TABLES `movie_genres` WRITE;
/*!40000 ALTER TABLE `movie_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_producers`
--

DROP TABLE IF EXISTS `movie_producers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_producers` (
  `idMovie` int DEFAULT NULL,
  `idproducer` int DEFAULT NULL,
  KEY `movieproducerid` (`idMovie`),
  KEY `movieproduceridpro` (`idproducer`),
  CONSTRAINT `movieproducerid` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`),
  CONSTRAINT `movieproduceridpro` FOREIGN KEY (`idproducer`) REFERENCES `producers` (`idproducer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_producers`
--

LOCK TABLES `movie_producers` WRITE;
/*!40000 ALTER TABLE `movie_producers` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_producers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `idMovie` int NOT NULL AUTO_INCREMENT,
  `nameMovie` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `currentEpisode` int DEFAULT NULL,
  `totalEpisode` int DEFAULT NULL,
  `descriptionVN` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `descriptionEN` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `dayadd` datetime DEFAULT CURRENT_TIMESTAMP,
  `isActive` int NOT NULL,
  `moviescol` varchar(45) DEFAULT NULL,
  `typeID` int DEFAULT NULL,
  PRIMARY KEY (`idMovie`),
  KEY `typeMovieforeign_idx` (`typeID`),
  CONSTRAINT `typeMovieforeign` FOREIGN KEY (`typeID`) REFERENCES `types_movie` (`typeID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies_price`
--

DROP TABLE IF EXISTS `movies_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies_price` (
  `idMovie` int NOT NULL,
  `idproducer` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  KEY `idmovieForegin_idx` (`idMovie`),
  KEY `idproducerForegin_idx` (`idproducer`),
  CONSTRAINT `idmovieForegin` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`),
  CONSTRAINT `idproducerForegin` FOREIGN KEY (`idproducer`) REFERENCES `producers` (`idproducer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies_price`
--

LOCK TABLES `movies_price` WRITE;
/*!40000 ALTER TABLE `movies_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `movies_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies_purchased`
--

DROP TABLE IF EXISTS `movies_purchased`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies_purchased` (
  `idUser` int NOT NULL,
  `idMovie` int NOT NULL,
  `purchase_date` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `idUserForeign_idx` (`idUser`),
  KEY `idMoviesForeignkey_idx` (`idMovie`),
  CONSTRAINT `idMoviesForeignkey` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`),
  CONSTRAINT `idUserForeign` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies_purchased`
--

LOCK TABLES `movies_purchased` WRITE;
/*!40000 ALTER TABLE `movies_purchased` DISABLE KEYS */;
/*!40000 ALTER TABLE `movies_purchased` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producers`
--

DROP TABLE IF EXISTS `producers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producers` (
  `idproducer` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` longtext,
  PRIMARY KEY (`idproducer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producers`
--

LOCK TABLES `producers` WRITE;
/*!40000 ALTER TABLE `producers` DISABLE KEYS */;
/*!40000 ALTER TABLE `producers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates_movie`
--

DROP TABLE IF EXISTS `rates_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rates_movie` (
  `idMovie` int DEFAULT NULL,
  `idUser` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `timevote` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `FK__rate__idMovie__4AB81AF0` (`idMovie`),
  KEY `FK__rate__UserName__4BAC3F29` (`idUser`),
  CONSTRAINT `FK__rate__idMovie__4AB81AF0` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`),
  CONSTRAINT `FK__rate__UserName__4BAC3F29` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates_movie`
--

LOCK TABLES `rates_movie` WRITE;
/*!40000 ALTER TABLE `rates_movie` DISABLE KEYS */;
/*!40000 ALTER TABLE `rates_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recharge_code`
--

DROP TABLE IF EXISTS `recharge_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recharge_code` (
  `idcode` int NOT NULL AUTO_INCREMENT,
  `code` longtext,
  `price` double DEFAULT NULL,
  `used` int DEFAULT NULL,
  PRIMARY KEY (`idcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recharge_code`
--

LOCK TABLES `recharge_code` WRITE;
/*!40000 ALTER TABLE `recharge_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `recharge_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply_comments_blog`
--

DROP TABLE IF EXISTS `reply_comments_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reply_comments_blog` (
  `idBlog` int DEFAULT NULL,
  `idCmt` int DEFAULT NULL,
  `idUserCmt` int DEFAULT NULL,
  `idUserReply` int DEFAULT NULL,
  `mess` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `daycmt` datetime DEFAULT CURRENT_TIMESTAMP,
  `sttCmt` int NOT NULL AUTO_INCREMENT,
  `isActive` int NOT NULL,
  PRIMARY KEY (`sttCmt`),
  KEY `FK__replyComm__idBlo__4CA06362` (`idBlog`),
  KEY `FK__replyComm__idCmt__6383C8BA` (`idCmt`),
  KEY `FK__replyComm__UserN__6477ECF3` (`idUserCmt`),
  KEY `FK__replyComm__UserN__656C112C` (`idUserReply`),
  CONSTRAINT `FK__replyComm__idBlo__4CA06362` FOREIGN KEY (`idBlog`) REFERENCES `blogs` (`idBlog`),
  CONSTRAINT `FK__replyComm__idCmt__4D94879B` FOREIGN KEY (`idCmt`) REFERENCES `blog_comments` (`idCmt`),
  CONSTRAINT `FK__replyComm__idCmt__6383C8BA` FOREIGN KEY (`idCmt`) REFERENCES `blog_comments` (`idCmt`),
  CONSTRAINT `FK__replyComm__UserN__4E88ABD4` FOREIGN KEY (`idUserCmt`) REFERENCES `accounts` (`idUser`),
  CONSTRAINT `FK__replyComm__UserN__4F7CD00D` FOREIGN KEY (`idUserReply`) REFERENCES `accounts` (`idUser`),
  CONSTRAINT `FK__replyComm__UserN__6477ECF3` FOREIGN KEY (`idUserCmt`) REFERENCES `accounts` (`idUser`),
  CONSTRAINT `FK__replyComm__UserN__656C112C` FOREIGN KEY (`idUserReply`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply_comments_blog`
--

LOCK TABLES `reply_comments_blog` WRITE;
/*!40000 ALTER TABLE `reply_comments_blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `reply_comments_blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply_comments_movie`
--

DROP TABLE IF EXISTS `reply_comments_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reply_comments_movie` (
  `idMovie` int DEFAULT NULL,
  `idComment` int DEFAULT NULL,
  `idUserCmt` int DEFAULT NULL,
  `idUserReply` int DEFAULT NULL,
  `mess` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `daycmt` datetime DEFAULT CURRENT_TIMESTAMP,
  `sttCmt` int NOT NULL AUTO_INCREMENT,
  `isActive` int NOT NULL,
  PRIMARY KEY (`sttCmt`),
  KEY `FK__replyComm__idBlo__4CA063621` (`idMovie`),
  KEY `FK__replyComm__idCmt__6383C8BA1` (`idComment`),
  KEY `FK__replyComm__UserN__6477ECF31` (`idUserCmt`),
  KEY `FK__replyComm__UserN__656C112C1` (`idUserReply`),
  CONSTRAINT `FK__replyComm__idBlo__4CA063621` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`),
  CONSTRAINT `FK__replyComm__idCmt__4D94879B1` FOREIGN KEY (`idComment`) REFERENCES `movie_comments` (`idComment`),
  CONSTRAINT `FK__replyComm__idCmt__6383C8BA1` FOREIGN KEY (`idComment`) REFERENCES `movie_comments` (`idComment`),
  CONSTRAINT `FK__replyComm__UserN__4E88ABD41` FOREIGN KEY (`idUserCmt`) REFERENCES `accounts` (`idUser`),
  CONSTRAINT `FK__replyComm__UserN__4F7CD00D1` FOREIGN KEY (`idUserReply`) REFERENCES `accounts` (`idUser`),
  CONSTRAINT `FK__replyComm__UserN__6477ECF31` FOREIGN KEY (`idUserCmt`) REFERENCES `accounts` (`idUser`),
  CONSTRAINT `FK__replyComm__UserN__656C112C1` FOREIGN KEY (`idUserReply`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply_comments_movie`
--

LOCK TABLES `reply_comments_movie` WRITE;
/*!40000 ALTER TABLE `reply_comments_movie` DISABLE KEYS */;
/*!40000 ALTER TABLE `reply_comments_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests_recharge_code`
--

DROP TABLE IF EXISTS `requests_recharge_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests_recharge_code` (
  `id_requests` int NOT NULL AUTO_INCREMENT,
  `idUser` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id_requests`),
  KEY `userNamerequest_idx` (`idUser`),
  CONSTRAINT `userNamerequest` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests_recharge_code`
--

LOCK TABLES `requests_recharge_code` WRITE;
/*!40000 ALTER TABLE `requests_recharge_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `requests_recharge_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `idrole` int NOT NULL AUTO_INCREMENT,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`idrole`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'base User'),(2,'insert'),(4,'admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types_movie`
--

DROP TABLE IF EXISTS `types_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types_movie` (
  `typeID` int NOT NULL AUTO_INCREMENT,
  `description` tinytext,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types_movie`
--

LOCK TABLES `types_movie` WRITE;
/*!40000 ALTER TABLE `types_movie` DISABLE KEYS */;
/*!40000 ALTER TABLE `types_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_views`
--

DROP TABLE IF EXISTS `user_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_views` (
  `idUser` int DEFAULT NULL,
  `idMovie` int DEFAULT NULL,
  `timewatch` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `userviewidmovie` (`idMovie`),
  KEY `userviewUserName` (`idUser`),
  CONSTRAINT `userviewidmovie` FOREIGN KEY (`idMovie`) REFERENCES `movies` (`idMovie`),
  CONSTRAINT `userviewUserName` FOREIGN KEY (`idUser`) REFERENCES `accounts` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_views`
--

LOCK TABLES `user_views` WRITE;
/*!40000 ALTER TABLE `user_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_views` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-02 22:16:34
