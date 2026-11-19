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
-- Table structure for table `tbd_carts_items`
--

DROP TABLE IF EXISTS `tbd_carts_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_carts_items` (
  `id_cart` int unsigned NOT NULL,
  `id_provider` int NOT NULL,
  `id_product` int NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cart`,`id_provider`,`id_product`),
  KEY `provider_ID` (`id_provider`),
  KEY `product_ID` (`id_product`),
  CONSTRAINT `tbd_carts_items_ibfk_1` FOREIGN KEY (`id_cart`) REFERENCES `tb_carts` (`id_carts`),
  CONSTRAINT `tbd_carts_items_ibfk_2` FOREIGN KEY (`id_provider`) REFERENCES `tbd_products_users_providers` (`id_product_user_provider`),
  CONSTRAINT `chk_cart_quantity` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_carts_items`
--

LOCK TABLES `tbd_carts_items` WRITE;
/*!40000 ALTER TABLE `tbd_carts_items` DISABLE KEYS */;
INSERT INTO `tbd_carts_items` VALUES (9401,7,1,2,'2026-11-19 11:09:10'),(9401,7,2,1,'2026-11-19 11:09:10'),(9401,7,3,3,'2026-11-19 11:09:10'),(9401,7,4,1,'2026-11-19 11:09:10'),(9401,7,5,2,'2026-11-19 11:09:10'),(9402,7,1,1,'2026-11-19 11:09:10'),(9402,7,2,2,'2026-11-19 11:09:10'),(9402,7,3,3,'2026-11-19 11:09:10'),(9402,7,4,1,'2026-11-19 11:09:10'),(9402,7,5,4,'2026-11-19 11:09:10'),(9402,7,6,2,'2026-11-19 11:09:10'),(9402,7,8,5,'2026-11-19 11:09:10'),(9402,7,10,3,'2026-11-19 11:09:10'),(9402,7,11,1,'2026-11-19 11:09:10'),(9402,7,12,2,'2026-11-19 11:09:10'),(9403,7,3,2,'2026-11-19 11:09:10'),(9403,7,5,5,'2026-11-19 11:09:10'),(9403,7,13,1,'2026-11-19 11:09:10'),(9404,7,4,1,'2026-11-19 11:09:10'),(9404,7,54,2,'2026-11-19 11:09:10'),(9404,7,79,3,'2026-11-19 11:09:10'),(9405,7,329,3,'2026-11-19 11:09:10');
/*!40000 ALTER TABLE `tbd_carts_items` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_carts_items_after_insert` AFTER INSERT ON `tbd_carts_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_carts_items', 'Create', USER(), CONCAT('Insertado item en carrito ID: ', NEW.id_cart), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_carts_items_after_update` AFTER UPDATE ON `tbd_carts_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_carts_items', 'Update', USER(), CONCAT('Actualizado item en carrito ID: ', NEW.id_cart), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_carts_items_after_delete` AFTER DELETE ON `tbd_carts_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_carts_items', 'Delete', USER(), CONCAT('Eliminado item de carrito ID: ', OLD.id_cart), b'1');
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
