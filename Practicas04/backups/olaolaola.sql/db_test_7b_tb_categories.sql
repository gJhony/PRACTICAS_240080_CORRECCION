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
-- Table structure for table `tb_categories`
--

DROP TABLE IF EXISTS `tb_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_categories` (
  `id_category` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `description` text,
  `sup_id_category` int unsigned DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_category`),
  UNIQUE KEY `name` (`name`),
  KEY `fk_superior_category` (`sup_id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_categories`
--

LOCK TABLES `tb_categories` WRITE;
/*!40000 ALTER TABLE `tb_categories` DISABLE KEYS */;
INSERT INTO `tb_categories` VALUES (1,'Electrónica','Productos electrónicos y gadgets',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(2,'Ropa y Accesorios','Prendas de vestir y complementos',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(3,'Hogar y Jardín','Artículos para el hogar y jardinería',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(4,'Deportes y Aire Libre','Equipamiento deportivo y actividades al aire libre',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(5,'Belleza y Cuidado Personal','Productos de belleza y cuidado personal',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(6,'Alimentos y Bebidas','Comestibles y bebidas',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(7,'Juguetes y Juegos','Juguetes, juegos y entretenimiento infantil',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(8,'Libros y Medios','Libros, música, películas y medios digitales',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(9,'Automoción','Repuestos y accesorios para vehículos',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(10,'Salud y Bienestar','Productos de salud y bienestar',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(11,'Oficina y Papelería','Material de oficina y papelería',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(12,'Mascotas','Productos para mascotas',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(13,'Bebés y Niños','Artículos para bebés y niños pequeños',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(14,'Herramientas y Bricolaje','Herramientas y materiales de bricolaje',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(15,'Viajes y Equipaje','Artículos de viaje y maletas',NULL,_binary '','2024-01-15 00:00:00','2024-06-20 00:00:00'),(16,'Smartphones','Teléfonos inteligentes y accesorios',1,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(17,'Ordenadores Portátiles','Laptops y notebooks',1,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(18,'Tablets','Tabletas y e-readers',1,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(19,'Auriculares y Audio','Auriculares, altavoces y equipos de audio',1,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(20,'Cámaras','Cámaras fotográficas y de video',1,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(21,'Televisores','Smart TVs y monitores',1,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(22,'Consolas de Videojuegos','Consolas y accesorios gaming',1,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(23,'Wearables','Relojes inteligentes y pulseras de actividad',1,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(24,'Componentes PC','Hardware y componentes para ordenadores',1,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(25,'Redes y Conectividad','Routers, switches y accesorios de red',1,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(26,'Ropa de Hombre','Prendas masculinas',2,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(27,'Ropa de Mujer','Prendas femeninas',2,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(28,'Ropa Infantil','Ropa para niños y niñas',2,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(29,'Calzado','Zapatos, zapatillas y botas',2,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(30,'Bolsos y Carteras','Bolsos, mochilas y carteras',2,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(31,'Joyería','Joyas y bisutería',2,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(32,'Relojes','Relojes de pulsera',2,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(33,'Gafas de Sol','Gafas de sol y ópticas',2,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(34,'Accesorios de Moda','Cinturones, bufandas y complementos',2,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(35,'Ropa Deportiva','Prendas técnicas para deporte',2,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(36,'Muebles','Muebles para el hogar',3,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(37,'Decoración','Artículos decorativos',3,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(38,'Cocina','Utensilios y electrodomésticos de cocina',3,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(39,'Baño','Artículos para el baño',3,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(40,'Jardinería','Herramientas y plantas de jardín',3,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(41,'Iluminación','Lámparas y sistemas de iluminación',3,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(42,'Textiles del Hogar','Ropa de cama, cortinas y toallas',3,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(43,'Almacenamiento','Cajas, estanterías y organizadores',3,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(44,'Limpieza','Productos de limpieza del hogar',3,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(45,'Exterior','Muebles y accesorios de exterior',3,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(46,'Fitness','Equipamiento de gimnasio y fitness',4,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(47,'Ciclismo','Bicicletas y accesorios',4,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(48,'Running','Zapatillas y ropa de running',4,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(49,'Camping','Material de camping y senderismo',4,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(50,'Natación','Artículos de natación y playa',4,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(51,'Fútbol','Balones, botas y equipación de fútbol',4,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(52,'Baloncesto','Material de baloncesto',4,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(53,'Tenis y Pádel','Raquetas y accesorios de raqueta',4,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(54,'Esquí y Snowboard','Equipamiento de deportes de invierno',4,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(55,'Pesca','Cañas, carretes y artículos de pesca',4,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(56,'Maquillaje','Productos de maquillaje',5,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(57,'Cuidado de la Piel','Cremas, sérums y tratamientos faciales',5,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(58,'Cuidado del Cabello','Champús, acondicionadores y tratamientos',5,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(59,'Perfumes','Fragancias para hombre y mujer',5,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(60,'Cuidado Corporal','Cremas corporales y exfoliantes',5,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(61,'Higiene Oral','Cepillos, pastas y enjuagues',5,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(62,'Afeitado','Máquinas y productos de afeitado',5,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(63,'Manicura y Pedicura','Esmaltes y cuidados de uñas',5,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(64,'Cuidado Masculino','Productos específicos para hombres',5,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(65,'Cosmética Natural','Productos ecológicos y naturales',5,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(66,'Supermercado','Productos de alimentación básica',6,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(67,'Bebidas','Refrescos, zumos y aguas',6,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(68,'Café y Té','Café, té e infusiones',6,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(69,'Snacks','Aperitivos y snacks',6,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(70,'Productos Ecológicos','Alimentos orgánicos y ecológicos',6,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(71,'Gourmet','Productos gourmet y delicatessen',6,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(72,'Vinos y Licores','Vinos, cervezas y destilados',6,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(73,'Congelados','Alimentos congelados',6,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(74,'Repostería','Ingredientes y productos de repostería',6,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(75,'Dietética','Productos dietéticos y suplementos alimenticios',6,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(76,'Juguetes Educativos','Juguetes para el aprendizaje',7,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(77,'Muñecas y Figuras','Muñecas, action figures y coleccionables',7,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(78,'Juegos de Mesa','Juegos de mesa y de cartas',7,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(79,'Construcción','Bloques y sets de construcción',7,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(80,'Vehículos de Juguete','Coches, trenes y aviones de juguete',7,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(81,'Peluches','Ositos y peluches',7,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(82,'Juegos Electrónicos','Juguetes electrónicos e interactivos',7,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(83,'Puzzles','Rompecabezas y puzzles',7,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(84,'Juegos de Exterior','Juguetes para el aire libre',7,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(85,'Manualidades Infantiles','Kits de manualidades para niños',7,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(86,'Libros de Ficción','Novelas y literatura de ficción',8,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(87,'Libros No Ficción','Ensayos, biografías y no ficción',8,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(88,'Libros Infantiles','Cuentos y libros para niños',8,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(89,'Cómics y Manga','Cómics, novelas gráficas y manga',8,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(90,'Música','CDs, vinilos y música digital',8,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00'),(91,'Películas y Series','DVDs, Blu-ray y streaming',8,_binary '','2024-02-16 00:00:00','2024-03-17 00:00:00'),(92,'Videojuegos','Juegos para consolas y PC',8,_binary '','2024-02-19 00:00:00','2024-03-20 00:00:00'),(93,'Revistas','Revistas y publicaciones periódicas',8,_binary '','2024-02-22 00:00:00','2024-03-23 00:00:00'),(94,'Audiolibros','Libros en formato audio',8,_binary '','2024-02-25 00:00:00','2024-03-26 00:00:00'),(95,'E-books','Libros electrónicos',8,_binary '','2024-02-28 00:00:00','2024-03-29 00:00:00'),(96,'Repuestos de Motor','Piezas del motor y mecánica',9,_binary '','2024-02-01 00:00:00','2024-03-02 00:00:00'),(97,'Neumáticos','Neumáticos y llantas',9,_binary '','2024-02-04 00:00:00','2024-03-05 00:00:00'),(98,'Accesorios Interiores','Fundas, alfombrillas y accesorios interiores',9,_binary '','2024-02-07 00:00:00','2024-03-08 00:00:00'),(99,'Accesorios Exteriores','Spoilers, faros y exteriores',9,_binary '','2024-02-10 00:00:00','2024-03-11 00:00:00'),(100,'Electrónica del Coche','Radios, GPS y sistemas multimedia',9,_binary '','2024-02-13 00:00:00','2024-03-14 00:00:00');
/*!40000 ALTER TABLE `tb_categories` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_categories_after_insert` AFTER INSERT ON `tb_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_categories', 'Create', USER(), CONCAT('Insertado ID: ', NEW.id_category), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_categories_after_update` AFTER UPDATE ON `tb_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_categories', 'Update', USER(), CONCAT('Actualizado ID: ', NEW.id_category), b'1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trq_tb_categories_after_delete` AFTER DELETE ON `tb_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status) 
    VALUES ('tb_categories', 'Delete', USER(), CONCAT('Eliminado ID: ', OLD.id_category), b'1');
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
