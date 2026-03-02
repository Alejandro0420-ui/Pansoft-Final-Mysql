-- ============================================
-- SCRIPT: Crear Tabla de Roles y Permisos
-- ============================================

-- Tabla de Roles
CREATE TABLE IF NOT EXISTS roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE,
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de Permisos
CREATE TABLE IF NOT EXISTS permissions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255),
  module VARCHAR(50),
  action VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de relación Roles - Permisos
CREATE TABLE IF NOT EXISTS role_permissions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  role_id INT NOT NULL,
  permission_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
  UNIQUE KEY unique_role_permission (role_id, permission_id)
);

-- ============================================
-- INSERTAR ROLES
-- ============================================

INSERT INTO roles (name, description) VALUES
('Administrador General', 'Acceso total al sistema'),
('Supervisor de Stock', 'Responsable de inventario y suministros'),
('Encargado de Ventas', 'Encargado de ventas y facturación'),
('Panadero', 'Responsable de la producción');

-- Modificar tabla usuarios para agregar role_id
ALTER TABLE users ADD COLUMN role_id INT DEFAULT 1;

-- Actualizar usuarios existentes con role_id válido
UPDATE users SET role_id = 1 WHERE role_id IS NULL;

-- Remover foreign key antigua si existe
ALTER TABLE users DROP FOREIGN KEY fk_users_role_id;

-- Agregar foreign key después de los datos
ALTER TABLE users ADD CONSTRAINT fk_users_role_id FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET DEFAULT;

-- ============================================
-- INSERTAR PERMISOS
-- ============================================

-- Dashboard
INSERT INTO permissions (name, module, action, description) VALUES
('dashboard.view', 'dashboard', 'read', 'Ver dashboard'),
('dashboard.export', 'dashboard', 'write', 'Exportar datos del dashboard');

-- Inventario
INSERT INTO permissions (name, module, action, description) VALUES
('inventory.view', 'inventory', 'read', 'Ver inventario'),
('inventory.create', 'inventory', 'write', 'Crear movimientos de inventario'),
('inventory.edit', 'inventory', 'write', 'Editar movimientos'),
('inventory.delete', 'inventory', 'delete', 'Eliminar movimientos');

-- Productos
INSERT INTO permissions (name, module, action, description) VALUES
('products.view', 'products', 'read', 'Ver productos'),
('products.create', 'products', 'write', 'Crear productos'),
('products.edit', 'products', 'write', 'Editar productos'),
('products.delete', 'products', 'delete', 'Eliminar productos');

-- Órdenes
INSERT INTO permissions (name, module, action, description) VALUES
('orders.view', 'orders', 'read', 'Ver órdenes'),
('orders.create', 'orders', 'write', 'Crear órdenes'),
('orders.edit', 'orders', 'write', 'Editar órdenes'),
('orders.delete', 'orders', 'delete', 'Eliminar órdenes');

-- Órdenes de Producción
INSERT INTO permissions (name, module, action, description) VALUES
('production_orders.view', 'production_orders', 'read', 'Ver órdenes de producción'),
('production_orders.create', 'production_orders', 'write', 'Crear órdenes de producción'),
('production_orders.edit', 'production_orders', 'write', 'Editar órdenes de producción'),
('production_orders.delete', 'production_orders', 'delete', 'Eliminar órdenes de producción');

-- Órdenes de Venta
INSERT INTO permissions (name, module, action, description) VALUES
('sales_orders.view', 'sales_orders', 'read', 'Ver órdenes de venta'),
('sales_orders.create', 'sales_orders', 'write', 'Crear órdenes de venta'),
('sales_orders.edit', 'sales_orders', 'write', 'Editar órdenes de venta'),
('sales_orders.delete', 'sales_orders', 'delete', 'Eliminar órdenes de venta');

-- Facturación
INSERT INTO permissions (name, module, action, description) VALUES
('billing.view', 'billing', 'read', 'Ver facturas'),
('billing.create', 'billing', 'write', 'Crear facturas'),
('billing.edit', 'billing', 'write', 'Editar facturas'),
('billing.delete', 'billing', 'delete', 'Eliminar facturas'),
('billing.pay', 'billing', 'write', 'Registrar pagos');

-- Empleados
INSERT INTO permissions (name, module, action, description) VALUES
('employees.view', 'employees', 'read', 'Ver empleados'),
('employees.create', 'employees', 'write', 'Crear empleados'),
('employees.edit', 'employees', 'write', 'Editar empleados'),
('employees.delete', 'employees', 'delete', 'Eliminar empleados');

-- Reportes
INSERT INTO permissions (name, module, action, description) VALUES
('reports.view', 'reports', 'read', 'Ver reportes'),
('reports.export', 'reports', 'write', 'Exportar reportes'),
('reports.production', 'reports', 'read', 'Ver reportes de producción'),
('reports.sales', 'reports', 'read', 'Ver reportes de ventas'),
('reports.inventory', 'reports', 'read', 'Ver reportes de inventario');

-- Proveedores
INSERT INTO permissions (name, module, action, description) VALUES
('suppliers.view', 'suppliers', 'read', 'Ver proveedores'),
('suppliers.create', 'suppliers', 'write', 'Crear proveedores'),
('suppliers.edit', 'suppliers', 'write', 'Editar proveedores'),
('suppliers.delete', 'suppliers', 'delete', 'Eliminar proveedores');

-- Suministros
INSERT INTO permissions (name, module, action, description) VALUES
('supplies.view', 'supplies', 'read', 'Ver suministros'),
('supplies.create', 'supplies', 'write', 'Crear suministros'),
('supplies.edit', 'supplies', 'write', 'Editar suministros'),
('supplies.delete', 'supplies', 'delete', 'Eliminar suministros');

-- Notificaciones
INSERT INTO permissions (name, module, action, description) VALUES
('notifications.view', 'notifications', 'read', 'Ver notificaciones'),
('notifications.manage', 'notifications', 'write', 'Gestionar notificaciones');

-- Configuración
INSERT INTO permissions (name, module, action, description) VALUES
('settings.view', 'settings', 'read', 'Ver configuración'),
('settings.edit', 'settings', 'write', 'Editar configuración'),
('users.manage', 'settings', 'write', 'Gestionar usuarios');

-- ============================================
-- ASIGNAR PERMISOS A ROLES
-- ============================================

-- ADMINISTRADOR GENERAL (ID: 1) - Acceso Total
INSERT INTO role_permissions (role_id, permission_id)
SELECT 1, id FROM permissions;

-- SUPERVISOR DE STOCK (ID: 2) - Inventario, Suministros, Proveedores
INSERT INTO role_permissions (role_id, permission_id)
SELECT 2, id FROM permissions WHERE module IN (
  'dashboard', 'inventory', 'products', 'supplies', 'suppliers', 'reports', 'notifications'
) AND (action = 'read' OR module IN ('inventory', 'supplies', 'suppliers') AND action IN ('read', 'write'));

-- ENCARGADO DE VENTAS (ID: 3) - Ventas y Facturación
INSERT INTO role_permissions (role_id, permission_id)
SELECT 3, id FROM permissions WHERE module IN (
  'dashboard', 'sales_orders', 'billing', 'products', 'inventory', 'notifications'
) AND (action = 'read' OR (module IN ('sales_orders', 'billing') AND action = 'write'));

-- PANADERO (ID: 4) - Producción
INSERT INTO role_permissions (role_id, permission_id)
SELECT 4, id FROM permissions WHERE module IN (
  'dashboard', 'production_orders', 'supplies', 'notifications', 'reports'
) AND action IN ('read', 'write');

-- ============================================
-- QUERY DE PRUEBA: Ver permisos por rol
-- ============================================

-- SELECT r.name as Role, p.module, p.name, p.action 
-- FROM roles r
-- LEFT JOIN role_permissions rp ON r.id = rp.role_id
-- LEFT JOIN permissions p ON rp.permission_id = p.id
-- ORDER BY r.name, p.module, p.name;
