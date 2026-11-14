# Práctica 03: Diseño y documentación de una base de datos E-Commerce

## Documentación publicada

El sitio reúne la portada de la práctica, el modelo entidad-relación interactivo y la documentación técnica del esquema `db_test_7b`.

| Recurso | Descripción | Enlace |
|---|---|---|
| **Portada de la práctica** | Resumen y navegación de los materiales publicados. | [Abrir sitio](https://gjhony.github.io/PRACTICAS_240080_CORRECCION/) |
| **Modelo EER y diccionario de datos actualizado** | Modelo interactivo con relaciones, atributos, restricciones y datos del respaldo `final4.sql`. | [Abrir modelo final4](https://gjhony.github.io/PRACTICAS_240080_CORRECCION/archify/final4_model.html) |
| **Modelo EER anterior** | Versión previa del modelo, generada desde `final3.sql`. | [Abrir modelo final3](https://gjhony.github.io/PRACTICAS_240080_CORRECCION/archify/final3_model.html) |
| **Modelo EER anterior** | Versión previa del diccionario interactivo, generada desde `final2.sql`. | [Abrir modelo final2](https://gjhony.github.io/PRACTICAS_240080_CORRECCION/modelo_eer_diccionario_final2.html) |
| **Diagrama EER anterior** | Vista independiente de la versión anterior del modelo. | [Abrir diagrama anterior](https://gjhony.github.io/PRACTICAS_240080_CORRECCION/archify/modelo_eer_final2.html) |
| **Informe técnico** | Inventario del esquema y alcance de la evidencia disponible. | [Leer informe](https://github.com/gJhony/PRACTICAS_240080_CORRECCION/blob/Practica03/Practicas03/docs/informe_final2.md) |
| **Consultas de verificación** | Consultas SQL para revisar tablas, triggers, bitácora y rutinas. | [Ver consultas](queries/consultas_verificaciones.sql) |

> La documentación se genera desde archivos de respaldo SQL. Las cantidades reportadas describen esos archivos; no representan datos consultados en vivo en un servidor.

## Descripción general

Esta práctica documenta una base de datos relacional para un sistema de comercio electrónico. El esquema `db_test_7b` organiza cuentas y personas, catálogo de productos y categorías, carritos y órdenes, pagos, envíos, devoluciones, reseñas y registros de auditoría.

El modelo interactivo actualizado se genera desde `final4.sql`: **25 tablas, 189 columnas, 30 claves foráneas, 72 triggers, 25 vistas únicas y 1 procedimiento almacenado**. Estas cantidades describen el respaldo; su presencia en el archivo no demuestra por sí sola que los objetos estén activos en una instancia MySQL. El informe `informe_final2.md` conserva el análisis de una versión anterior.

## Actividades y contenido

- Diseño y lectura de entidades y relaciones para el dominio E-Commerce.
- Identificación de claves primarias, claves foráneas, restricciones y tablas de asociación.
- Documentación de triggers de auditoría, vistas de trazabilidad y procedimiento almacenado.
- Consultas SQL para inspeccionar objetos de la base y datos disponibles.
- Preparación de datos de ejemplo para productos y categorías.

## Estructura del proyecto

```text
Practicas03/
├── README.md
├── backups/                 # Respaldos SQL y materiales de referencia
├── docs/
│   ├── index.html           # Portada de GitHub Pages
│   ├── archify/
│   │   ├── final4_model.html  # Modelo actualizado desde final4.sql
│   │   └── final3_model.html  # Versión anterior
│   ├── modelo_eer_diccionario_final2.html  # Versión anterior
│   ├── informe_final2.md
│   └── archify/              # Diagrama e informe complementarios
├── queries/
│   └── consultas_verificaciones.sql
├── scripts/                 # Configuración de usuarios remotos y privilegios
└── seeders/                 # Datos de ejemplo para carga
```

## Publicación en GitHub Pages

El flujo [deploy-pages.yml](../.github/workflows/deploy-pages.yml) publica automáticamente el contenido de `Practicas03/docs` al hacer push a la rama `Practica03`. También se puede iniciar manualmente desde **Actions → Publicar Practicas03 en GitHub Pages → Run workflow**.

La primera vez, si el sitio todavía no se publica, abre **Settings → Pages** en el repositorio y selecciona **GitHub Actions** como fuente de despliegue. El sitio publicado queda disponible en [gjhony.github.io/PRACTICAS_240080_CORRECCION](https://gjhony.github.io/PRACTICAS_240080_CORRECCION/).
