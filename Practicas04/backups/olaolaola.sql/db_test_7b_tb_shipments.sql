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
-- Table structure for table `tb_shipments`
--

DROP TABLE IF EXISTS `tb_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_shipments` (
  `id_shipment` int NOT NULL AUTO_INCREMENT,
  `id_buyer_order` int unsigned NOT NULL,
  `id_carrier` int NOT NULL,
  `id_user_adress` bigint unsigned NOT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `shipping_cost` decimal(10,2) DEFAULT '0.00',
  `status` enum('pending','shipped','in_transit','delivered','returned') DEFAULT 'pending',
  `shipped_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_shipment`),
  UNIQUE KEY `tracking_number` (`tracking_number`),
  KEY `id_buyer_order` (`id_buyer_order`),
  KEY `id_carrier` (`id_carrier`),
  KEY `id_user_adress` (`id_user_adress`),
  CONSTRAINT `tb_shipments_ibfk_1` FOREIGN KEY (`id_buyer_order`) REFERENCES `tb_buyer_orders` (`id_buyer_order`),
  CONSTRAINT `tb_shipments_ibfk_2` FOREIGN KEY (`id_carrier`) REFERENCES `tbc_shipping_carriers` (`id_carrier`),
  CONSTRAINT `tb_shipments_ibfk_3` FOREIGN KEY (`id_user_adress`) REFERENCES `tb_user_addresses` (`id_user_adress`)
) ENGINE=InnoDB AUTO_INCREMENT=94022 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_shipments`
--

LOCK TABLES `tb_shipments` WRITE;
/*!40000 ALTER TABLE `tb_shipments` DISABLE KEYS */;
INSERT INTO `tb_shipments` VALUES (9401,9401,9201,9401,'P04-C1-SHIP-0001',150.00,'delivered','2026-11-19 11:09:10','2026-11-19 11:09:10'),(9402,9402,9201,9402,'P04-C2-SHIP-0001',200.00,'delivered','2026-11-19 11:09:10','2026-11-19 11:09:10'),(9403,9403,9201,9403,'P04-C3-SHIP-0001',120.00,'delivered','2026-11-19 11:09:10','2026-11-19 11:09:10'),(9404,9404,9202,9404,'P04-C4-SHIP-0001',99.00,'delivered','2026-11-19 11:09:10','2026-11-19 11:09:10'),(94021,9402,9201,9402,'P04-C2-SHIP-0002-REENVIO',0.00,'delivered','2026-11-19 11:09:10','2026-11-19 11:09:10');
/*!40000 ALTER TABLE `tb_shipments` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_shipments_after_insert` AFTER INSERT ON `tb_shipments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_shipments', 'Create', USER(), CONCAT('Insertado ID: ', NEW.id_shipment), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_shipments_after_update` AFTER UPDATE ON `tb_shipments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_shipments', 'Update', USER(), CONCAT('Actualizado ID: ', NEW.id_shipment), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_shipments_after_delete` AFTER DELETE ON `tb_shipments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_shipments', 'Delete', USER(), CONCAT('Eliminado ID: ', OLD.id_shipment), b'1');
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

-- Dump completed on 2026-11-19 11:44:13
