# Análisis de ventas y distribución editorial — SQL / BigQuery

Proyecto de análisis de datos sobre un dataset real (anonimizado) de una distribuidora editorial argentina. Se responden preguntas de negocio usando SQL estándar compatible con BigQuery.

## Dataset

| Tabla | Registros | Descripción |
|-------|-----------|-------------|
| `ventas` | ~9.000 | Ventas mensuales por sucursal, título y categoría |
| `stock_editorial` | ~2.100 | Stock consolidado por artículo (depósito, cadena, terceros) |
| `stock_sucursales` | ~1.200 | Stock detallado por sucursal (formato wide) |

**Alcance**: 63 sucursales, 594 títulos, 18 categorías, 45.261 unidades vendidas.

## Preguntas de negocio

| # | Pregunta | Query | Técnicas SQL |
|---|----------|-------|-------------|
| 01 | ¿Cuál es el volumen total de operación? | [01_resumen_general.sql](queries/01_resumen_general.sql) | Agregaciones, COUNT DISTINCT |
| 02 | ¿Qué sucursales concentran las ventas? | [02_top_sucursales.sql](queries/02_top_sucursales.sql) | CTE, Window Functions (SUM OVER) |
| 03 | ¿Qué categorías dominan? | [03_ventas_por_categoria.sql](queries/03_ventas_por_categoria.sql) | Subquery escalar, GROUP BY |
| 04 | ¿Cuáles son los títulos estrella? | [04_top_titulos.sql](queries/04_top_titulos.sql) | GROUP BY múltiple, ORDER + LIMIT |
| 05 | ¿Cuántos títulos generan el 80% de ventas? | [05_concentracion_pareto.sql](queries/05_concentracion_pareto.sql) | ROW_NUMBER, acumulado con Window Functions |
| 06 | ¿Cómo se distribuye el stock por ubicación? | [06_stock_por_tipo.sql](queries/06_stock_por_tipo.sql) | UNION ALL, agregaciones |
| 07 | ¿Consignado vs Firme? | [07_consignado_vs_firme.sql](queries/07_consignado_vs_firme.sql) | Subquery, porcentajes |
| 08 | ¿Qué categorías rotan más rápido? | [08_rotacion_inventario.sql](queries/08_rotacion_inventario.sql) | CTE doble, LEFT JOIN, COALESCE |
| 09 | ¿Qué títulos tienen riesgo de quiebre? | [09_riesgo_quiebre.sql](queries/09_riesgo_quiebre.sql) | JOIN, CASE, filtrado condicional |
| 10 | ¿Las sucursales dependen de una categoría? | [10_sucursales_mix_categorias.sql](queries/10_sucursales_mix_categorias.sql) | CTE encadenados, PARTITION BY |

## Hallazgos clave

- **Pareto confirmado**: ~20% de los títulos genera el 80% de las ventas
- **Concentración geográfica**: 3 sucursales (AMBA 24, Feria 01, AMBA 01) representan ~75% del volumen
- **Categoría dominante**: Juvenil = 53% de las ventas — riesgo de dependencia
- **Modelo de negocio**: 99.6% del stock es compra firme (no consignación)
- **Alertas de stock**: Títulos best-seller con ventas que superan el stock disponible

## Stack

- **SQL** (BigQuery Standard SQL)
- **BigQuery** (Google Cloud)

## Cómo ejecutar

1. Crear un dataset en BigQuery (o usar el sandbox gratuito)
2. Cargar los CSV desde `data/` a las tablas definidas en `schema.sql`
3. Ejecutar las queries en orden desde `queries/`

## Estructura

```
sql-bigquery-project/
├── README.md
├── schema.sql
├── data/
│   ├── ventas.csv
│   ├── stock_editorial.csv
│   └── stock_sucursales.csv
└── queries/
    ├── 01_resumen_general.sql
    ├── 02_top_sucursales.sql
    ├── 03_ventas_por_categoria.sql
    ├── 04_top_titulos.sql
    ├── 05_concentracion_pareto.sql
    ├── 06_stock_por_tipo.sql
    ├── 07_consignado_vs_firme.sql
    ├── 08_rotacion_inventario.sql
    ├── 09_riesgo_quiebre.sql
    └── 10_sucursales_mix_categorias.sql
```
