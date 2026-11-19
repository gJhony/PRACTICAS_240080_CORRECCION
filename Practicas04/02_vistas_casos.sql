-- Práctica 04: Vistas de trazabilidad para los 5 casos de simulación
-- Base: db_test_7b (MySQL 8.0)

USE db_test_7b;

-- ============================================================
-- CASO 1: Compra exitosa, sin modificaciones
-- Flujo completo: usuario nuevo, cambio de rol a buyer, 5 productos,
-- carrito, orden, domicilio, método de pago (débito), pago autorizado y entrega en casa.
-- ============================================================
CREATE OR REPLACE VIEW vw_caso1_compra_exitosa AS
SELECT
  u.id_user,
  u.nick,
  u.email,
  u.roles AS rol_actual,
  p.given_names,
  p.family_names,
  (SELECT GROUP_CONCAT(DISTINCT l.table_description ORDER BY l.operation_date SEPARATOR ' || ')
     FROM tb_logs l
    WHERE l.table_description LIKE 'P04_CASO1:%'
      AND l.table_description LIKE '%rol buyer%') AS cambio_rol_buyer_evidencia,
  c.id_carts AS id_carrito,
  c.creation_date AS fecha_carrito,
  bo.id_buyer_order AS id_orden,
  bo.seller_ID AS id_vendedor_fulfillment,
  bo.subtotal,
  bo.shipping_cost,
  (bo.subtotal + bo.shipping_cost) AS total_orden,
  bo.fulfillment_status AS estatus_orden,
  ua.id_user_adress AS id_domicilio,
  ua.address_label AS domicilio_envio,
  ua.recipient_name AS destinatario,
  ua.delivery_instructions AS instrucciones_entrega,
  pm.id_user_payment_method AS id_metodo_pago,
  pmt.code AS tipo_metodo_pago_codigo,
  pmt.description AS tipo_metodo_pago,
  pm.provider AS proveedor_metodo,
  pm.provider_method_ref AS cuenta_referencia_16d,
  pm.last_four AS ultimos_4,
  pay.id_payment,
  pay.amount AS monto_pago,
  pay.currency AS moneda,
  pay.status AS estatus_pago,
  pay.paid_at AS fecha_pago,
  (SELECT GROUP_CONCAT(CONCAT(tx.id_transaction, '[', tx.gateway_transaction_id, '] resp=', tx.response_code,
                              ' resultado=', JSON_UNQUOTE(JSON_EXTRACT(tx.raw_response, '$.result')))
                      ORDER BY tx.id_transaction SEPARATOR ' | ')
     FROM tb_payment_transactions tx
    WHERE tx.id_payment = pay.id_payment) AS transacciones_bancarias,
  sh.id_shipment,
  sc.name AS paqueteria,
  sh.tracking_number,
  sh.status AS estatus_envio,
  sh.shipped_at AS fecha_envio,
  sh.delivered_at AS fecha_entrega,
  (SELECT COUNT(*) FROM tbd_order_items oi WHERE oi.id_order_seller = bo.id_buyer_order) AS cantidad_lineas_productos,
  (SELECT GROUP_CONCAT(CONCAT('Prod#', pr.id_product, ' ', pr.name, ' (SKU:', pr.sku, ', ', pr.category,
                              ') x', oi.quantity, ' @', oi.unit_price, ' = ', oi.subtotal)
                      ORDER BY oi.id_order_item SEPARATOR ' | ')
     FROM tbd_order_items oi
     JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS detalle_productos,
  (SELECT GROUP_CONCAT(CONCAT('Prod#', pr.id_product, ' stock_actual=', pr.current_stock)
                      ORDER BY pr.id_product SEPARATOR ' | ')
     FROM tbd_order_items oi
     JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS movimiento_inventario_actual
FROM tb_users u
JOIN tb_people p ON p.id_user = u.id_user
JOIN tb_carts c ON c.user_ID = u.id_user AND c.id_carts = 9401
JOIN tb_buyer_orders bo ON bo.id_buyer_order = 9401
JOIN tb_user_addresses ua ON ua.id_user_adress = 9401 AND ua.id_user = u.id_user
JOIN tbd_user_payment_methods pm ON pm.id_user_payment_method = 9401 AND pm.id_user = u.id_user
JOIN tbc_payment_methods_types pmt ON pmt.id_payment_method_type = pm.id_payment_method_type
JOIN tb_payments pay ON pay.id_payment = 9401 AND pay.id_buyer_order = bo.id_buyer_order
LEFT JOIN tb_shipments sh ON sh.id_shipment = 9401 AND sh.id_buyer_order = bo.id_buyer_order
LEFT JOIN tbc_shipping_carriers sc ON sc.id_carrier = sh.id_carrier
WHERE u.email = 'caso1.nuevo.p04@utxicotepec.edu.mx';

-- ============================================================
-- CASO 2: Compra con detalles en el último pago y con reclamación y reenvío
-- 10 productos, 5 pagos autorizados vs 6to rechazado por límite de crédito,
-- reclamación por daño y reenvío.
-- ============================================================
CREATE OR REPLACE VIEW vw_caso2_reclamacion_reenvio AS
SELECT
  u.id_user,
  u.nick,
  u.email,
  u.roles AS rol_actual,
  (SELECT GROUP_CONCAT(DISTINCT l.table_description ORDER BY l.operation_date SEPARATOR ' || ')
     FROM tb_logs l
    WHERE l.table_description LIKE 'P04_CASO2:%'
      AND l.table_description LIKE '%rol buyer%') AS cambio_rol_buyer_evidencia,
  c.id_carts AS id_carrito,
  bo.id_buyer_order AS id_orden,
  bo.subtotal,
  bo.shipping_cost,
  (bo.subtotal + bo.shipping_cost) AS total_orden,
  bo.fulfillment_status AS estatus_orden,
  ua.address_label AS domicilio_envio,
  ua.delivery_instructions AS detalle_destino,
  pm.label AS metodo_pago,
  pmt.description AS tipo_metodo_pago,
  pm.provider_method_ref AS cuenta_referencia_16d,
  pm.last_four AS ultimos_4,
  (SELECT COUNT(*) FROM tbd_order_items oi WHERE oi.id_order_seller = bo.id_buyer_order) AS cantidad_lineas_productos,
  (SELECT SUM(oi.quantity) FROM tbd_order_items oi WHERE oi.id_order_seller = bo.id_buyer_order) AS cantidad_total_unidades,
  (SELECT GROUP_CONCAT(CONCAT('Prod#', pr.id_product, ' ', pr.name, ' x', oi.quantity, ' @', oi.unit_price)
                      ORDER BY oi.id_order_item SEPARATOR ' | ')
     FROM tbd_order_items oi
     JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS detalle_10_productos,
  (SELECT COUNT(*) FROM tb_payments pay WHERE pay.id_buyer_order = bo.id_buyer_order) AS total_pagos_registrados,
  (SELECT GROUP_CONCAT(CONCAT('Pago#', pay.id_payment, ' monto=', pay.amount, ' estado=', pay.status,
                              IFNULL(CONCAT(' pagado=', pay.paid_at), ''))
                      ORDER BY pay.id_payment SEPARATOR ' | ')
     FROM tb_payments pay
    WHERE pay.id_buyer_order = bo.id_buyer_order) AS detalle_pagos,
  (SELECT GROUP_CONCAT(CONCAT('Tx ', tx.gateway_transaction_id, ' (pago ', tx.id_payment, ') resp=', tx.response_code,
                              ' motivo=', IFNULL(JSON_UNQUOTE(JSON_EXTRACT(tx.raw_response, '$.reason')),
                                                 JSON_UNQUOTE(JSON_EXTRACT(tx.raw_response, '$.result'))))
                      ORDER BY tx.id_transaction SEPARATOR ' | ')
     FROM tb_payment_transactions tx
     JOIN tb_payments pay ON pay.id_payment = tx.id_payment
    WHERE pay.id_buyer_order = bo.id_buyer_order) AS transacciones_autorizadas_y_rechazadas,
  (SELECT GROUP_CONCAT(CONCAT('Return#', r.id_return, ' estado=', r.status, ' motivo=', r.reason,
                              ' items=', IFNULL(ri_det.items, ''))
                      ORDER BY r.id_return SEPARATOR ' || ')
     FROM tb_order_returns r
     LEFT JOIN (
       SELECT ri.id_return,
              GROUP_CONCAT(CONCAT('oi=', ri.id_order_item, ' prod=', oi.id_product, ' qty=', ri.quantity,
                                  ' refund=', ri.refund_amount) SEPARATOR ', ') AS items
         FROM tbd_return_items ri
         JOIN tbd_order_items oi ON oi.id_order_item = ri.id_order_item
        GROUP BY ri.id_return
     ) ri_det ON ri_det.id_return = r.id_return
    WHERE r.id_buyer_order = bo.id_buyer_order) AS reclamaciones_y_devoluciones,
  (SELECT GROUP_CONCAT(CONCAT('Ship#', sh.id_shipment, ' tracking=', sh.tracking_number,
                              ' carrier=', sc.name, ' estado=', sh.status,
                              ' enviado=', IFNULL(sh.shipped_at, 'N/A'),
                              ' entregado=', IFNULL(sh.delivered_at, 'N/A'))
                      ORDER BY sh.id_shipment SEPARATOR ' | ')
     FROM tb_shipments sh
     LEFT JOIN tbc_shipping_carriers sc ON sc.id_carrier = sh.id_carrier
    WHERE sh.id_buyer_order = bo.id_buyer_order) AS envios_y_reenvio,
  (SELECT GROUP_CONCAT(DISTINCT l.table_description ORDER BY l.operation_date SEPARATOR ' || ')
     FROM tb_logs l
    WHERE l.table_description LIKE 'P04_CASO2:%'
      AND (l.table_description LIKE '%reclamación%' OR l.table_description LIKE '%reenvío%')) AS evidencia_reclamacion_reenvio
FROM tb_users u
JOIN tb_carts c ON c.user_ID = u.id_user AND c.id_carts = 9402
JOIN tb_buyer_orders bo ON bo.id_buyer_order = 9402
JOIN tb_user_addresses ua ON ua.id_user_adress = 9402 AND ua.id_user = u.id_user
JOIN tbd_user_payment_methods pm ON pm.id_user_payment_method = 9402 AND pm.id_user = u.id_user
JOIN tbc_payment_methods_types pmt ON pmt.id_payment_method_type = pm.id_payment_method_type
WHERE u.id_user = 2;

-- ============================================================
-- CASO 3: Compra exitosa con cancelación parcial, ajuste y reembolso parcial
-- Compra original, producto cancelado, ajuste del total de la orden,
-- reembolso parcial y entrega.
-- ============================================================
CREATE OR REPLACE VIEW vw_caso3_cancelacion_reembolso AS
SELECT
  u.id_user,
  u.nick,
  u.email,
  u.roles AS rol_actual,
  c.id_carts AS id_carrito,
  bo.id_buyer_order AS id_orden,
  bo.subtotal AS subtotal_orden_actual_ajustado,
  bo.shipping_cost,
  (bo.subtotal + bo.shipping_cost) AS total_orden_actual,
  bo.fulfillment_status AS estatus_orden,
  ua.address_label AS domicilio_envio,
  ua.delivery_instructions AS instrucciones_entrega,
  pm.label AS metodo_pago,
  pmt.description AS tipo_metodo_pago,
  pm.provider_method_ref AS cuenta_referencia_16d,
  (SELECT SUM(oi.subtotal) FROM tbd_order_items oi WHERE oi.id_order_seller = bo.id_buyer_order) AS subtotal_compra_original_items,
  (SELECT GROUP_CONCAT(CONCAT('Prod#', pr.id_product, ' ', pr.name, ' (cat_id=', pc.id_category, ') x', oi.quantity,
                              ' @', oi.unit_price, ' = ', oi.subtotal)
                      ORDER BY oi.id_order_item SEPARATOR ' | ')
     FROM tbd_order_items oi
     JOIN tb_products pr ON pr.id_product = oi.id_product
     LEFT JOIN tbd_products_categories pc ON pc.id_product = pr.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS detalle_compra_original,
  (SELECT GROUP_CONCAT(CONCAT('Cancel#', oc.id_order_cancellation, ' por=', oc.cancelled_by, ' motivo=', oc.reason,
                              ' items=', IFNULL(ci_det.items, ''))
                      ORDER BY oc.id_order_cancellation SEPARATOR ' || ')
     FROM tb_order_cancellations oc
     LEFT JOIN (
       SELECT ci.id_order_cancellation,
              GROUP_CONCAT(CONCAT('oi=', ci.id_order_item, ' prod=', oi.id_product, ' qty=', ci.quantity,
                                  ' razon=', ci.reason) SEPARATOR ', ') AS items
         FROM tbd_cancellation_items ci
         JOIN tbd_order_items oi ON oi.id_order_item = ci.id_order_item
        GROUP BY ci.id_order_cancellation
     ) ci_det ON ci_det.id_order_cancellation = oc.id_order_cancellation
    WHERE oc.id_user = u.id_user AND oc.reason LIKE 'P04_CASO3:%') AS cancelacion_parcial,
  (SELECT GROUP_CONCAT(CONCAT('Pago#', pay.id_payment, ' monto=', pay.amount, ' estado=', pay.status,
                              ' pagado=', IFNULL(pay.paid_at, 'N/A'))
                      ORDER BY pay.id_payment SEPARATOR ' | ')
     FROM tb_payments pay
    WHERE pay.id_buyer_order = bo.id_buyer_order) AS pagos_y_reembolsos,
  (SELECT GROUP_CONCAT(CONCAT('Tx ', tx.gateway_transaction_id, ' pago=', tx.id_payment, ' resp=', tx.response_code,
                              ' resultado=', IFNULL(JSON_UNQUOTE(JSON_EXTRACT(tx.raw_response, '$.result')), 'N/A'),
                              ' tipo=', IFNULL(JSON_UNQUOTE(JSON_EXTRACT(tx.raw_response, '$.type')), 'pago'))
                      ORDER BY tx.id_transaction SEPARATOR ' | ')
     FROM tb_payment_transactions tx
     JOIN tb_payments pay ON pay.id_payment = tx.id_payment
    WHERE pay.id_buyer_order = bo.id_buyer_order) AS transacciones_pago_y_reembolso,
  (SELECT GROUP_CONCAT(CONCAT('Ship#', sh.id_shipment, ' tracking=', sh.tracking_number,
                              ' estado=', sh.status, ' entregado=', IFNULL(sh.delivered_at, 'N/A'))
                      ORDER BY sh.id_shipment SEPARATOR ' | ')
     FROM tb_shipments sh
    WHERE sh.id_buyer_order = bo.id_buyer_order) AS envio_y_entrega,
  (SELECT GROUP_CONCAT(CONCAT('Prod#', pr.id_product, ' stock_actual=', pr.current_stock)
                      ORDER BY pr.id_product SEPARATOR ' | ')
     FROM tbd_order_items oi
     JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS movimiento_inventario_actual
FROM tb_users u
JOIN tb_carts c ON c.user_ID = u.id_user AND c.id_carts = 9403
JOIN tb_buyer_orders bo ON bo.id_buyer_order = 9403
JOIN tb_user_addresses ua ON ua.id_user_adress = 9403 AND ua.id_user = u.id_user
JOIN tbd_user_payment_methods pm ON pm.id_user_payment_method = 9403 AND pm.id_user = u.id_user
JOIN tbc_payment_methods_types pmt ON pmt.id_payment_method_type = pm.id_payment_method_type
WHERE u.id_user = 5;

-- ============================================================
-- CASO 4: Compra exitosa del mismo proveedor con entrega en punto de recolección
-- 3 productos del mismo proveedor, pago SPEI, intento fallido en domicilio
-- y recolección final en punto.
-- ============================================================
CREATE OR REPLACE VIEW vw_caso4_punto_recoleccion AS
SELECT
  u.id_user,
  u.nick,
  u.email,
  u.roles AS rol_actual,
  c.id_carts AS id_carrito,
  bo.id_buyer_order AS id_orden,
  bo.subtotal,
  bo.shipping_cost,
  (bo.subtotal + bo.shipping_cost) AS total_orden,
  bo.fulfillment_status AS estatus_orden,
  ua.address_label AS domicilio_registrado_hogar,
  ua.delivery_instructions AS instrucciones_domicilio,
  pm.label AS metodo_pago,
  pmt.code AS tipo_metodo_pago_codigo,
  pmt.description AS tipo_metodo_pago,
  pm.provider_method_ref AS cuenta_referencia_spei_16d,
  pay.id_payment,
  pay.amount AS monto_pago,
  pay.status AS estatus_pago,
  (SELECT GROUP_CONCAT(CONCAT(tx.gateway_transaction_id, ' resp=', tx.response_code,
                              ' metodo=', JSON_UNQUOTE(JSON_EXTRACT(tx.raw_response, '$.method')),
                              ' ref=', JSON_UNQUOTE(JSON_EXTRACT(tx.raw_response, '$.reference')))
                      ORDER BY tx.id_transaction SEPARATOR ' | ')
     FROM tb_payment_transactions tx
    WHERE tx.id_payment = pay.id_payment) AS transaccion_spei,
  (SELECT COUNT(DISTINCT pr.provider) FROM tbd_order_items oi JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS cantidad_proveedores_distintos,
  (SELECT GROUP_CONCAT(DISTINCT pr.provider ORDER BY pr.provider SEPARATOR ', ')
     FROM tbd_order_items oi JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS proveedor_productos,
  (SELECT GROUP_CONCAT(CONCAT('Prod#', pr.id_product, ' ', pr.name, ' (proveedor=', pr.provider, ') x', oi.quantity,
                              ' @', oi.unit_price)
                      ORDER BY oi.id_order_item SEPARATOR ' | ')
     FROM tbd_order_items oi
     JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS detalle_3_productos_mismo_proveedor,
  (SELECT GROUP_CONCAT(CONCAT('Ship#', sh.id_shipment, ' tracking=', sh.tracking_number,
                              ' carrier=', sc.name, ' estado_envio=', sh.status,
                              ' enviado=', IFNULL(sh.shipped_at, 'N/A'),
                              ' entregado/recogido=', IFNULL(sh.delivered_at, 'N/A'))
                      ORDER BY sh.id_shipment SEPARATOR ' | ')
     FROM tb_shipments sh
     LEFT JOIN tbc_shipping_carriers sc ON sc.id_carrier = sh.id_carrier
    WHERE sh.id_buyer_order = bo.id_buyer_order) AS envio_y_recoleccion,
  (SELECT GROUP_CONCAT(DISTINCT l.table_description ORDER BY l.operation_date SEPARATOR ' || ')
     FROM tb_logs l
    WHERE l.table_description LIKE 'P04_CASO4:%') AS evidencia_intento_fallido_y_punto_recoleccion
FROM tb_users u
JOIN tb_carts c ON c.user_ID = u.id_user AND c.id_carts = 9404
JOIN tb_buyer_orders bo ON bo.id_buyer_order = 9404
JOIN tb_user_addresses ua ON ua.id_user_adress = 9404 AND ua.id_user = u.id_user
JOIN tbd_user_payment_methods pm ON pm.id_user_payment_method = 9404 AND pm.id_user = u.id_user
JOIN tbc_payment_methods_types pmt ON pmt.id_payment_method_type = pm.id_payment_method_type
JOIN tb_payments pay ON pay.id_payment = 9404 AND pay.id_buyer_order = bo.id_buyer_order
WHERE u.id_user = 9;

-- ============================================================
-- CASO 5: Compra fallida por falta de inventario
-- Intento de compra, estatus no atendida/cancelada por falta de stock
-- y reasignación/reactivación del cupón de regalo.
-- ============================================================
CREATE OR REPLACE VIEW vw_caso5_fallida_inventario AS
SELECT
  u.id_user,
  u.nick,
  u.email,
  c.id_carts AS id_carrito,
  bo.id_buyer_order AS id_orden,
  bo.subtotal AS subtotal_intento,
  bo.shipping_cost,
  (bo.subtotal + bo.shipping_cost) AS total_intento,
  bo.fulfillment_status AS estatus_orden,
  CASE WHEN bo.status = b'1' THEN 'ACTIVA' ELSE 'NO ATENDIDA/INACTIVA' END AS estado_registro_orden,
  ua.address_label AS domicilio_envio,
  pm.id_user_payment_method AS id_cupon_metodo,
  pm.label AS metodo_pago_cupon,
  pmt.description AS tipo_metodo_pago,
  pm.provider_method_ref AS referencia_cupon,
  CASE WHEN pm.status = b'1' THEN 'REACTIVADO/DISPONIBLE' ELSE 'INACTIVO' END AS estado_cupon_actual,
  (SELECT GROUP_CONCAT(CONCAT('Prod#', pr.id_product, ' ', pr.name, ' proveedor=', pr.provider,
                              ' stock_disponible=', pr.current_stock,
                              ' solicitado=', oi.quantity, ' precio=', oi.unit_price)
                      ORDER BY oi.id_order_item SEPARATOR ' | ')
     FROM tbd_order_items oi
     JOIN tb_products pr ON pr.id_product = oi.id_product
    WHERE oi.id_order_seller = bo.id_buyer_order) AS detalle_intento_compra_e_inventario,
  (SELECT GROUP_CONCAT(CONCAT('Cancel#', oc.id_order_cancellation, ' por=', oc.cancelled_by,
                              ' motivo=', oc.reason, ' items=', IFNULL(ci_det.items, ''))
                      ORDER BY oc.id_order_cancellation SEPARATOR ' || ')
     FROM tb_order_cancellations oc
     LEFT JOIN (
       SELECT ci.id_order_cancellation,
              GROUP_CONCAT(CONCAT('oi=', ci.id_order_item, ' qty=', ci.quantity, ' razon=', ci.reason) SEPARATOR ', ') AS items
         FROM tbd_cancellation_items ci
        GROUP BY ci.id_order_cancellation
     ) ci_det ON ci_det.id_order_cancellation = oc.id_order_cancellation
    WHERE oc.id_user = u.id_user AND oc.reason LIKE 'P04_CASO5:%') AS cancelacion_por_falta_inventario,
  (SELECT GROUP_CONCAT(DISTINCT l.table_description ORDER BY l.operation_date SEPARATOR ' || ')
     FROM tb_logs l
    WHERE l.table_description LIKE 'P04_CASO5:%') AS evidencia_logs_falla_y_reactivacion_cupon
FROM tb_users u
JOIN tb_carts c ON c.user_ID = u.id_user AND c.id_carts = 9405
JOIN tb_buyer_orders bo ON bo.id_buyer_order = 9405
JOIN tb_user_addresses ua ON ua.id_user_adress = 9405 AND ua.id_user = u.id_user
JOIN tbd_user_payment_methods pm ON pm.id_user_payment_method = 9405 AND pm.id_user = u.id_user
JOIN tbc_payment_methods_types pmt ON pmt.id_payment_method_type = pm.id_payment_method_type
WHERE u.id_user = 12;

-- ============================================================
-- Consultas de verificación (listas para MySQL Workbench)
-- ============================================================
SELECT * FROM vw_caso1_compra_exitosa;
SELECT * FROM vw_caso2_reclamacion_reenvio;
SELECT * FROM vw_caso3_cancelacion_reembolso;
SELECT * FROM vw_caso4_punto_recoleccion;
SELECT * FROM vw_caso5_fallida_inventario;
