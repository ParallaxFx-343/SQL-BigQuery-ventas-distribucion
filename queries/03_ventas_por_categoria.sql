-- ============================================================
-- 03. Ventas por categoría con participación porcentual
-- Pregunta: ¿Qué categorías dominan las ventas?
-- ============================================================

SELECT
  CATEGORIA,
  SUM(CANTIDAD) AS unidades,
  COUNT(DISTINCT TITULO) AS titulos,
  ROUND(SUM(CANTIDAD) * 100.0 / (SELECT SUM(CANTIDAD) FROM distribuidora.ventas), 2) AS pct_ventas
FROM distribuidora.ventas
GROUP BY CATEGORIA
ORDER BY unidades DESC;

-- Hallazgo: LIBROS > Juvenil representa ~53% de las unidades vendidas.
-- Es la categoría core del negocio, seguida por Ciencia (~17%) y Académico (~9%).
