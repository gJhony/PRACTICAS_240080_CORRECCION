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
-- Temporary view structure for view `vw_trazabilidad_address_components`
--

DROP TABLE IF EXISTS `vw_trazabilidad_address_components`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_address_components`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_address_components` AS SELECT 
 1 AS `id_address_component`,
 1 AS `id_address`,
 1 AS `value`,
 1 AS `component_type`,
 1 AS `status`,
 1 AS `address_sup_id`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_caso4_punto_recoleccion`
--

DROP TABLE IF EXISTS `vw_caso4_punto_recoleccion`;
/*!50001 DROP VIEW IF EXISTS `vw_caso4_punto_recoleccion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_caso4_punto_recoleccion` AS SELECT 
 1 AS `id_user`,
 1 AS `nick`,
 1 AS `email`,
 1 AS `rol_actual`,
 1 AS `id_carrito`,
 1 AS `id_orden`,
 1 AS `subtotal`,
 1 AS `shipping_cost`,
 1 AS `total_orden`,
 1 AS `estatus_orden`,
 1 AS `domicilio_registrado_hogar`,
 1 AS `instrucciones_domicilio`,
 1 AS `metodo_pago`,
 1 AS `tipo_metodo_pago_codigo`,
 1 AS `tipo_metodo_pago`,
 1 AS `cuenta_referencia_spei_16d`,
 1 AS `id_payment`,
 1 AS `monto_pago`,
 1 AS `estatus_pago`,
 1 AS `transaccion_spei`,
 1 AS `cantidad_proveedores_distintos`,
 1 AS `proveedor_productos`,
 1 AS `detalle_3_productos_mismo_proveedor`,
 1 AS `envio_y_recoleccion`,
 1 AS `evidencia_intento_fallido_y_punto_recoleccion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_caso5_fallida_inventario`
--

DROP TABLE IF EXISTS `vw_caso5_fallida_inventario`;
/*!50001 DROP VIEW IF EXISTS `vw_caso5_fallida_inventario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_caso5_fallida_inventario` AS SELECT 
 1 AS `id_user`,
 1 AS `nick`,
 1 AS `email`,
 1 AS `id_carrito`,
 1 AS `id_orden`,
 1 AS `subtotal_intento`,
 1 AS `shipping_cost`,
 1 AS `total_intento`,
 1 AS `estatus_orden`,
 1 AS `estado_registro_orden`,
 1 AS `domicilio_envio`,
 1 AS `id_cupon_metodo`,
 1 AS `metodo_pago_cupon`,
 1 AS `tipo_metodo_pago`,
 1 AS `referencia_cupon`,
 1 AS `estado_cupon_actual`,
 1 AS `detalle_intento_compra_e_inventario`,
 1 AS `cancelacion_por_falta_inventario`,
 1 AS `evidencia_logs_falla_y_reactivacion_cupon`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_carts_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_carts_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_carts_items` AS SELECT 
 1 AS `id_cart`,
 1 AS `id_provider`,
 1 AS `id_product`,
 1 AS `quantity`,
 1 AS `creation_date`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_order_cancellations`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_order_cancellations`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_order_cancellations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_order_cancellations` AS SELECT 
 1 AS `id_order_cancellation`,
 1 AS `reason`,
 1 AS `cancelled_by`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_shipping_carriers`
--

DROP TABLE IF EXISTS `vw_trazabilidad_shipping_carriers`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_shipping_carriers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_shipping_carriers` AS SELECT 
 1 AS `id_carrier`,
 1 AS `name`,
 1 AS `tracking_url_template`,
 1 AS `is_active`,
 1 AS `created_at`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_categories`
--

DROP TABLE IF EXISTS `vw_trazabilidad_categories`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categories`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_categories` AS SELECT 
 1 AS `id_category`,
 1 AS `category_name`,
 1 AS `id_product`,
 1 AS `product_name`,
 1 AS `precio_mxn`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_order_returns`
--

DROP TABLE IF EXISTS `vw_trazabilidad_order_returns`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_returns`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_order_returns` AS SELECT 
 1 AS `id_return`,
 1 AS `id_buyer_order`,
 1 AS `id_user`,
 1 AS `reason`,
 1 AS `status`,
 1 AS `created_at`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_caso1_compra_exitosa`
--

DROP TABLE IF EXISTS `vw_caso1_compra_exitosa`;
/*!50001 DROP VIEW IF EXISTS `vw_caso1_compra_exitosa`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_caso1_compra_exitosa` AS SELECT 
 1 AS `id_user`,
 1 AS `nick`,
 1 AS `email`,
 1 AS `rol_actual`,
 1 AS `given_names`,
 1 AS `family_names`,
 1 AS `cambio_rol_buyer_evidencia`,
 1 AS `id_carrito`,
 1 AS `fecha_carrito`,
 1 AS `id_orden`,
 1 AS `id_vendedor_fulfillment`,
 1 AS `subtotal`,
 1 AS `shipping_cost`,
 1 AS `total_orden`,
 1 AS `estatus_orden`,
 1 AS `id_domicilio`,
 1 AS `domicilio_envio`,
 1 AS `destinatario`,
 1 AS `instrucciones_entrega`,
 1 AS `id_metodo_pago`,
 1 AS `tipo_metodo_pago_codigo`,
 1 AS `tipo_metodo_pago`,
 1 AS `proveedor_metodo`,
 1 AS `cuenta_referencia_16d`,
 1 AS `ultimos_4`,
 1 AS `id_payment`,
 1 AS `monto_pago`,
 1 AS `moneda`,
 1 AS `estatus_pago`,
 1 AS `fecha_pago`,
 1 AS `transacciones_bancarias`,
 1 AS `id_shipment`,
 1 AS `paqueteria`,
 1 AS `tracking_number`,
 1 AS `estatus_envio`,
 1 AS `fecha_envio`,
 1 AS `fecha_entrega`,
 1 AS `cantidad_lineas_productos`,
 1 AS `detalle_productos`,
 1 AS `movimiento_inventario_actual`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_carts`
--

DROP TABLE IF EXISTS `vw_trazabilidad_carts`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_carts` AS SELECT 
 1 AS `id_carts`,
 1 AS `user_ID`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_buyer_orders`
--

DROP TABLE IF EXISTS `vw_trazabilidad_buyer_orders`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_buyer_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_buyer_orders` AS SELECT 
 1 AS `id_buyer_order`,
 1 AS `seller_ID`,
 1 AS `subtotal`,
 1 AS `shipping_cost`,
 1 AS `fulfillment_status`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_people`
--

DROP TABLE IF EXISTS `vw_trazabilidad_people`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_people`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_people` AS SELECT 
 1 AS `id_people`,
 1 AS `id_user`,
 1 AS `user_email`,
 1 AS `user_nick`,
 1 AS `user_roles`,
 1 AS `courtesy_title`,
 1 AS `given_names`,
 1 AS `family_names`,
 1 AS `full_name`,
 1 AS `birth_date`,
 1 AS `gender`,
 1 AS `country_code`,
 1 AS `phone`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_order_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_order_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_order_items` AS SELECT 
 1 AS `id_order_item`,
 1 AS `id_order_seller`,
 1 AS `id_product`,
 1 AS `id_provider`,
 1 AS `product_name`,
 1 AS `quantity`,
 1 AS `unit_price`,
 1 AS `subtotal`,
 1 AS `creation_date`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payment_methods_types`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payment_methods_types`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods_types`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payment_methods_types` AS SELECT 
 1 AS `id_payment_method_type`,
 1 AS `code`,
 1 AS `description`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_products_users_providers`
--

DROP TABLE IF EXISTS `vw_trazabilidad_products_users_providers`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products_users_providers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_products_users_providers` AS SELECT 
 1 AS `id_product_user_provider`,
 1 AS `id_product`,
 1 AS `type_ownership`,
 1 AS `status`,
 1 AS `avalaible_date`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_products_categories`
--

DROP TABLE IF EXISTS `vw_trazabilidad_products_categories`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products_categories`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_products_categories` AS SELECT 
 1 AS `id_product`,
 1 AS `id_category`,
 1 AS `id_logs`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `operation_date`,
 1 AS `table_description`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_caso3_cancelacion_reembolso`
--

DROP TABLE IF EXISTS `vw_caso3_cancelacion_reembolso`;
/*!50001 DROP VIEW IF EXISTS `vw_caso3_cancelacion_reembolso`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_caso3_cancelacion_reembolso` AS SELECT 
 1 AS `id_user`,
 1 AS `nick`,
 1 AS `email`,
 1 AS `rol_actual`,
 1 AS `id_carrito`,
 1 AS `id_orden`,
 1 AS `subtotal_orden_actual_ajustado`,
 1 AS `shipping_cost`,
 1 AS `total_orden_actual`,
 1 AS `estatus_orden`,
 1 AS `domicilio_envio`,
 1 AS `instrucciones_entrega`,
 1 AS `metodo_pago`,
 1 AS `tipo_metodo_pago`,
 1 AS `cuenta_referencia_16d`,
 1 AS `subtotal_compra_original_items`,
 1 AS `detalle_compra_original`,
 1 AS `cancelacion_parcial`,
 1 AS `pagos_y_reembolsos`,
 1 AS `transacciones_pago_y_reembolso`,
 1 AS `envio_y_entrega`,
 1 AS `movimiento_inventario_actual`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_caso2_reclamacion_reenvio`
--

DROP TABLE IF EXISTS `vw_caso2_reclamacion_reenvio`;
/*!50001 DROP VIEW IF EXISTS `vw_caso2_reclamacion_reenvio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_caso2_reclamacion_reenvio` AS SELECT 
 1 AS `id_user`,
 1 AS `nick`,
 1 AS `email`,
 1 AS `rol_actual`,
 1 AS `cambio_rol_buyer_evidencia`,
 1 AS `id_carrito`,
 1 AS `id_orden`,
 1 AS `subtotal`,
 1 AS `shipping_cost`,
 1 AS `total_orden`,
 1 AS `estatus_orden`,
 1 AS `domicilio_envio`,
 1 AS `detalle_destino`,
 1 AS `metodo_pago`,
 1 AS `tipo_metodo_pago`,
 1 AS `cuenta_referencia_16d`,
 1 AS `ultimos_4`,
 1 AS `cantidad_lineas_productos`,
 1 AS `cantidad_total_unidades`,
 1 AS `detalle_10_productos`,
 1 AS `total_pagos_registrados`,
 1 AS `detalle_pagos`,
 1 AS `transacciones_autorizadas_y_rechazadas`,
 1 AS `reclamaciones_y_devoluciones`,
 1 AS `envios_y_reenvio`,
 1 AS `evidencia_reclamacion_reenvio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_user_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_user_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_user_payment_methods` AS SELECT 
 1 AS `id_user_payment_method`,
 1 AS `id_user`,
 1 AS `id_payment_method_type`,
 1 AS `provider`,
 1 AS `provider_method_ref`,
 1 AS `label`,
 1 AS `last_four`,
 1 AS `is_default`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_users_wishlist_products`
--

DROP TABLE IF EXISTS `vw_trazabilidad_users_wishlist_products`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_users_wishlist_products`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_users_wishlist_products` AS SELECT 
 1 AS `id_user_wishlist_product`,
 1 AS `id_product`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tbd_cancellation_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tbd_cancellation_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_cancellation_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tbd_cancellation_items` AS SELECT 
 1 AS `id_cancellation_item`,
 1 AS `id_order_cancellation`,
 1 AS `id_order_item`,
 1 AS `quantity`,
 1 AS `cancellation_reason`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payment_transactions`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payment_transactions`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_transactions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payment_transactions` AS SELECT 
 1 AS `id_transaction`,
 1 AS `id_payment`,
 1 AS `gateway_name`,
 1 AS `gateway_transaction_id`,
 1 AS `response_code`,
 1 AS `raw_response`,
 1 AS `created_at`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_return_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_return_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_return_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_return_items` AS SELECT 
 1 AS `id_return_item`,
 1 AS `id_return`,
 1 AS `id_order_item`,
 1 AS `quantity`,
 1 AS `refund_amount`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_users`
--

DROP TABLE IF EXISTS `vw_trazabilidad_users`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_users` AS SELECT 
 1 AS `id_user`,
 1 AS `email`,
 1 AS `username`,
 1 AS `creation_date`,
 1 AS `roles`,
 1 AS `given_names`,
 1 AS `family_names`,
 1 AS `phone`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_total_products_by_category`
--

DROP TABLE IF EXISTS `vw_total_products_by_category`;
/*!50001 DROP VIEW IF EXISTS `vw_total_products_by_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_total_products_by_category` AS SELECT 
 1 AS `category_id`,
 1 AS `category_path`,
 1 AS `category_level`,
 1 AS `total_products`,
 1 AS `total_active_products`,
 1 AS `total_inactive_products`,
 1 AS `total_uncategorized_products`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_products`
--

DROP TABLE IF EXISTS `vw_trazabilidad_products`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_products` AS SELECT 
 1 AS `id_product`,
 1 AS `sku`,
 1 AS `product_name`,
 1 AS `current_prize`,
 1 AS `current_stock`,
 1 AS `current_status`,
 1 AS `id_logs`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `operation_date`,
 1 AS `table_description`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_shipments`
--

DROP TABLE IF EXISTS `vw_trazabilidad_shipments`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_shipments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_shipments` AS SELECT 
 1 AS `id_shipment`,
 1 AS `id_buyer_order`,
 1 AS `id_carrier`,
 1 AS `id_user_adress`,
 1 AS `tracking_number`,
 1 AS `shipping_cost`,
 1 AS `status`,
 1 AS `shipped_at`,
 1 AS `delivered_at`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_user_addresses`
--

DROP TABLE IF EXISTS `vw_trazabilidad_user_addresses`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_addresses`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_user_addresses` AS SELECT 
 1 AS `id_user_adress`,
 1 AS `id_user`,
 1 AS `address_label`,
 1 AS `recipient_name`,
 1 AS `recipient_phone`,
 1 AS `delivery_instructions`,
 1 AS `latitude`,
 1 AS `longitude`,
 1 AS `is_default`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_payment_methods` AS SELECT 
 1 AS `id_payment_method`,
 1 AS `id_user`,
 1 AS `user_email`,
 1 AS `id_payment_method_type`,
 1 AS `provider_token`,
 1 AS `is_default`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tbd_user_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tbd_user_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_user_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tbd_user_payment_methods` AS SELECT 
 1 AS `id_user_payment_method`,
 1 AS `id_user`,
 1 AS `user_email`,
 1 AS `id_payment_method_type`,
 1 AS `provider`,
 1 AS `provider_method_ref`,
 1 AS `label`,
 1 AS `last_four`,
 1 AS `is_default`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payments`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payments`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payments` AS SELECT 
 1 AS `id_payment`,
 1 AS `id_buyer_order`,
 1 AS `id_user_payment_method`,
 1 AS `amount`,
 1 AS `currency`,
 1 AS `status`,
 1 AS `paid_at`,
 1 AS `log_operation`,
 1 AS `log_description`,
 1 AS `log_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_trazabilidad_address_components`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_address_components`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_address_components` AS select `ac`.`id_address_component` AS `id_address_component`,`ac`.`id_address` AS `id_address`,`ac`.`value` AS `value`,`ac`.`component_type` AS `component_type`,`ac`.`status` AS `status`,`ac`.`address_sup_id` AS `address_sup_id`,`ac`.`creation_date` AS `creation_date`,`ac`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbd_address_components` `ac` left join `tb_logs` `l` on((`l`.`table_name` = 'tbd_address_components'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_caso4_punto_recoleccion`
--

/*!50001 DROP VIEW IF EXISTS `vw_caso4_punto_recoleccion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jhon.gonzalez`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_caso4_punto_recoleccion` AS select `u`.`id_user` AS `id_user`,`u`.`nick` AS `nick`,`u`.`email` AS `email`,`u`.`roles` AS `rol_actual`,`c`.`id_carts` AS `id_carrito`,`bo`.`id_buyer_order` AS `id_orden`,`bo`.`subtotal` AS `subtotal`,`bo`.`shipping_cost` AS `shipping_cost`,(`bo`.`subtotal` + `bo`.`shipping_cost`) AS `total_orden`,`bo`.`fulfillment_status` AS `estatus_orden`,`ua`.`address_label` AS `domicilio_registrado_hogar`,`ua`.`delivery_instructions` AS `instrucciones_domicilio`,`pm`.`label` AS `metodo_pago`,`pmt`.`code` AS `tipo_metodo_pago_codigo`,`pmt`.`description` AS `tipo_metodo_pago`,`pm`.`provider_method_ref` AS `cuenta_referencia_spei_16d`,`pay`.`id_payment` AS `id_payment`,`pay`.`amount` AS `monto_pago`,`pay`.`status` AS `estatus_pago`,(select group_concat(concat(`tx`.`gateway_transaction_id`,' resp=',`tx`.`response_code`,' metodo=',json_unquote(json_extract(`tx`.`raw_response`,'$.method')),' ref=',json_unquote(json_extract(`tx`.`raw_response`,'$.reference'))) order by `tx`.`id_transaction` ASC separator ' | ') from `tb_payment_transactions` `tx` where (`tx`.`id_payment` = `pay`.`id_payment`)) AS `transaccion_spei`,(select count(distinct `pr`.`provider`) from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `cantidad_proveedores_distintos`,(select group_concat(distinct `pr`.`provider` order by `pr`.`provider` ASC separator ', ') from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `proveedor_productos`,(select group_concat(concat('Prod#',`pr`.`id_product`,' ',`pr`.`name`,' (proveedor=',`pr`.`provider`,') x',`oi`.`quantity`,' @',`oi`.`unit_price`) order by `oi`.`id_order_item` ASC separator ' | ') from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `detalle_3_productos_mismo_proveedor`,(select group_concat(concat('Ship#',`sh`.`id_shipment`,' tracking=',`sh`.`tracking_number`,' carrier=',`sc`.`name`,' estado_envio=',`sh`.`status`,' enviado=',ifnull(`sh`.`shipped_at`,'N/A'),' entregado/recogido=',ifnull(`sh`.`delivered_at`,'N/A')) order by `sh`.`id_shipment` ASC separator ' | ') from (`tb_shipments` `sh` left join `tbc_shipping_carriers` `sc` on((`sc`.`id_carrier` = `sh`.`id_carrier`))) where (`sh`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `envio_y_recoleccion`,(select group_concat(distinct `l`.`table_description` order by `l`.`operation_date` ASC separator ' || ') from `tb_logs` `l` where (`l`.`table_description` like 'P04_CASO4:%')) AS `evidencia_intento_fallido_y_punto_recoleccion` from ((((((`tb_users` `u` join `tb_carts` `c` on(((`c`.`user_ID` = `u`.`id_user`) and (`c`.`id_carts` = 9404)))) join `tb_buyer_orders` `bo` on((`bo`.`id_buyer_order` = 9404))) join `tb_user_addresses` `ua` on(((`ua`.`id_user_adress` = 9404) and (`ua`.`id_user` = `u`.`id_user`)))) join `tbd_user_payment_methods` `pm` on(((`pm`.`id_user_payment_method` = 9404) and (`pm`.`id_user` = `u`.`id_user`)))) join `tbc_payment_methods_types` `pmt` on((`pmt`.`id_payment_method_type` = `pm`.`id_payment_method_type`))) join `tb_payments` `pay` on(((`pay`.`id_payment` = 9404) and (`pay`.`id_buyer_order` = `bo`.`id_buyer_order`)))) where (`u`.`id_user` = 9) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_caso5_fallida_inventario`
--

/*!50001 DROP VIEW IF EXISTS `vw_caso5_fallida_inventario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jhon.gonzalez`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_caso5_fallida_inventario` AS select `u`.`id_user` AS `id_user`,`u`.`nick` AS `nick`,`u`.`email` AS `email`,`c`.`id_carts` AS `id_carrito`,`bo`.`id_buyer_order` AS `id_orden`,`bo`.`subtotal` AS `subtotal_intento`,`bo`.`shipping_cost` AS `shipping_cost`,(`bo`.`subtotal` + `bo`.`shipping_cost`) AS `total_intento`,`bo`.`fulfillment_status` AS `estatus_orden`,(case when (`bo`.`status` = 0x01) then 'ACTIVA' else 'NO ATENDIDA/INACTIVA' end) AS `estado_registro_orden`,`ua`.`address_label` AS `domicilio_envio`,`pm`.`id_user_payment_method` AS `id_cupon_metodo`,`pm`.`label` AS `metodo_pago_cupon`,`pmt`.`description` AS `tipo_metodo_pago`,`pm`.`provider_method_ref` AS `referencia_cupon`,(case when (`pm`.`status` = 0x01) then 'REACTIVADO/DISPONIBLE' else 'INACTIVO' end) AS `estado_cupon_actual`,(select group_concat(concat('Prod#',`pr`.`id_product`,' ',`pr`.`name`,' proveedor=',`pr`.`provider`,' stock_disponible=',`pr`.`current_stock`,' solicitado=',`oi`.`quantity`,' precio=',`oi`.`unit_price`) order by `oi`.`id_order_item` ASC separator ' | ') from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `detalle_intento_compra_e_inventario`,(select group_concat(concat('Cancel#',`oc`.`id_order_cancellation`,' por=',`oc`.`cancelled_by`,' motivo=',`oc`.`reason`,' items=',ifnull(`ci_det`.`items`,'')) order by `oc`.`id_order_cancellation` ASC separator ' || ') from (`tb_order_cancellations` `oc` left join (select `ci`.`id_order_cancellation` AS `id_order_cancellation`,group_concat(concat('oi=',`ci`.`id_order_item`,' qty=',`ci`.`quantity`,' razon=',`ci`.`reason`) separator ', ') AS `items` from `tbd_cancellation_items` `ci` group by `ci`.`id_order_cancellation`) `ci_det` on((`ci_det`.`id_order_cancellation` = `oc`.`id_order_cancellation`))) where ((`oc`.`id_user` = `u`.`id_user`) and (`oc`.`reason` like 'P04_CASO5:%'))) AS `cancelacion_por_falta_inventario`,(select group_concat(distinct `l`.`table_description` order by `l`.`operation_date` ASC separator ' || ') from `tb_logs` `l` where (`l`.`table_description` like 'P04_CASO5:%')) AS `evidencia_logs_falla_y_reactivacion_cupon` from (((((`tb_users` `u` join `tb_carts` `c` on(((`c`.`user_ID` = `u`.`id_user`) and (`c`.`id_carts` = 9405)))) join `tb_buyer_orders` `bo` on((`bo`.`id_buyer_order` = 9405))) join `tb_user_addresses` `ua` on(((`ua`.`id_user_adress` = 9405) and (`ua`.`id_user` = `u`.`id_user`)))) join `tbd_user_payment_methods` `pm` on(((`pm`.`id_user_payment_method` = 9405) and (`pm`.`id_user` = `u`.`id_user`)))) join `tbc_payment_methods_types` `pmt` on((`pmt`.`id_payment_method_type` = `pm`.`id_payment_method_type`))) where (`u`.`id_user` = 12) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_carts_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_carts_items` AS select `ci`.`id_cart` AS `id_cart`,`ci`.`id_provider` AS `id_provider`,`ci`.`id_product` AS `id_product`,`ci`.`quantity` AS `quantity`,`ci`.`creation_date` AS `creation_date`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbd_carts_items` `ci` left join `tb_logs` `l` on((`l`.`table_name` = 'tbd_carts_items'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_order_cancellations`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_order_cancellations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_order_cancellations` AS select `oc`.`id_order_cancellation` AS `id_order_cancellation`,`oc`.`reason` AS `reason`,`oc`.`cancelled_by` AS `cancelled_by`,`oc`.`status` AS `status`,`oc`.`creation_date` AS `creation_date`,`oc`.`last_update` AS `last_update` from `tb_order_cancellations` `oc` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_shipping_carriers`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_shipping_carriers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_shipping_carriers` AS select `sc`.`id_carrier` AS `id_carrier`,`sc`.`name` AS `name`,`sc`.`tracking_url_template` AS `tracking_url_template`,`sc`.`is_active` AS `is_active`,`sc`.`created_at` AS `created_at`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbc_shipping_carriers` `sc` left join `tb_logs` `l` on((`l`.`table_name` = 'tbc_shipping_carriers'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_categories`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categories`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_categories` AS select `c`.`id_category` AS `id_category`,`c`.`name` AS `category_name`,`p`.`id_product` AS `id_product`,`p`.`name` AS `product_name`,`p`.`current_prize` AS `precio_mxn` from ((`tb_categories` `c` left join `tbd_products_categories` `pc` on((`c`.`id_category` = `pc`.`id_category`))) left join `tb_products` `p` on((`pc`.`id_product` = `p`.`id_product`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_order_returns`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_returns`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_order_returns` AS select `r`.`id_return` AS `id_return`,`r`.`id_buyer_order` AS `id_buyer_order`,`r`.`id_user` AS `id_user`,`r`.`reason` AS `reason`,`r`.`status` AS `status`,`r`.`created_at` AS `created_at`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tb_order_returns` `r` left join `tb_logs` `l` on((`l`.`table_name` = 'tb_order_returns'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_caso1_compra_exitosa`
--

/*!50001 DROP VIEW IF EXISTS `vw_caso1_compra_exitosa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jhon.gonzalez`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_caso1_compra_exitosa` AS select `u`.`id_user` AS `id_user`,`u`.`nick` AS `nick`,`u`.`email` AS `email`,`u`.`roles` AS `rol_actual`,`p`.`given_names` AS `given_names`,`p`.`family_names` AS `family_names`,(select group_concat(distinct `l`.`table_description` order by `l`.`operation_date` ASC separator ' || ') from `tb_logs` `l` where ((`l`.`table_description` like 'P04_CASO1:%') and (`l`.`table_description` like '%rol buyer%'))) AS `cambio_rol_buyer_evidencia`,`c`.`id_carts` AS `id_carrito`,`c`.`creation_date` AS `fecha_carrito`,`bo`.`id_buyer_order` AS `id_orden`,`bo`.`seller_ID` AS `id_vendedor_fulfillment`,`bo`.`subtotal` AS `subtotal`,`bo`.`shipping_cost` AS `shipping_cost`,(`bo`.`subtotal` + `bo`.`shipping_cost`) AS `total_orden`,`bo`.`fulfillment_status` AS `estatus_orden`,`ua`.`id_user_adress` AS `id_domicilio`,`ua`.`address_label` AS `domicilio_envio`,`ua`.`recipient_name` AS `destinatario`,`ua`.`delivery_instructions` AS `instrucciones_entrega`,`pm`.`id_user_payment_method` AS `id_metodo_pago`,`pmt`.`code` AS `tipo_metodo_pago_codigo`,`pmt`.`description` AS `tipo_metodo_pago`,`pm`.`provider` AS `proveedor_metodo`,`pm`.`provider_method_ref` AS `cuenta_referencia_16d`,`pm`.`last_four` AS `ultimos_4`,`pay`.`id_payment` AS `id_payment`,`pay`.`amount` AS `monto_pago`,`pay`.`currency` AS `moneda`,`pay`.`status` AS `estatus_pago`,`pay`.`paid_at` AS `fecha_pago`,(select group_concat(concat(`tx`.`id_transaction`,'[',`tx`.`gateway_transaction_id`,'] resp=',`tx`.`response_code`,' resultado=',json_unquote(json_extract(`tx`.`raw_response`,'$.result'))) order by `tx`.`id_transaction` ASC separator ' | ') from `tb_payment_transactions` `tx` where (`tx`.`id_payment` = `pay`.`id_payment`)) AS `transacciones_bancarias`,`sh`.`id_shipment` AS `id_shipment`,`sc`.`name` AS `paqueteria`,`sh`.`tracking_number` AS `tracking_number`,`sh`.`status` AS `estatus_envio`,`sh`.`shipped_at` AS `fecha_envio`,`sh`.`delivered_at` AS `fecha_entrega`,(select count(0) from `tbd_order_items` `oi` where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `cantidad_lineas_productos`,(select group_concat(concat('Prod#',`pr`.`id_product`,' ',`pr`.`name`,' (SKU:',`pr`.`sku`,', ',`pr`.`category`,') x',`oi`.`quantity`,' @',`oi`.`unit_price`,' = ',`oi`.`subtotal`) order by `oi`.`id_order_item` ASC separator ' | ') from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `detalle_productos`,(select group_concat(concat('Prod#',`pr`.`id_product`,' stock_actual=',`pr`.`current_stock`) order by `pr`.`id_product` ASC separator ' | ') from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `movimiento_inventario_actual` from (((((((((`tb_users` `u` join `tb_people` `p` on((`p`.`id_user` = `u`.`id_user`))) join `tb_carts` `c` on(((`c`.`user_ID` = `u`.`id_user`) and (`c`.`id_carts` = 9401)))) join `tb_buyer_orders` `bo` on((`bo`.`id_buyer_order` = 9401))) join `tb_user_addresses` `ua` on(((`ua`.`id_user_adress` = 9401) and (`ua`.`id_user` = `u`.`id_user`)))) join `tbd_user_payment_methods` `pm` on(((`pm`.`id_user_payment_method` = 9401) and (`pm`.`id_user` = `u`.`id_user`)))) join `tbc_payment_methods_types` `pmt` on((`pmt`.`id_payment_method_type` = `pm`.`id_payment_method_type`))) join `tb_payments` `pay` on(((`pay`.`id_payment` = 9401) and (`pay`.`id_buyer_order` = `bo`.`id_buyer_order`)))) left join `tb_shipments` `sh` on(((`sh`.`id_shipment` = 9401) and (`sh`.`id_buyer_order` = `bo`.`id_buyer_order`)))) left join `tbc_shipping_carriers` `sc` on((`sc`.`id_carrier` = `sh`.`id_carrier`))) where (`u`.`email` = 'caso1.nuevo.p04@utxicotepec.edu.mx') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_carts`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_carts` AS select `c`.`id_carts` AS `id_carts`,`c`.`user_ID` AS `user_ID`,`c`.`status` AS `status`,`c`.`creation_date` AS `creation_date`,`c`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tb_carts` `c` left join `tb_logs` `l` on((`l`.`table_name` = 'tb_carts'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_buyer_orders`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_buyer_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_buyer_orders` AS select `bo`.`id_buyer_order` AS `id_buyer_order`,`bo`.`seller_ID` AS `seller_ID`,`bo`.`subtotal` AS `subtotal`,`bo`.`shipping_cost` AS `shipping_cost`,`bo`.`fulfillment_status` AS `fulfillment_status`,`bo`.`status` AS `status`,`bo`.`creation_date` AS `creation_date`,`bo`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tb_buyer_orders` `bo` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_buyer_orders') and (`l`.`table_description` like concat('%',`bo`.`id_buyer_order`,'%'))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_people`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_people`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_people` AS select `p`.`id_people` AS `id_people`,`p`.`id_user` AS `id_user`,`u`.`email` AS `user_email`,`u`.`nick` AS `user_nick`,`u`.`roles` AS `user_roles`,`p`.`courtesy_title` AS `courtesy_title`,`p`.`given_names` AS `given_names`,`p`.`family_names` AS `family_names`,concat(`p`.`given_names`,' ',`p`.`family_names`) AS `full_name`,`p`.`birth_date` AS `birth_date`,`p`.`gender` AS `gender`,`p`.`country_code` AS `country_code`,`p`.`phone` AS `phone`,`p`.`status` AS `status`,`p`.`creation_date` AS `creation_date`,`p`.`last_update` AS `last_update` from (`tb_people` `p` left join `tb_users` `u` on((`p`.`id_user` = `u`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_order_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_order_items` AS select `oi`.`id_order_item` AS `id_order_item`,`oi`.`id_order_seller` AS `id_order_seller`,`oi`.`id_product` AS `id_product`,`oi`.`id_provider` AS `id_provider`,`oi`.`product_name` AS `product_name`,`oi`.`quantity` AS `quantity`,`oi`.`unit_price` AS `unit_price`,`oi`.`subtotal` AS `subtotal`,`oi`.`creation_date` AS `creation_date`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbd_order_items` `oi` left join `tb_logs` `l` on((`l`.`table_name` = 'tbd_order_items'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payment_methods_types`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payment_methods_types` AS select `pmt`.`id_payment_method_type` AS `id_payment_method_type`,`pmt`.`code` AS `code`,`pmt`.`description` AS `description`,`pmt`.`status` AS `status`,`pmt`.`creation_date` AS `creation_date`,`pmt`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbc_payment_methods_types` `pmt` left join `tb_logs` `l` on((`l`.`table_name` = 'tbc_payment_methods_types'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_products_users_providers`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products_users_providers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_products_users_providers` AS select `pup`.`id_product_user_provider` AS `id_product_user_provider`,`pup`.`id_product` AS `id_product`,`pup`.`type_ownership` AS `type_ownership`,`pup`.`status` AS `status`,`pup`.`avalaible_date` AS `avalaible_date`,`pup`.`creation_date` AS `creation_date`,`pup`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbd_products_users_providers` `pup` left join `tb_logs` `l` on((`l`.`table_name` = 'tbd_products_users_providers'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_products_categories`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products_categories`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_products_categories` AS select `pc`.`id_product` AS `id_product`,`pc`.`id_category` AS `id_category`,`l`.`id_logs` AS `id_logs`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`operation_date` AS `operation_date`,`l`.`table_description` AS `table_description`,`l`.`operation_status` AS `operation_status` from (`tbd_products_categories` `pc` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_products_categories') and (`l`.`table_description` like concat('%',`pc`.`id_product`,'%')) and (`l`.`table_description` like concat('%',`pc`.`id_category`,'%'))))) order by `l`.`operation_date` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_caso3_cancelacion_reembolso`
--

/*!50001 DROP VIEW IF EXISTS `vw_caso3_cancelacion_reembolso`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jhon.gonzalez`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_caso3_cancelacion_reembolso` AS select `u`.`id_user` AS `id_user`,`u`.`nick` AS `nick`,`u`.`email` AS `email`,`u`.`roles` AS `rol_actual`,`c`.`id_carts` AS `id_carrito`,`bo`.`id_buyer_order` AS `id_orden`,`bo`.`subtotal` AS `subtotal_orden_actual_ajustado`,`bo`.`shipping_cost` AS `shipping_cost`,(`bo`.`subtotal` + `bo`.`shipping_cost`) AS `total_orden_actual`,`bo`.`fulfillment_status` AS `estatus_orden`,`ua`.`address_label` AS `domicilio_envio`,`ua`.`delivery_instructions` AS `instrucciones_entrega`,`pm`.`label` AS `metodo_pago`,`pmt`.`description` AS `tipo_metodo_pago`,`pm`.`provider_method_ref` AS `cuenta_referencia_16d`,(select sum(`oi`.`subtotal`) from `tbd_order_items` `oi` where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `subtotal_compra_original_items`,(select group_concat(concat('Prod#',`pr`.`id_product`,' ',`pr`.`name`,' (cat_id=',`pc`.`id_category`,') x',`oi`.`quantity`,' @',`oi`.`unit_price`,' = ',`oi`.`subtotal`) order by `oi`.`id_order_item` ASC separator ' | ') from ((`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) left join `tbd_products_categories` `pc` on((`pc`.`id_product` = `pr`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `detalle_compra_original`,(select group_concat(concat('Cancel#',`oc`.`id_order_cancellation`,' por=',`oc`.`cancelled_by`,' motivo=',`oc`.`reason`,' items=',ifnull(`ci_det`.`items`,'')) order by `oc`.`id_order_cancellation` ASC separator ' || ') from (`tb_order_cancellations` `oc` left join (select `ci`.`id_order_cancellation` AS `id_order_cancellation`,group_concat(concat('oi=',`ci`.`id_order_item`,' prod=',`oi`.`id_product`,' qty=',`ci`.`quantity`,' razon=',`ci`.`reason`) separator ', ') AS `items` from (`tbd_cancellation_items` `ci` join `tbd_order_items` `oi` on((`oi`.`id_order_item` = `ci`.`id_order_item`))) group by `ci`.`id_order_cancellation`) `ci_det` on((`ci_det`.`id_order_cancellation` = `oc`.`id_order_cancellation`))) where ((`oc`.`id_user` = `u`.`id_user`) and (`oc`.`reason` like 'P04_CASO3:%'))) AS `cancelacion_parcial`,(select group_concat(concat('Pago#',`pay`.`id_payment`,' monto=',`pay`.`amount`,' estado=',`pay`.`status`,' pagado=',ifnull(`pay`.`paid_at`,'N/A')) order by `pay`.`id_payment` ASC separator ' | ') from `tb_payments` `pay` where (`pay`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `pagos_y_reembolsos`,(select group_concat(concat('Tx ',`tx`.`gateway_transaction_id`,' pago=',`tx`.`id_payment`,' resp=',`tx`.`response_code`,' resultado=',ifnull(json_unquote(json_extract(`tx`.`raw_response`,'$.result')),'N/A'),' tipo=',ifnull(json_unquote(json_extract(`tx`.`raw_response`,'$.type')),'pago')) order by `tx`.`id_transaction` ASC separator ' | ') from (`tb_payment_transactions` `tx` join `tb_payments` `pay` on((`pay`.`id_payment` = `tx`.`id_payment`))) where (`pay`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `transacciones_pago_y_reembolso`,(select group_concat(concat('Ship#',`sh`.`id_shipment`,' tracking=',`sh`.`tracking_number`,' estado=',`sh`.`status`,' entregado=',ifnull(`sh`.`delivered_at`,'N/A')) order by `sh`.`id_shipment` ASC separator ' | ') from `tb_shipments` `sh` where (`sh`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `envio_y_entrega`,(select group_concat(concat('Prod#',`pr`.`id_product`,' stock_actual=',`pr`.`current_stock`) order by `pr`.`id_product` ASC separator ' | ') from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `movimiento_inventario_actual` from (((((`tb_users` `u` join `tb_carts` `c` on(((`c`.`user_ID` = `u`.`id_user`) and (`c`.`id_carts` = 9403)))) join `tb_buyer_orders` `bo` on((`bo`.`id_buyer_order` = 9403))) join `tb_user_addresses` `ua` on(((`ua`.`id_user_adress` = 9403) and (`ua`.`id_user` = `u`.`id_user`)))) join `tbd_user_payment_methods` `pm` on(((`pm`.`id_user_payment_method` = 9403) and (`pm`.`id_user` = `u`.`id_user`)))) join `tbc_payment_methods_types` `pmt` on((`pmt`.`id_payment_method_type` = `pm`.`id_payment_method_type`))) where (`u`.`id_user` = 5) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_caso2_reclamacion_reenvio`
--

/*!50001 DROP VIEW IF EXISTS `vw_caso2_reclamacion_reenvio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jhon.gonzalez`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_caso2_reclamacion_reenvio` AS select `u`.`id_user` AS `id_user`,`u`.`nick` AS `nick`,`u`.`email` AS `email`,`u`.`roles` AS `rol_actual`,(select group_concat(distinct `l`.`table_description` order by `l`.`operation_date` ASC separator ' || ') from `tb_logs` `l` where ((`l`.`table_description` like 'P04_CASO2:%') and (`l`.`table_description` like '%rol buyer%'))) AS `cambio_rol_buyer_evidencia`,`c`.`id_carts` AS `id_carrito`,`bo`.`id_buyer_order` AS `id_orden`,`bo`.`subtotal` AS `subtotal`,`bo`.`shipping_cost` AS `shipping_cost`,(`bo`.`subtotal` + `bo`.`shipping_cost`) AS `total_orden`,`bo`.`fulfillment_status` AS `estatus_orden`,`ua`.`address_label` AS `domicilio_envio`,`ua`.`delivery_instructions` AS `detalle_destino`,`pm`.`label` AS `metodo_pago`,`pmt`.`description` AS `tipo_metodo_pago`,`pm`.`provider_method_ref` AS `cuenta_referencia_16d`,`pm`.`last_four` AS `ultimos_4`,(select count(0) from `tbd_order_items` `oi` where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `cantidad_lineas_productos`,(select sum(`oi`.`quantity`) from `tbd_order_items` `oi` where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `cantidad_total_unidades`,(select group_concat(concat('Prod#',`pr`.`id_product`,' ',`pr`.`name`,' x',`oi`.`quantity`,' @',`oi`.`unit_price`) order by `oi`.`id_order_item` ASC separator ' | ') from (`tbd_order_items` `oi` join `tb_products` `pr` on((`pr`.`id_product` = `oi`.`id_product`))) where (`oi`.`id_order_seller` = `bo`.`id_buyer_order`)) AS `detalle_10_productos`,(select count(0) from `tb_payments` `pay` where (`pay`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `total_pagos_registrados`,(select group_concat(concat('Pago#',`pay`.`id_payment`,' monto=',`pay`.`amount`,' estado=',`pay`.`status`,ifnull(concat(' pagado=',`pay`.`paid_at`),'')) order by `pay`.`id_payment` ASC separator ' | ') from `tb_payments` `pay` where (`pay`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `detalle_pagos`,(select group_concat(concat('Tx ',`tx`.`gateway_transaction_id`,' (pago ',`tx`.`id_payment`,') resp=',`tx`.`response_code`,' motivo=',ifnull(json_unquote(json_extract(`tx`.`raw_response`,'$.reason')),json_unquote(json_extract(`tx`.`raw_response`,'$.result')))) order by `tx`.`id_transaction` ASC separator ' | ') from (`tb_payment_transactions` `tx` join `tb_payments` `pay` on((`pay`.`id_payment` = `tx`.`id_payment`))) where (`pay`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `transacciones_autorizadas_y_rechazadas`,(select group_concat(concat('Return#',`r`.`id_return`,' estado=',`r`.`status`,' motivo=',`r`.`reason`,' items=',ifnull(`ri_det`.`items`,'')) order by `r`.`id_return` ASC separator ' || ') from (`tb_order_returns` `r` left join (select `ri`.`id_return` AS `id_return`,group_concat(concat('oi=',`ri`.`id_order_item`,' prod=',`oi`.`id_product`,' qty=',`ri`.`quantity`,' refund=',`ri`.`refund_amount`) separator ', ') AS `items` from (`tbd_return_items` `ri` join `tbd_order_items` `oi` on((`oi`.`id_order_item` = `ri`.`id_order_item`))) group by `ri`.`id_return`) `ri_det` on((`ri_det`.`id_return` = `r`.`id_return`))) where (`r`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `reclamaciones_y_devoluciones`,(select group_concat(concat('Ship#',`sh`.`id_shipment`,' tracking=',`sh`.`tracking_number`,' carrier=',`sc`.`name`,' estado=',`sh`.`status`,' enviado=',ifnull(`sh`.`shipped_at`,'N/A'),' entregado=',ifnull(`sh`.`delivered_at`,'N/A')) order by `sh`.`id_shipment` ASC separator ' | ') from (`tb_shipments` `sh` left join `tbc_shipping_carriers` `sc` on((`sc`.`id_carrier` = `sh`.`id_carrier`))) where (`sh`.`id_buyer_order` = `bo`.`id_buyer_order`)) AS `envios_y_reenvio`,(select group_concat(distinct `l`.`table_description` order by `l`.`operation_date` ASC separator ' || ') from `tb_logs` `l` where ((`l`.`table_description` like 'P04_CASO2:%') and ((`l`.`table_description` like '%reclamaci??n%') or (`l`.`table_description` like '%reenv??o%')))) AS `evidencia_reclamacion_reenvio` from (((((`tb_users` `u` join `tb_carts` `c` on(((`c`.`user_ID` = `u`.`id_user`) and (`c`.`id_carts` = 9402)))) join `tb_buyer_orders` `bo` on((`bo`.`id_buyer_order` = 9402))) join `tb_user_addresses` `ua` on(((`ua`.`id_user_adress` = 9402) and (`ua`.`id_user` = `u`.`id_user`)))) join `tbd_user_payment_methods` `pm` on(((`pm`.`id_user_payment_method` = 9402) and (`pm`.`id_user` = `u`.`id_user`)))) join `tbc_payment_methods_types` `pmt` on((`pmt`.`id_payment_method_type` = `pm`.`id_payment_method_type`))) where (`u`.`id_user` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_user_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_user_payment_methods` AS select `upm`.`id_user_payment_method` AS `id_user_payment_method`,`upm`.`id_user` AS `id_user`,`upm`.`id_payment_method_type` AS `id_payment_method_type`,`upm`.`provider` AS `provider`,`upm`.`provider_method_ref` AS `provider_method_ref`,`upm`.`label` AS `label`,`upm`.`last_four` AS `last_four`,`upm`.`is_default` AS `is_default`,`upm`.`status` AS `status`,`upm`.`creation_date` AS `creation_date`,`upm`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbd_user_payment_methods` `upm` left join `tb_logs` `l` on((`l`.`table_name` = 'tbd_user_payment_methods'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_users_wishlist_products`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_users_wishlist_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_users_wishlist_products` AS select `uwp`.`id_user_wishlist_product` AS `id_user_wishlist_product`,`uwp`.`id_product` AS `id_product`,`uwp`.`status` AS `status`,`uwp`.`creation_date` AS `creation_date`,`uwp`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbd_users_wishlist_products` `uwp` left join `tb_logs` `l` on((`l`.`table_name` = 'tbd_users_wishlist_products'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tbd_cancellation_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_cancellation_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tbd_cancellation_items` AS select `ci`.`id_cancellation_item` AS `id_cancellation_item`,`ci`.`id_order_cancellation` AS `id_order_cancellation`,`ci`.`id_order_item` AS `id_order_item`,`ci`.`quantity` AS `quantity`,`ci`.`reason` AS `cancellation_reason`,`ci`.`status` AS `status`,`ci`.`creation_date` AS `creation_date`,`ci`.`last_update` AS `last_update` from `tbd_cancellation_items` `ci` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payment_transactions`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_transactions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payment_transactions` AS select `pt`.`id_transaction` AS `id_transaction`,`pt`.`id_payment` AS `id_payment`,`pt`.`gateway_name` AS `gateway_name`,`pt`.`gateway_transaction_id` AS `gateway_transaction_id`,`pt`.`response_code` AS `response_code`,`pt`.`raw_response` AS `raw_response`,`pt`.`created_at` AS `created_at`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tb_payment_transactions` `pt` left join `tb_logs` `l` on((`l`.`table_name` = 'tb_payment_transactions'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_return_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_return_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_return_items` AS select `ri`.`id_return_item` AS `id_return_item`,`ri`.`id_return` AS `id_return`,`ri`.`id_order_item` AS `id_order_item`,`ri`.`quantity` AS `quantity`,`ri`.`refund_amount` AS `refund_amount`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tbd_return_items` `ri` left join `tb_logs` `l` on((`l`.`table_name` = 'tbd_return_items'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_users`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_users` AS select `u`.`id_user` AS `id_user`,`u`.`email` AS `email`,`u`.`nick` AS `username`,`u`.`creation_date` AS `creation_date`,`u`.`roles` AS `roles`,`p`.`given_names` AS `given_names`,`p`.`family_names` AS `family_names`,`p`.`phone` AS `phone` from (`tb_users` `u` left join `tb_people` `p` on((`u`.`id_user` = `p`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_total_products_by_category`
--

/*!50001 DROP VIEW IF EXISTS `vw_total_products_by_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_total_products_by_category` AS with recursive `categorypath` as (select `tb_categories`.`id_category` AS `id_category`,`tb_categories`.`name` AS `category_name`,cast(`tb_categories`.`name` as char(1000) charset utf8mb4) AS `category_path`,1 AS `category_level` from `tb_categories` where ((`tb_categories`.`sup_id_category` is null) or (`tb_categories`.`sup_id_category` = 0)) union all select `c`.`id_category` AS `id_category`,`c`.`name` AS `name`,concat(`cp`.`category_path`,' → ',`c`.`name`) AS `CONCAT(cp.category_path, ' → ', c.name)`,(`cp`.`category_level` + 1) AS `cp.category_level + 1` from (`tb_categories` `c` join `categorypath` `cp` on((`c`.`sup_id_category` = `cp`.`id_category`)))) select `cp`.`id_category` AS `category_id`,`cp`.`category_path` AS `category_path`,`cp`.`category_level` AS `category_level`,count(`p`.`id_product`) AS `total_products`,sum((case when (`p`.`status` = 1) then 1 else 0 end)) AS `total_active_products`,sum((case when (`p`.`status` = 0) then 1 else 0 end)) AS `total_inactive_products`,0 AS `total_uncategorized_products` from ((`categorypath` `cp` left join `tbd_products_categories` `pc` on((`cp`.`id_category` = `pc`.`id_category`))) left join `tb_products` `p` on((`pc`.`id_product` = `p`.`id_product`))) group by `cp`.`id_category`,`cp`.`category_path`,`cp`.`category_level` union all select NULL AS `category_id`,'Sin categoría' AS `category_path`,0 AS `category_level`,count(`p`.`id_product`) AS `total_products`,sum((case when (`p`.`status` = 1) then 1 else 0 end)) AS `total_active_products`,sum((case when (`p`.`status` = 0) then 1 else 0 end)) AS `total_inactive_products`,count(`p`.`id_product`) AS `total_uncategorized_products` from `tb_products` `p` where `p`.`id_product` in (select `tbd_products_categories`.`id_product` from `tbd_products_categories`) is false */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_products`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_products` AS select `p`.`id_product` AS `id_product`,`p`.`sku` AS `sku`,`p`.`name` AS `product_name`,`p`.`current_prize` AS `current_prize`,`p`.`current_stock` AS `current_stock`,`p`.`status` AS `current_status`,`l`.`id_logs` AS `id_logs`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`operation_date` AS `operation_date`,`l`.`table_description` AS `table_description`,`l`.`operation_status` AS `operation_status` from (`tb_products` `p` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_products') and (`l`.`table_description` like concat('%',`p`.`id_product`,'%'))))) order by `l`.`operation_date` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_shipments`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_shipments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_shipments` AS select `s`.`id_shipment` AS `id_shipment`,`s`.`id_buyer_order` AS `id_buyer_order`,`s`.`id_carrier` AS `id_carrier`,`s`.`id_user_adress` AS `id_user_adress`,`s`.`tracking_number` AS `tracking_number`,`s`.`shipping_cost` AS `shipping_cost`,`s`.`status` AS `status`,`s`.`shipped_at` AS `shipped_at`,`s`.`delivered_at` AS `delivered_at`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tb_shipments` `s` left join `tb_logs` `l` on((`l`.`table_name` = 'tb_shipments'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_user_addresses`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_addresses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_user_addresses` AS select `ua`.`id_user_adress` AS `id_user_adress`,`ua`.`id_user` AS `id_user`,`ua`.`address_label` AS `address_label`,`ua`.`recipient_name` AS `recipient_name`,`ua`.`recipient_phone` AS `recipient_phone`,`ua`.`delivery_instructions` AS `delivery_instructions`,`ua`.`latitude` AS `latitude`,`ua`.`longitude` AS `longitude`,`ua`.`is_default` AS `is_default`,`ua`.`status` AS `status`,`ua`.`creation_date` AS `creation_date`,`ua`.`last_update` AS `last_update`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tb_user_addresses` `ua` left join `tb_logs` `l` on((`l`.`table_name` = 'tb_user_addresses'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_payment_methods` AS select `pm`.`id_payment_method` AS `id_payment_method`,`pm`.`id_user` AS `id_user`,`u`.`email` AS `user_email`,`pm`.`id_payment_method_type` AS `id_payment_method_type`,`pm`.`provider_token` AS `provider_token`,`pm`.`is_default` AS `is_default`,`pm`.`status` AS `status`,`pm`.`creation_date` AS `creation_date`,`pm`.`last_update` AS `last_update` from (`tb_payment_methods` `pm` left join `tb_users` `u` on((`pm`.`id_user` = `u`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tbd_user_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_user_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tbd_user_payment_methods` AS select `upm`.`id_user_payment_method` AS `id_user_payment_method`,`upm`.`id_user` AS `id_user`,`u`.`email` AS `user_email`,`upm`.`id_payment_method_type` AS `id_payment_method_type`,`upm`.`provider` AS `provider`,`upm`.`provider_method_ref` AS `provider_method_ref`,`upm`.`label` AS `label`,`upm`.`last_four` AS `last_four`,`upm`.`is_default` AS `is_default`,`upm`.`status` AS `status`,`upm`.`creation_date` AS `creation_date`,`upm`.`last_update` AS `last_update` from (`tbd_user_payment_methods` `upm` left join `tb_users` `u` on((`upm`.`id_user` = `u`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payments`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payments` AS select `p`.`id_payment` AS `id_payment`,`p`.`id_buyer_order` AS `id_buyer_order`,`p`.`id_user_payment_method` AS `id_user_payment_method`,`p`.`amount` AS `amount`,`p`.`currency` AS `currency`,`p`.`status` AS `status`,`p`.`paid_at` AS `paid_at`,`l`.`table_operation` AS `log_operation`,`l`.`table_description` AS `log_description`,`l`.`operation_date` AS `log_date` from (`tb_payments` `p` left join `tb_logs` `l` on((`l`.`table_name` = 'tb_payments'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'db_test_7b'
--

--
-- Dumping routines for database 'db_test_7b'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_register_new_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_new_user`(
    IN p_email          VARCHAR(100),
    IN p_nick           VARCHAR(50),
    IN p_password       VARCHAR(100),
    IN p_courtesy_title VARCHAR(20),
    IN p_given_names    VARCHAR(150),
    IN p_family_names   VARCHAR(150),
    IN p_birth_date     DATE,
    IN p_gender         VARCHAR(30),
    IN p_country_code   VARCHAR(50),
    IN p_phone          VARCHAR(25)
)
    MODIFIES SQL DATA
BEGIN
    DECLARE v_db_user    VARCHAR(32);
    DECLARE v_has_role   INT DEFAULT 0;
    DECLARE v_count      INT DEFAULT 0;
    DECLARE v_user_id    INT; 
    DECLARE v_person_id  BIGINT UNSIGNED;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo o el nick ya se encuentran registrados';
    END;

    
    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);

    
    SELECT COUNT(*)
    INTO v_has_role
    FROM mysql.role_edges re
    WHERE re.TO_USER = v_db_user
      AND re.TO_HOST = '%'
      AND re.FROM_HOST = '%'
      AND re.FROM_USER IN (
          'superadmin',
          'admin',
          'support',
          'user_not_registered'
      );

    IF v_has_role = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: rol no autorizado';
    END IF;

    
    SET p_email          = LOWER(TRIM(p_email));
    SET p_nick           = TRIM(p_nick);
    SET p_given_names    = TRIM(p_given_names);
    SET p_family_names   = NULLIF(TRIM(p_family_names), '');
    SET p_courtesy_title = NULLIF(TRIM(p_courtesy_title), '');
    SET p_gender         = COALESCE(NULLIF(TRIM(p_gender), ''), 'Prefiero no decirlo');
    SET p_country_code   = NULLIF(UPPER(TRIM(p_country_code)), '');
    SET p_phone          = NULLIF(TRIM(p_phone), '');

    
    IF p_email IS NULL OR p_email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electrónico es inválido';
    END IF;

    IF p_nick IS NULL OR CHAR_LENGTH(p_nick) < 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nick debe tener al menos 3 caracteres';
    END IF;

    IF p_password IS NULL OR CHAR_LENGTH(p_password) < 8 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La contraseña debe tener al menos 8 caracteres';
    END IF;

    
    IF p_given_names IS NULL OR p_given_names = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre es obligatorio';
    END IF;

    IF p_birth_date IS NOT NULL
       AND (p_birth_date > CURRENT_DATE OR p_birth_date < '1900-01-01') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de nacimiento es inválida';
    END IF;

    IF p_gender NOT IN ('Hombre', 'Mujer', 'Prefiero no decirlo') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El género debe ser Hombre, Mujer o Prefiero no decirlo';
    END IF;

    IF p_country_code IS NOT NULL AND p_country_code NOT REGEXP '^[A-Z]{2}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El código de país debe tener 2 letras (ISO)';
    END IF;

    IF p_phone IS NOT NULL AND p_phone NOT REGEXP '^[0-9+() -]{7,25}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono es inválido';
    END IF;

    
    SELECT COUNT(*) INTO v_count FROM tb_users WHERE email = p_email;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electrónico ya se encuentra registrado';
    END IF;

    SELECT COUNT(*) INTO v_count FROM tb_users WHERE nick = p_nick;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nick ya se encuentra en uso';
    END IF;

    
    START TRANSACTION;

    INSERT INTO tb_users (email, nick, password)
    VALUES (p_email, p_nick, MD5(p_password));

    SET v_user_id = LAST_INSERT_ID();

    INSERT INTO tb_people (
        user_ID, courtesy_title, given_names, family_names,
        birth_date, gender, country_code, phone
    )
    VALUES (
        v_user_id, p_courtesy_title, p_given_names, p_family_names,
        p_birth_date, p_gender, p_country_code, p_phone
    );

    SET v_person_id = LAST_INSERT_ID();

    COMMIT;

    
    SELECT
        'Usuario y persona registrados correctamente' AS mensaje,
        v_user_id AS user_id,
        v_person_id AS person_id,
        p_email AS email,
        p_nick AS nick,
        v_db_user AS ejecutado_por,
        CURRENT_TIMESTAMP AS fecha_operacion;
END ;;
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
