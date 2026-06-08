-- ============================================================
-- 05. Análisis de Pareto (80/20) por título
-- Pregunta: ¿Cuántos títulos generan el 80% de las ventas?
-- ============================================================

WITH ranking AS (
  SELECT
    TITULO,
    SUM(CANTIDAD) AS unidades,
    ROW_NUMBER() OVER(ORDER BY SUM(CANTIDAD) DESC) AS rn,
    COUNT(*) OVER() AS total_titulos
  FROM distribuidora.ventas
  GROUP BY TITULO
),
acumulado AS (
  SELECT
    *,
    SUM(unidades) OVER(ORDER BY rn) AS acum,
    SUM(unidades) OVER() AS total
  FROM ranking
)
SELECT
  rn AS posicion,
  TITULO,
  unidades,
  ROUND(acum * 100.0 / total, 2) AS pct_acumulado,
  ROUND(rn * 100.0 / total_titulos, 2) AS pct_titulos
FROM acumulado
WHERE acum <= total * 0.8
   OR rn = (SELECT MIN(rn) FROM acumulado WHERE acum >= total * 0.8)
ORDER BY rn;

-- Hallazgo: Aproximadamente el 20% de los títulos (~120 de 594)
-- genera el 80% de las unidades vendidas. Pareto confirmado.
