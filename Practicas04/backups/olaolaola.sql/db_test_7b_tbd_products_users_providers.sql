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
-- Table structure for table `tbd_products_users_providers`
--

DROP TABLE IF EXISTS `tbd_products_users_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_products_users_providers` (
  `id_product_user_provider` int NOT NULL,
  `id_product` int unsigned NOT NULL,
  `type_ownership` enum('Owner','Reseller','Distributor') DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `avalaible_date` datetime NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_product_user_provider`,`id_product`),
  KEY `fk_products2` (`id_product`),
  CONSTRAINT `fk_prod_user_prov_product` FOREIGN KEY (`id_product`) REFERENCES `tb_products` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user1` FOREIGN KEY (`id_product_user_provider`) REFERENCES `tb_users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_products_users_providers`
--

LOCK TABLES `tbd_products_users_providers` WRITE;
/*!40000 ALTER TABLE `tbd_products_users_providers` DISABLE KEYS */;
INSERT INTO `tbd_products_users_providers` VALUES (7,1,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,2,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,3,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,4,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,5,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,6,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,8,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,10,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,11,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,12,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,13,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,54,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,79,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10'),(7,329,'Owner',_binary '','2026-11-19 11:09:10','2026-11-19 11:09:10','2026-11-19 11:09:10');
/*!40000 ALTER TABLE `tbd_products_users_providers` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_products_users_providers_after_insert` AFTER INSERT ON `tbd_products_users_providers` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_products_users_providers', 'Create', USER(), 'Relación producto-usuario-proveedor creada', b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_products_users_providers_after_update` AFTER UPDATE ON `tbd_products_users_providers` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_products_users_providers', 'Update', USER(), 'Relación producto-usuario-proveedor actualizada', b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_products_users_providers_after_delete` AFTER DELETE ON `tbd_products_users_providers` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_products_users_providers', 'Delete', USER(), 'Relación producto-usuario-proveedor eliminada', b'1');
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

-- Dump completed on 2026-11-19 11:44:14
