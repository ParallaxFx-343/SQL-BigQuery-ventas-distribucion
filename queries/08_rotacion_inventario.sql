-- ============================================================
-- 08. Rotación de inventario por categoría (ventas / stock)
-- Pregunta: ¿Qué categorías rotan más rápido?
-- ============================================================

WITH ventas_cat AS (
  SELECT
    CATEGORIA,
    SUM(CANTIDAD) AS unidades_vendidas
  FROM distribuidora.ventas
  GROUP BY CATEGORIA
),
stock_cat AS (
  SELECT
    CATEGORIA,
    SUM(TOTAL_UNI) AS unidades_stock
  FROM distribuidora.stock_editorial
  GROUP BY CATEGORIA
)
SELECT
  v.CATEGORIA,
  v.unidades_vendidas,
  COALESCE(s.unidades_stock, 0) AS unidades_stock,
  CASE
    WHEN COALESCE(s.unidades_stock, 0) = 0 THEN NULL
    ELSE ROUND(v.unidades_vendidas * 1.0 / s.unidades_stock, 2)
  END AS ratio_rotacion
FROM ventas_cat v
LEFT JOIN stock_cat s ON v.CATEGORIA = s.CATEGORIA
ORDER BY ratio_rotacion DESC NULLS LAST;

-- Hallazgo: Las categorías con alta rotación (ratio > 1) tienen ventas
-- que superan su stock actual — señal de reposición frecuente o riesgo de quiebre.
-- Categorías con ratio bajo (<0.1) tienen inventario estancado.
