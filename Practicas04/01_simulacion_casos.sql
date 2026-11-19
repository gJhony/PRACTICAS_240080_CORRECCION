-- Práctica 04: Procesos de Simulación de Compra
-- Base: db_test_7b (esquema/respaldos finalfinal.sql)
-- Motor objetivo: MySQL 8.0
--
-- Notas de adaptación/inspección:
-- * El esquema ya contiene tablas para usuarios, carritos, órdenes, pagos, envíos,
--   cancelaciones, devoluciones, cupones/métodos (tbd_user_payment_methods) y logs.
-- * No se requieren ALTER TABLE para cumplir los 5 casos; se realizan ajustes de datos
--   de catálogo (tipos de método de pago, paqueterías) y relaciones proveedor-producto
--   necesarias para respetar las llaves foráneas existentes.
-- * tb_buyer_orders no almacena buyer_id/cart_id; la trazabilidad del comprador se
--   vincula mediante direcciones, métodos de pago/pagos, devoluciones, cancelaciones y logs.
-- * Los triggers de auditoría del esquema registran automáticamente DML en tb_logs.
--   Se agregan logs explícitos para eventos de negocio (activación de rol buyer,
--   autorización/rechazo, reenvío, recolección en punto, reactivación de cupón).

USE db_test_7b;

SET NAMES utf8mb4;
SET @OLD_SQL_SAFE_UPDATES := @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;

-- ============================================================
-- 0) PREPARACIÓN IDEMPOTENTE (limpieza de ejecuciones previas
--    de esta simulación y catálogos mínimos)
-- ============================================================

-- Limpieza por marcadores de simulación (orden seguro por FKs)
DELETE FROM tb_logs WHERE table_description LIKE 'P04_CASO%' OR table_description LIKE 'P04_%';
DELETE FROM tbd_return_items WHERE id_return IN (SELECT id_return FROM tb_order_returns WHERE reason LIKE 'P04_CASO%');
DELETE FROM tb_order_returns WHERE reason LIKE 'P04_CASO%';
DELETE FROM tbd_cancellation_items WHERE reason LIKE 'P04_CASO%' OR id_order_cancellation IN (SELECT id_order_cancellation FROM tb_order_cancellations WHERE reason LIKE 'P04_CASO%');
DELETE FROM tb_order_cancellations WHERE reason LIKE 'P04_CASO%';
DELETE FROM tb_payment_transactions WHERE gateway_transaction_id LIKE 'P04-%';
DELETE FROM tb_payments WHERE id_user_payment_method IN (SELECT id_user_payment_method FROM tbd_user_payment_methods WHERE label LIKE 'P04_CASO%');
DELETE FROM tb_shipments WHERE tracking_number LIKE 'P04-%' OR id_buyer_order IN (9401,9402,9403,9404,9405);
DELETE FROM tbd_order_items WHERE id_order_seller IN (9401,9402,9403,9404,9405);
DELETE FROM tb_buyer_orders WHERE id_buyer_order IN (9401,9402,9403,9404,9405);
DELETE FROM tbd_carts_items WHERE id_cart IN (9401,9402,9403,9404,9405);
DELETE FROM tb_carts WHERE id_carts IN (9401,9402,9403,9404,9405);
DELETE FROM tb_payment_methods WHERE provider_token LIKE 'P04-%';
DELETE FROM tbd_user_payment_methods WHERE label LIKE 'P04_CASO%' OR provider_method_ref LIKE 'P04REF%';
DELETE FROM tbd_address_components WHERE id_address IN (SELECT id_user_adress FROM tb_user_addresses WHERE address_label LIKE 'P04_CASO%');
DELETE FROM tb_user_addresses WHERE address_label LIKE 'P04_CASO%';
DELETE FROM tbd_products_users_providers WHERE (id_product_user_provider = 7 AND id_product IN (1,2,3,4,5,6,8,10,11,12,13,54,79,329))
   OR (id_product_user_provider = 11 AND id_product IN (1,2,3,4,5,6,8,10,11,12,13,54,79,329));

-- Usuario nuevo del Caso 1 (si ya existiera de corrida previa)
DELETE p FROM tb_people p JOIN tb_users u ON p.id_user = u.id_user WHERE u.email = 'caso1.nuevo.p04@utxicotepec.edu.mx';
DELETE FROM tb_users WHERE email = 'caso1.nuevo.p04@utxicotepec.edu.mx';

-- Catálogos de tipos de pago (idempotente)
INSERT INTO tbc_payment_methods_types (id_payment_method_type, code, description, status, creation_date, last_update)
VALUES
  (9101, 'DEBIT_CARD',  'Tarjeta de débito', b'1', NOW(), NOW()),
  (9102, 'CREDIT_CARD', 'Tarjeta de crédito', b'1', NOW(), NOW()),
  (9103, 'SPIN_DIGITAL','Tarjeta digital (Spin)', b'1', NOW(), NOW()),
  (9104, 'SPEI',        'Transferencia SPEI', b'1', NOW(), NOW()),
  (9105, 'GIFT_COUPON', 'Cupón de regalo', b'1', NOW(), NOW())
ON DUPLICATE KEY UPDATE
  code = VALUES(code),
  description = VALUES(description),
  status = VALUES(status),
  last_update = VALUES(last_update);

-- Paqueterías/puntos logísticos (idempotente)
INSERT INTO tbc_shipping_carriers (id_carrier, name, tracking_url_template, is_active, created_at)
VALUES
  (9201, 'Paquetería HogarExpress', 'https://tracking.example/home/{tracking}', 1, NOW()),
  (9202, 'Punto Recolección MercadoExpress', 'https://tracking.example/pickup/{tracking}', 1, NOW())
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  tracking_url_template = VALUES(tracking_url_template),
  is_active = VALUES(is_active);

-- Proveedores/vendedores por producto (necesario para FKs de carrito/orden)
-- Se usa el usuario vendedor 7 (PONCHO, seller) como proveedor/fulfillment para los productos simulados.
INSERT INTO tbd_products_users_providers (id_product_user_provider, id_product, type_ownership, status, avalaible_date, creation_date, last_update)
VALUES
  (7, 1,  'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 2,  'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 3,  'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 4,  'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 5,  'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 6,  'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 8,  'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 10, 'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 11, 'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 12, 'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 13, 'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 54, 'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 79, 'Owner', b'1', NOW(), NOW(), NOW()),
  (7, 329,'Owner', b'1', NOW(), NOW(), NOW())
ON DUPLICATE KEY UPDATE
  status = VALUES(status),
  last_update = VALUES(last_update);

-- Snapshot de stock previo (para validación interna de movimientos)
DROP TEMPORARY TABLE IF EXISTS tmp_p04_stock_before;
CREATE TEMPORARY TABLE tmp_p04_stock_before AS
SELECT id_product, current_stock FROM tb_products WHERE id_product IN (1,2,3,4,5,6,8,10,11,12,13,54,79,329);

-- ============================================================
-- CASO 1: Compra exitosa, sin modificaciones
-- Usuario nuevo (AppWeb/AppMobile, rol user_not_registered -> buyer), 5 productos,
-- carrito, orden, domicilio, tarjeta débito, pago único autorizado, atendida y entregada.
-- ============================================================
START TRANSACTION;

-- Paso 1: Registro de usuario nuevo (simula conexión AppWeb/AppMobile con rol user_not_registered)
-- Nota: sp_register_new_user existe; se realiza inserción equivalente determinista para conservar IDs/rastreabilidad.
INSERT INTO tb_users (email, nick, password, creation_date, last_login, status, roles)
VALUES ('caso1.nuevo.p04@utxicotepec.edu.mx', 'caso1_nuevo_p04', MD5('Caso1P04!2026'), NOW(), NULL, b'1', 'Sin rol');
SET @c1_user_id := LAST_INSERT_ID();

INSERT INTO tb_people (id_user, courtesy_title, given_names, family_names, birth_date, gender, country_code, phone, status, creation_date, last_update)
VALUES (@c1_user_id, 'Sr.', 'Usuario', 'Caso Uno P04', '2000-01-15', 'Prefiero no decirlo', 'MX', '7641234501', b'1', NOW(), NOW());
SET @c1_people_id := LAST_INSERT_ID();

INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES
  ('tb_users', 'Create', 'AppWeb/AppMobile(user_not_registered)', CONCAT('P04_CASO1: registro usuario nuevo id=', @c1_user_id, ' nick=caso1_nuevo_p04 email=caso1.nuevo.p04@utxicotepec.edu.mx'), b'1');

-- Paso 2-4: Carrito y 5 productos disponibles con cantidades diferentes
INSERT INTO tb_carts (id_carts, user_ID, status, creation_date, last_update) VALUES (9401, @c1_user_id, b'1', NOW(), NOW());
INSERT INTO tbd_carts_items (id_cart, id_provider, id_product, quantity, creation_date) VALUES
  (9401, 7, 1, 2, NOW()), -- Boing Mango
  (9401, 7, 2, 1, NOW()), -- Coca-Cola Original
  (9401, 7, 3, 3, NOW()), -- HyperX Micrófono Plus
  (9401, 7, 4, 1, NOW()), -- LogiTech Headset Gamer Lite
  (9401, 7, 5, 2, NOW()); -- Apex Lámpara LED Premium

-- Paso 5: Orden de compra (seller_ID=7)
SET @c1_subtotal := (18.00*2 + 22.00*1 + 1704.07*3 + 1020.80*1 + 1881.37*2); -- 9953.75
SET @c1_shipping := 150.00;
INSERT INTO tb_buyer_orders (id_buyer_order, seller_ID, subtotal, shipping_cost, fulfillment_status, status, creation_date, last_update)
VALUES (9401, 7, @c1_subtotal, @c1_shipping, 'Pending', b'1', NOW(), NOW());

INSERT INTO tbd_order_items (id_order_seller, id_product, id_provider, product_name, quantity, unit_price, creation_date) VALUES
  (9401, 1, 7, 'Boing Mango', 2, 18.00, NOW()),
  (9401, 2, 7, 'Coca-Cola Original', 1, 22.00, NOW()),
  (9401, 3, 7, 'HyperX Micrófono Plus', 3, 1704.07, NOW()),
  (9401, 4, 7, 'LogiTech Headset Gamer Lite', 1, 1020.80, NOW()),
  (9401, 5, 7, 'Apex Lámpara LED Premium', 2, 1881.37, NOW());

-- Paso 6: Domicilio de envío
INSERT INTO tb_user_addresses (id_user_adress, id_user, address_label, recipient_name, recipient_phone, delivery_instructions, is_default, status, creation_date, last_update)
VALUES (9401, @c1_user_id, 'P04_CASO1_Hogar', 'Usuario Caso Uno P04', '7641234501', 'Entregar en domicilio principal, tocar timbre', 1, b'1', NOW(), NOW());

-- Paso 7-8: Método de pago (tarjeta débito, 16 dígitos) y pago único; activación de rol buyer al pagar
INSERT INTO tbd_user_payment_methods (id_user_payment_method, id_user, id_payment_method_type, provider, provider_method_ref, label, last_four, is_default, status, creation_date, last_update)
VALUES (9401, @c1_user_id, 9101, 'BancoSim Debito', 'P04REF-4111111111111111', 'P04_CASO1_Tarjeta_Debito', '1111', 1, b'1', NOW(), NOW());

-- Simulación de cambio de contexto/rol al pagar
-- SET ROLE 'buyer';
UPDATE tb_users SET roles = 'buyer', last_update = NOW() WHERE id_user = @c1_user_id;
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_users', 'Update', 'AppWeb/AppMobile->buyer', CONCAT('P04_CASO1: usuario id=', @c1_user_id, ' activó rol buyer al realizar pago único'), b'1');

INSERT INTO tb_payments (id_payment, id_buyer_order, id_user_payment_method, amount, currency, status, paid_at)
VALUES (9401, 9401, 9401, @c1_subtotal + @c1_shipping, 'MXN', 'completed', NOW());

-- Paso 9: Transacción bancaria autorizada
INSERT INTO tb_payment_transactions (id_transaction, id_payment, gateway_name, gateway_transaction_id, response_code, raw_response, created_at)
VALUES (9401, 9401, 'BancoSim', 'P04-C1-TX-0001', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','message','Pago único aprobado','card_last4','1111'), NOW());

-- Paso 10: Orden atendida + movimiento de inventario
UPDATE tb_buyer_orders SET fulfillment_status = 'Delivered', last_update = NOW() WHERE id_buyer_order = 9401;
UPDATE tb_products SET current_stock = current_stock - 2 WHERE id_product = 1;
UPDATE tb_products SET current_stock = current_stock - 1 WHERE id_product = 2;
UPDATE tb_products SET current_stock = current_stock - 3 WHERE id_product = 3;
UPDATE tb_products SET current_stock = current_stock - 1 WHERE id_product = 4;
UPDATE tb_products SET current_stock = current_stock - 2 WHERE id_product = 5;

-- Paso 11: Envío y recepción en casa
INSERT INTO tb_shipments (id_shipment, id_buyer_order, id_carrier, id_user_adress, tracking_number, shipping_cost, status, shipped_at, delivered_at)
VALUES (9401, 9401, 9201, 9401, 'P04-C1-SHIP-0001', @c1_shipping, 'delivered', NOW(), NOW());

INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_shipments', 'Update', 'SYSTEM', CONCAT('P04_CASO1: orden 9401 entregada en domicilio (usuario ', @c1_user_id, '), pago autorizado, inventario descontado'), b'1');

COMMIT;

-- ============================================================
-- CASO 2: Compra con detalles en el último pago y con reclamación y reenvío
-- Usuario registrado (id 2, JEIG), 10 productos qty 1-5, envío a trabajo,
-- tarjeta crédito, 6 pagos mensuales (5 autorizados, 6 rechazado límite excedido),
-- orden atendida, entrega, reclamación por daño y reenvío.
-- ============================================================
START TRANSACTION;
SET @c2_user_id := 2;

-- Paso 1: Carrito de 10 productos aleatorios con cantidades 1-5
INSERT INTO tb_carts (id_carts, user_ID, status, creation_date, last_update) VALUES (9402, @c2_user_id, b'1', NOW(), NOW());
INSERT INTO tbd_carts_items (id_cart, id_provider, id_product, quantity, creation_date) VALUES
  (9402, 7, 1, 1, NOW()),
  (9402, 7, 2, 2, NOW()),
  (9402, 7, 3, 3, NOW()),
  (9402, 7, 4, 1, NOW()),
  (9402, 7, 5, 4, NOW()),
  (9402, 7, 6, 2, NOW()),
  (9402, 7, 8, 5, NOW()),
  (9402, 7, 10, 3, NOW()),
  (9402, 7, 11, 1, NOW()),
  (9402, 7, 12, 2, NOW());

-- Paso 2: Orden de compra
SET @c2_subtotal := (18.00*1 + 22.00*2 + 1704.07*3 + 1020.80*1 + 1881.37*4 + 4773.31*2 + 4519.90*5 + 4716.09*3 + 3734.43*1 + 386.18*2); -- 64521.67
SET @c2_shipping := 200.00;
INSERT INTO tb_buyer_orders (id_buyer_order, seller_ID, subtotal, shipping_cost, fulfillment_status, status, creation_date, last_update)
VALUES (9402, 7, @c2_subtotal, @c2_shipping, 'Pending', b'1', NOW(), NOW());
INSERT INTO tbd_order_items (id_order_seller, id_product, id_provider, product_name, quantity, unit_price, creation_date) VALUES
  (9402, 1, 7, 'Boing Mango', 1, 18.00, NOW()),
  (9402, 2, 7, 'Coca-Cola Original', 2, 22.00, NOW()),
  (9402, 3, 7, 'HyperX Micrófono Plus', 3, 1704.07, NOW()),
  (9402, 4, 7, 'LogiTech Headset Gamer Lite', 1, 1020.80, NOW()),
  (9402, 5, 7, 'Apex Lámpara LED Premium', 4, 1881.37, NOW()),
  (9402, 6, 7, 'Vertex Impresora Ultra', 2, 4773.31, NOW()),
  (9402, 8, 7, 'Procesador de 8 nucleos Solara 4.2 GHz modelo 9880', 5, 4519.90, NOW()),
  (9402, 10, 7, 'Mini proyector Kukulcan con bateria modelo 2371', 3, 4716.09, NOW()),
  (9402, 11, 7, 'Monitor para oficina Andes de 24 pulgadas modelo 1021', 1, 3734.43, NOW()),
  (9402, 12, 7, 'Nova Headset Gamer Premium', 2, 386.18, NOW());

-- Paso 3: Domicilio de envío a lugar distinto al hogar (trabajo)
INSERT INTO tb_user_addresses (id_user_adress, id_user, address_label, recipient_name, recipient_phone, delivery_instructions, is_default, status, creation_date, last_update)
VALUES (9402, @c2_user_id, 'P04_CASO2_Trabajo', 'JEIG (Recepción Trabajo)', '7640000002', 'Entregar en oficina, recepción edificio B (no domicilio particular)', 0, b'1', NOW(), NOW());

-- Paso 4-5: Tarjeta de crédito (16 dígitos) y 6 pagos mensuales; activar rol buyer
INSERT INTO tbd_user_payment_methods (id_user_payment_method, id_user, id_payment_method_type, provider, provider_method_ref, label, last_four, is_default, status, creation_date, last_update)
VALUES (9402, @c2_user_id, 9102, 'BancoSim Credito', 'P04REF-5222222222222222', 'P04_CASO2_Tarjeta_Credito', '2222', 1, b'1', NOW(), NOW());

-- SET ROLE 'buyer';
UPDATE tb_users SET roles = 'buyer', last_update = NOW() WHERE id_user = @c2_user_id;
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_users', 'Update', 'AppWeb/AppMobile->buyer', 'P04_CASO2: usuario id=2 (JEIG) activó rol buyer al registrar pagos mensuales', b'1');

-- Paso 6: 6 pagos mensuales (5 autorizados, 6to rechazado por "límite excedido de crédito")
INSERT INTO tb_payments (id_payment, id_buyer_order, id_user_payment_method, amount, currency, status, paid_at) VALUES
  (940201, 9402, 9402, 10786.95, 'MXN', 'completed', NOW()),
  (940202, 9402, 9402, 10786.95, 'MXN', 'completed', NOW()),
  (940203, 9402, 9402, 10786.95, 'MXN', 'completed', NOW()),
  (940204, 9402, 9402, 10786.95, 'MXN', 'completed', NOW()),
  (940205, 9402, 9402, 10786.95, 'MXN', 'completed', NOW()),
  (940206, 9402, 9402, 10786.92, 'MXN', 'failed',    NULL);

INSERT INTO tb_payment_transactions (id_transaction, id_payment, gateway_name, gateway_transaction_id, response_code, raw_response, created_at) VALUES
  (940201, 940201, 'BancoSim', 'P04-C2-TX-0001', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','installment',1,'card_last4','2222'), NOW()),
  (940202, 940202, 'BancoSim', 'P04-C2-TX-0002', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','installment',2,'card_last4','2222'), NOW()),
  (940203, 940203, 'BancoSim', 'P04-C2-TX-0003', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','installment',3,'card_last4','2222'), NOW()),
  (940204, 940204, 'BancoSim', 'P04-C2-TX-0004', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','installment',4,'card_last4','2222'), NOW()),
  (940205, 940205, 'BancoSim', 'P04-C2-TX-0005', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','installment',5,'card_last4','2222'), NOW()),
  (940206, 940206, 'BancoSim', 'P04-C2-TX-0006', 'DECLINED_LIMIT_EXCEEDED', JSON_OBJECT('result','REJECTED','installment',6,'reason','límite excedido de crédito','card_last4','2222'), NOW());

-- Paso 7: Orden atendida + inventario
UPDATE tb_buyer_orders SET fulfillment_status = 'Delivered', last_update = NOW() WHERE id_buyer_order = 9402;
UPDATE tb_products SET current_stock = current_stock - 1 WHERE id_product = 1;
UPDATE tb_products SET current_stock = current_stock - 2 WHERE id_product = 2;
UPDATE tb_products SET current_stock = current_stock - 3 WHERE id_product = 3;
UPDATE tb_products SET current_stock = current_stock - 1 WHERE id_product = 4;
UPDATE tb_products SET current_stock = current_stock - 4 WHERE id_product = 5;
UPDATE tb_products SET current_stock = current_stock - 2 WHERE id_product = 6;
UPDATE tb_products SET current_stock = current_stock - 5 WHERE id_product = 8;
UPDATE tb_products SET current_stock = current_stock - 3 WHERE id_product = 10;
UPDATE tb_products SET current_stock = current_stock - 1 WHERE id_product = 11;
UPDATE tb_products SET current_stock = current_stock - 2 WHERE id_product = 12;

-- Paso 8: Entrega en destino
INSERT INTO tb_shipments (id_shipment, id_buyer_order, id_carrier, id_user_adress, tracking_number, shipping_cost, status, shipped_at, delivered_at)
VALUES (9402, 9402, 9201, 9402, 'P04-C2-SHIP-0001', @c2_shipping, 'delivered', NOW(), NOW());

-- Paso 9: Reclamación/devolución de un producto dañado (id_product 6, Vertex Impresora Ultra, 1 pieza)
SET @c2_item_damaged := (SELECT id_order_item FROM tbd_order_items WHERE id_order_seller = 9402 AND id_product = 6 LIMIT 1);
INSERT INTO tb_order_returns (id_return, id_buyer_order, id_user, reason, status, created_at)
VALUES (9402, 9402, @c2_user_id, 'P04_CASO2: Reclamación - producto llegó dañado (Vertex Impresora Ultra)', 'completed', NOW());
INSERT INTO tbd_return_items (id_return_item, id_return, id_order_item, quantity, refund_amount)
VALUES (9402, 9402, @c2_item_damaged, 1, 0.00);
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_order_returns', 'Create', 'SYSTEM/USER', 'P04_CASO2: reclamación registrada y aprobada por daño en producto (orden 9402, item impresora)', b'1');

-- Paso 10: Reenvío del producto en buenas condiciones
INSERT INTO tb_shipments (id_shipment, id_buyer_order, id_carrier, id_user_adress, tracking_number, shipping_cost, status, shipped_at, delivered_at)
VALUES (94021, 9402, 9201, 9402, 'P04-C2-SHIP-0002-REENVIO', 0.00, 'delivered', NOW(), NOW());
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_shipments', 'Create', 'SYSTEM', 'P04_CASO2: reenvío realizado del producto dañado en buenas condiciones (tracking P04-C2-SHIP-0002-REENVIO)', b'1');

COMMIT;

-- ============================================================
-- CASO 3: Compra exitosa con cancelación parcial, ajuste y reembolso parcial
-- Usuario registrado (id 5, SARA), 3 productos misma categoría, envío "Casa Papas",
-- Spin, pago único, atendida, cancela 1 producto, ajuste de orden, reembolso parcial, envío y entrega.
-- ============================================================
START TRANSACTION;
SET @c3_user_id := 5;

-- Paso 1: Carrito 3 productos de la misma categoría (cat 1 / Electrónica en mapeo) con cantidades 1-10
INSERT INTO tb_carts (id_carts, user_ID, status, creation_date, last_update) VALUES (9403, @c3_user_id, b'1', NOW(), NOW());
INSERT INTO tbd_carts_items (id_cart, id_provider, id_product, quantity, creation_date) VALUES
  (9403, 7, 3,  2, NOW()), -- HyperX Micrófono Plus (cat 1)
  (9403, 7, 5,  5, NOW()), -- Apex Lámpara LED Premium (cat 1)
  (9403, 7, 13, 1, NOW()); -- HyperX Lámpara LED Ultra (cat 1)

-- Paso 2: Orden de compra
SET @c3_subtotal := (1704.07*2 + 1881.37*5 + 4549.24*1); -- 17364.23
SET @c3_shipping := 120.00;
INSERT INTO tb_buyer_orders (id_buyer_order, seller_ID, subtotal, shipping_cost, fulfillment_status, status, creation_date, last_update)
VALUES (9403, 7, @c3_subtotal, @c3_shipping, 'Pending', b'1', NOW(), NOW());
INSERT INTO tbd_order_items (id_order_seller, id_product, id_provider, product_name, quantity, unit_price, creation_date) VALUES
  (9403, 3,  7, 'HyperX Micrófono Plus', 2, 1704.07, NOW()),
  (9403, 5,  7, 'Apex Lámpara LED Premium', 5, 1881.37, NOW()),
  (9403, 13, 7, 'HyperX Lámpara LED Ultra', 1, 4549.24, NOW());

-- Paso 3: Domicilio distinto al hogar "Casa Papas"
INSERT INTO tb_user_addresses (id_user_adress, id_user, address_label, recipient_name, recipient_phone, delivery_instructions, is_default, status, creation_date, last_update)
VALUES (9403, @c3_user_id, 'P04_CASO3_Casa Papas', 'Familia de SARA', '7640000003', 'Enviar a Casa Papas (domicilio alterno), avisar antes de llegar', 0, b'1', NOW(), NOW());

-- Paso 4-5: Tarjeta digital Spin y pago único total
INSERT INTO tbd_user_payment_methods (id_user_payment_method, id_user, id_payment_method_type, provider, provider_method_ref, label, last_four, is_default, status, creation_date, last_update)
VALUES (9403, @c3_user_id, 9103, 'Spin', 'P04REF-5333333333333333', 'P04_CASO3_Spin_Digital', '3333', 1, b'1', NOW(), NOW());

-- SET ROLE 'buyer';
UPDATE tb_users SET roles = 'buyer', last_update = NOW() WHERE id_user = @c3_user_id;
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_users', 'Update', 'AppWeb/AppMobile->buyer', 'P04_CASO3: usuario id=5 (SARA) activó rol buyer al pagar con Spin', b'1');

INSERT INTO tb_payments (id_payment, id_buyer_order, id_user_payment_method, amount, currency, status, paid_at)
VALUES (9403, 9403, 9403, @c3_subtotal + @c3_shipping, 'MXN', 'completed', NOW());
INSERT INTO tb_payment_transactions (id_transaction, id_payment, gateway_name, gateway_transaction_id, response_code, raw_response, created_at)
VALUES (9403, 9403, 'SpinGateway', 'P04-C3-TX-0001', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','method','Spin','card_last4','3333'), NOW());

-- Paso 6: Orden atendida + inventario original
UPDATE tb_buyer_orders SET fulfillment_status = 'Accepted', last_update = NOW() WHERE id_buyer_order = 9403;
UPDATE tb_products SET current_stock = current_stock - 2 WHERE id_product = 3;
UPDATE tb_products SET current_stock = current_stock - 5 WHERE id_product = 5;
UPDATE tb_products SET current_stock = current_stock - 1 WHERE id_product = 13;

-- Paso 7: Cancelación de un producto del pedido (producto 13, qty 1)
SET @c3_item_cancel := (SELECT id_order_item FROM tbd_order_items WHERE id_order_seller = 9403 AND id_product = 13 LIMIT 1);
SET @c3_refund_amount := 4549.24;
INSERT INTO tb_order_cancellations (id_order_cancellation, id_user, reason, cancelled_by, status, creation_date, last_update)
VALUES (9403, @c3_user_id, 'P04_CASO3: Cancelación parcial de producto por solicitud del cliente', 'buyer:5(SARA)', 1, NOW(), NOW());
INSERT INTO tbd_cancellation_items (id_cancellation_item, id_order_cancellation, id_order_item, quantity, reason, status, creation_date, last_update)
VALUES (9403, 9403, @c3_item_cancel, 1, 'P04_CASO3: Producto cancelado del pedido (HyperX Lámpara LED Ultra)', 1, NOW(), NOW());

-- Paso 8: Actualización de la orden de compra (ajuste de totales/detalles)
UPDATE tb_buyer_orders SET subtotal = subtotal - @c3_refund_amount, last_update = NOW() WHERE id_buyer_order = 9403;
-- Reintegro de inventario del artículo cancelado
UPDATE tb_products SET current_stock = current_stock + 1 WHERE id_product = 13;
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_buyer_orders', 'Update', 'SYSTEM', 'P04_CASO3: orden 9403 ajustada por cancelación parcial (-4549.24 subtotal) y reintegro de inventario prod 13', b'1');

-- Paso 9: Reembolso parcial del monto del producto cancelado
INSERT INTO tb_payments (id_payment, id_buyer_order, id_user_payment_method, amount, currency, status, paid_at)
VALUES (94031, 9403, 9403, @c3_refund_amount, 'MXN', 'refunded', NOW());
INSERT INTO tb_payment_transactions (id_transaction, id_payment, gateway_name, gateway_transaction_id, response_code, raw_response, created_at)
VALUES (94031, 94031, 'SpinGateway', 'P04-C3-TX-0002-REFUND', 'REFUNDED', JSON_OBJECT('result','REFUNDED','type','partial_refund','amount',@c3_refund_amount,'reason','P04_CASO3 cancelación parcial'), NOW());

-- Paso 10-11: Envío y recepción en destino (Casa Papas)
UPDATE tb_buyer_orders SET fulfillment_status = 'Delivered', last_update = NOW() WHERE id_buyer_order = 9403;
INSERT INTO tb_shipments (id_shipment, id_buyer_order, id_carrier, id_user_adress, tracking_number, shipping_cost, status, shipped_at, delivered_at)
VALUES (9403, 9403, 9201, 9403, 'P04-C3-SHIP-0001', @c3_shipping, 'delivered', NOW(), NOW());
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_shipments', 'Create', 'SYSTEM', 'P04_CASO3: pedido enviado y entregado en "Casa Papas" tras cancelación parcial y reembolso', b'1');

COMMIT;

-- ============================================================
-- CASO 4: Compra exitosa del mismo proveedor con entrega en punto de recolección
-- Usuario registrado (id 9, Dara), 3 productos del mismo proveedor, envío a hogar,
-- SPEI, pago único, atendida, intento fallido en domicilio y recolección en punto.
-- ============================================================
START TRANSACTION;
SET @c4_user_id := 9;

-- Paso 1: Carrito 3 productos del mismo proveedor (Proveedor 4 / seller 7) qty 1-3
INSERT INTO tb_carts (id_carts, user_ID, status, creation_date, last_update) VALUES (9404, @c4_user_id, b'1', NOW(), NOW());
INSERT INTO tbd_carts_items (id_cart, id_provider, id_product, quantity, creation_date) VALUES
  (9404, 7, 4,  1, NOW()), -- LogiTech Headset Gamer Lite (Proveedor 4)
  (9404, 7, 54, 2, NOW()), -- LogiTech Calculadora Premium (Proveedor 4)
  (9404, 7, 79, 3, NOW()); -- Maxlink Repetidor WiFi Pro (Proveedor 4)

-- Paso 2: Orden de compra
SET @c4_subtotal := (1020.80*1 + 637.88*2 + 1129.82*3); -- 5686.02
SET @c4_shipping := 99.00;
INSERT INTO tb_buyer_orders (id_buyer_order, seller_ID, subtotal, shipping_cost, fulfillment_status, status, creation_date, last_update)
VALUES (9404, 7, @c4_subtotal, @c4_shipping, 'Pending', b'1', NOW(), NOW());
INSERT INTO tbd_order_items (id_order_seller, id_product, id_provider, product_name, quantity, unit_price, creation_date) VALUES
  (9404, 4,  7, 'LogiTech Headset Gamer Lite', 1, 1020.80, NOW()),
  (9404, 54, 7, 'LogiTech Calculadora Premium', 2, 637.88, NOW()),
  (9404, 79, 7, 'Maxlink Repetidor WiFi Pro', 3, 1129.82, NOW());

-- Paso 3: Domicilio correspondiente al hogar
INSERT INTO tb_user_addresses (id_user_adress, id_user, address_label, recipient_name, recipient_phone, delivery_instructions, is_default, status, creation_date, last_update)
VALUES (9404, @c4_user_id, 'P04_CASO4_Hogar', 'Dara (Hogar)', '7640000004', 'Domicilio particular; si no hay quien reciba, redirigir a punto de recolección MercadoExpress', 1, b'1', NOW(), NOW());

-- Paso 4-5: Transferencia SPEI (cuenta/referencia simulada 16 dígitos) y pago único
INSERT INTO tbd_user_payment_methods (id_user_payment_method, id_user, id_payment_method_type, provider, provider_method_ref, label, last_four, is_default, status, creation_date, last_update)
VALUES (9404, @c4_user_id, 9104, 'SPEI', 'P04REF-0123456789012345', 'P04_CASO4_SPEI', '2345', 1, b'1', NOW(), NOW());

-- SET ROLE 'buyer';
UPDATE tb_users SET roles = 'buyer', last_update = NOW() WHERE id_user = @c4_user_id;
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_users', 'Update', 'AppWeb/AppMobile->buyer', 'P04_CASO4: usuario id=9 (Dara) activó rol buyer al pagar por SPEI', b'1');

INSERT INTO tb_payments (id_payment, id_buyer_order, id_user_payment_method, amount, currency, status, paid_at)
VALUES (9404, 9404, 9404, @c4_subtotal + @c4_shipping, 'MXN', 'completed', NOW());
INSERT INTO tb_payment_transactions (id_transaction, id_payment, gateway_name, gateway_transaction_id, response_code, raw_response, created_at)
VALUES (9404, 9404, 'SPEI', 'P04-C4-TX-0001', 'AUTHORIZED', JSON_OBJECT('result','AUTHORIZED','method','SPEI','reference','0123456789012345'), NOW());

-- Paso 6: Orden atendida + inventario
UPDATE tb_buyer_orders SET fulfillment_status = 'Sent', last_update = NOW() WHERE id_buyer_order = 9404;
UPDATE tb_products SET current_stock = current_stock - 1 WHERE id_product = 4;
UPDATE tb_products SET current_stock = current_stock - 2 WHERE id_product = 54;
UPDATE tb_products SET current_stock = current_stock - 3 WHERE id_product = 79;

-- Paso 7-8: Envío, intento fallido en domicilio y recolección en punto
INSERT INTO tb_shipments (id_shipment, id_buyer_order, id_carrier, id_user_adress, tracking_number, shipping_cost, status, shipped_at, delivered_at)
VALUES (9404, 9404, 9202, 9404, 'P04-C4-SHIP-0001', @c4_shipping, 'in_transit', NOW(), NULL);
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_shipments', 'Update', 'CARRIER', 'P04_CASO4: intento de entrega fallido en domicilio (no hubo quien recibiera), paquete disponible en punto de recolección MercadoExpress', b'1');
UPDATE tb_shipments SET status = 'delivered', delivered_at = NOW()
WHERE id_shipment = 9404;
UPDATE tb_buyer_orders SET fulfillment_status = 'Delivered', last_update = NOW() WHERE id_buyer_order = 9404;
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_shipments', 'Update', 'CARRIER', 'P04_CASO4: cliente recogió el pedido en punto de recolección (entrega final completada)', b'1');

COMMIT;

-- ============================================================
-- CASO 5: Compra fallida por falta de inventario
-- Usuario registrado (id 12, Aaron), 1 producto proveedor específico qty 1-5
-- superior al stock disponible, domicilio hogar, cupón de regalo,
-- orden no atendida por falta de inventario, cancelada y cupón reactivado.
-- ============================================================
START TRANSACTION;
SET @c5_user_id := 12;

-- Paso 1: Carrito con 1 producto (stock=1) y cantidad solicitada 3 (> stock)
INSERT INTO tb_carts (id_carts, user_ID, status, creation_date, last_update) VALUES (9405, @c5_user_id, b'1', NOW(), NOW());
INSERT INTO tbd_carts_items (id_cart, id_provider, id_product, quantity, creation_date) VALUES
  (9405, 7, 329, 3, NOW()); -- Maxlink Webcam Max (Proveedor 4), stock disponible 1

-- Paso 2: Orden de compra (intento)
SET @c5_subtotal := (2534.59*3); -- 7603.77
SET @c5_shipping := 0.00;
INSERT INTO tb_buyer_orders (id_buyer_order, seller_ID, subtotal, shipping_cost, fulfillment_status, status, creation_date, last_update)
VALUES (9405, 7, @c5_subtotal, @c5_shipping, 'Pending', b'1', NOW(), NOW());
INSERT INTO tbd_order_items (id_order_seller, id_product, id_provider, product_name, quantity, unit_price, creation_date) VALUES
  (9405, 329, 7, 'Maxlink Webcam Max', 3, 2534.59, NOW());

-- Paso 3: Domicilio correspondiente al hogar
INSERT INTO tb_user_addresses (id_user_adress, id_user, address_label, recipient_name, recipient_phone, delivery_instructions, is_default, status, creation_date, last_update)
VALUES (9405, @c5_user_id, 'P04_CASO5_Hogar', 'Aaron (Hogar)', '7640000005', 'Domicilio particular', 1, b'1', NOW(), NOW());

-- Paso 4: Método de pago cupón de regalo
INSERT INTO tbd_user_payment_methods (id_user_payment_method, id_user, id_payment_method_type, provider, provider_method_ref, label, last_four, is_default, status, creation_date, last_update)
VALUES (9405, @c5_user_id, 9105, 'GiftCard', 'P04REF-GIFT-9405-7610', 'P04_CASO5_Cupon_Regalo', '7610', 1, b'1', NOW(), NOW());

-- Paso 5: Procesamiento falla por falta de inventario (stock 1 < solicitado 3), no se descuenta inventario
UPDATE tb_buyer_orders SET fulfillment_status = 'Canceled', status = b'0', last_update = NOW() WHERE id_buyer_order = 9405;
INSERT INTO tb_order_cancellations (id_order_cancellation, id_user, reason, cancelled_by, status, creation_date, last_update)
VALUES (9405, @c5_user_id, 'P04_CASO5: Orden no atendida/cancelada por falta de inventario (stock insuficiente)', 'SYSTEM', 1, NOW(), NOW());
INSERT INTO tbd_cancellation_items (id_cancellation_item, id_order_cancellation, id_order_item, quantity, reason, status, creation_date, last_update)
SELECT 9405, 9405, oi.id_order_item, oi.quantity, 'P04_CASO5: Sin stock suficiente para surtir la cantidad solicitada', 1, NOW(), NOW()
FROM tbd_order_items oi WHERE oi.id_order_seller = 9405 AND oi.id_product = 329;

INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tb_buyer_orders', 'Update', 'SYSTEM', 'P04_CASO5: compra fallida por falta de inventario (prod 329, stock 1, solicitado 3), orden cancelada/no atendida', b'0');

-- Paso 6: Cupón utilizado en intento -> reasignado/reactivado al usuario
UPDATE tbd_user_payment_methods SET status = b'0', last_update = NOW() WHERE id_user_payment_method = 9405; -- marcado como usado en intento
UPDATE tbd_user_payment_methods SET status = b'1', last_update = NOW() WHERE id_user_payment_method = 9405; -- reactivado/reasignado
INSERT INTO tb_logs (table_name, table_operation, db_user, table_description, operation_status)
VALUES ('tbd_user_payment_methods', 'Update', 'SYSTEM', 'P04_CASO5: cupón de regalo (P04REF-GIFT-9405-7610) reasignado/reactivado al usuario tras cancelación por falta de inventario', b'1');

COMMIT;

SET SQL_SAFE_UPDATES = @OLD_SQL_SAFE_UPDATES;

-- Fin de simulaciones. Consultar Practicas04/02_vistas_casos.sql para las vistas y SELECTs de verificación.
