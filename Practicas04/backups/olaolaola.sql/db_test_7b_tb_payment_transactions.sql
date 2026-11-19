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
-- Table structure for table `tb_payment_transactions`
--

DROP TABLE IF EXISTS `tb_payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payment_transactions` (
  `id_transaction` int NOT NULL AUTO_INCREMENT,
  `id_payment` int NOT NULL,
  `gateway_name` varchar(50) NOT NULL,
  `gateway_transaction_id` varchar(150) NOT NULL,
  `response_code` varchar(50) DEFAULT NULL,
  `raw_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaction`),
  UNIQUE KEY `gateway_transaction_id` (`gateway_transaction_id`),
  KEY `id_payment` (`id_payment`),
  CONSTRAINT `tb_payment_transactions_ibfk_1` FOREIGN KEY (`id_payment`) REFERENCES `tb_payments` (`id_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=940207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_payment_transactions`
--

LOCK TABLES `tb_payment_transactions` WRITE;
/*!40000 ALTER TABLE `tb_payment_transactions` DISABLE KEYS */;
INSERT INTO `tb_payment_transactions` VALUES (9401,9401,'BancoSim','P04-C1-TX-0001','AUTHORIZED','{\"result\": \"AUTHORIZED\", \"message\": \"Pago ??nico aprobado\", \"card_last4\": \"1111\"}','2026-11-19 17:09:10'),(9403,9403,'SpinGateway','P04-C3-TX-0001','AUTHORIZED','{\"method\": \"Spin\", \"result\": \"AUTHORIZED\", \"card_last4\": \"3333\"}','2026-11-19 17:09:10'),(9404,9404,'SPEI','P04-C4-TX-0001','AUTHORIZED','{\"method\": \"SPEI\", \"result\": \"AUTHORIZED\", \"reference\": \"0123456789012345\"}','2026-11-19 17:09:10'),(94031,94031,'SpinGateway','P04-C3-TX-0002-REFUND','REFUNDED','{\"type\": \"partial_refund\", \"amount\": 4549.24, \"reason\": \"P04_CASO3 cancelaci??n parcial\", \"result\": \"REFUNDED\"}','2026-11-19 17:09:10'),(940201,940201,'BancoSim','P04-C2-TX-0001','AUTHORIZED','{\"result\": \"AUTHORIZED\", \"card_last4\": \"2222\", \"installment\": 1}','2026-11-19 17:09:10'),(940202,940202,'BancoSim','P04-C2-TX-0002','AUTHORIZED','{\"result\": \"AUTHORIZED\", \"card_last4\": \"2222\", \"installment\": 2}','2026-11-19 17:09:10'),(940203,940203,'BancoSim','P04-C2-TX-0003','AUTHORIZED','{\"result\": \"AUTHORIZED\", \"card_last4\": \"2222\", \"installment\": 3}','2026-11-19 17:09:10'),(940204,940204,'BancoSim','P04-C2-TX-0004','AUTHORIZED','{\"result\": \"AUTHORIZED\", \"card_last4\": \"2222\", \"installment\": 4}','2026-11-19 17:09:10'),(940205,940205,'BancoSim','P04-C2-TX-0005','AUTHORIZED','{\"result\": \"AUTHORIZED\", \"card_last4\": \"2222\", \"installment\": 5}','2026-11-19 17:09:10'),(940206,940206,'BancoSim','P04-C2-TX-0006','DECLINED_LIMIT_EXCEEDED','{\"reason\": \"l??mite excedido de cr??dito\", \"result\": \"REJECTED\", \"card_last4\": \"2222\", \"installment\": 6}','2026-11-19 17:09:10');
/*!40000 ALTER TABLE `tb_payment_transactions` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_payment_transactions_after_insert` AFTER INSERT ON `tb_payment_transactions` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_payment_transactions', 'Create', USER(), CONCAT('Insertado ID: ', NEW.id_transaction), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_payment_transactions_after_update` AFTER UPDATE ON `tb_payment_transactions` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_payment_transactions', 'Update', USER(), CONCAT('Actualizado ID: ', NEW.id_transaction), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_payment_transactions_after_delete` AFTER DELETE ON `tb_payment_transactions` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_payment_transactions', 'Delete', USER(), CONCAT('Eliminado ID: ', OLD.id_transaction), b'1');
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
