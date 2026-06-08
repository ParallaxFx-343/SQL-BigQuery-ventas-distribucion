-- ============================================================
-- 04. Top 15 títulos más vendidos
-- Pregunta: ¿Cuáles son los títulos estrella?
-- ============================================================

SELECT
  TITULO,
  CATEGORIA,
  SUM(CANTIDAD) AS unidades,
  COUNT(DISTINCT SUCURSAL) AS sucursales_presentes
FROM distribuidora.ventas
GROUP BY TITULO, CATEGORIA
ORDER BY unidades DESC
LIMIT 15;

-- Hallazgo: "La torre en la niebla" lidera con 1.280 uds,
-- vendido en pocas sucursales (concentración en Feria 01).
-- Los top 15 títulos representan ~40% de las ventas totales.
