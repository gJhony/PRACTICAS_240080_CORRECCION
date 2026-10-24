# Especificación para Archify: Diccionario de Datos Interactivo

## Fuente y alcance

Construir una aplicación web de consulta titulada **Diccionario de datos — db_test_7b**, para personal de negocio, administración y operaciones. La fuente examinada es `respM.sql` (respaldo MySQL, base `db_test_7b`). No se encontró `RES 20.sql` en la carpeta de trabajo; por tanto, los conteos de abajo corresponden a filas presentes en instrucciones `INSERT` de `respM.sql`, no a una consulta en vivo. Indicar esta fecha/fuente como “Conteo incluido en el respaldo” y no afirmar que son cifras actuales de producción.

Hay 13 tablas, 17 claves foráneas declaradas y 11,478 filas insertadas explícitamente en total. No exponer valores sensibles ni muestras de `password`, `provider_method_ref` o datos que identifiquen personas. Las descripciones funcionales se infieren por nombres, tipos, constraints, relaciones y registros de ejemplo. Marcar inferencias como “Descripción interpretada del esquema”.

## Inventario verificado

| Tabla exacta | Explicación para negocio | Filas `INSERT` del respaldo |
|---|---|---:|
| `tb_users` | Cuentas de personas que usan la plataforma | 10 |
| `tb_products` | Catálogo de productos, precios y existencias | 5,000 |
| `tbc_categories` | Categorías y subcategorías para organizar productos | 100 |
| `tbc_payment_methods_types` | Tipos de medios de pago admitidos | 0 |
| `tb_buyer_orders` | Órdenes de compra registradas por un vendedor | 0 |
| `tb_carts` | Carritos de compra de usuarios | 0 |
| `tbd_carts_items` | Productos y cantidades dentro de cada carrito | 0 |
| `tbd_order_items` | Productos que componen cada orden | 0 |
| `tbd_products_categorias` | Asociación entre productos y categorías | 628 |
| `tbd_products_users_providers` | Asociación de productos con usuarios proveedores y propiedad/disponibilidad | 0 |
| `tbd_user_payment_methods` | Medios de pago asociados a una cuenta | 0 |
| `tbd_users_wishlist_products` | Productos guardados por cada usuario | 0 |
| `tb_logs` | Historial de acciones realizadas en el sistema | 5,740 |

Conteos son número de tuplas del `INSERT` en el dump. Cero significa que no hay filas insertadas para esa tabla en este archivo; no inferir que la tabla siempre estará vacía. No sumar IDs o registros mencionados dentro del texto de auditoría como filas de otras tablas.

## Relaciones que deben explicarse en lenguaje cotidiano

Conservar tabla y columna técnicas en cada frase. Mostrar una vista de relaciones con enlaces a la ficha de tabla.

- `tb_buyer_orders.seller_ID` → `tb_users.ID`: cada orden identifica la cuenta del vendedor asociado.
- `tb_carts.user_ID` → `tb_users.ID`: cada carrito pertenece a una cuenta.
- `tbc_categories.sup_id_category` → `tbc_categories.ID`: una categoría puede depender de otra categoría superior; la referencia puede quedar vacía.
- `tbd_carts_items.cart_ID` → `tb_carts.ID`: cada producto del detalle pertenece a un carrito.
- `tbd_carts_items.provider_ID` → `tbd_products_users_providers.ID` y `product_ID` → `tbd_products_users_providers.id_producto`: el renglón del carrito identifica la combinación de producto y proveedor disponible.
- `tbd_order_items.seller_order_ID` → `tb_buyer_orders.ID`: cada renglón de producto forma parte de una orden.
- `tbd_order_items.product_ID` → `tbd_products_users_providers.id_producto` y `provider_ID` → `tbd_products_users_providers.ID`: el renglón conserva el producto ofrecido y su proveedor.
- `tbd_products_categorias.product_ID` → `tb_products.id_producto` y `category_ID` → `tbc_categories.ID`: conecta productos con categorías; permite clasificar productos sin duplicar sus datos.
- `tbd_products_users_providers.ID` → `tb_users.ID` y `id_producto` → `tb_products.id_producto`: indica qué usuario ofrece/posee cada producto.
- `tbd_user_payment_methods.user_ID` → `tb_users.ID` y `payment_method_type_ID` → `tbc_payment_methods_types.ID`: cada medio de pago guardado pertenece a una cuenta y usa un tipo definido.
- `tbd_users_wishlist_products.ID` → `tb_users.ID` y `id_producto` → `tb_products.id_producto`: conecta una cuenta con los productos de su lista de deseos.

Las FK de tablas puente con PK compuesta deben marcar ambas funciones: por ejemplo `tbd_products_users_providers.ID` es PK y FK; no reducirlo a una sola insignia. Verificar PK y columnas exactas directamente contra `CREATE TABLE`; dibujar las referencias compuestas en la vista ERD sin cambiar el esquema original.

## Interfaz solicitada

Crear una experiencia interactiva en español, adaptable a escritorio y móvil, con dos vistas sincronizadas: **Diccionario** como vista principal y **Relaciones** como mapa ERD complementario. La aplicación debe funcionar desde un HTML autocontenido, sin backend y sin dependencias remotas obligatorias.

### Cabecera y navegación

- Título y explicación breve: “Consulta qué guarda cada tabla y cómo se relaciona con las demás”.
- Indicadores: `13 tablas`, `17 claves foráneas`, `11,478 filas en el respaldo`.
- Búsqueda global inmediata por nombre técnico, significado, tipo SQL o tabla relacionada; resaltar coincidencias y mostrar estado vacío útil.
- Filtros por área: Cuentas, Catálogo, Compra, Pagos, Auditoría.
- Selector de vista Diccionario / Relaciones; menú lateral de tablas con conteos.
- Acciones “Expandir todas” / “Contraer todas”. Mantener la búsqueda/filtro al cambiar de vista.

### Tarjetas y fichas de tablas

Cada tabla debe mostrar el nombre SQL exacto y enseguida su subtítulo cotidiano, conteo en el respaldo, cantidad de campos y etiqueta del dominio. Las tablas se despliegan con animación breve y respetan `prefers-reduced-motion`.

Dentro de cada tabla, usar columnas: **Campo y significado**, **Tipo SQL**, **Dato que almacena**, **Reglas**. Para cada campo mantener exactamente el nombre y tipo extraídos del DDL (incluyendo tamaño, precisión y `UNSIGNED` cuando exista), explicar en una frase llana su utilidad y mostrar badges reconocibles:

- Texto: `CHAR`, `VARCHAR`, `TEXT`, `ENUM`.
- Número: `INT`, `BIGINT`, `DECIMAL`, `TINYINT`.
- Fecha: `DATE`, `DATETIME`.
- Sí/No: `BIT(1)`, `TINYINT(1)` solo cuando represente indicador.
- Clave primaria `PK`, referencia a otra tabla `FK`, valor único `Único` si el DDL lo declara.
- `Obligatorio` si `NOT NULL`; `Puede quedar vacío` si permite NULL. Indicar `AUTO_INCREMENT` y `DEFAULT` cuando estén declarados.

No adivinar restricciones: extraer PK/FK/UNIQUE/NULL/DEFAULT literalmente del `CREATE TABLE`; inferir solamente la explicación funcional. Mostrar el valor de ejemplo solo si es inocuo y anonimizado, y nunca mostrar hashes, contraseñas, referencias de pago o datos personales reales. En campos sensibles incluir aviso neutral “Dato sensible: valor oculto”.

### Vista Relaciones

Presentar un diagrama ERD con las 13 tablas y solo relaciones físicas declaradas en el dump. Añadir leyenda accesible para PK/FK/nullable y cardinalidad; al seleccionar una conexión, explicar la frase correspondiente en una tarjeta. En móvil, proveer lista equivalente de conexiones para no depender del zoom del diagrama. Las tablas puente se agrupan visualmente en Compra, Clasificación, Catálogo, Cuentas y Pagos. El diagrama puede ser una vista general con foco/zoom y un panel detalle; no intentar poner explicaciones largas dentro de las cajas.

### Diseño y accesibilidad

Estética editorial y sobria: fondo claro cálido, texto oscuro de alto contraste, acento azul petróleo, espacio generoso y tipografía sans serif. No depender únicamente del color para identificar badges. Estados de foco de teclado visibles, controles con etiquetas, encabezados semánticos, tabla con navegación móvil o filas apiladas, área de toque cómoda, contraste WCAG AA. Animar búsqueda, cambio de vista y despliegue con transiciones discretas (150–220 ms); desactivarlas con `prefers-reduced-motion`. Las acciones deben funcionar también con teclado.

## Reglas de calidad del contenido

1. Leer `respM.sql` como fuente de autoridad; conservar cada identificador y tipo SQL sin traducir ni normalizar.
2. No inventar tablas, columnas, FK, cardinalidades, reglas operativas o valores permitidos que no estén en el DDL.
3. En `ENUM`, listar las opciones exactas del DDL en el detalle. Aclarar que describe opciones técnicas, no una política del negocio.
4. Describir datos de productos como precio en MXN solo si el campo/nombre o evidencia del dump lo respalda; describir `stock` como existencia registrada.
5. Distinguir `fecha_ingreso` (DATE) de marcas de tiempo de creación/actualización (DATETIME).
6. Para `tb_logs`, explicar que registra quién ejecutó qué operación, sobre qué tabla y cuándo; no presentar el contenido textual de auditoría como prueba de que toda acción fue exitosa sin leer `operation_status`.
7. `tb_users.password` y `tbd_user_payment_methods.provider_method_ref` son sensibles: explicar su finalidad sin divulgar valores ni sugerir que el diccionario revela credenciales.
8. Explicar que las tablas de órdenes/carritos/pago no tienen tuplas INSERT en este respaldo; sus definiciones y relaciones sí aparecen.
9. Incluir en pie: “Conteos leídos de `respM.sql`; pueden diferir de la base de datos en uso. Las explicaciones de negocio son interpretaciones del esquema y deben validarse con el área responsable”.

## Nota de implementación para Archify

Usa Archify ERD para la vista de relaciones y conserva todos los atributos físicos, tipos SQL, PK, FK, referencias y grupos por dominio. Su esquema de ERD no tiene campos nativos para descripción por columna ni conteo por entidad; por eso el diccionario principal debe ser una interfaz HTML interactiva propia que consuma un modelo JSON generado a partir del DDL y los INSERT. No rellenar atributos no soportados del JSON de Archify ni sacrificar columnas para hacer caber el diagrama. Mantener descripciones, nulabilidad, defaults y conteos en el modelo de datos de la interfaz.

### Contrato JSON sugerido para el componente de diccionario

```json
{
  "source": {"file": "respM.sql", "database": "db_test_7b", "countBasis": "tuplas INSERT del respaldo"},
  "tables": [{
    "name": "tb_users",
    "businessName": "Cuentas de personas que usan la plataforma",
    "rowCountInDump": 10,
    "domain": "Cuentas",
    "descriptionBasis": "inferencia",
    "columns": [{
      "name": "ID",
      "sqlType": "INT",
      "meaning": "Identificador de la cuenta",
      "badges": ["Número", "PK", "Obligatorio", "AUTO_INCREMENT"],
      "nullable": false,
      "default": null,
      "references": null,
      "sensitive": false
    }]
  }],
  "relationships": [{
    "from": "tb_carts.user_ID",
    "to": "tb_users.ID",
    "businessExplanation": "Cada carrito pertenece a una cuenta de usuario."
  }]
}
```

Generar las descripciones restantes a partir del esquema real; el ejemplo de JSON solo ilustra el contrato, no sustituye la extracción completa de columnas.


