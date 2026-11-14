# Anexo: rutinas de `final2.sql`

## Inventario

El respaldo contiene **1 procedimiento**, **0 funciones**, **0 triggers** y **0 eventos**. El procedimiento es `sp_register_new_user`, `DEFINER` `root`@`localhost`, caracter?stica `MODIFIES SQL DATA`, delimitador de creaci?n `;;` (restaurado a `;`). No declara `DETERMINISTIC`, `READS SQL DATA` ni par?metros OUT/INOUT.

## An?lisis funcional y t?cnico

Registra una cuenta y su perfil personal despu?s de validar permisos y normalizar los datos recibidos. La complejidad es **media-alta**: incluye autorizaci?n, validaciones de formato y rango, verificaci?n de duplicados, dos inserciones transaccionales y manejadores de excepciones.

- **Par?metros:** 10 entradas: correo (`VARCHAR(100)`), alias (`VARCHAR(50)`), contrase?a (`VARCHAR(100)`), tratamiento (`VARCHAR(20)`), nombres (`VARCHAR(150)`), apellidos (`VARCHAR(150)`), nacimiento (`DATE`), g?nero (`VARCHAR(30)`), pa?s (`VARCHAR(50)`) y tel?fono (`VARCHAR(25)`). Descripciones campo a campo y nombres exactos en el JSON.
- **Tablas:** lee `mysql.role_edges` para comprobar roles y `tb_users` para detectar duplicados; inserta en `tb_users` y `tb_people`.
- **Transacciones:** `START TRANSACTION`, `COMMIT`; dos `EXIT HANDLER` ejecutan `ROLLBACK`; para excepciones SQL propaga con `RESIGNAL`, y para c?digo 1062 emite SQLSTATE `45000`.
- **Flujo:** autorizaci?n por rol; normalizaci?n y validaci?n; control de duplicados; inserci?n de cuenta y persona; resultado con IDs, datos b?sicos, ejecutor y marca de tiempo.

`tb_users` y `tb_people` existen en el esquema de `final2.sql`. No se identificaron referencias a tablas de negocio inexistentes. `mysql.role_edges` es una dependencia del cat?logo del servidor MySQL, ajena al esquema aplicativo exportado. La verificaci?n previa de duplicados no elimina la necesidad de las restricciones ?nicas ante concurrencia. La rutina usa `MD5` para transformar la contrase?a; es un hash d?bil para almacenamiento moderno de contrase?as y debe revisarse.

## Integraci?n visual

Se gener? `modelo_eer_diccionario_final2.html` usando el `index.html` disponible como base, ya que no exist?a un archivo fuente con el nombre solicitado. La pesta?a interactiva permite buscar en nombre, tablas y SQL, desplegar c?digo con resaltado, copiarlo y navegar a tablas presentes en el diccionario. El diccionario base se identifica como derivado de `respM.sql`; por ello la rutina conserva en el JSON todas las dependencias exactas de `final2.sql`, aunque alguna tabla no est? representada en esa base visual.
