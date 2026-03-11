-- Seed data for table: supplies
-- Extracted from: pansoft_db.sql

INSERT INTO `supplies` (`id`, `name`, `sku`, `description`, `category`, `price`, `stock_quantity`, `min_stock_level`, `unit`, `supplier_id`, `image_url`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Harina de Trigo', 'SUP-001', 'Harina de trigo premium', 'Harinas', 4.50, 500, 100, 'kg', NULL, NULL, 0, '2026-02-11 04:16:49', '2026-02-17 21:25:22'),
(2, 'Azúcar Blanca', 'SUP-002', 'Azúcar blanca refinada', 'Endulzantes', 3.20, 200, 80, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(3, 'Levadura Seca', 'SUP-003', 'Levadura seca instantánea', 'Levaduras', 18.00, 30, 15, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(4, 'Mantequilla', 'SUP-004', 'Mantequilla de calidad premium', 'Lácteos', 12.00, 80, 30, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(5, 'Huevos Frescos', 'SUP-005', 'Huevos frescos de granja', 'Lácteos', 0.60, 500, 150, 'docena', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(6, 'Chocolate en Polvo', 'SUP-006', 'Chocolate en polvo premium', 'Saborizantes', 22.00, 40, 15, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(7, 'Sal Fina', 'SUP-007', 'Sal fina para panadería', 'Condimentos', 1.80, 100, 40, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(8, 'Vainilla Pura', 'SUP-008', 'Extracto de vainilla pura', 'Saborizantes', 35.00, 15, 5, 'l', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-12 18:56:48'),
(9, 'Arándanos Secos', 'SUP-009', 'Arándanos deshidratados', 'Frutas', NULL, 20, 8, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-19 18:40:30'),
(10, 'Aceite de Oliva', 'SUP-010', 'Aceite de oliva virgen extra', 'Aceites', NULL, 30, 10, 'l', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-19 18:40:24');