-- ============================================================
-- 02. Ranking de sucursales por volumen de ventas
-- Pregunta: ¿Qué sucursales concentran la mayor parte de las ventas?
-- ============================================================

WITH ventas_sucursal AS (
  SELECT
    SUCURSAL,
    SUM(CANTIDAD) AS unidades,
    COUNT(DISTINCT TITULO) AS titulos_vendidos
  FROM distribuidora.ventas
  GROUP BY SUCURSAL
)
SELECT
  SUCURSAL,
  unidades,
  titulos_vendidos,
  ROUND(unidades * 100.0 / SUM(unidades) OVER(), 2) AS pct_del_total,
  ROUND(SUM(unidades) OVER(ORDER BY unidades DESC) * 100.0
    / SUM(unidades) OVER(), 2) AS pct_acumulado
FROM ventas_sucursal
ORDER BY unidades DESC
LIMIT 10;

-- Hallazgo: Sucursal AMBA 24 y Feria 01 concentran ~65% de las ventas.
-- Patrón Pareto clásico: 3 sucursales generan ~75% del volumen.
