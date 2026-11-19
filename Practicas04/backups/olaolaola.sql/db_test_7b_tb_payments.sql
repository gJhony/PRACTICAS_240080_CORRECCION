CREATE DATABASE  IF NOT EXISTS `db_test_7b` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_test_7b`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_test_7b
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `tb_payments`
--

DROP TABLE IF EXISTS `tb_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payments` (
  `id_payment` int NOT NULL AUTO_INCREMENT,
  `id_buyer_order` int unsigned NOT NULL,
  `id_user_payment_method` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(10) DEFAULT 'MXN',
  `status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_payment`),
  KEY `id_buyer_order` (`id_buyer_order`),
  KEY `id_user_payment_method` (`id_user_payment_method`),
  CONSTRAINT `tb_payments_ibfk_1` FOREIGN KEY (`id_buyer_order`) REFERENCES `tb_buyer_orders` (`id_buyer_order`),
  CONSTRAINT `tb_payments_ibfk_2` FOREIGN KEY (`id_user_payment_method`) REFERENCES `tbd_user_payment_methods` (`id_user_payment_method`)
) ENGINE=InnoDB AUTO_INCREMENT=940207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_payments`
--

LOCK TABLES `tb_payments` WRITE;
/*!40000 ALTER TABLE `tb_payments` DISABLE KEYS */;
INSERT INTO `tb_payments` VALUES (9401,9401,9401,10103.75,'MXN','completed','2026-11-19 11:09:10'),(9403,9403,9403,17484.23,'MXN','completed','2026-11-19 11:09:10'),(9404,9404,9404,5785.02,'MXN','completed','2026-11-19 11:09:10'),(94031,9403,9403,4549.24,'MXN','refunded','2026-11-19 11:09:10'),(940201,9402,9402,10786.95,'MXN','completed','2026-11-19 11:09:10'),(940202,9402,9402,10786.95,'MXN','completed','2026-11-19 11:09:10'),(940203,9402,9402,10786.95,'MXN','completed','2026-11-19 11:09:10'),(940204,9402,9402,10786.95,'MXN','completed','2026-11-19 11:09:10'),(940205,9402,9402,10786.95,'MXN','completed','2026-11-19 11:09:10'),(940206,9402,9402,10786.92,'MXN','failed',NULL);
/*!40000 ALTER TABLE `tb_payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_payments_after_insert` AFTER INSERT ON `tb_payments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_payments', 'Create', USER(), CONCAT('Insertado ID: ', NEW.id_payment), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_payments_after_update` AFTER UPDATE ON `tb_payments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_payments', 'Update', USER(), CONCAT('Actualizado ID: ', NEW.id_payment), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_payments_after_delete` AFTER DELETE ON `tb_payments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_payments', 'Delete', USER(), CONCAT('Eliminado ID: ', OLD.id_payment), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-19 11:44:15
