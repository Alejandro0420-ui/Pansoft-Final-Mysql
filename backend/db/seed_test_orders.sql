-- Insertar cliente de prueba si no existe
INSERT INTO customers (name, email, phone, city, status) 
SELECT 'Cliente Prueba', 'cliente@test.com', '123456', 'Bogotá', 'active'
FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE name = 'Cliente Prueba');

-- Insertar orden de venta de prueba
INSERT INTO sales_orders (order_number, customer_id, customer_name, order_date, total_amount, status) 
SELECT CONCAT('VNT-', YEAR(NOW()), '-001'), 
       (SELECT id FROM customers WHERE name = 'Cliente Prueba' LIMIT 1),
       'Cliente Prueba',
       NOW(),
       250000,
       'pending'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sales_orders WHERE order_number LIKE 'VNT-%');

-- Insertar producto de prueba si no existe
INSERT INTO products (name, sku, category, price, stock_quantity, min_stock_level) 
SELECT 'Pan de Aceite', 'PAN-ACEITE-001', 'Panadería', 5000, 50, 10
FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM products WHERE sku = 'PAN-ACEITE-001');

-- Insertar empleado de prueba si no existe
INSERT INTO employees (first_name, last_name, email, position, department, status) 
SELECT 'Juan', 'Pérez', 'juan@test.com', 'Panadero', 'Producción', 'active'
FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM employees WHERE email = 'juan@test.com');

-- Insertar orden de producción de prueba
INSERT INTO production_orders (order_number, product_id, quantity, responsible_employee_id, order_date, due_date, status) 
SELECT CONCAT('PROD-', YEAR(NOW()), '-001'),
       (SELECT id FROM products WHERE sku = 'PAN-ACEITE-001' LIMIT 1),
       100,
       (SELECT id FROM employees WHERE email = 'juan@test.com' LIMIT 1),
       NOW(),
       DATE_ADD(NOW(), INTERVAL 1 DAY),
       'pendiente'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM production_orders WHERE order_number LIKE 'PROD-%');
