# 📘 Diccionario de datos · `db_test_7b`

> Generado desde `Practicas03/backups/finalfinal.sql`. 25 tablas · 190 columnas · 33 FK · 72 triggers · 26 vistas · 1 procedimiento.
> Los conteos describen el contenido del respaldo, no una consulta en vivo.

| Dominio | Tablas | Columnas | Relaciones FK |
|---|---:|---:|---:|
| Núcleo y catálogo base (nucleo) | 5 | 52 | 2 |
| Operación y pagos (operacion) | 9 | 64 | 13 |
| Detalles y asociaciones (detalles) | 9 | 63 | 18 |
| Catálogos de referencia (catalogos) | 2 | 11 | 0 |

## Leyenda

- **PK** llave primaria · **FK** llave foránea · **UQ** valor único · **NN** no nulo.
- `Referencia` indica `tabla.columna` destino declarada en el DDL.

## Núcleo y catálogo base

### `tb_users`

9 columnas · PK: `id_user` · FK: 0

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user` | `int` | NN | — | — | — |
| `email` | `varchar(100)` | NN | — | — | — |
| `nick` | `varchar(50)` | NN | — | — | — |
| `password` | `varchar(255)` | NN | — | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |
| `last_login` | `datetime` | SÍ | `NULL` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `roles` | `varchar(50)` | SÍ | `'Sin rol'` | — | — |

### `tb_people`

12 columnas · PK: `id_people` · FK: 1

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_people` | `bigint unsigned` | NN | — | — | — |
| `id_user` | `int` | SÍ | `NULL` | — | — |
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

12 columnas · PK: `id_user_adress` · FK: 1

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user_adress` | `bigint unsigned` | NN | — | — | — |
| `id_user` | `int` | NN | — | — | — |
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

7 columnas · PK: `id_category` · FK: 0

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_category` | `int unsigned` | NN | — | — | — |
| `name` | `varchar(120)` | NN | — | — | — |
| `description` | `text` | SÍ | — | — | — |
| `sup_id_category` | `int unsigned` | SÍ | `NULL` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tb_products`

12 columnas · PK: `id_product` · FK: 0

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_product` | `int unsigned` | NN | — | — | — |
| `sku` | `varchar(30)` | NN | — | — | — |
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

8 columnas · PK: `id_buyer_order` · FK: 1

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_buyer_order` | `int unsigned` | NN | — | — | — |
| `seller_ID` | `int` | NN | — | — | — |
| `subtotal` | `decimal(12,2)` | NN | `'0.00'` | — | — |
| `shipping_cost` | `decimal(12,2)` | NN | `'0.00'` | — | — |
| `fulfillment_status` | `enum('Pending','Accepted','Preparing','Sent','Delivered','Canceled','Returned')` | NN | `'Pending'` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_carts`

5 columnas · PK: `id_carts` · FK: 1

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_carts` | `int unsigned` | NN | — | — | — |
| `user_ID` | `int` | NN | — | — | — |
| `status` | `bit(1)` | SÍ | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_payments`

7 columnas · PK: `id_payment` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_payment` | `int` | NN | — | — | — |
| `id_buyer_order` | `int unsigned` | NN | — | — | — |
| `id_user_payment_method` | `bigint unsigned` | NN | — | — | — |
| `amount` | `decimal(10,2)` | NN | — | — | — |
| `currency` | `varchar(10)` | SÍ | `'MXN'` | — | — |
| `status` | `enum('pending','completed','failed','refunded')` | SÍ | `'pending'` | — | — |
| `paid_at` | `datetime` | SÍ | `NULL` | — | — |

### `tb_payment_methods`

8 columnas · PK: `id_payment_method` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_payment_method` | `int` | NN | — | — | — |
| `id_user` | `int` | NN | — | — | — |
| `id_payment_method_type` | `int` | NN | — | — | — |
| `provider_token` | `varchar(255)` | SÍ | `NULL` | — | — |
| `is_default` | `tinyint` | NN | `'0'` | — | — |
| `status` | `tinyint` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_payment_transactions`

7 columnas · PK: `id_transaction` · FK: 1

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_transaction` | `int` | NN | — | — | — |
| `id_payment` | `int` | NN | — | — | — |
| `gateway_name` | `varchar(50)` | NN | — | — | — |
| `gateway_transaction_id` | `varchar(150)` | NN | — | — | — |
| `response_code` | `varchar(50)` | SÍ | `NULL` | — | — |
| `raw_response` | `json` | SÍ | `NULL` | — | — |
| `created_at` | `timestamp` | SÍ | `CURRENT_TIMESTAMP` | — | — |

### `tb_order_cancellations`

7 columnas · PK: `id_order_cancellation` · FK: 1

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_order_cancellation` | `int` | NN | — | — | — |
| `id_user` | `int` | NN | — | — | — |
| `reason` | `varchar(255)` | NN | — | — | — |
| `cancelled_by` | `varchar(100)` | NN | — | — | — |
| `status` | `tinyint` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tb_order_returns`

6 columnas · PK: `id_return` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_return` | `int` | NN | — | — | — |
| `id_buyer_order` | `int unsigned` | NN | — | — | — |
| `id_user` | `int` | NN | — | — | — |
| `reason` | `text` | NN | — | — | — |
| `status` | `enum('requested','approved','rejected','completed')` | SÍ | `'requested'` | — | — |
| `created_at` | `timestamp` | SÍ | `CURRENT_TIMESTAMP` | — | — |

### `tb_shipments`

9 columnas · PK: `id_shipment` · FK: 3

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_shipment` | `int` | NN | — | — | — |
| `id_buyer_order` | `int unsigned` | NN | — | — | — |
| `id_carrier` | `int` | NN | — | — | — |
| `id_user_adress` | `bigint unsigned` | NN | — | — | — |
| `tracking_number` | `varchar(100)` | SÍ | `NULL` | — | — |
| `shipping_cost` | `decimal(10,2)` | SÍ | `'0.00'` | — | — |
| `status` | `enum('pending','shipped','in_transit','delivered','returned')` | SÍ | `'pending'` | — | — |
| `shipped_at` | `datetime` | SÍ | `NULL` | — | — |
| `delivered_at` | `datetime` | SÍ | `NULL` | — | — |

### `tb_logs`

7 columnas · PK: `id_logs` · FK: 0

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_logs` | `int` | NN | — | — | — |
| `table_name` | `varchar(80)` | NN | — | — | — |
| `table_operation` | `enum('Create','Read','Update','Delete')` | SÍ | `NULL` | — | — |
| `db_user` | `varchar(80)` | NN | — | — | — |
| `operation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `table_description` | `text` | NN | — | — | — |
| `operation_status` | `bit(1)` | NN | `b'1'` | — | — |

## Detalles y asociaciones

### `tbd_address_components`

8 columnas · PK: `id_address_component` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_address_component` | `bigint unsigned` | NN | — | — | — |
| `id_address` | `bigint unsigned` | NN | — | — | — |
| `value` | `varchar(255)` | NN | — | — | — |
| `component_type` | `varchar(50)` | NN | — | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `address_sup_id` | `bigint unsigned` | SÍ | `NULL` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tbd_cancellation_items`

8 columnas · PK: `id_cancellation_item` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_cancellation_item` | `int` | NN | — | — | — |
| `id_order_cancellation` | `int` | NN | — | — | — |
| `id_order_item` | `int unsigned` | NN | — | — | — |
| `quantity` | `int` | NN | — | — | — |
| `reason` | `varchar(255)` | SÍ | `NULL` | — | — |
| `status` | `tinyint` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tbd_carts_items`

5 columnas · PK: `id_cart`, `id_provider`, `id_product` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_cart` | `int unsigned` | NN | — | — | — |
| `id_provider` | `int` | NN | — | — | — |
| `id_product` | `int` | NN | — | — | — |
| `quantity` | `int unsigned` | NN | `'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tbd_order_items`

9 columnas · PK: `id_order_item` · FK: 3

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_order_item` | `int unsigned` | NN | — | — | — |
| `id_order_seller` | `int unsigned` | NN | — | — | — |
| `id_product` | `int` | NN | — | — | — |
| `id_provider` | `int` | NN | — | — | — |
| `product_name` | `varchar(255)` | NN | — | — | — |
| `quantity` | `int unsigned` | NN | — | — | — |
| `unit_price` | `decimal(12,2)` | NN | — | — | — |
| `subtotal` | `decimal(12,2)` | SÍ | — | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tbd_products_categories`

5 columnas · PK: `id_product`, `id_category` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_product` | `int unsigned` | NN | — | — | — |
| `id_category` | `int unsigned` | NN | — | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

### `tbd_products_users_providers`

7 columnas · PK: `id_product_user_provider`, `id_product` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_product_user_provider` | `int` | NN | — | — | — |
| `id_product` | `int unsigned` | NN | — | — | — |
| `type_ownership` | `enum('Owner','Reseller','Distributor')` | SÍ | `NULL` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `avalaible_date` | `datetime` | NN | — | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | — | — | — |

### `tbd_return_items`

5 columnas · PK: `id_return_item` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_return_item` | `int` | NN | — | — | — |
| `id_return` | `int` | NN | — | — | — |
| `id_order_item` | `int unsigned` | NN | — | — | — |
| `quantity` | `int` | NN | — | — | — |
| `refund_amount` | `decimal(10,2)` | NN | — | — | — |

### `tbd_user_payment_methods`

11 columnas · PK: `id_user_payment_method` · FK: 2

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user_payment_method` | `bigint unsigned` | NN | — | — | — |
| `id_user` | `int` | NN | — | — | — |
| `id_payment_method_type` | `int` | NN | — | — | — |
| `provider` | `varchar(60)` | NN | — | — | — |
| `provider_method_ref` | `varchar(255)` | NN | — | — | — |
| `label` | `varchar(100)` | SÍ | `NULL` | — | — |
| `last_four` | `char(4)` | SÍ | `NULL` | — | — |
| `is_default` | `tinyint(1)` | NN | `'0'` | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | SÍ | `NULL` | — | — |

### `tbd_users_wishlist_products`

5 columnas · PK: `id_user_wishlist_product`, `id_product` · FK: 1

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_user_wishlist_product` | `int` | NN | — | — | — |
| `id_product` | `int unsigned` | NN | — | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |
| `last_update` | `datetime` | NN | `CURRENT_TIMESTAMP` | — | — |

## Catálogos de referencia

### `tbc_payment_methods_types`

6 columnas · PK: `id_payment_method_type` · FK: 0

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_payment_method_type` | `int` | NN | — | — | — |
| `code` | `varchar(30)` | NN | — | — | — |
| `description` | `text` | SÍ | — | — | — |
| `status` | `bit(1)` | NN | `b'1'` | — | — |
| `creation_date` | `datetime` | NN | — | — | — |
| `last_update` | `datetime` | NN | — | — | — |

### `tbc_shipping_carriers`

5 columnas · PK: `id_carrier` · FK: 0

| Columna | Tipo SQL | Nulo | Default | Clave | Referencia |
|---|---|---|---|---|---|
| `id_carrier` | `int` | NN | — | — | — |
| `name` | `varchar(100)` | NN | — | — | — |
| `tracking_url_template` | `varchar(255)` | SÍ | `NULL` | — | — |
| `is_active` | `tinyint(1)` | SÍ | `'1'` | — | — |
| `created_at` | `timestamp` | SÍ | `CURRENT_TIMESTAMP` | — | — |

---

Volver al [modelo interactivo](page_final.html) · [índice del sitio](index.html).
