-- ============================================================
-- 09. Títulos con riesgo de quiebre de stock
-- Pregunta: ¿Qué títulos venden mucho pero tienen poco stock?
-- ============================================================

WITH ventas_titulo AS (
  SELECT
    TITULO,
    ISBN,
    CATEGORIA,
    SUM(CANTIDAD) AS unidades_vendidas
  FROM distribuidora.ventas
  GROUP BY TITULO, ISBN, CATEGORIA
),
stock_titulo AS (
  SELECT
    ISBN,
    TOTAL_UNI AS unidades_stock
  FROM distribuidora.stock_editorial
)
SELECT
  v.TITULO,
  v.CATEGORIA,
  v.unidades_vendidas,
  COALESCE(s.unidades_stock, 0) AS unidades_stock,
  CASE
    WHEN COALESCE(s.unidades_stock, 0) = 0 THEN 'SIN STOCK'
    WHEN v.unidades_vendidas > s.unidades_stock * 2 THEN 'CRITICO'
    WHEN v.unidades_vendidas > s.unidades_stock THEN 'ALERTA'
    ELSE 'OK'
  END AS estado
FROM ventas_titulo v
LEFT JOIN stock_titulo s ON v.ISBN = s.ISBN
WHERE COALESCE(s.unidades_stock, 0) < v.unidades_vendidas
ORDER BY v.unidades_vendidas DESC
LIMIT 20;

-- Hallazgo: Identificamos títulos donde las ventas del mes superan el stock
-- disponible. Estos requieren reposición urgente o están agotados.
