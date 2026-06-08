-- ============================================================
-- 01. Resumen general del negocio
-- Pregunta: ¿Cuál es el volumen total de operación?
-- ============================================================

SELECT
  COUNT(DISTINCT SUCURSAL)  AS total_sucursales,
  COUNT(DISTINCT TITULO)    AS total_titulos,
  COUNT(DISTINCT CATEGORIA) AS total_categorias,
  SUM(CANTIDAD)             AS total_unidades_vendidas
FROM distribuidora.ventas;

-- Resultado esperado:
-- total_sucursales | total_titulos | total_categorias | total_unidades_vendidas
-- 63              | 594           | 18               | 45.261
