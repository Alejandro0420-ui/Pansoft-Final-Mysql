-- Agregar columnas para recuperación de contraseña
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS reset_token VARCHAR(255) NULL,
ADD COLUMN IF NOT EXISTS reset_token_expires DATETIME NULL;

-- Verificar que se agregaron
-- SHOW COLUMNS FROM users LIKE 'reset_token';