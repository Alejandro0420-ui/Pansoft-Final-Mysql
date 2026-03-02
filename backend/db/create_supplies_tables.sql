-- Crear tabla supplies completa con todos los campos necesarios
CREATE TABLE IF NOT EXISTS supplies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  sku VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  category VARCHAR(50),
  price DECIMAL(10, 2),
  stock_quantity INT DEFAULT 0,
  min_stock_level INT DEFAULT 10,
  unit VARCHAR(20),
  image_url VARCHAR(255),
  supplier_id INT,
  expiry_date DATE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE SET NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Crear tabla para registrar movimientos de supplies
CREATE TABLE IF NOT EXISTS supplies_movements (
  id INT AUTO_INCREMENT PRIMARY KEY,
  supply_id INT NOT NULL,
  movement_type VARCHAR(50) DEFAULT 'ajuste',
  quantity_change INT NOT NULL,
  previous_quantity INT DEFAULT 0,
  new_quantity INT DEFAULT 0,
  reason VARCHAR(255),
  notes TEXT,
  user_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (supply_id) REFERENCES supplies(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
