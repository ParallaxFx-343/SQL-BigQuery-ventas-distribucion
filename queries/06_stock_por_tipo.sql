-- ============================================================
-- 06. Distribución de stock por tipo de ubicación
-- Pregunta: ¿Cómo se distribuye el inventario entre depósito, cadena y terceros?
-- ============================================================

SELECT
  'Depósito' AS ubicacion,
  SUM(STOCK_DEPO) AS unidades,
  ROUND(SUM(VAL_DEPO), 2) AS valor,
  ROUND(SUM(STOCK_DEPO) * 100.0 / SUM(TOTAL_UNI), 2) AS pct_unidades
FROM distribuidora.stock_editorial
WHERE TOTAL_UNI > 0

UNION ALL

SELECT
  'Cadena',
  SUM(STOCK_CAD),
  ROUND(SUM(VAL_CAD), 2),
  ROUND(SUM(STOCK_CAD) * 100.0 / SUM(TOTAL_UNI), 2)
FROM distribuidora.stock_editorial
WHERE TOTAL_UNI > 0

UNION ALL

SELECT
  'Terceros',
  SUM(STOCK_3),
  ROUND(SUM(VAL_3), 2),
  ROUND(SUM(STOCK_3) * 100.0 / SUM(TOTAL_UNI), 2)
FROM distribuidora.stock_editorial
WHERE TOTAL_UNI > 0

ORDER BY unidades DESC;

-- Hallazgo: Stock terceros es el mayor componente (~45%),
-- seguido por cadena (~35%) y depósito (~20%).
