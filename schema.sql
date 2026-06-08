-- ============================================================
-- SCHEMA: Distribuidora editorial — análisis de ventas y stock
-- Target: BigQuery (Standard SQL)
-- ============================================================

CREATE SCHEMA IF NOT EXISTS distribuidora;

-- Ventas mensuales por sucursal y título
CREATE TABLE distribuidora.ventas (
  SUCURSAL    STRING    NOT NULL,
  FECHA       STRING    NOT NULL,   -- formato YYYY-MM
  CATEGORIA   STRING    NOT NULL,
  ARTICULO    INT64     NOT NULL,
  ISBN        STRING    NOT NULL,
  TITULO      STRING    NOT NULL,
  CANTIDAD    INT64     NOT NULL
);

-- Stock consolidado por artículo (depósito, cadena, terceros)
CREATE TABLE distribuidora.stock_editorial (
  ID_ARTICULO       INT64   NOT NULL,
  ISBN              STRING  NOT NULL,
  ALTAPROD          STRING,           -- fecha de alta (YYYY-MM)
  TITULO            STRING  NOT NULL,
  COMERCIALIZACION  STRING,           -- FIRME / CONSIGNADO
  CATEGORIA         STRING,
  STOCK_DEPO        INT64,
  VAL_DEPO          FLOAT64,
  STOCK_CAD         INT64,
  VAL_CAD           FLOAT64,
  STOCK_3           INT64,
  VAL_3             FLOAT64,
  TOTAL_UNI         INT64,
  TOTAL_VAL         FLOAT64
);

-- Stock detallado por sucursal (una columna por sucursal — formato wide)
-- Nota: en un entorno real se normalizaría a formato long.
-- Para las queries se usa stock_editorial como fuente principal de stock.
