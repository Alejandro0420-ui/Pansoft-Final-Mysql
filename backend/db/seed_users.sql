-- ============================================
-- SCRIPT: Insertarse Datos de Ejemplo - Roles y Usuarios
-- ============================================

-- Limpiar datos anteriores (opcional)
-- DELETE FROM users WHERE username IN ('admin', 'gerente1', 'panadero1', 'vendedor1', 'stock1');

-- ============================================
-- INSERTAR USUARIOS DE EJEMPLO
-- ============================================

-- 1. ADMINISTRADOR GENERAL
INSERT INTO users (username, email, password, role_id) 
VALUES (
  'admin',
  'admin@pansoft.com',
  '$2a$10$Iy8aU8vBaWrb4pWy9Gj1R.gNbqLt4sFvH4e7Kq4eW4qL3vKG6K7gO', -- password: admin123 (hasheada con bcrypt)
  1
) ON DUPLICATE KEY UPDATE role_id = 1;

-- 2. SUPERVISOR DE STOCK
INSERT INTO users (username, email, password, role_id) 
VALUES (
  'stock1',
  'stock@pansoft.com',
  '$2a$10$Iy8aU8vBaWrb4pWy9Gj1R.gNbqLt4sFvH4e7Kq4eW4qL3vKG6K7gO', -- password: stock123
  2
) ON DUPLICATE KEY UPDATE role_id = 2;

-- 3. ENCARGADO DE VENTAS
INSERT INTO users (username, email, password, role_id) 
VALUES (
  'vendedor1',
  'vendedor@pansoft.com',
  '$2a$10$Iy8aU8vBaWrb4pWy9Gj1R.gNbqLt4sFvH4e7Kq4eW4qL3vKG6K7gO', -- password: vendedor123
  3
) ON DUPLICATE KEY UPDATE role_id = 3;

-- 4. PANADERO
INSERT INTO users (username, email, password, role_id) 
VALUES (
  'panadero1',
  'panadero@pansoft.com',
  '$2a$10$Iy8aU8vBaWrb4pWy9Gj1R.gNbqLt4sFvH4e7Kq4eW4qL3vKG6K7gO', -- password: panadero123
  4
) ON DUPLICATE KEY UPDATE role_id = 4;

-- ============================================
-- VERIFICAR QUE SE INSERTARON CORRECTAMENTE
-- ============================================

SELECT 
  u.username,
  u.email,
  r.name as role,
  COUNT(rp.permission_id) as total_permissions
FROM users u
LEFT JOIN roles r ON u.role_id = r.id
LEFT JOIN role_permissions rp ON r.id = rp.role_id
WHERE u.username IN ('admin', 'gerente1', 'panadero1', 'vendedor1', 'stock1')
GROUP BY u.id, u.username, u.email, r.name;

-- ============================================
-- QUERY: VER PERMISOS DETALLADOS POR USUARIO
-- ============================================

-- Para Admin
SELECT 
  u.username,
  r.name as role,
  p.module,
  p.action,
  COUNT(*) as count
FROM users u
JOIN roles r ON u.role_id = r.id
LEFT JOIN role_permissions rp ON r.id = rp.role_id
LEFT JOIN permissions p ON rp.permission_id = p.id
WHERE u.username = 'admin'
GROUP BY p.module, p.action
ORDER BY p.module;

-- ============================================
-- QUERY: COMPARAR PERMISOS ENTRE ROLES
-- ============================================

SELECT 
  r.name as role,
  p.module,
  GROUP_CONCAT(DISTINCT p.action ORDER BY p.action) as actions,
  COUNT(DISTINCT p.id) as total_permissions
FROM roles r
LEFT JOIN role_permissions rp ON r.id = rp.role_id
LEFT JOIN permissions p ON rp.permission_id = p.id
GROUP BY r.name, p.module
ORDER BY r.name, p.module;

-- ============================================
-- QUERY: VER ACCESO A MÓDULOS POR ROL
-- ============================================

SELECT DISTINCT
  r.name as role,
  p.module
FROM roles r
LEFT JOIN role_permissions rp ON r.id = rp.role_id
LEFT JOIN permissions p ON rp.permission_id = p.id
WHERE p.module IS NOT NULL
ORDER BY r.name, p.module;

-- ============================================
-- QUERY ÚTIL: Verificar qué puede hacer cada rol
-- ============================================

-- ¿Quién puede crear órdenes de venta?
SELECT DISTINCT r.name as role
FROM role_permissions rp
JOIN roles r ON rp.role_id = r.id
JOIN permissions p ON rp.permission_id = p.id
WHERE p.name = 'sales_orders.create'
ORDER BY r.name;

-- ¿Quién puede editar inventario?
SELECT DISTINCT r.name as role
FROM role_permissions rp
JOIN roles r ON rp.role_id = r.id
JOIN permissions p ON rp.permission_id = p.id
WHERE p.name = 'inventory.edit'
ORDER BY r.name;

-- ¿Quién puede eliminar usuarios?
SELECT DISTINCT r.name as role
FROM role_permissions rp
JOIN roles r ON rp.role_id = r.id
JOIN permissions p ON rp.permission_id = p.id
WHERE p.name LIKE 'users%'
ORDER BY r.name;

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================

/*
CONTRASEÑAS DE PRUEBA (sin hashear):
- admin: admin123
- stock1: stock123
- vendedor1: vendedor123
- panadero1: panadero123

Para generar nuevas contraseñas hasheadas en Node.js:
  const bcrypt = require('bcryptjs');
  bcrypt.hashSync('tu_contraseña', 10)

O usar:
  npm run seed  (si tienes un script de seed)

LOS HASHES EN ESTE ARCHIVO SON SOLO EJEMPLOS
Debes generar los tuyos propios con bcryptjs
*/
