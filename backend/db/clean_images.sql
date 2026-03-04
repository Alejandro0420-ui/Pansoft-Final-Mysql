-- Limpiar todas las imágenes de productos
UPDATE products SET image_url = NULL WHERE image_url IS NOT NULL;

-- Verificar que se actualizaron
SELECT COUNT(*) as productos_sin_imagen FROM products WHERE image_url IS NULL;
