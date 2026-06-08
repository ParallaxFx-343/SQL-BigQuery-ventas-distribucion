-- ============================================================
-- 10. Mix de categorías por sucursal (diversificación)
-- Pregunta: ¿Las sucursales top dependen de una sola categoría?
-- ============================================================

WITH ventas_suc_cat AS (
  SELECT
    SUCURSAL,
    CATEGORIA,
    SUM(CANTIDAD) AS unidades
  FROM distribuidora.ventas
  GROUP BY SUCURSAL, CATEGORIA
),
total_suc AS (
  SELECT
    SUCURSAL,
    SUM(unidades) AS total
  FROM ventas_suc_cat
  GROUP BY SUCURSAL
),
ranked AS (
  SELECT
    v.SUCURSAL,
    v.CATEGORIA,
    v.unidades,
    ROUND(v.unidades * 100.0 / t.total, 2) AS pct,
    ROW_NUMBER() OVER(PARTITION BY v.SUCURSAL ORDER BY v.unidades DESC) AS rn
  FROM ventas_suc_cat v
  JOIN total_suc t ON v.SUCURSAL = t.SUCURSAL
  WHERE t.total >= 100
)
SELECT
  SUCURSAL,
  CATEGORIA AS categoria_principal,
  pct AS pct_categoria_principal,
  CASE
    WHEN pct > 70 THEN 'Alta dependencia'
    WHEN pct > 50 THEN 'Moderada'
    ELSE 'Diversificada'
  END AS nivel_concentracion
FROM ranked
WHERE rn = 1
ORDER BY pct DESC;

-- Hallazgo: Sucursales como Feria 01 tienen alta dependencia de Juvenil (>70%).
-- Si esa categoría cae, el impacto es directo.
