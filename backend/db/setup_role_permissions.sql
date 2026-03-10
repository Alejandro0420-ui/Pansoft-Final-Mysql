-- Asignar permisos a roles
-- ============================================
-- ADMINISTRADOR GENERAL - Acceso total
-- ============================================

-- Primero, limpiar permisos existentes
DELETE FROM role_permissions WHERE role_id = (SELECT id FROM roles WHERE name = 'Administrador General');

-- Asignar todos los permisos a Administrador General
INSERT INTO role_permissions (role_id, permission_id)
SELECT 
  (SELECT id FROM roles WHERE name = 'Administrador General'),
  id 
FROM permissions;

-- ============================================
-- SUPERVISOR DE STOCK
-- ============================================
DELETE FROM role_permissions WHERE role_id = (SELECT id FROM roles WHERE name = 'Supervisor de Stock');

-- Supervisores NO pueden ver Empleados y Reportes
INSERT INTO role_permissions (role_id, permission_id)
SELECT 
  (SELECT id FROM roles WHERE name = 'Supervisor de Stock'),
  id 
FROM permissions
WHERE module NOT IN ('employees', 'reports');

-- ============================================
-- ENCARGADO DE VENTAS
-- ============================================
DELETE FROM role_permissions WHERE role_id = (SELECT id FROM roles WHERE name = 'Encargado de Ventas');

-- Encargados NO pueden ver Empleados y Reportes
INSERT INTO role_permissions (role_id, permission_id)
SELECT 
  (SELECT id FROM roles WHERE name = 'Encargado de Ventas'),
  id 
FROM permissions
WHERE module NOT IN ('employees', 'reports');

-- ============================================
-- PANADERO
-- ============================================
DELETE FROM role_permissions WHERE role_id = (SELECT id FROM roles WHERE name = 'Panadero');

-- Panaderos NO pueden ver Empleados y Reportes
INSERT INTO role_permissions (role_id, permission_id)
SELECT 
  (SELECT id FROM roles WHERE name = 'Panadero'),
  id 
FROM permissions
WHERE module NOT IN ('employees', 'reports');
