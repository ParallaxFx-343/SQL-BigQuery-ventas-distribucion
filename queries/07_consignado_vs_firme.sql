-- ============================================================
-- 07. Comparación Consignado vs Firme
-- Pregunta: ¿Cuál es la proporción de stock según tipo de comercialización?
-- ============================================================

SELECT
  COMERCIALIZACION,
  COUNT(*) AS articulos,
  SUM(TOTAL_UNI) AS unidades,
  ROUND(SUM(TOTAL_VAL), 2) AS valor_total,
  ROUND(SUM(TOTAL_UNI) * 100.0 / (SELECT SUM(TOTAL_UNI) FROM distribuidora.stock_editorial), 2) AS pct_unidades
FROM distribuidora.stock_editorial
GROUP BY COMERCIALIZACION
ORDER BY unidades DESC;

-- Hallazgo: ~99.6% del stock es FIRME (comprado).
-- Solo 0.4% en consignación — casi toda la operación es compra directa.
