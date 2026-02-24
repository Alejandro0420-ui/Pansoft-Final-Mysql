-- ============================================
-- TABLAS BASE (sin referencias)
-- ============================================

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  full_name VARCHAR(100),
  role VARCHAR(20) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  address TEXT,
  city VARCHAR(50),
  country VARCHAR(50),
  customer_type VARCHAR(20),
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  sku VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  category VARCHAR(50),
  price DECIMAL(10, 2),
  stock_quantity INT DEFAULT 0,
  min_stock_level INT DEFAULT 10,
  image_url VARCHAR(255),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS supplies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  sku VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  category VARCHAR(50),
  unit_price DECIMAL(10, 2),
  stock_quantity INT DEFAULT 0,
  min_stock_level INT DEFAULT 10,
  image_url VARCHAR(255),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS suppliers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company_name VARCHAR(100) NOT NULL,
  contact_person VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(20),
  address TEXT,
  city VARCHAR(50),
  country VARCHAR(50),
  payment_terms VARCHAR(50),
  category VARCHAR(100),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  position VARCHAR(50),
  department VARCHAR(50),
  hire_date DATE,
  salary DECIMAL(10, 2),
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_number VARCHAR(50) UNIQUE NOT NULL,
  customer_id INT,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  delivery_date DATE,
  total_amount DECIMAL(10, 2),
  status VARCHAR(20) DEFAULT 'pending',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  unit_price DECIMAL(10, 2),
  total DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS invoices (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_number VARCHAR(50) UNIQUE NOT NULL,
  order_id INT,
  customer_id INT,
  issue_date DATE,
  due_date DATE,
  total_amount DECIMAL(10, 2),
  paid_amount DECIMAL(10, 2) DEFAULT 0,
  status VARCHAR(20) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS sales_orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_number VARCHAR(50) UNIQUE NOT NULL,
  customer_id INT,
  customer_name VARCHAR(100),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  delivery_date DATE,
  total_amount DECIMAL(10, 2) DEFAULT 0,
  status VARCHAR(20) DEFAULT 'pending',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS sales_order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sales_order_id INT NOT NULL,
  product_id INT,
  quantity INT NOT NULL,
  unit_price DECIMAL(10, 2),
  total DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS sales_order_insumos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sales_order_id INT NOT NULL,
  insumo_id INT,
  quantity_required DECIMAL(10, 2),
  unit VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS production_orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_number VARCHAR(50) UNIQUE NOT NULL,
  product_id INT,
  quantity INT NOT NULL,
  responsible_employee_id INT,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  due_date DATE,
  status VARCHAR(20) DEFAULT 'pendiente',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS production_order_insumos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  production_order_id INT NOT NULL,
  insumo_id INT,
  quantity_required DECIMAL(10, 2) NOT NULL,
  quantity_used DECIMAL(10, 2) DEFAULT 0,
  unit VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS inventory (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  warehouse_location VARCHAR(100),
  quantity INT,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS sales_reports (
  id INT AUTO_INCREMENT PRIMARY KEY,
  report_date DATE,
  total_sales DECIMAL(10, 2),
  total_purchases DECIMAL(10, 2),
  product_category VARCHAR(50),
  quantity_sold INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- ============================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- ============================================

ALTER TABLE products ADD INDEX IF NOT EXISTS idx_products_category (category);
ALTER TABLE products ADD INDEX IF NOT EXISTS idx_products_sku (sku);
ALTER TABLE orders ADD INDEX IF NOT EXISTS idx_orders_customer (customer_id);
ALTER TABLE orders ADD INDEX IF NOT EXISTS idx_orders_status (status);
ALTER TABLE invoices ADD INDEX IF NOT EXISTS idx_invoices_customer (customer_id);
ALTER TABLE invoices ADD INDEX IF NOT EXISTS idx_invoices_status (status);
ALTER TABLE invoices ADD INDEX IF NOT EXISTS idx_invoices_due_date (due_date);
ALTER TABLE employees ADD INDEX IF NOT EXISTS idx_employees_department (department);
ALTER TABLE sales_orders ADD INDEX IF NOT EXISTS idx_sales_orders_customer (customer_id);
ALTER TABLE production_orders ADD INDEX IF NOT EXISTS idx_production_orders_status (status);
ALTER TABLE supplies ADD INDEX IF NOT EXISTS idx_supplies_sku (sku);
