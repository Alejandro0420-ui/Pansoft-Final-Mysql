-- Verificar estructura de la tabla supplies
DESCRIBE supplies;

-- Si la tabla existe, mostrar su información
SELECT COLUMN_NAME, COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'supplies' AND TABLE_SCHEMA = DATABASE();
