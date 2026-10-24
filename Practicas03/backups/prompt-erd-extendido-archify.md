# Prompt para Archify: modelo entidad-relación extendido

Actúa como arquitecto de datos, diseñador UX/UI y generador de diagramas Archify. Construye un **modelo entidad-relación extendido e interactivo** a partir del archivo adjunto `db_test_finald.sql`. Analiza ese archivo directamente antes de crear el resultado; conserva fielmente los identificadores, tipos, claves y relaciones.

## Fuente y cifras verificadas

El archivo se llama `db_test_finald.sql`, pero el nombre de base declarado dentro del respaldo es **`db_test_7b`** (MySQL 8.0.43). El esquema contiene **8 tablas, 59 columnas, 8 claves foráneas y 11,490 filas insertadas explícitamente**. Vuelve a calcular los conteos a partir del archivo y compáralos con esta referencia.

| Tabla SQL exacta | Filas insertadas en el respaldo | Descripción inicial para personas de negocio |
|---|---:|---|
| `tb_carts` | 0 | Carritos de compra asociados a cuentas |
| `tb_logs` | 5,752 | Historial de operaciones registradas en el sistema |
| `tb_products` | 5,000 | Catálogo de productos, precios y existencias |
| `tb_users` | 10 | Cuentas de personas que usan la plataforma |
| `tbc_categories` | 100 | Categorías y subcategorías para organizar productos |
| `tbd_products_categorias` | 628 | Asociación entre productos y categorías |
| `tbd_products_users_providers` | 0 | Productos asociados con las cuentas que los ofrecen |
| `tbd_users_wishlist_products` | 0 | Productos guardados en la lista de deseos de cada cuenta |

Estos valores son filas encontradas en el **respaldo**; no son una consulta en vivo. Etiqueta los indicadores como “Filas incluidas en el respaldo” y muestra la fuente `db_test_finald.sql`. Un cero significa que la tabla está definida, pero el respaldo no trae filas insertadas para ella. No lo presentes como garantía de que la tabla esté vacía en producción.

## Esquema que debes preservar

Utiliza la lista como guía y contrástala con el DDL. No cambies mayúsculas, guiones bajos, nombres, tipos ni precisión.

- `tb_carts`: `ID int unsigned`, `user_ID int`, `status bit(1)`, `creation_date datetime`, `last_update datetime`.
- `tb_logs`: `ID int`, `table_name varchar(80)`, `table_operation enum('Create','Read','Update','Delete')`, `db_user varchar(80)`, `operation_date datetime`, `table_description text`, `operation_status bit(1)`.
- `tb_products`: `id_producto int`, `sku varchar(30)`, `nombre varchar(150)`, `categoria varchar(100)`, `marca varchar(100)`, `variante varchar(100)`, `color varchar(50)`, `precio_mxn decimal(12,2)`, `stock int`, `proveedor varchar(150)`, `fecha_ingreso date`, `calificacion decimal(3,1)`, `ventas_mensuales int`, `activo varchar(10)`.
- `tb_users`: `ID int`, `email varchar(100)`, `nick varchar(50)`, `password varchar(255)`, `creation_date datetime`, `last_update datetime`, `last_login datetime`, `status bit(1)`, `roles varchar(50)`.
- `tbc_categories`: `ID int unsigned`, `name varchar(120)`, `description text`, `sup_id_category int unsigned`, `status bit(1)`, `creation_date datetime`, `last_update datetime`.
- `tbd_products_categorias`: `product_ID int`, `category_ID int unsigned`, `status bit(1)`, `creation_date datetime`, `last_update datetime`.
- `tbd_products_users_providers`: `ID int`, `id_producto int`, `type_ownership enum('Owner','Reseller','Distributor')`, `status bit(1)`, `avalaible_date datetime`, `creation_date datetime`, `last_update datetime`. Preserva exactamente el nombre original `avalaible_date` aunque parezca tener una errata.
- `tbd_users_wishlist_products`: `ID int`, `id_producto int`, `status bit(1)`, `creation_date datetime`, `last_update datetime`.

La lista anterior abrevia atributos como `NOT NULL`, `DEFAULT`, `AUTO_INCREMENT`, `UNSIGNED`, claves únicas y precisión; extráelos literalmente del `CREATE TABLE` y muéstralos completos en el detalle de cada campo.

## Relaciones declaradas por el DDL

Representa únicamente estas claves foráneas físicas. Conserva ambos extremos con nombres exactos y explica la relación en lenguaje cotidiano:

1. `tb_carts.user_ID` → `tb_users.ID`: cada carrito corresponde a una cuenta. `user_ID` tiene restricción única, por lo que una cuenta puede tener como máximo un carrito registrado.
2. `tbc_categories.sup_id_category` → `tbc_categories.ID`: una categoría puede depender de otra categoría superior; la referencia puede estar vacía.
3. `tbd_products_categorias.category_ID` → `tbc_categories.ID`: conecta una asignación con su categoría.
4. `tbd_products_categorias.product_ID` → `tb_products.id_producto`: conecta una asignación con su producto. La tabla puente permite clasificar productos en categorías.
5. `tbd_products_users_providers.id_producto` → `tb_products.id_producto`: conecta la oferta con el producto del catálogo.
6. `tbd_products_users_providers.ID` → `tb_users.ID`: conecta la oferta con la cuenta que ofrece el producto.
7. `tbd_users_wishlist_products.id_producto` → `tb_products.id_producto`: conecta la lista de deseos con un producto.
8. `tbd_users_wishlist_products.ID` → `tb_users.ID`: conecta la lista de deseos con su cuenta.

La PK de `tbd_products_categorias` es compuesta (`product_ID`, `category_ID`); también son compuestas las PK de `tbd_products_users_providers` (`ID`, `id_producto`) y `tbd_users_wishlist_products` (`ID`, `id_producto`). Señala cada columna que participa en la PK y FK con ambos atributos. No inventes relaciones para campos que solo tengan nombres parecidos.

## Contenido extendido de cada campo

Para cada tabla muestra el nombre exacto y una descripción breve de negocio entre paréntesis o debajo. Para cada columna muestra:

- nombre SQL original y tipo SQL exacto, incluidos longitud, precisión, `UNSIGNED` y valores permitidos de `ENUM`;
- explicación sencilla de qué representa, inferida del nombre, tipo, restricciones y ejemplos no sensibles del respaldo;
- badges accesibles por categoría: Texto, Número, Fecha, Sí/No;
- indicadores `PK`, `FK`, Único, Obligatorio (`NOT NULL`), Puede quedar vacío (`NULL`), `AUTO_INCREMENT`, valor `DEFAULT` y Calculado si la columna es generada;
- nombre exacto de la tabla/campo de destino para las FK;
- composición de campos compuestos, como `decimal(12,2)` (total de dígitos y decimales) y `ENUM` (opciones permitidas).

No inventes restricciones ni reglas operativas. Distingue `DATE` de `DATETIME`. Los tipos SQL describen cómo se almacena el dato, no siempre sus reglas de negocio. Si una interpretación no se puede confirmar con el respaldo, márcala como “Significado inferido del esquema”.

## Interacción y experiencia visual

Entrega una página HTML interactiva en español, de estilo claro, moderno y legible para personal no técnico. Incluye:

- vista ERD general con las ocho tablas y todas sus columnas visibles; zoom, desplazamiento, centrar/restablecer y foco en una tabla;
- vista de diccionario con fichas expandibles/plegables por tabla, conteo del respaldo, descripción amigable y tabla completa de campos;
- vista/listado de relaciones con frases explicativas; al seleccionar una FK, resalta ambos campos y tablas y permite abrir la ficha de cada extremo;
- búsqueda inmediata por tabla, columna, tipo, significado o tabla relacionada; filtros por área y botones para expandir/contraer;
- transiciones discretas (aprox. 150–220 ms) al expandir fichas, buscar y cambiar de vista; respeta `prefers-reduced-motion`;
- estados de teclado visibles, controles con etiquetas, contraste suficiente, leyenda que no dependa solo del color y alternativa textual al diagrama en móvil.

Usa los dominios: **Cuentas** (`tb_users`, `tbd_users_wishlist_products`), **Catálogo** (`tb_products`, `tbc_categories`, `tbd_products_categorias`, `tbd_products_users_providers`), **Compras** (`tb_carts`) y **Auditoría** (`tb_logs`).

No muestres valores reales de `tb_users.password`. Evita exponer correos, nombres de usuario, detalles de auditoría o cualquier otro valor personal de los `INSERT`; bastan tipos y ejemplos sintéticos/no sensibles. No muestres filas completas del respaldo.

## Requisitos de Archify y entrega

Genera un ERD Archify válido, de tipo `erd`, con todas las columnas en `entities[].attributes`, el tipo SQL exacto y los roles de clave correctos (`pk`, `fk` o ambos), así como `references` para cada FK. Organiza las tablas por dominio y conserva las ocho relaciones. No agregues propiedades no admitidas por el esquema ERD de Archify para intentar guardar conteos o descripciones extensas: esos datos deben vivir en el modelo de la interfaz HTML complementaria.

Entrega el HTML autocontenido como `modelo-er-extendido-db-test-finald.html`, junto con el JSON de candidato Archify. Antes de finalizar, verifica que haya 8 tablas, 59 columnas, 8 FK y los conteos por tabla indicados; reporta diferencias si la lectura del SQL arroja otros resultados. Indica claramente en la interfaz que las cifras proceden del respaldo `db_test_finald.sql`, no de una base conectada en vivo.
