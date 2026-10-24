# Diccionario de datos ? db_test_7b

Fuente: `respM.sql`. El DDL define 13 tablas y 118 claves for?neas. El respaldo incluye 11,478 filas insertadas expl?citamente; este conteo no es una consulta en vivo.

## `tb_buyer_orders` ? ?rdenes de compra vinculadas a la cuenta del vendedor

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `ID`
**Validaciones:** `(`subtotal` >= 0)`; `(`shipping_cost` >= 0)`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int unsigned` | Identificador ?nico de la orden | PK; Obligatorio; AUTO_INCREMENT |
| `seller_ID` | `int` | Identificador de la cuenta que vende o gestiona la orden | FK; Obligatorio; referencia a `tb_users.ID` |
| `subtotal` | `decimal(12,2)` | Importe del rengl?n calculado como cantidad por precio unitario | Obligatorio; DEFAULT '0.00' |
| `shipping_cost` | `decimal(12,2)` | Importe registrado por el env?o | Obligatorio; DEFAULT '0.00' |
| `fulfillment_status` | `enum('Pending','Accepted','Preparing','Sent','Delivered','Canceled','Returned')` | Etapa de preparaci?n o entrega de la orden | Obligatorio; DEFAULT 'Pending' |
| `status` | `bit(1)` | Indica si la orden est? activa | Obligatorio; DEFAULT b'1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Puede quedar vac?o; DEFAULT NULL |

## `tb_carts` ? Carritos de compra de las cuentas usuarias

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `ID`
**Restricciones ?nicas:** `user_ID`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int unsigned` | Identificador ?nico del carrito | PK; Obligatorio; AUTO_INCREMENT |
| `user_ID` | `int` | Identificador de la cuenta propietaria | FK; ?nico; Obligatorio; referencia a `tb_users.ID` |
| `status` | `bit(1)` | Indica si el carrito est? activo | Puede quedar vac?o; DEFAULT b'1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Puede quedar vac?o; DEFAULT NULL |

## `tb_logs` ? Historial de operaciones realizadas en el sistema

**Filas insertadas en `respM.sql`:** 5,740  
**Clave primaria:** `ID`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int` | Identificador ?nico del evento de historial | PK; Obligatorio; AUTO_INCREMENT |
| `table_name` | `varchar(80)` | Nombre de la tabla afectada por la operaci?n | Obligatorio |
| `table_operation` | `enum('Create','Read','Update','Delete')` | Tipo de operaci?n realizada | Puede quedar vac?o; DEFAULT NULL |
| `db_user` | `varchar(80)` | Usuario de base de datos que ejecut? la operaci?n | Obligatorio |
| `operation_date` | `datetime` | Fecha y hora en que ocurri? la operaci?n | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `table_description` | `text` | Detalle textual de la operaci?n registrada | Obligatorio |
| `operation_status` | `bit(1)` | Indica si la operaci?n qued? marcada como exitosa | Obligatorio; DEFAULT b'1' |

## `tb_products` ? Cat?logo de productos, precios y existencias

**Filas insertadas en `respM.sql`:** 5,000  
**Clave primaria:** `id_producto`
**Restricciones ?nicas:** `sku`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `id_producto` | `int` | Identificador ?nico del producto | PK; Obligatorio |
| `sku` | `varchar(30)` | C?digo ?nico usado para reconocer el producto | ?nico; Obligatorio |
| `nombre` | `varchar(150)` | Nombre comercial del producto | Obligatorio |
| `categoria` | `varchar(100)` | Categor?a descriptiva del producto | Obligatorio |
| `marca` | `varchar(100)` | Marca del producto | Obligatorio |
| `variante` | `varchar(100)` | Versi?n, modelo o presentaci?n del producto | Obligatorio |
| `color` | `varchar(50)` | Color del producto | Obligatorio |
| `precio_mxn` | `decimal(12,2)` | Precio del producto expresado en pesos mexicanos | Obligatorio |
| `stock` | `int` | Cantidad registrada como disponible en inventario | Obligatorio |
| `proveedor` | `varchar(150)` | Nombre del proveedor del producto | Obligatorio |
| `fecha_ingreso` | `date` | Fecha en que el producto se registr? o ingres? | Obligatorio |
| `calificacion` | `decimal(3,1)` | Calificaci?n registrada para el producto | Obligatorio |
| `ventas_mensuales` | `int` | Cantidad de ventas mensuales registrada | Obligatorio |
| `activo` | `varchar(10)` | Indica si el producto est? habilitado | Obligatorio |

## `tb_users` ? Cuentas de personas que usan la plataforma

**Filas insertadas en `respM.sql`:** 10  
**Clave primaria:** `ID`
**Restricciones ?nicas:** `email`; `nick`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int` | Identificador ?nico de la cuenta | PK; Obligatorio; AUTO_INCREMENT |
| `email` | `varchar(100)` | Correo electr?nico de la cuenta | ?nico; Obligatorio |
| `nick` | `varchar(50)` | Nombre corto o alias de la cuenta | ?nico; Obligatorio |
| `password` | `varchar(255)` | Credencial protegida de acceso; el valor no debe mostrarse | Obligatorio |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Puede quedar vac?o; DEFAULT NULL |
| `last_login` | `datetime` | Fecha y hora del acceso m?s reciente | Puede quedar vac?o; DEFAULT NULL |
| `status` | `bit(1)` | Indica si el registro est? activo | Obligatorio; DEFAULT b'1' |
| `roles` | `varchar(50)` | Rol o perfil asignado a la cuenta | Puede quedar vac?o; DEFAULT 'Sin rol' |

## `tbc_categories` ? Categor?as y subcategor?as para organizar productos

**Filas insertadas en `respM.sql`:** 100  
**Clave primaria:** `ID`
**Restricciones ?nicas:** `name`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int unsigned` | Identificador ?nico de la categor?a | PK; Obligatorio; AUTO_INCREMENT |
| `name` | `varchar(120)` | Nombre de la categor?a | ?nico; Obligatorio |
| `description` | `text` | Descripci?n de la categor?a o del tipo de pago | Puede quedar vac?o |
| `sup_id_category` | `int unsigned` | Identificador de la categor?a superior, si existe | FK; Puede quedar vac?o; DEFAULT NULL; referencia a `tbc_categories.ID` |
| `status` | `bit(1)` | Indica si el registro est? activo | Obligatorio; DEFAULT b'1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Obligatorio; DEFAULT CURRENT_TIMESTAMP |

## `tbc_payment_methods_types` ? Tipos de medios de pago que el sistema reconoce

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `ID`
**Restricciones ?nicas:** `code`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int` | Identificador ?nico del tipo de pago | PK; Obligatorio; AUTO_INCREMENT |
| `code` | `varchar(30)` | C?digo ?nico del tipo de medio de pago | ?nico; Obligatorio |
| `description` | `text` | Descripci?n de la categor?a o del tipo de pago | Puede quedar vac?o |
| `status` | `bit(1)` | Indica si el registro est? activo | Obligatorio; DEFAULT b'1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Obligatorio |

## `tbd_carts_items` ? Productos y cantidades agregados a cada carrito

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `cart_ID`, `provider_ID`, `product_ID`
**Validaciones:** `(`quantity` > 0)`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `cart_ID` | `int unsigned` | Identificador del carrito al que pertenece el rengl?n | PK; FK; Obligatorio; referencia a `tb_carts.ID` |
| `provider_ID` | `int` | Identificador de la cuenta proveedora del art?culo | PK; FK; Obligatorio; referencia a `tbd_products_users_providers.ID` |
| `product_ID` | `int` | Identificador del producto a?adido al carrito | PK; FK; Obligatorio; referencia a `tbd_products_users_providers.id_producto` |
| `quantity` | `int unsigned` | Cantidad de unidades del producto | Obligatorio; DEFAULT '1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |

## `tbd_order_items` ? Productos que forman parte de una orden

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `ID`
**Validaciones:** `(`quantity` > 0)`; `(`unit_price` >= 0)`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int unsigned` | Identificador ?nico del rengl?n de la orden | PK; Obligatorio; AUTO_INCREMENT |
| `seller_order_ID` | `int unsigned` | Identificador de la orden a la que pertenece el rengl?n | FK; Obligatorio; referencia a `tb_buyer_orders.ID` |
| `product_ID` | `int` | Identificador del producto incluido en la orden | FK; Obligatorio; referencia a `tbd_products_users_providers.id_producto` |
| `provider_ID` | `int` | Identificador de la cuenta proveedora del art?culo | FK; Obligatorio; referencia a `tbd_products_users_providers.ID` |
| `product_name` | `varchar(255)` | Nombre del producto guardado en el detalle de la orden | Obligatorio |
| `quantity` | `int unsigned` | Cantidad de unidades del producto | Obligatorio |
| `unit_price` | `decimal(12,2)` | Precio por unidad registrado para la orden | Obligatorio |
| `subtotal` | `decimal(12,2)` | Importe del rengl?n calculado como cantidad por precio unitario | Puede quedar vac?o; Calculado autom?ticamente |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |

## `tbd_products_categorias` ? Relaci?n que clasifica productos en categor?as

**Filas insertadas en `respM.sql`:** 628  
**Clave primaria:** `product_ID`, `category_ID`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `product_ID` | `int` | Identificador del producto que se clasifica | PK; FK; Obligatorio; referencia a `tb_products.id_producto` |
| `category_ID` | `int unsigned` | Identificador de la categor?a asignada | PK; FK; Obligatorio; referencia a `tbc_categories.ID` |
| `status` | `bit(1)` | Indica si la clasificaci?n est? activa | Obligatorio; DEFAULT b'1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Obligatorio; DEFAULT CURRENT_TIMESTAMP |

## `tbd_products_users_providers` ? Relaci?n entre productos y cuentas que los ofrecen

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `ID`, `id_producto`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int` | Identificador de la cuenta que ofrece el producto | PK; FK; Obligatorio; referencia a `tb_users.ID` |
| `id_producto` | `int` | Identificador del producto ofrecido | PK; FK; Obligatorio; referencia a `tb_products.id_producto` |
| `type_ownership` | `enum('Owner','Reseller','Distributor')` | Tipo de relaci?n de propiedad o reventa del producto | Puede quedar vac?o; DEFAULT NULL |
| `status` | `bit(1)` | Indica si la oferta est? activa | Obligatorio; DEFAULT b'1' |
| `avalaible_date` | `datetime` | Fecha y hora desde la que se indica disponibilidad | Obligatorio |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Obligatorio |

## `tbd_user_payment_methods` ? Medios de pago asociados a una cuenta

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `ID`
**Restricciones ?nicas:** `provider` + `provider_method_ref`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `bigint unsigned` | Identificador ?nico del medio de pago guardado | PK; Obligatorio; AUTO_INCREMENT |
| `user_ID` | `int` | Identificador de la cuenta propietaria | FK; Obligatorio; referencia a `tb_users.ID` |
| `payment_method_type_ID` | `int` | Identificador del tipo de medio de pago | FK; Obligatorio; referencia a `tbc_payment_methods_types.ID` |
| `provider` | `varchar(60)` | Dato asociado a provider. Confirmar su significado con el ?rea responsable. | ?nico; Obligatorio |
| `provider_method_ref` | `varchar(255)` | Referencia del medio de pago en el proveedor; dato sensible oculto | ?nico; Obligatorio |
| `label` | `varchar(100)` | Nombre elegido para reconocer el medio de pago | Puede quedar vac?o; DEFAULT NULL |
| `last_four` | `char(4)` | ?ltimos cuatro caracteres asociados al medio de pago | Puede quedar vac?o; DEFAULT NULL |
| `is_default` | `tinyint(1)` | Indica si este es el medio de pago predeterminado | Obligatorio; DEFAULT '0' |
| `status` | `bit(1)` | Indica si el medio de pago est? activo | Obligatorio; DEFAULT b'1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Puede quedar vac?o; DEFAULT NULL |

## `tbd_users_wishlist_products` ? Productos guardados por cada cuenta en su lista de deseos

**Filas insertadas en `respM.sql`:** 0  
**Clave primaria:** `ID`, `id_producto`

| Campo exacto | Tipo SQL exacto | Significado | Reglas |
|---|---|---|---|
| `ID` | `int` | Identificador de la cuenta propietaria de la lista | PK; FK; Obligatorio; referencia a `tb_users.ID` |
| `id_producto` | `int` | Identificador del producto guardado en la lista | PK; FK; Obligatorio; referencia a `tb_products.id_producto` |
| `status` | `bit(1)` | Indica si el elemento de la lista est? activo | Obligatorio; DEFAULT b'1' |
| `creation_date` | `datetime` | Fecha y hora en que se cre? el registro | Obligatorio; DEFAULT CURRENT_TIMESTAMP |
| `last_update` | `datetime` | Fecha y hora de la ?ltima actualizaci?n | Obligatorio; DEFAULT CURRENT_TIMESTAMP |

## Relaciones declaradas

| Campo de origen | Campo de destino | Explicaci?n sencilla |
|---|---|---|
| `tb_buyer_orders.seller_ID` | `tb_users.ID` | Cada orden queda asociada a la cuenta del vendedor que la gestiona. |
| `tb_carts.user_ID` | `tb_users.ID` | Cada carrito pertenece a una cuenta de usuario. |
| `tbc_categories.sup_id_category` | `tbc_categories.ID` | Una categor?a puede se?alar otra categor?a como su categor?a superior. |
| `tbd_carts_items.cart_ID` | `tb_carts.ID` | Cada producto agregado pertenece a un carrito espec?fico. |
| `tbd_carts_items.provider_ID` | `tbd_products_users_providers.ID` | Identifica al usuario que ofrece el producto agregado al carrito. |
| `tbd_carts_items.product_ID` | `tbd_products_users_providers.id_producto` | Identifica el producto agregado al carrito. |
| `tbd_order_items.seller_order_ID` | `tb_buyer_orders.ID` | Cada rengl?n de producto forma parte de una orden. |
| `tbd_order_items.product_ID` | `tbd_products_users_providers.id_producto` | Identifica el producto incluido en el rengl?n de la orden. |
| `tbd_order_items.provider_ID` | `tbd_products_users_providers.ID` | Identifica al usuario proveedor asociado al producto de la orden. |
| `tbd_products_categorias.product_ID` | `tb_products.id_producto` | Indica qu? producto se est? clasificando. |
| `tbd_products_categorias.category_ID` | `tbc_categories.ID` | Indica a qu? categor?a se asigna el producto. |
| `tbd_products_users_providers.ID` | `tb_users.ID` | Indica qu? cuenta ofrece o posee el producto. |
| `tbd_products_users_providers.id_producto` | `tb_products.id_producto` | Indica qu? producto ofrece o posee la cuenta. |
| `tbd_user_payment_methods.user_ID` | `tb_users.ID` | Cada medio de pago guardado pertenece a una cuenta. |
| `tbd_user_payment_methods.payment_method_type_ID` | `tbc_payment_methods_types.ID` | Indica qu? tipo de medio de pago usa el registro. |
| `tbd_users_wishlist_products.ID` | `tb_users.ID` | Indica a qu? cuenta pertenece la lista de deseos. |
| `tbd_users_wishlist_products.id_producto` | `tb_products.id_producto` | Indica qu? producto se guard? en la lista de deseos. |

## Nota de lectura

Los nombres, tipos y restricciones se extrajeron del DDL. Las explicaciones funcionales son interpretaciones y deben confirmarse con el ?rea responsable. Las tablas con cero filas no tienen tuplas INSERT en este respaldo; su definici?n s? aparece. Los valores de `password` y `provider_method_ref` son sensibles y no deben divulgarse.
