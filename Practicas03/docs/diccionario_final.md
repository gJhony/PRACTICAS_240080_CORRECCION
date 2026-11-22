# 📘 Diccionario de datos · `db_test_7b`

> Generado desde `Practicas03/backups/finalfinal.sql`. 25 tablas · 190 columnas · 33 FK · 79,501 filas · 72 triggers · 26 vistas · 1 procedimiento.
> Los conteos describen el contenido del respaldo, no una consulta en vivo.

| Dominio | Tablas | Columnas | Relaciones FK | Filas |
|---|---:|---:|---:|---:|
| Núcleo y catálogo base (nucleo) | 5 | 52 | 2 | 27,122 |
| Operación y pagos (operacion) | 9 | 64 | 13 | 45,379 |
| Detalles y asociaciones (detalles) | 9 | 63 | 18 | 7,000 |
| Catálogos de referencia (catalogos) | 2 | 11 | 0 | 0 |

## Leyenda

- **PK** llave primaria · **FK** llave foránea · **UQ** valor único · **NN** no nulo.
- `Referencia` indica `tabla.columna` destino declarada en el DDL.

## Núcleo y catálogo base

### `tb_users`

9 columnas · PK: `id_user` · FK: 0 · Filas: **10,011**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user` | `int` | NN | — | PK | — |
| `email` | `varchar(100)` | NN | — | UQ | — |
| `nick` | `varchar(50)` | NN | — | UQ | — |
| `password` | `varchar(255)` | NN | — | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |
| `last_login` | `datetime` | SÍ | `NULL` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `roles` | `varchar(50)` | SÍ | `'Sin rol'` | — | — |

### `tb_people`

12 columnas · PK: `id_people` · FK: 1 · Filas: **10,011**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_people` | `bigint unsigned` | NN | — | PK | — |
| `id_user` | `int` | SÍ | `NULL` | FK UQ | `tb_users.id_user` |
| `courtesy_title` | `varchar(20)` | SÍ | `NULL` | — | — |
| `given_names` | `varchar(150)` | NN | — | — | — |
| `family_names` | `varchar(150)` | SÍ | `NULL` | — | — |
| `birth_date` | `date` | SÍ | `NULL` | — | — |
| `gender` | `enum('Hombre','Mujer','Prefiero no decirlo')` | NN | `'Prefiero no decirlo'` | — | — |
| `country_code` | `char(2)` | SÍ | `NULL` | — | — |
| `phone` | `varchar(25)` | SÍ | `NULL` | — | — |
| `status` | `bit(1)` | SÍ | `b'1'` | — | — |
| `creation_date` | `datetime` | SÍ | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `CURRENT_TIMESTAMP` | — | — |

### `tb_user_addresses`

12 columnas · PK: `id_user_adress` · FK: 1 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user_adress` | `bigint unsigned` | NN | — | PK | — |
| `id_user` | `int` | NN | — | FK | `tb_users.id_user` |
| `address_label` | `varchar(100)` | NN | — | — | — |
| `recipient_name` | `varchar(150)` | SÍ | `NULL` | — | — |
| `recipient_phone` | `varchar(25)` | SÍ | `NULL` | — | — |
| `delivery_instructions` | `varchar(500)` | SÍ | `NULL` | — | — |
| `latitude` | `decimal(10,7)` | SÍ | `NULL` | — | — |
| `longitude` | `decimal(10,7)` | SÍ | `NULL` | — | — |
| `is_default` | `tinyint(1)` | NN | `'0'` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_categories`

7 columnas · PK: `id_category` · FK: 0 · Filas: **100**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_category` | `int unsigned` | NN | — | PK | — |
| `name` | `varchar(120)` | NN | — | UQ | — |
| `description` | `text` | SÍ | — | — | — |
| `sup_id_category` | `int unsigned` | SÍ | `NULL` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tb_products`

12 columnas · PK: `id_product` · FK: 0 · Filas: **7,000**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_product` | `int unsigned` | NN | — | PK | — |
| `sku` | `varchar(30)` | NN | — | UQ | — |
| `name` | `varchar(150)` | NN | — | — | — |
| `description` | `text` | SÍ | — | — | — |
| `category` | `varchar(100)` | NN | — | — | — |
| `color` | `varchar(50)` | NN | — | — | — |
| `current_prize` | `decimal(12,2)` | NN | `'0.00'` | — | — |
| `current_stock` | `int unsigned` | NN | `'0'` | — | — |
| `provider` | `varchar(150)` | NN | — | — | — |
| `status` | `tinyint(1)` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

## Operación y pagos

### `tb_buyer_orders`

8 columnas · PK: `id_buyer_order` · FK: 1 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_buyer_order` | `int unsigned` | NN | — | PK | — |
| `seller_ID` | `int` | NN | — | FK | `tb_users.id_user` |
| `subtotal` | `decimal(12,2)` | NN | `'0.00'` | — | — |
| `shipping_cost` | `decimal(12,2)` | NN | `'0.00'` | — | — |
| `fulfillment_status` | `enum('Pending','Accepted','Preparing','Sent','Delivered','Canceled','Returned')` | NN | `'Pending'` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_carts`

5 columnas · PK: `id_carts` · FK: 1 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_carts` | `int unsigned` | NN | — | PK | — |
| `user_ID` | `int` | NN | — | FK UQ | `tb_users.id_user` |
| `status` | `bit(1)` | SÍ | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_payments`

7 columnas · PK: `id_payment` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_payment` | `int` | NN | — | PK | — |
| `id_buyer_order` | `int unsigned` | NN | — | FK | `tb_buyer_orders.id_buyer_order` |
| `id_user_payment_method` | `bigint unsigned` | NN | — | FK | `tbd_user_payment_methods.id_user_payment_method` |
| `amount` | `decimal(10,2)` | NN | — | — | — |
| `currency` | `varchar(10)` | SÍ | `'MXN'` | — | — |
| `status` | `enum('pending','completed','failed','refunded')` | SÍ | `'pending'` | — | — |
| `paid_at` | `datetime` | SÍ | `NULL` | — | — |

### `tb_payment_methods`

8 columnas · PK: `id_payment_method` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_payment_method` | `int` | NN | — | PK | — |
| `id_user` | `int` | NN | — | FK | `tb_users.id_user` |
| `id_payment_method_type` | `int` | NN | — | FK | `tbc_payment_methods_types.id_payment_method_type` |
| `provider_token` | `varchar(255)` | SÍ | `NULL` | — | — |
| `is_default` | `tinyint` | NN | `'0'` | — | — |
| `status` | `tinyint` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_payment_transactions`

7 columnas · PK: `id_transaction` · FK: 1 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_transaction` | `int` | NN | — | PK | — |
| `id_payment` | `int` | NN | — | FK | `tb_payments.id_payment` |
| `gateway_name` | `varchar(50)` | NN | — | — | — |
| `gateway_transaction_id` | `varchar(150)` | NN | — | UQ | — |
| `response_code` | `varchar(50)` | SÍ | `NULL` | — | — |
| `raw_response` | `json` | SÍ | `NULL` | — | — |
| `created_at` | `timestamp` | SÍ | `CURRENT_TIMESTAMP` | — | — |

### `tb_order_cancellations`

7 columnas · PK: `id_order_cancellation` · FK: 1 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_order_cancellation` | `int` | NN | — | PK | — |
| `id_user` | `int` | NN | — | FK | `tb_users.id_user` |
| `reason` | `varchar(255)` | NN | — | — | — |
| `cancelled_by` | `varchar(100)` | NN | — | — | — |
| `status` | `tinyint` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_order_returns`

6 columnas · PK: `id_return` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_return` | `int` | NN | — | PK | — |
| `id_buyer_order` | `int unsigned` | NN | — | FK | `tb_buyer_orders.id_buyer_order` |
| `id_user` | `int` | NN | — | FK | `tb_users.id_user` |
| `reason` | `text` | NN | — | — | — |
| `status` | `enum('requested','approved','rejected','completed')` | SÍ | `'requested'` | — | — |
| `created_at` | `timestamp` | SÍ | `CURRENT_TIMESTAMP` | — | — |

### `tb_shipments`

9 columnas · PK: `id_shipment` · FK: 3 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_shipment` | `int` | NN | — | PK | — |
| `id_buyer_order` | `int unsigned` | NN | — | FK | `tb_buyer_orders.id_buyer_order` |
| `id_carrier` | `int` | NN | — | FK | `tbc_shipping_carriers.id_carrier` |
| `id_user_adress` | `bigint unsigned` | NN | — | FK | `tb_user_addresses.id_user_adress` |
| `tracking_number` | `varchar(100)` | SÍ | `NULL` | UQ | — |
| `shipping_cost` | `decimal(10,2)` | SÍ | `'0.00'` | — | — |
| `status` | `enum('pending','shipped','in_transit','delivered','returned')` | SÍ | `'pending'` | — | — |
| `shipped_at` | `datetime` | SÍ | `NULL` | — | — |
| `delivered_at` | `datetime` | SÍ | `NULL` | — | — |

### `tb_logs`

7 columnas · PK: `id_logs` · FK: 0 · Filas: **45,379**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_logs` | `int` | NN | — | PK | — |
| `table_name` | `varchar(80)` | NN | — | — | — |
| `table_operation` | `enum('Create','Read','Update','Delete')` | SÍ | `NULL` | — | — |
| `db_user` | `varchar(80)` | NN | — | — | — |
| `operation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `table_description` | `text` | NN | — | — | — |
| `operation_status` | `bit(1)` | NN | `b'1'` | — | — |

## Detalles y asociaciones

### `tbd_address_components`

8 columnas · PK: `id_address_component` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_address_component` | `bigint unsigned` | NN | — | PK UQ | — |
| `id_address` | `bigint unsigned` | NN | — | FK UQ | `tb_user_addresses.id_user_adress` |
| `value` | `varchar(255)` | NN | — | — | — |
| `component_type` | `varchar(50)` | NN | — | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `address_sup_id` | `bigint unsigned` | SÍ | `NULL` | FK | `tbd_address_components.id_address_component` |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tbd_cancellation_items`

8 columnas · PK: `id_cancellation_item` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_cancellation_item` | `int` | NN | — | PK | — |
| `id_order_cancellation` | `int` | NN | — | FK | `tb_order_cancellations.id_order_cancellation` |
| `id_order_item` | `int unsigned` | NN | — | FK | `tbd_order_items.id_order_item` |
| `quantity` | `int` | NN | — | — | — |
| `reason` | `varchar(255)` | SÍ | `NULL` | — | — |
| `status` | `tinyint` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tbd_carts_items`

5 columnas · PK: `id_cart`, `id_provider`, `id_product` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_cart` | `int unsigned` | NN | — | PK FK | `tb_carts.id_carts` |
| `id_provider` | `int` | NN | — | PK FK | `tbd_products_users_providers.id_product_user_provider` |
| `id_product` | `int` | NN | — | PK | — |
| `quantity` | `int unsigned` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tbd_order_items`

9 columnas · PK: `id_order_item` · FK: 3 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_order_item` | `int unsigned` | NN | — | PK | — |
| `id_order_seller` | `int unsigned` | NN | — | FK | `tb_buyer_orders.id_buyer_order` |
| `id_product` | `int` | NN | — | — | — |
| `id_provider` | `int` | NN | — | FK | `tbd_products_users_providers.id_product_user_provider` |
| `product_name` | `varchar(255)` | NN | — | — | — |
| `quantity` | `int unsigned` | NN | — | — | — |
| `unit_price` | `decimal(12,2)` | NN | — | — | — |
| `subtotal` | `decimal(12,2)` | SÍ | — | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tbd_products_categories`

5 columnas · PK: `id_product`, `id_category` · FK: 2 · Filas: **7,000**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_product` | `int unsigned` | NN | — | PK FK | `tb_products.id_product` |
| `id_category` | `int unsigned` | NN | — | PK FK | `tb_categories.id_category` |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tbd_products_users_providers`

7 columnas · PK: `id_product_user_provider`, `id_product` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_product_user_provider` | `int` | NN | — | PK FK | `tb_users.id_user` |
| `id_product` | `int unsigned` | NN | — | PK FK | `tb_products.id_product` |
| `type_ownership` | `enum('Owner','Reseller','Distributor')` | SÍ | `NULL` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `avalaible_date` | `datetime` | NN | — | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | — | — | — |

### `tbd_return_items`

5 columnas · PK: `id_return_item` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_return_item` | `int` | NN | — | PK | — |
| `id_return` | `int` | NN | — | FK | `tb_order_returns.id_return` |
| `id_order_item` | `int unsigned` | NN | — | FK | `tbd_order_items.id_order_item` |
| `quantity` | `int` | NN | — | — | — |
| `refund_amount` | `decimal(10,2)` | NN | — | — | — |

### `tbd_user_payment_methods`

11 columnas · PK: `id_user_payment_method` · FK: 2 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user_payment_method` | `bigint unsigned` | NN | — | PK | — |
| `id_user` | `int` | NN | — | FK | `tb_users.id_user` |
| `id_payment_method_type` | `int` | NN | — | FK | `tbc_payment_methods_types.id_payment_method_type` |
| `provider` | `varchar(60)` | NN | — | UQ | — |
| `provider_method_ref` | `varchar(255)` | NN | — | UQ | — |
| `label` | `varchar(100)` | SÍ | `NULL` | — | — |
| `last_four` | `char(4)` | SÍ | `NULL` | — | — |
| `is_default` | `tinyint(1)` | NN | `'0'` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tbd_users_wishlist_products`

5 columnas · PK: `id_user_wishlist_product`, `id_product` · FK: 1 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user_wishlist_product` | `int` | NN | — | PK FK | `tb_users.id_user` |
| `id_product` | `int unsigned` | NN | — | PK | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

## Catálogos de referencia

### `tbc_payment_methods_types`

6 columnas · PK: `id_payment_method_type` · FK: 0 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_payment_method_type` | `int` | NN | — | PK | — |
| `code` | `varchar(30)` | NN | — | UQ | — |
| `description` | `text` | SÍ | — | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | NN | — | — | — |

### `tbc_shipping_carriers`

5 columnas · PK: `id_carrier` · FK: 0 · Filas: **0**

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_carrier` | `int` | NN | — | PK | — |
| `name` | `varchar(100)` | NN | — | — | — |
| `tracking_url_template` | `varchar(255)` | SÍ | `NULL` | — | — |
| `is_active` | `tinyint(1)` | SÍ | `'1'` | — | — |
| `created_at` | `timestamp` | SÍ | `CURRENT_TIMESTAMP` | — | — |

---

Volver al [modelo interactivo](page_final.html) · [índice del sitio](index.html) · [diccionario HTML](diccionario_final.html) · [código en GitHub](https://github.com/gJhony/PRACTICAS_240080_CORRECCION/blob/Practica03/Practicas03/docs/diccionario_final.md).
