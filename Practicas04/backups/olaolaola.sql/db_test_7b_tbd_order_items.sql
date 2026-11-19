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
-- Table structure for table `tbd_order_items`
--

DROP TABLE IF EXISTS `tbd_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_order_items` (
  `id_order_item` int unsigned NOT NULL AUTO_INCREMENT,
  `id_order_seller` int unsigned NOT NULL,
  `id_product` int NOT NULL,
  `id_provider` int NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) GENERATED ALWAYS AS ((`quantity` * `unit_price`)) STORED,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_order_item`),
  KEY `seller_order_ID` (`id_order_seller`),
  KEY `product_ID` (`id_product`),
  KEY `provider_ID` (`id_provider`),
  CONSTRAINT `tbd_order_items_ibfk_1` FOREIGN KEY (`id_order_seller`) REFERENCES `tb_buyer_orders` (`id_buyer_order`),
  CONSTRAINT `tbd_order_items_ibfk_2` FOREIGN KEY (`id_provider`) REFERENCES `tbd_products_users_providers` (`id_product_user_provider`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbd_order_items_ibfk_3` FOREIGN KEY (`id_provider`) REFERENCES `tbd_products_users_providers` (`id_product_user_provider`),
  CONSTRAINT `tbd_order_items_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `tbd_order_items_chk_2` CHECK ((`unit_price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_order_items`
--

LOCK TABLES `tbd_order_items` WRITE;
/*!40000 ALTER TABLE `tbd_order_items` DISABLE KEYS */;
INSERT INTO `tbd_order_items` (`id_order_item`, `id_order_seller`, `id_product`, `id_provider`, `product_name`, `quantity`, `unit_price`, `creation_date`) VALUES (24,9401,1,7,'Boing Mango',2,18.00,'2026-11-19 11:09:10'),(25,9401,2,7,'Coca-Cola Original',1,22.00,'2026-11-19 11:09:10'),(26,9401,3,7,'HyperX Micr??fono Plus',3,1704.07,'2026-11-19 11:09:10'),(27,9401,4,7,'LogiTech Headset Gamer Lite',1,1020.80,'2026-11-19 11:09:10'),(28,9401,5,7,'Apex L??mpara LED Premium',2,1881.37,'2026-11-19 11:09:10'),(29,9402,1,7,'Boing Mango',1,18.00,'2026-11-19 11:09:10'),(30,9402,2,7,'Coca-Cola Original',2,22.00,'2026-11-19 11:09:10'),(31,9402,3,7,'HyperX Micr??fono Plus',3,1704.07,'2026-11-19 11:09:10'),(32,9402,4,7,'LogiTech Headset Gamer Lite',1,1020.80,'2026-11-19 11:09:10'),(33,9402,5,7,'Apex L??mpara LED Premium',4,1881.37,'2026-11-19 11:09:10'),(34,9402,6,7,'Vertex Impresora Ultra',2,4773.31,'2026-11-19 11:09:10'),(35,9402,8,7,'Procesador de 8 nucleos Solara 4.2 GHz modelo 9880',5,4519.90,'2026-11-19 11:09:10'),(36,9402,10,7,'Mini proyector Kukulcan con bateria modelo 2371',3,4716.09,'2026-11-19 11:09:10'),(37,9402,11,7,'Monitor para oficina Andes de 24 pulgadas modelo 1021',1,3734.43,'2026-11-19 11:09:10'),(38,9402,12,7,'Nova Headset Gamer Premium',2,386.18,'2026-11-19 11:09:10'),(39,9403,3,7,'HyperX Micr??fono Plus',2,1704.07,'2026-11-19 11:09:10'),(40,9403,5,7,'Apex L??mpara LED Premium',5,1881.37,'2026-11-19 11:09:10'),(41,9403,13,7,'HyperX L??mpara LED Ultra',1,4549.24,'2026-11-19 11:09:10'),(42,9404,4,7,'LogiTech Headset Gamer Lite',1,1020.80,'2026-11-19 11:09:10'),(43,9404,54,7,'LogiTech Calculadora Premium',2,637.88,'2026-11-19 11:09:10'),(44,9404,79,7,'Maxlink Repetidor WiFi Pro',3,1129.82,'2026-11-19 11:09:10'),(45,9405,329,7,'Maxlink Webcam Max',3,2534.59,'2026-11-19 11:09:10');
/*!40000 ALTER TABLE `tbd_order_items` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_order_items_after_insert` AFTER INSERT ON `tbd_order_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_order_items', 'Create', USER(), 'Item insertado en orden', b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_order_items_after_update` AFTER UPDATE ON `tbd_order_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_order_items', 'Update', USER(), 'Item actualizado en orden', b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tbd_order_items_after_delete` AFTER DELETE ON `tbd_order_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tbd_order_items', 'Delete', USER(), 'Item eliminado de orden', b'1');
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
