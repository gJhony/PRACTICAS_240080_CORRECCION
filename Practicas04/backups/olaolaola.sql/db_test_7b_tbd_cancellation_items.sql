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
-- Table structure for table `tbd_cancellation_items`
--

DROP TABLE IF EXISTS `tbd_cancellation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_cancellation_items` (
  `id_cancellation_item` int NOT NULL AUTO_INCREMENT,
  `id_order_cancellation` int NOT NULL,
  `id_order_item` int unsigned NOT NULL,
  `quantity` int NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cancellation_item`),
  KEY `fk_cancellation_item_cancellation` (`id_order_cancellation`),
  KEY `fk_cancellation_item_order_item` (`id_order_item`),
  CONSTRAINT `fk_cancellation_item_cancellation` FOREIGN KEY (`id_order_cancellation`) REFERENCES `tb_order_cancellations` (`id_order_cancellation`) ON DELETE CASCADE,
  CONSTRAINT `fk_cancellation_item_order_item` FOREIGN KEY (`id_order_item`) REFERENCES `tbd_order_items` (`id_order_item`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9406 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_cancellation_items`
--

LOCK TABLES `tbd_cancellation_items` WRITE;
/*!40000 ALTER TABLE `tbd_cancellation_items` DISABLE KEYS */;
INSERT INTO `tbd_cancellation_items` VALUES (9403,9403,41,1,'P04_CASO3: Producto cancelado del pedido (HyperX L??mpara LED Ultra)',1,'2026-11-19 11:09:10','2026-11-19 11:09:10'),(9405,9405,45,3,'P04_CASO5: Sin stock suficiente para surtir la cantidad solicitada',1,'2026-11-19 11:09:10','2026-11-19 11:09:10');
/*!40000 ALTER TABLE `tbd_cancellation_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jhon.gonzalez`@`%`*/ /*!50003 TRIGGER `trq_tbd_cancellation_items_after_insert` AFTER INSERT ON `tbd_cancellation_items` FOR EACH ROW INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tbd_cancellation_items', 'Create', USER(), CONCAT('Insertado ID: ', NEW.id_cancellation_item), b'1') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jhon.gonzalez`@`%`*/ /*!50003 TRIGGER `trq_tbd_cancellation_items_after_update` AFTER UPDATE ON `tbd_cancellation_items` FOR EACH ROW INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tbd_cancellation_items', 'Update', USER(), CONCAT('Actualizado ID: ', NEW.id_cancellation_item), b'1') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jhon.gonzalez`@`%`*/ /*!50003 TRIGGER `trq_tbd_cancellation_items_after_delete` AFTER DELETE ON `tbd_cancellation_items` FOR EACH ROW INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tbd_cancellation_items', 'Delete', USER(), CONCAT('Eliminado ID: ', OLD.id_cancellation_item), b'1') */;;
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

-- Dump completed on 2026-11-19 11:44:14
