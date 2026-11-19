# Informe t?cnico de la base de datos `db_test_7b`

**Fuente ?nica de verdad:** `final2.sql`. Este informe distingue las definiciones presentes en el archivo de aquello que requerir?a comprobarse en una instancia activa.

## Resumen ejecutivo

El respaldo declara **25 tablas**, **189 columnas**, **30 claves for?neas**, **72 triggers**, **25 vistas ?nicas** y **1 rutina almacenada**. El dominio funcional integra cuentas/personas, cat?logo, carritos y ?rdenes, pagos, env?os, devoluciones, rese?as y bit?cora. El modelo usa tablas de detalle/asociaci?n (`tbd_*`) y cat?logos (`tbc_*`) adem?s de entidades principales (`tb_*`).

## Arquitectura relacional y documentaci?n

`modelo_eer_final2.html` ofrece un resumen ejecutivo, un diagrama navegable con relaciones FK, diccionario filtrable en tiempo real y una vista de trazabilidad. El cat?logo JSON incluye definiciones de columnas, tipos SQL, nulabilidad, DEFAULT, PK, FK, UNIQUE, CHECK y motor de almacenamiento, adem?s de objetos programables.

La integridad referencial se contrast? est?ticamente contra el DDL: **30 FK revisadas; 0 referencias a tablas o columnas inexistentes** dentro del archivo. Esto demuestra consistencia estructural de los destinos declarados, pero no valida registros existentes ni prueba que el dump se restaure correctamente en una instalaci?n.

## Bit?cora `tb_logs`

La tabla conserva `id_logs` como clave primaria y campos para nombre de tabla, operaci?n, usuario, fecha, descripci?n y estado. El inventario identifica 72 definiciones de trigger, cubriendo eventos AFTER INSERT, AFTER UPDATE y AFTER DELETE para las tablas de negocio instrumentadas. El enum de `table_operation` permite tambi?n `Read`; sin embargo, los triggers de fila identificados auditan escrituras y no acreditan captura autom?tica de consultas SELECT.

El respaldo contiene 24 vistas `vw_trazabilidad_*` y la vista agregada `vw_total_products_by_category`. Algunas vistas relacionan bit?cora solo por nombre de tabla; otras comparan IDs incluidos en texto descriptivo. Estas ?ltimas pueden producir asociaciones incompletas o ambiguas y requieren validaci?n funcional.

## Reglas de negocio identificadas

- `tb_users` declara email y nick ?nicos.
- Tablas de cat?logo y transacci?n incorporan claves y checks definidos por el esquema.
- `sp_register_new_user` comprueba un rol permitido y valida/normaliza datos; luego registra usuario y persona dentro de una transacci?n con manejo de errores.
- Triggers `trq_*` generan trazas de operaciones de escritura.
- Vistas `vw_trazabilidad_*` exponen campos de entidades junto con columnas de auditor?a.

La lista estructurada est? en `procedimientos_final2.json`; incluye los SQL de vistas y cuerpos de triggers extra?dos del respaldo.

## Estado de cumplimiento y alcance de la evidencia

Los tres artefactos solicitados est?n incluidos en `archify/`: p?gina web, inventario JSON e informe Markdown. Eso acredita la cobertura de los entregables documentales de esta solicitud. **No es posible afirmar que el proyecto cumple el 100% de todos sus requisitos** usando solo `final2.sql`: aqu? no se proporciona una matriz de requisitos ni criterios de aceptaci?n contra los cuales medir ese porcentaje. La p?gina y el JSON, por tanto, documentan lo comprobable sin convertirlo en una certificaci?n externa.

Los objetos se describen como definidos en el respaldo. Para afirmar que est?n activos habr?a que consultar la instancia MySQL; tambi?n requerir?a ejecuci?n comprobar privilegios del DEFINER, compatibilidad del servidor y resultado de restauraci?n.

## Archivos

- [modelo_eer_final2.html](modelo_eer_final2.html)
- [procedimientos_final2.json](procedimientos_final2.json)
- [informe_final2.md](informe_final2.md)
