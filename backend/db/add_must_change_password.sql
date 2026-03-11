-- Agregar columna must_change_password a tabla users
ALTER TABLE users ADD COLUMN must_change_password BOOLEAN DEFAULT FALSE;
