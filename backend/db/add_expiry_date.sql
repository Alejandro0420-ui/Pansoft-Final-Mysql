-- Agregar campo de fecha de caducidad a productos
ALTER TABLE products ADD COLUMN IF NOT EXISTS expiry_date DATE DEFAULT NULL;

-- Agregar índice para búsquedas rápidas de productos vencidos
CREATE INDEX IF NOT EXISTS idx_products_expiry ON products(expiry_date);

-- Agregar campo de fecha de caducidad a insumos
ALTER TABLE supplies ADD COLUMN IF NOT EXISTS expiry_date DATE DEFAULT NULL;

-- Agregar índice para búsquedas rápidas de insumos vencidos
CREATE INDEX IF NOT EXISTS idx_supplies_expiry ON supplies(expiry_date);

-- Tabla de alertas de caducidad
CREATE TABLE IF NOT EXISTS expiry_alerts (
  id SERIAL PRIMARY KEY,
  product_id INT,
  supply_id INT,
  alert_type VARCHAR(50), -- 'expired', 'expiring_soon', 'expiring_this_week'
  expiry_date DATE NOT NULL,
  days_until_expiry INT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (supply_id) REFERENCES supplies(id) ON DELETE CASCADE,
  CHECK ((product_id IS NOT NULL AND supply_id IS NULL) OR (product_id IS NULL AND supply_id IS NOT NULL))
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Índices para alertas
CREATE INDEX IF NOT EXISTS idx_expiry_alerts_product ON expiry_alerts(product_id);
CREATE INDEX IF NOT EXISTS idx_expiry_alerts_supply ON expiry_alerts(supply_id);
CREATE INDEX IF NOT EXISTS idx_expiry_alerts_type ON expiry_alerts(alert_type);
CREATE INDEX IF NOT EXISTS idx_expiry_alerts_active ON expiry_alerts(is_active);
